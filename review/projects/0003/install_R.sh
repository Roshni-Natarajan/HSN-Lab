wget http://download2.rstudio.org/rstudio-server-0.98.1102-amd64.deb &&

gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 
gpg -a --export E084DAB9 | apt-key add - 
echo "deb http://cran.wustl.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list 
apt-get update 
apt-get -y install r-base r-cran-rcpp &&
dpkg -i rstudio-server-0.98.1102-amd64.deb &&
echo "www-port=80" >>  /etc/rstudio/rserver.conf 
rstudio-server restart