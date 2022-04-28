#multilevel model
library(rethinking)

n <- 10 #10 group
m <- 20 #each group contains 20 friends

#group id
f <- rep(1:n, each = m)

p <- rnorm(n,0,0.4)
a <- rnorm(n*m, p ,1)

mu <- p[f] - a
sigma <- 0.2

h <- rnorm(n*m, mu, sigma)
plot(a,h)

model <- ulam(alist(
  h ~ dnorm(mu, sigma),
  mu <- alpha + beta * a + p[f],
  
  sigma ~ dunif(0,1),
  sigma2 ~ exponential(5),
  p[f] ~ dnorm(0,sigma2),
  alpha ~ dnorm(0,1),
  beta ~ dnorm(0,1)
),data = list(h=h, a=a, f=f, n=n, m=m))

stancode(model)

samples <- extract.samples(model)

hist(samples$beta)

hist(samples$sigma2)

hist(samples$p)
