FROM jupyter/datascience-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

USER root

# Install PsychoPy(not working now)
# https://discourse.psychopy.org/t/running-psychopy-on-a-public-notebook-server-nosuchdisplayexception-cannot-connect-to-none/11538
# RUN apt-get update &&\
#    apt-get install -y x11-apps
# ENV DISPLAY=localhost:0.0
RUN conda update pip -y
RUN pip install pyglet psychopy

# Install MNE python(https://mne.tools/stable/index.html) without 3D plotting and source analysis
RUN pip install mne

# Install cuda(https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.0/ubuntu20.04-x86_64/base/Dockerfile)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-11-0=11.0.221-1 \
    cuda-compat-11-0 \
    && ln -s cuda-11.0 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441"


# Install cmdstan
RUN mkdir /opt/cmdstan &&\
    curl -L https://github.com/stan-dev/cmdstan/releases/download/v2.23.0/cmdstan-2.23.0.tar.gz | tar -z -x -C /opt/cmdstan --strip-components=1 &&\
    cd /opt/cmdstan &&\
    make build
ENV CMDSTAN_HOME /opt/cmdstan

# Install julia Pkg
RUN julia -e 'using Pkg; Pkg.update()' && \
    julia -e 'using Pkg; Pkg.add("ForwardDiff")' && \
    julia -e 'using Pkg; Pkg.add("LinearAlgebra")' && \
    julia -e 'using Pkg; Pkg.add("Optim")' && \
    julia -e 'using Pkg; Pkg.add("Gadfly")' && \
    julia -e 'using Pkg; Pkg.add("Plots")' && \
    julia -e 'using Pkg; Pkg.add("StatsPlots")' && \
    julia -e 'using Pkg; Pkg.add("DifferentialEquations")' && \
    julia -e 'using Pkg; Pkg.add("RDatasets")' && \
    julia -e 'using Pkg; Pkg.add("Distributions")' && \
    julia -e 'using Pkg; Pkg.add("StatsFuns")'&& \
    julia -e 'using Pkg; Pkg.add("StatsBase")' && \
    julia -e 'using Pkg; Pkg.add("Distributions")'&& \
    julia -e 'using Pkg; Pkg.add("Turing")' && \
    julia -e 'using Pkg; Pkg.add("Stan")' && \
    julia -e 'using Pkg; Pkg.add("StanOptimize")' && \
    julia -e 'using Pkg; Pkg.add("StanBase")' && \
    julia -e 'using Pkg; Pkg.add("StanVariational")' && \
    julia -e 'using Pkg; Pkg.add("StanDiagnose")' && \
    julia -e 'using Pkg; Pkg.add("CmdStan")' && \
    julia -e 'using Pkg; Pkg.add("StanSample")' && \
    julia -e 'using Pkg; Pkg.add("DiffEqBayes")' && \
    julia -e 'using Pkg; Pkg.add("StanMamba")'


# install tensorflow
RUN conda config --set channel_priority false
RUN conda update --all
RUN conda install -c anaconda tensorflow-gpu
RUN conda install -c anaconda tensorflow-hub
RUN conda install -c anaconda tensorflow-datasets
RUN conda install -y pydot graphviz

USER jovyan
# Install PsychRNN-v1.0.0-alpha
RUN pip install psychrnn==1.0.0-alpha
