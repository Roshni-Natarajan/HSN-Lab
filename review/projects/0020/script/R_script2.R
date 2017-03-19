myfun2=function(folder_addr,file_name,tcp){

ext1 <- ".txt"
addr1 <- paste(folder_addr,file_name,ext1,sep='')

dat <- read.csv(addr1)
str(dat)
cnames <- c("time", "srcip", "srcport", "dstip", 
            "dstport", "id", "interval", "data", 
            "tput")
names(dat) <- cnames
dat$tcp <- "cubic"
dat$capacity <- 25
dat$rtt <- 220
dat$trial <- 1
str(dat)

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
dat$trial <- as.factor(dat$trial)
dat$tcp <- as.factor(dat$tcp)
library(reshape2)
dat <- transform(dat, interval = colsplit(interval,"-", names = c('begin', 'end')))
dat$interval.begin <- dat$interval$begin
dat$interval.end <- dat$interval$end
dat$interval <- NULL
totals  <- dat[dat$interval.begin<=1 & dat$interval.end>=500,]
details <- dat[!(dat$interval.begin<=1 & dat$interval.end>=500),]
details <- details[!(details$interval.begin<=5),]

data <- details[details$interval.begin%%1==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value1 <- c(cov1, "1" , tcp)

data <- details[details$interval.begin%%5==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value5 <- c(cov1, "5" , tcp)

data <- details[details$interval.begin%%10==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value10 <- c(cov1, "10" , tcp)

data <- details[details$interval.begin%%20==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value20 <- c(cov1, "20" , tcp)

data <- details[details$interval.begin%%40==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value40 <- c(cov1, "40" , tcp)

data <- details[details$interval.begin%%80==0,]
data1 <- data[data$trial==1,]
data2 <- data[data$trial==2,]
data3 <- data[data$trial==3,]
cov11 <- sd(data1$data)/mean(data1$data)
cov12 <- sd(data2$data)/mean(data2$data)
cov13 <- sd(data3$data)/mean(data3$data)
cov1 <- (cov11+cov12+cov13)/3
value80 <- c(cov1, "80" , tcp)

cov <- data.frame(value1,value5,value10,value20,value40,value80)

cov <- t(cov)
cov <- data.frame(cov)
TEMPext<-"Temp.txt"
TEMPname <- paste(file_name,TEMPext,sep='')
write.table(cov,file=TEMPname,row.names=FALSE, col.names=FALSE)

}
