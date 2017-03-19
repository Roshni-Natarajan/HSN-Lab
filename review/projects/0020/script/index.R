# In this file, you need to modify some variant: source; data address and names of your data files without ".txt"
# the default value of variants are given as follow: 
# config

# script and data folder addresses
script_folder_addr<-"~/cubic-stability-project/script/"
folder_addr <- "~/cubic-stability-project/data/"
# name of your row data1 without ext
file1_name1 <- "CUBIC-buffer20"
file1_name2 <- "BIC-buffer20"
file1_name3 <- "HSTCP-buffer20"
file1_name4 <- "HTCP-buffer20"
file1_name5 <- "STCP-buffer20"
# name of your row data2 without ext
file2_name1 <- "CUBIC-buffer200"
file2_name2 <- "BIC-buffer200"
file2_name3 <- "HSTCP-buffer200"
file2_name4 <- "HTCP-buffer200"
file2_name5 <- "STCP-buffer200"
# name of 3 R scirps
R_script1<-"R_script1.R"
R_script2<-"R_script2.R"
R_script3<-"R_script3.R"

# tcp names
tcp1="cubic"
tcp2="bic"
tcp3="hstcp"
tcp4="htcp"
tcp5="stcp"

# name of final img
imgName1<-"cov20.png"
imgName2<-"cov200.png"


script_addr1<-paste(script_folder_addr,R_script1,sep='')
script_addr2<-paste(script_folder_addr,R_script2,sep='')
script_addr3<-paste(script_folder_addr,R_script3,sep='')


#1. It will generate the first graph. it will generate 10 images in "~/" and name them "UERFILENAME.png"
source(script_addr1)
myfun(folder_addr,file1_name1)
myfun(folder_addr,file1_name2)
myfun(folder_addr,file1_name3)
myfun(folder_addr,file1_name4)
myfun(folder_addr,file1_name5)

myfun(folder_addr,file2_name1)
myfun(folder_addr,file2_name2)
myfun(folder_addr,file2_name3)
myfun(folder_addr,file2_name4)
myfun(folder_addr,file2_name5)

#2. It will generate data for the second graph; it will generate 10 files in "~/" and name them "UERFILENAME+Temp.txt"
source(script_addr2)


myfun2(folder_addr,file1_name1,tcp1)
myfun2(folder_addr,file1_name2,tcp2)
myfun2(folder_addr,file1_name3,tcp3)
myfun2(folder_addr,file1_name4,tcp4)
myfun2(folder_addr,file1_name5,tcp5)

myfun2(folder_addr,file2_name1,tcp1)
myfun2(folder_addr,file2_name2,tcp2)
myfun2(folder_addr,file2_name3,tcp3)
myfun2(folder_addr,file2_name4,tcp4)
myfun2(folder_addr,file2_name5,tcp5)



#3.generate the final 2 images by using the data you generated in last step.
source(script_addr3)
Tempname=function(a){
	TEMPext<-"Temp.txt"
	b<-paste(a,TEMPext,sep='')
	return(b)
}

tname1_1<- Tempname(file1_name1)
tname1_2<- Tempname(file1_name2)
tname1_3<- Tempname(file1_name3)
tname1_4<- Tempname(file1_name4)
tname1_5<- Tempname(file1_name5)

tname2_1<- Tempname(file2_name1)
tname2_2<- Tempname(file2_name2)
tname2_3<- Tempname(file2_name3)
tname2_4<- Tempname(file2_name4)
tname2_5<- Tempname(file2_name5)
myfun3(tname1_1,tname1_2,tname1_3,tname1_4,tname1_5,imgName1)
myfun3(tname2_1,tname2_2,tname2_3,tname2_4,tname2_5,imgName2)


