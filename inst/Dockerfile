FROM rocker/verse:4.2.1

LABEL org.opencontainers.image.authors="Aaron Willcox <aaron.willcox@unimelb.edu.au>" \
org.opencontainers.image.source="https://github.com/psychtek/docker-replicat"

# install scripts port from: https://github.com/rocker-org/rocker-versioned2
COPY /inst/rocker_scripts/install_python.sh /tmp/

COPY /inst/rocker_scripts/install_pyenv.sh /tmp/

RUN chmod +x /tmp/install_python.sh

RUN /tmp/install_python.sh

COPY /inst/rocker_scripts/install_additional.sh /tmp/

RUN /tmp/install_additional.sh

COPY /inst/rocker_scripts/install_quarto.sh /tmp/

RUN chmod +x /tmp/install_quarto.sh

RUN /tmp/install_quarto.sh
