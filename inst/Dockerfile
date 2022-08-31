FROM rocker/verse:4.2.1

LABEL org.opencontainers.image.authors="Aaron Willcox <aaron.willcox@unimelb.edu.au>" \
org.opencontainers.image.source="https://github.com/psychtek/docker-replicat"

# install scripts port from: https://github.com/rocker-org/rocker-versioned2
COPY /inst/rocker_scripts/install_python.sh /tmp/

COPY /inst/rocker_scripts/install_pyenv.sh /tmp/

RUN chmod +x /tmp/install_python.sh

#RUN chmod +x /tmp/install_pyenv.sh

RUN /tmp/install_python.sh

#RUN /tmp/install_pyenv.sh

COPY /inst/rocker_scripts/install_additional.sh /tmp/

RUN /tmp/install_additional.sh

# Generate Jags infomation
RUN R -e "rjags::jags.version()"

# Generate Python info
RUN R -e "reticulate::py_config()"

# Generate R Platform Info
RUN R -e "sessioninfo::platform_info()"
