
FROM rocker/rstudio:4.1.1

MAINTAINER Aaron Willcox "aaron.willcox@unimelb.edu.au"

#RUN export PATH=/usr/lib/rstudio-server/bin:$PATH

# installers
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -qy install -f \
    gdal-bin \
    lbzip2 \
    libv8-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfftw3-dev \
    libgdal-dev \
    libgeos-dev \
    libgit2-dev \
    libicu-dev \
    libgsl0-dev \
    libglpk40 \
    libglpk-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libhdf5-dev \
    libjq-dev \
    libmagick++-dev \
    libmpfr-dev \
    libpng-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libpython3-dev \
    libxt-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libudunits2-dev \
    libxml2-dev \
    libxt-dev \
    gsl-bin \
    jags \
    r-cran-rjags \
	  nano \
    netcdf-bin \
    openbox \
    postgis \
    protobuf-compiler \
	  pandoc \
    pandoc-citeproc \
    python3-pip \
    qpdf \
    sqlite3 \
    sudo \
    texlive \
    tk-dev \
    unixodbc-dev \
    xorg \
    zlib1g-dev \
    && apt-get clean

# install python libraries
RUN pip3 install \
  pandas \
  python-dateutil \
  requests

# Additional libraries
RUN install2.r --error --skipinstalled \
  DBI \
  broom \
  cli \
  coda \
  curl \
  covr \
  crayon \
  credentials \
  DescTools \
  GoFKernel \
  ggridges \
  ggthemes \
  glue \
  gt \
  gtable \
  git2r \
  googledrive \
  googlesheets4 \
  lubridate \
  mathjaxr \
  nlme \
  osfr \
  pointblank \
  precrec \
  qualtRics \
  R6 \
  RCurl \
  reprex \
  rlang \
  readr \
  readxl \
  remotes \
  reticulate \
  rfUtilities \
  rjags \
  R2jags \
  roxygen2 \
  rcmdcheck \
  rmarkdown \
  rvest \
  janitor \
  jsonlite \
  jsonvalidate \
  kableExtra \
  knitr \
  lubridate \
  testthat \
  tinytex \
  tidybayes \
  tidytext \
  usethis \
  VGAM \
  KernSmooth \
  haven \
  huxtable \
  here \
  httr \
  sass \
  sessioninfo \
  scales \
  stringi \
  stringr \
  qpdf \
  DT \
  tidyverse \
  XML \
  R.utils \
  dtplyr \
  R.methodsS3 \
  modelr \
  arrow \
  R.oo \
  devtools \
  log4r \
  rstudio.prefs \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Install tiny text
RUN R -e "tinytex::install_tinytex()"

# Install packages from github
RUN R -e "remotes::install_github('jthomasmock/gtExtras')"

# Install Pins version
RUN R -e "remotes::install_version('pins', version = '0.4.5')"

# Set rstudio preferences 
RUN R -e "rstudio.prefs::use_rstudio_prefs( \
  always_save_history = FALSE, \
  initial_working_directory = '~/CATnap', \
  load_workspace = TRUE, \
  save_workspace = 'never', \
  rainbow_parentheses = TRUE, \
  editor_theme = 'Chaos', \
  python_type = 'system', \
  python_version = '3.8.10', \
  python_path = '/usr/bin/python3.8', \
  posix_terminal_shell = 'bash', \
  terminal_renderer = 'dom')"

# Generate session info
RUN R -e "reticulate::py_config()"

