#Demo Exam Ds
library(rethinking)

#simulating data

Y <- rnorm(100,0,0.2) 

#ulam model
model <- ulam(alist(
  Y ~ dnorm(mu,sigma),
  
  mu ~ dnorm(0,3),
  sigma ~ dexp(1)
),data = list(Y = Y))

P <- extract.samples(model)
X <- P$mu
Y <- P$sigma

hist(X)
hist(Y)
