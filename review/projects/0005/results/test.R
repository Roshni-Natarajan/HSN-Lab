library(ggplot2)
cnames <- c("time","srcip","srcport","dstip","dstport","id","interval","data","tput")

data <- read.csv("el6383-project/data/fifo-1-run1-h3.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-1-run2-h3.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-1-run3-h3.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-1-run4-h3.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-1-run5-h3.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo13 <- mean(all$V9)/1000000    #average throughput in Mbps

data <- read.csv("el6383-project/data/fifo-1-run1-h4.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-1-run2-h4.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-1-run3-h4.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-1-run4-h4.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-1-run5-h4.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo14 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/fifo-2-run1-h3.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-2-run2-h3.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-2-run3-h3.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-2-run4-h3.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-2-run5-h3.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo23 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/fifo-2-run1-h4.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-2-run2-h4.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-2-run3-h4.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-2-run4-h4.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-2-run5-h4.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo24 <- mean(all$V9)/1000000

#-------- R1 TO R2 SIDE DONE (FIFO) ---------------#

data <- read.csv("el6383-project/data/fifo-3-run1-h1.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-3-run2-h1.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-3-run3-h1.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-3-run4-h1.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-3-run5-h1.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo31 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/fifo-3-run1-h2.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-3-run2-h2.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-3-run3-h2.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-3-run4-h2.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-3-run5-h2.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo32 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/fifo-4-run1-h1.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-4-run2-h1.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-4-run3-h1.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-4-run4-h1.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-4-run5-h1.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo41 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/fifo-4-run1-h2.txt",header=F)
data1 <- read.csv("el6383-project/data/fifo-4-run2-h2.txt",header=F)
data2 <- read.csv("el6383-project/data/fifo-4-run3-h2.txt",header=F)
data3 <- read.csv("el6383-project/data/fifo-4-run4-h2.txt",header=F)
data4 <- read.csv("el6383-project/data/fifo-4-run5-h2.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgfifo42 <- mean(all$V9)/1000000

# ---------------- R2 TO R1 DONE (FIFO) ----------------#

#RED filenames have destination first, then source
data <- read.csv("el6383-project/data/red-run1-h1-h3.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h1-h3.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h1-h3.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h1-h3.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h1-h3.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred13 <- mean(all$V9)/1000000    #average throughput in Mbps

data <- read.csv("el6383-project/data/red-run1-h1-h4.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h1-h4.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h1-h4.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h1-h4.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h1-h4.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred14 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/red-run1-h2-h3.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h2-h3.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h2-h3.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h2-h3.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h2-h3.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred23 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/red-run1-h2-h3.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h2-h3.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h2-h3.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h2-h3.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h2-h3.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred24 <- mean(all$V9)/1000000

#-------- R1 TO R2 SIDE DONE (red) ---------------#

data <- read.csv("el6383-project/data/red-run1-h3-h1.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h3-h1.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h3-h1.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h3-h1.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h3-h1.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred31 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/red-run1-h3-h2.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h3-h2.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h3-h2.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h3-h2.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h3-h2.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred32 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/red-run1-h4-h1.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h4-h1.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h4-h1.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h4-h1.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h4-h1.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred41 <- mean(all$V9)/1000000

data <- read.csv("el6383-project/data/red-run1-h4-h2.txt",header=F)
data1 <- read.csv("el6383-project/data/red-run2-h4-h2.txt",header=F)
data2 <- read.csv("el6383-project/data/red-run3-h4-h2.txt",header=F)
data3 <- read.csv("el6383-project/data/red-run4-h4-h2.txt",header=F)
data4 <- read.csv("el6383-project/data/red-run5-h4-h2.txt",header=F)

all <- rbind (data,data1,data2,data3,data4)
avgred42 <- mean(all$V9)/1000000

# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx #

fifoavgs <- c(avgfifo13,avgfifo14,avgfifo23,avgfifo24,avgfifo31,avgfifo32,avgfifo41,avgfifo42)
redavgs <- c(avgred13,avgred14,avgred23,avgred24,avgred31,avgred32,avgred41,avgred42)

fifosched <- c("FIFO","FIFO","FIFO","FIFO","FIFO","FIFO","FIFO","FIFO")
fifoavgs <- as.data.frame(cbind(fifoavgs,fifosched))
colnames(fifoavgs) <- c("Throughput", "Scheduler")
fifoavgs$Throughput <- as.character(fifoavgs$Throughput)
fifoavgs$Throughput <- as.numeric(fifoavgs$Throughput)

redsched <- c("RED","RED","RED","RED","RED","RED","RED","RED")
redavgs <- as.data.frame(cbind(redavgs,redsched))
colnames(redavgs) <- c("Throughput", "Scheduler")
redavgs$Throughput <- as.character(redavgs$Throughput)
redavgs$Throughput <- as.numeric(redavgs$Throughput)

finaltable <- rbind(fifoavgs,redavgs)

box <- ggplot(finaltable)
box <- box+geom_boxplot(aes(x=Scheduler,y=Throughput,group=Scheduler),fill=c("green","red"))
box <- box + ggtitle("Bandwidth spread on varying scheduling algorithm on router nodes")
box <- box + scale_y_continuous("Throughput (Mbps)")
ggsave("Plot.png", plot=box)