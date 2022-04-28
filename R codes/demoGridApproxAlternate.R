set.seed(1)
library(rethinking)
Y <- rnorm(1000,0.5,0.3) 

mu <- seq(0,1,length.out = 200)
sigma <- seq(0,1,length.out = 200)

##log posterior
log_posterior <- function(mu,sigma){
  sum(log(dnorm(Y,mu,sigma))) + log(dnorm(mu,0,3))+ log(dexp(sigma,1))
}
##simple posterior
log_posterior_1 <- function(mu,sigma){
  prod((dnorm(Y,mu,sigma))) * (dnorm(mu,0,3)) * (dexp(sigma,1))
}

grid <- expand.grid(mu=mu,s=sigma)
likly <- sapply(seq_len(nrow(grid)),function(i)log_posterior_1(grid$mu[i],grid$s[i]))

contour_xyz(grid$mu,grid$s,likly)
