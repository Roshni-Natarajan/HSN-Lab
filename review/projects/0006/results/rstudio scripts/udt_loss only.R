dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 0 0 0 .01 large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "lg"
all <- dat
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 0 0 0.01 SMALL.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "sm"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 0 0 0.01 mediumtxt.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "med"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 10 0 0.01 large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "lg"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 10 0 0.01 mediumtxt.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "med"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 10 0 0 .01 SMALL.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "sm"
all <- rbind(all, dat)
View(all)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 100 0 0.01 large.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "lg"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 100 0 0.01 SMALL.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "sm"
all <- rbind(all, dat)
dat <- read.csv("~/hvs232-el6383-project/results/Udt/BW 100 0 0.01 medium.txt", header=FALSE)
cnames <- c("tput", "bw")
names(dat) <- cnames
dat$cond <- "loss only"
dat$delay <- 0
dat$plr <- 0.01
dat$trial <- "med"
all <- rbind(all, dat)
View(all)