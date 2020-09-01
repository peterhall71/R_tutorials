# loading packages
library(qcc)

# load data
data(pistonrings)

# exploratory
pistonrings$sample <- as.factor(pistonrings$sample)
str(pistonrings)
head(pistonrings)
hist(pistonrings$diameter)

## Xbar, R Charts

# group data
diameter <- qcc.groups(pistonrings$diameter, pistonrings$sample)
head(diameter)


# charting
diamXbar <- qcc(diameter[1:30,], type="xbar", newdata=diameter[31:40,])
summary(diamXbar)

## Cp, Cpk

# process capability function
diamC <- process.capability(diamXbar, spec.limits = c(73.98, 74.02))