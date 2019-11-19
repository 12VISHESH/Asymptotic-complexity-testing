library(PeakSegOptimal)
library(PeakSegDP)
library(microbenchmark)
library(ggplot2)
n_seq = c(10, 100, 1000, 10000)
cdpa_data <- integer(length(n_seq))
pdpa_data <- integer(length(n_seq))
for (i in seq(1, length(n_seq))){
  
  x <- rpois(n_seq[i],20 )
  
  m <- summary(microbenchmark( PeakSegPDPA(x, rep(1, length(x)), 3L),cDPA(x, rep(1, length(x)), 3L)))
  pdpa_data[i] <- m$mean[1]
  cdpa_data[i] <- m$mean[2]
}
df = data.frame(pdpa_data, cdpa_data, n_seq)
ggplot(df, aes(x=n_seq, y=cdpa_data)) + geom_line(color = 'blue') + geom_line(y = pdpa_data, color='green') + labs(x="N", y="Runtime") 
