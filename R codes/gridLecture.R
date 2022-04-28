#grid approx
set.seed(1)

n <- 18

D <- rbinom(n, 1, 0.2)

prob <- seq(0,1,length.out = 21)

likelihood <- sapply(prob, function(x){
  return(prod(dbinom(D,1,prob = x)))
})

posterior <- prob * likelihood
plot(prob, likelihood, type = 'l')

plot(posterior)
