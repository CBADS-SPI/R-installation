#!/usr/bin/env bash

# requirements: 
# * Homebrew https://brew.sh/
# * X11 https://www.xquartz.org/ 
# * XCode / command line developer tools for macOS (installing homebrew will install these)

brew install --cask mactex
brew tap CBADS-SPI/homebrew-r-srf
brew install icu4c libtiff openblas openjdk CBADS-SPI/r-srf/cairo-x11 CBADS-SPI/r-srf/tcl-tk-x11
brew install CBADS-SPI/homebrew-r-srf/r --with-openblas --with-openjdk --with-tcl-tk-x11 --with-cairo-x11 --with-icu4c
