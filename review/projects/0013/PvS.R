

# Data Field Names
cnames <-c("x", "Recv buff", "Send buff", "Mess", "Time", "tput", "y")

# Serialize Policing Data
dat <- read.csv("Submit/policing-data.txt", header = FALSE)
names(dat) <- cnames
dat <- subset(dat, select = -c(x,y))
dat <- cbind(rate=c(1,5,10,20,30,40,50), dat)
dat$Method <- "Policing" 
all <- dat

# Serialize Shaping Data
dat <- read.csv("Submit/shaping-data.txt", header = FALSE)
names(dat) <- cnames
dat <- subset(dat, select = -c(x,y))
dat <- cbind(rate=c(1,5,10,20,30,40,50), dat)
dat$Method <- "Shaping" 
all <- rbind(all, dat)

# Categorize as factors
all$rate <- as.factor(all$rate)
all$tput <- as.factor(all$tput)
all$Method <- as.factor(all$Method)

# Plot Data
library(ggplot2)
q <- ggplot(data=all, aes(x = rate, y = tput, fill = Method)) 
q <- q + geom_bar( stat = "identity", position=position_dodge())
q <- q + scale_x_discrete("Bandwidth Limit Rate (Mbps)")
q <- q + scale_y_discrete("Throughput (Mbps)")
q <- q + ggtitle("Policing vs Shaping")
ggsave("Submit/PSgraph.png", plot=q)

