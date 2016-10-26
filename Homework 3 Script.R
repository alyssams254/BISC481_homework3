######################################
# Alyssa Sanchez
# BISC 481 Homework 3
# 10/24/16
######################################

## Install packages
# Bioconductor
source("https://bioconductor.org/biocLite.R")
biocLite()
# DNAshapeR
biocLite("DNAshapeR")
# Caret
install.packages("caret")

## Initialization
library(DNAshapeR)
library(caret)
workingPath <- "/Users/Alyssa/Downloads/BISC481-master-2/gcPBM"

## Predict DNA shapes
#fn_fasta <- paste0(workingPath, "Mad.txt.fa")
#fn_fasta <- paste0(workingPath, "Max.txt.fa")
fn_fasta <- paste0(workingPath, "Myc.txt.fa")

pred <- getShape(fn_fasta)

## Encode feature vectors
featureType <- c("1-mer", "1-shape")
#featureType <- c("1-mer")

featureVector <- encodeSeqShape(fn_fasta, pred, featureType)
head(featureVector)


## Build MLR model by using Caret
# Data preparation
#fn_exp <- paste0(workingPath, "Mad.txt")
#fn_exp <- paste0(workingPath, "Max.txt")
fn_exp <- paste0(workingPath, "Myc.txt")

exp_data <- read.table(fn_exp)
df <- data.frame(affinity=exp_data$V2, featureVector)

# Arguments setting for Caret
trainControl <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Prediction without L2-regularized
model <- train (affinity~ ., data = df, trControl=trainControl, 
                method = "lm", preProcess=NULL)

# Prediction with L2-regularized
model2 <- train(affinity~., data = df, trControl=trainControl, 
                method = "glmnet", tuneGrid = data.frame(alpha = 0, lambda = c(2^c(-15:15))))
model2
result <- model2$results$Rsquared[1]
result

