#poisson regression
library(rethinking)


df <- read.csv("D001.csv")
df1 <- read.csv("D002.csv")

X <- df$X
Y <- df$Y

x1 <- df1$X
y1 <- df1$Y

#simulating data1

model <- ulam(alist(
  Y ~ dpois(lambda),
  
  lambda <- exp(alpha + beta * X),
  
  alpha ~ dnorm(),
  beta ~ dnorm(0,1)
), data = list(X=X, Y=Y))
samples <- extract.samples(model) 

#simulating data2
model1 <- ulam(alist(
  Y ~ dpois(lambda),
  
  lambda <- exp(alpha + beta * X),
  
  alpha ~ dnorm(0,1),
  beta ~ dnorm(0,1)
), data = list(X=x1, Y=y1))

samples1 <- extract.samples(model1)

#for d002
hist(samples1$alpha)
hist(samples1$beta)

#for d001
hist(samples$beta)
hist(samples$alpha)
