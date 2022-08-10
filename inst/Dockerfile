FROM rocker/verse:4.2.1

LABEL org.opencontainers.image.authors="Aaron Willcox <aaron.willcox@unimelb.edu.au>" \
org.opencontainers.image.source="https://github.com/psychtek/docker-replicat"

COPY /inst/rocker_scripts/install_python.sh /tmp/

COPY /inst/rocker_scripts/install_pyenv.sh /tmp/

RUN chmod +x /tmp/install_python.sh

RUN chmod +x /tmp/install_pyenv.sh

RUN /tmp/install_python.sh

RUN /tmp/install_pyenv.sh

COPY /inst/rocker_scripts/install_verse.sh /tmp/

RUN /tmp/install_verse.sh

# Generate Python info
RUN R -e "reticulate::py_config()"

# Generate R Platform Info
RUN R -e "sessioninfo::platform_info()"
