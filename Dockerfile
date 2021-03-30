FROM ubuntu:20.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

## setup unprivileged user
ENV USER shifter
ENV SHIFTER_HOME=/home/$USER
RUN adduser --disabled-password --gecos "Default user" --uid 1000 $USER
USER $USER
ENV PATH=$SHIFTER_HOME/.local/bin:$PATH

# python libraries
RUN pip3 install jupyterlab jupyterhub \
    && chmod 755 $SHIFTER_HOME/.local

# see https://docs-dev.nersc.gov/jupyter/
ENV NERSC_JUPYTER_IMAGE=YES