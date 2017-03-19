prot <- c("FTP","UDT")
thrput <- c(11703.1, 929.12875)
df1 <- data.frame(prot,thrput)
df1$size <- "10M"
part3 <- df1
thrput <- c(11703.1, 5961.625)
df1 <- data.frame(prot,thrput)
df1$size <- "100M"
part3 <- rbind(part3, df1)
thrput <- c(11702.9,6884.1625)
df1 <- data.frame(prot,thrput)
df1$size <- "1G"
part3 <- rbind(part3, df1)
library(ggplot2)
part3$prot <- as.factor(part3$prot)
part3$size <- as.factor(part3$size)
plot3 <- ggplot(part3, aes(fill=prot , y=thrput , x=size))
plot3<- plot3 + geom_bar(position="dodge", stat="identity")
plot3
