 t1<-read.table("overview/project/final_OVS/OVS11.csv",sep=":")
 t2<-read.table("overview/project/final_OVS/OVS12.csv",sep=":")
 cnames<-c("date","minute","sec")
 names(t1)<-cnames
 names(t2)<-cnames
 a1=a2=NULL 
 a1<-t1$sec
 a2<-t2$sec
 c=NULL
 N=100000 #total number of bytes given after -n 
 L=1000 # bytes in each packet
 i=N/L
 for( n in 1:i-5){c[n]=a2[n]-a1[n]}
 s=NULL
 p=NULL
 cc=NULL
 cc=sort(c)
 s=sum(cc)
 for( n in 1:i-5){p[n]=sum(cc[1:n]/s)}
 temp=NULL
 temp<-data.frame(cc,p)
 q <- ggplot(temp2)
 q <- q + geom_point(aes(x=cc,y=p))
 q <- q + geom_line(aes(x=cc,y=p))
 q
