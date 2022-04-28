#For data1
vdata <- read.csv("data1.csv")
vdata <- table(vdata)
vdata <- vdata[order(vdata)]
par(mar = c(3, 12, 3, 3))
barplot(vdata, horiz = T, las = 1)

#For Data2
df <- read.csv("data2.csv")
library(ggplot2)
ggplot(df, aes(
  x = age,
  y = salary,
  color = part.of.germany,
  shape = part.of.germany)) +
  geom_point(size = 3) + theme_classic()

#For data3
df1 <- read.csv("data3.csv")

hist(df1$height)
