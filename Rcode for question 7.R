######################################
# 01.10.2016
# Emsemble plots 
# Alyssa Sanchez
# BISC 481
######################################

# Initialization
library(DNAshapeR)

# Extract sample sequences
fn <- "/Users/Alyssa/Downloads/BISC481-master-3/CTCF/bound_500.fa"

# Predict DNA shapes
pred <- getShape(fn)

# Generate ensemble plots
plotShape(pred$Roll)
#plotShape(pred$ProT)
#plotShape(pred$HelT)
#plotShape(pred$MGW)
heatShape(pred$ProT, 20)
