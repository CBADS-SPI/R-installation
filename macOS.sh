#!/usr/bin/env bash

# requirements: 
# * Intel MKL for macOS https://software.intel.com/en-us/mkl/choose-download
# * Homebrew https://brew.sh/
# * GNU Fortran: run `brew install gcc` sans quotes (GNU Fortran is included)
# * X11 https://www.xquartz.org/ 
# * XCode / command line developer tools for macOS (installing homebrew will install these)

RVERSION=3.6.2
export MKLROOT="/opt/intel/mkl"
export MKL=" -L${MKLROOT}/lib ${MKLROOT}/lib/libmkl_blas95_ilp64.a ${MKLROOT}/lib/libmkl_lapack95_ilp64.a -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -lmkl_gf_ilp64"
export arch=x86_64
export r_arch=x86_64
export CC="gcc -arch x86_64 -std=gnu99"
export CXX="g++ -arch x86_64"
export OBJC="clang"
export F77="gfortran -arch x86_64"
export FC="gfortran -arch x86_64"
export CFLAGS='-g -O2'
export CXXFLAGS='-g -O2'
export FCFLAGS='-g -O2'
export F77FLAGS='-g -O2'
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/lib/pkgconfig

./configure --with-blas="${MKL}" --with-lapack --with-aqua --with-system-zlib --enable-memory-profiling --enable-R-framework --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib --with-tcltk=/usr/local/lib
make
sudo make install