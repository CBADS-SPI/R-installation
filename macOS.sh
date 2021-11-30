#!/usr/bin/env bash

# requirements: 
# * Homebrew https://brew.sh/
# * X11 https://www.xquartz.org/ 
# * XCode / command line developer tools for macOS (installing homebrew will install these)

brew install --cask mactex
brew tap sethrfore/homebrew-r-srf
brew install icu4c libtiff openblas libomp openjdk xz
brew install sethrfore/r-srf/cairo-x11 sethrfore/r-srf/tcl-tk-x11
brew install sethrfore/r-srf/r --with-openblas --with-openjdk --with-tcl-tk-x11 --with-cairo-x11 --with-icu4c

sudo mkdir -p /Library/Frameworks/R.framework/Versions/Current/Resources/lib/
cd /Library/Frameworks/R.framework/Versions/Current/Resources/lib/
sudo ln -s /usr/local/lib/R/lib/libR.dylib
mkdir -p ~/.R
cp Makevars.mac ~/.R/Makevars