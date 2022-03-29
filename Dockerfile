FROM jupyter/scipy-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

## Install Python module
USER root
RUN pip3 install jupyterlab-git \
    jupyter_contrib_nbextensions \
    lckr-jupyterlab-variableinspector \
    mne \
    axelrod \
    deap \
    japanize-matplotlib \
    mecab-python3 \
    unidic-lite \
    networkx \
    PuLP \
    pymc3 \
    simpy \
    psychrnn \
    pyddm \
    inferactively-pymdp\
    bokeh

# Install Julia
ARG JULIA_VERSION="1.7.2"
RUN JULIA_MAJOR=`echo $JULIA_VERSION | sed -E  "s/\.[0-9]+$//g"` && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR/julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    cp -r julia-$JULIA_VERSION /opt/ && \
    ln -s /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \
    rm -r julia-$JULIA_VERSION-linux-x86_64.tar.gz

# Insatall Julia package
USER jovyan
RUN julia -e 'ENV["PYTHON"] = "";using Pkg;Pkg.update();Pkg.add(["IJulia","PyCall"]);Pkg.build(["IJulia","PyCall"]);'
RUN julia -e 'using Pkg;Pkg.add(["DataFrames","PyPlot","Distributions","Statistics","JuliaFormatter","CPUTime","Gadfly","GLM","Optim","Plots","Query","RDatasets","SpecialFunctions","StatisticalRethinking","StatsBase","StatsFuns","StatsPlots","AdvancedHMC","BAT","Bijectors","CmdStan","DiffEqBayes","DistributionsAD","ForwardDiff","MCMCChains","MeasureTheory","ParameterizedFunctions","Soss","Turing","LinearAlgebra","DifferentialEquations","Roots","SymPy","ForneyLab","Genie"]);Pkg.precompile()'

WORKDIR "${HOME}"
