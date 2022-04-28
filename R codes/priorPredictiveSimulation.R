df <- read.csv('data.csv')

wBar <- mean(df$weight)
w <- seq(20,70, length.out = 40)

#draw 50 possible lines

plot(NULL, ylim = c(0,400), xlim = c(30,60), ylab = "height", xlab = 'weight')

for(i in 1:50){
  a <- rnorm(1, 178,20)
  b <- rnorm(1, 0,10)
  
  h <- a + b * (w - wBar)
  
  lines(w,h)
}
