#!/bin/bash
set -e

## Code borrowed from rocker-verse

## build ARGs
NCPUS=${NCPUS:--1}

CRAN=${1:-${CRAN:-"https://cran.r-project.org"}}

ARCH=$(uname -m)

# always set this for scripts but don't declare as ENV..
export DEBIAN_FRONTEND=noninteractive

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

##  mechanism to force source installs if we're using RSPM
UBUNTU_VERSION=$(lsb_release -sc)
CRAN_SOURCE=${CRAN/"__linux__/$UBUNTU_VERSION/"/""}

## source install if using RSPM and arm64 image
if [ "$ARCH" = "aarch64" ]; then
    CRAN=$CRAN_SOURCE
fi

### Additional base dependencies
apt_install \
    curl \
    qpdf \
    texinfo \
    software-properties-common \
    vim \
    wget \
    jags \
    r-cran-rjags \
    nano \
    netcdf-bin \
    openbox \
    postgis \
    protobuf-compiler \
    sqlite3

# Remotes Installs
Rscript -e "install.packages(c('remotes'), repos='${CRAN_SOURCE}')"
Rscript -e "remotes::install_github('jthomasmock/gtExtras')"
Rscript -e "remotes::install_version('pins', version = '0.4.5')"
Rscript -e "remotes::install_github('mitchelloharawild/icons')"

# Additional R libraries
install2.r --error --skipinstalled -n "$NCPUS" \
    sessioninfo \
    vroom \
    gert \
    blogdown \
    bookdown \
    rstudio.prefs \
    rticles \
    rJava \
    xaringan \
    GoFKernel \
    qualtRics \
    rfUtilities \
    rjags \
    R2jags \
    pointblank \
    qpdf \
    VGAM \
    mathjaxr \
    precrec \
    readr \
    readxl \
    ggridges \
    ggthemes \
    glue \
    gt \
    gtable \
    git2r \
    haven \
    huxtable \
    here \
    janitor \
    jsonvalidate \
    kableExtra \
    KernSmooth \
    log4r \
    osfr \
    R.utils \
    R.methodsS3 \
    R.oo \
    tidybayes \
    XML \
    DT \
    tidymodels


# Clean up
rm -rf /var/lib/apt/lists/*

# Check the R info
echo -e "Check the littler info...\n"

r --version

echo -e "Check the R info...\n"

R -q -e "sessionInfo()"

R -q -e "library(tidyverse)"

R -q -e "reticulate::py_config()"

R -q -e "sessioninfo::platform_info()"

# Clean up
rm -rf /tmp/downloaded_packages
rm -rf /var/lib/apt/lists/*

## Strip binary installed lybraries from RSPM
## https://github.com/rocker-org/rocker-versioned2/issues/340
strip /usr/local/lib/R/site-library/*/libs/*.so
