FROM ubuntu:20.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# # julia
# RUN mkdir /opt/julia \
#     && curl -L https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.0-linux-x86_64.tar.gz | tar zxf - -C /opt/julia --strip=1 \
#     && chown -R 1000 /opt/julia \
#     && ln -s /opt/julia/bin/julia /usr/local/bin

## setup unprivileged user
ENV USER shifter
ENV SHIFTER_HOME=/home/$USER
RUN adduser --disabled-password --gecos "Default user" --uid 1000 $USER
USER $USER

# python libraries
RUN pip3 install jupyterlab jupyterhub

# see https://docs-dev.nersc.gov/jupyter/
ENV PATH=/home/shifter/.local/bin:$PATH
ENV NERSC_JUPYTER_IMAGE=YES