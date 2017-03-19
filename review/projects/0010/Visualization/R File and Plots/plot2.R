library(ggplot2)
maxdelay <- read.csv("/users/rif217/delay.txt", header=F)$V1
queuesize <- c( 0.1,0.5,1,1.5,2,3)

png("delay.png")

plot(queuesize, maxdelay, type="o", col="blue") 

title("Effect of Queue Size on Max Delay")
title(xlab= "                                         (in Mb)")
title(ylab= "                                         (in ms)")

packetslost <- read.csv("/users/rif217/plosspackets.txt", header=F)$V1

png("PLpackets.png")
plot(queuesize, packetslost, type="o", col="blue") 
title("Effect of Queue Size on Packet Loss (Packets)")
title(xlab= "                                         (in Mb)")
title(ylab= "                                         (number)")

packetslost <- read.csv("/users/rif217/plosspercentage.txt", header=F)$V1

png("PLpercentage.png")
plot(queuesize, packetslost, type="o", col="blue") 
title("Effect of Queue Size on Packet Loss (Percentage)")
title(xlab= "                                         (in Mb)")
title(ylab= "                                                (percentage)")


