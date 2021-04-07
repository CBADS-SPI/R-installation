#!/usr/bin/env bash
RVERSION=4.0.5
MKLVERSION=2020.4-912 

curl https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB | sudo apt-key add -
sudo sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'
sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get -y install build-essential g++ gfortran bzip2 libbz2-dev xorg-dev liblzma-dev libreadline-dev libpcre2-dev libpcre++-dev libcurl4-openssl-dev libpango1.0-dev libcairo2-dev default-jdk default-jre

# remove old MKL version - safe to ignore any warnings. Also clean up packages.
sudo apt-get -y remove 'intel-comp-l-all-var*' 'intel-comp-nomcu-vars*' 'intel-conda-index-tool*' 'intel-conda-intel-openmp*' 'intel-conda-mkl*' 'intel-conda-tbb*' 'intel-mkl*' 'intel-openmp*' 'intel-psxe-common*' 'intel-tbb-libs*'
sudo apt-get -y clean
# install latest MKL
sudo apt-get -y install intel-mkl-$MKLVERSION
# for good measure, make sure symlink is correct
sudo rm /opt/intel/compilers_and_libraries
sudo ln -s /opt/intel/compilers_and_libraries_2020 /opt/intel/compilers_and_libraries

sudo sh -c 'echo /opt/intel/lib/intel64 > /etc/ld.so.conf.d/mkl.conf'
sudo sh -c 'echo /opt/intel/mkl/lib/intel64 >> /etc/ld.so.conf.d/mkl.conf'
sudo ldconfig

[ -f /opt/intel/mkl/bin/mklvars.sh ]  && source /opt/intel/mkl/bin/mklvars.sh intel64
[ -f /opt/intel/mkl/bin/mklvars.sh ]  && export MKL="-Wl,--no-as-needed -lmkl_gf_lp64 -Wl,--start-group -lmkl_gnu_thread  -lmkl_core  -Wl,--end-group -fopenmp  -ldl -lpthread -lm"
 
curl -O https://cran.r-project.org/src/base/R-4/R-$RVERSION.tar.gz

tar xf R-$RVERSION.tar.gz
cd R-$RVERSION
./configure --with-blas="$MKL" --with-lapack --with-x=yes --prefix=/usr/local --enable-R-shlib
make
sudo make install
