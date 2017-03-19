myfun <- function(folder_addr, file_name) {
ext1 <- ".txt"
ext2 <- ".png"
addr1 <- paste(folder_addr,file_name,ext1,sep='')
addr2 <- paste(file_name,ext2,sep='')


#load the iperf data into dat

#add one trail to dat
dat <- read.csv(addr1)
str(dat)

#assign names to the columns of dat
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "thoughput", 
            "tput")
names(dat) <- cnames

#add some columns  to supplement meta-information about what the data means and how it was collected
dat$tcp <- "cubic"
dat$capacity <- 25
dat$rtt <- 220
dat$trial <- 1
str(dat)

#divide all data ,except that with zero source port number ,into three categories 
num1<- 0
num2<- 0
num3<- 0
for (i in 1:nrow(dat)) {
  if(num1!=0){
    if(num2!=0){
      if(num3!=0){
        break
      }
      else{
        if(dat[i,3]!=num1 && dat[i,3]!=num2){
          num3<- dat[i,3]
        }       
      }
    }
    else{
      if(dat[i,3]!=num1){
        num2<- dat[i,3]
      }     
    }
  }
  else{
    num1<- dat[i,3]
  }
}

# delete the rows which source port equals to zero and donate "1","2","3" to the three categories respectively
for (j in 1:nrow(dat)) {
  
  i <- nrow(dat)-j
  if(i>0){
    
    
    if(dat[i,3]==num1){
      dat[i,13]<- 1
    }
    else{
      if(dat[i,3]==num2){
        dat[i,13] <- 2}
      else{
        if(dat[i,3]==num3){
          dat[i,13]<- 3}
        else{
          dat=dat[-i,]}
      }
    }
  }
}


#change"tcp"and"trail" to factors
dat$trial <- as.factor(dat$trial)
dat$tcp <- as.factor(dat$tcp)

##subdivide the interval column into a begin and end time
library(reshape2)
dat <- transform(dat, interval = colsplit(interval,"-", names = c('begin', 'end')))
dat$interval.time <- dat$interval$begin
dat$interval.end <- dat$interval$end
dat$interval <- NULL

#make the plot
#separate those into two new data frames
totals  <- dat[dat$interval.time<=1 & dat$interval.end>=500,]
details <- dat[!(dat$interval.time<=1 & dat$interval.end>=500),]
details <- details[!(details$interval.time<=5),]
library(ggplot2)

#make a plot and add a title and axis labels to it
q <- ggplot(details)
q <- q + ylim(0,1600000)
q <- q + geom_line(aes(x=interval.time, y=thoughput, colour=trial, linetype=trial))
ggsave(addr2, plot=q)
}