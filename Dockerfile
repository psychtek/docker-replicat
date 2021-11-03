# ./Dockerfile

FROM rocker/tidyverse:4.1.1

MAINTAINER Aaron Willcox <aaron.willcox@unimelb.edu.au>

RUN apt-get -qq update && \
  # fix-broken: https://askubuntu.com/questions/1077298/depends-libnss3-23-26-but-23-21-1ubuntu4-is-to-be-installed
  DEBIAN_FRONTEND=noninteractive apt-get -qy install -f \
  python3-pip \
  # X11 Window system
  xorg \
  openbox \
  # enrichplot dependency
  libglpk-dev \
  # ggraph dependency (required for clusterProfiler)
  libudunits2-dev \
  # XML2 dependency (required for tidyverse)
  libxml2-dev \
  # httr dependency (required for tidyverse)
  libssl-dev \
  # curl dependency (required for tidyverse)
  libcurl4-openssl-dev \
  # svglite dependency (required for svg rmarkdown output)
  libcairo2-dev \
  # svglite dependency
  libfontconfig1-dev \
  libicu-dev \
  make \
  libgit2-dev \
  # Being able to use the `R` documentation
  less \
  git \
  # pandoc requirements
  pandoc \
  pandoc-citeproc \
  sudo \
  gdebi-core \
  libxt-dev \
  wget \
  # Visidata requirements
  man \
  # Seurat requirements (Single Cell RNASeq package)
  libhdf5-dev \
  # Pigz for parallel gzip file reading and writing. See https://cloud.r-project.org/web/packages/vroom/vignettes/vroom.html and https://www.jimhester.com/post/2019-09-26-pipe-connections/
  gsl-bin \
  libgsl0-dev \
  # Required for magick package
  libmagick++-dev \
  # Required for rjags
  jags \
  r-cran-rjags \
  # Required for Rmpfr which we need for Bayes stuff
  libmpfr-dev \
  zlib1g-dev \
  # pdf text library
  texlive \
  texlive-scripts \
  # Clean up
  && apt-get clean

# install python libraries
RUN pip3 install \
  # pandas
  pandas \
  # date util
  python-dateutil

# Additional libraries
RUN install2.r --error \
# Jags library
  rjags \
  R2jags \
  mathjaxr \
  coda \
  # Documentation
  roxygen2 \
  # For running tests
  rcmdcheck \
  testthat \
  # Date formatting
  lubridate \
  VGAM \
  # Bays stuff
  tidybayes \
  usethis \
  GoFKernel \
  qualtRics \
  DescTools \
  rfUtilities \
  KernSmooth \
  precrec \
  nlme \
  covr \
  huxtable \
  here \
  readr \
  # Warning messages
  cli \
  janitor \
  readxl \
  sass \
  sessioninfo \
  stringi \
  # Tests
  pointblank
