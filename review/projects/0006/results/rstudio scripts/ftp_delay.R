dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 0 10 0 Large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "lg"
all <- dat
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 0 10 0 small.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "sm"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 0 10 0 medium.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "med"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 10 10 0 large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "lg"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 10 10 0 medium.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "med"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 10 10 0 small.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "sm"
all <- rbind(all, dat)
View(all)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 100 0 0 large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "lg"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 100 0 0 small.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "sm"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/ftp/BW 100 0 0 medium.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "delay"
dat$delay <- 10
dat$plr <- 0
dat$trial <- "med"
all <- rbind(all, dat)
View(all)
