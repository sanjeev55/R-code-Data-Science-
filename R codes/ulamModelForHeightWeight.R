library(rethinking)

df <- read.csv("data.csv")
w <- df$weight
h <- df$height


wBar <- mean(df$weight)
model <- ulam(alist(
  h ~ dnorm(mu, sigma),
  mu <- a + b * (w - wBar),
  a ~ dnorm(178,20),
  b ~ dnorm(0,10),
  sigma ~ dunif(0,50)
    ), data = list(w = w, wBar = wBar, h = h))


samples <- extract.samples(model)
plot(w,h, ylim = c(0,400), xlim = c(30,60), ylab = "h", xlab = 'w')

for (j in 1:1000){
  a <- samples$a[j]
  b <- samples$b[j]
  
  mu <- a + b * (w - wBar)
  
  lines(w, mu)
}

#For quantile

#applying along the seq of w
quantiles <- sapply(seq_along(w), function(j){
  a <- samples$a
  b <- samples$b
  sigma <- samples$sigma
  
  #reproducing mu for all parameters
  mu <- a + b + (w[j] - wBar)
  
  #using sigma to generate artificial height that might go with sigma and mu 
  h <- rnorm(length(mu), mu, sigma) #simulating height on weight w
  
  #returning quantiles betn 0.99% and 0.01%;
  return(quantile(h, probs = c(0.99,0.01)))
})

lines(w, quantiles[1,], lty = 2, lwd = 2)
lines(w, quantiles[2,], lty = 2, lwd = 2)
