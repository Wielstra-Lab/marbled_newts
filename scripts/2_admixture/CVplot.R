require(ggplot2)
require(dplyr)

CVerrors <- read.table("CV_error")

colnames(CVerrors) <- c("K", "CV_error")

CV <- CVerrors %>% group_by(K) %>% summarise(mean = mean(CV_error),deviation = sd(CV_error))

ggplot(CV, aes(K,mean)) +
geom_point() +
geom_line() +
geom_linerange(aes(ymin = mean - deviation, ymax = mean + deviation)) +
ylab("CV_error") +
theme_bw()
