FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
USER root

# move in the yaml to build modulefiles from
COPY mavis_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder & file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# add the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy the setup file to load the modules at startup
COPY .bashrc /home/ubuntu/.bashrc

# set environment paths for modules
ENV MAVIS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/mavis-2.2.6"
ENV PYTHON_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6"
ENV BLAT_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/blat-36"
ENV CONDA_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14"

ENV PATH="/modules/gsi/modulator/sw/Ubuntu18.04/mavis-2.2.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/blat-36/bin:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV MANPATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/blat-36/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/share/man"
ENV LD_LIBRARY_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/mavis-2.2.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/blat-36/lib:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib"
ENV PYTHONPATH="/modules/gsi/modulator/sw/Ubuntu18.04/mavis-2.2.6/lib/python3.6/site-packages:/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib/python3.6/site-packages:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib/python3.7/site-packages"
ENV PKG_CONFIG_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib/pkgconfig:/modules/gsi/modulator/sw/Ubuntu18.04/blat-36/lib/pkgconfig:/modules/gsi/modulator/sw/Ubuntu18.04/conda-4.6.14/lib/pkgconfig" 

CMD /bin/bash
