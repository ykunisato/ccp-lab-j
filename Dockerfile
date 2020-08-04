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
