FROM jupyter/scipy-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

RUN apt -y update && apt -y upgrade
RUN apt install -y wget \
    git

# Intall Python packages
RUN pip3 install notebook \
    jupyterlab \
    jupyterlab-git \
    jupyter_contrib_nbextensions \
    lckr-jupyterlab-variableinspector \
    scipy \
    seaborn \
    scikit-learn \
    sympy \
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
    bokeh \
    sudachipy

# Install Julia
ARG JULIA_VERSION="1.8.5"
RUN JULIA_MAJOR=`echo $JULIA_VERSION | sed -E  "s/\.[0-9]+$//g"` && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR/julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    cp -r julia-$JULIA_VERSION /opt/ && \
    ln -s /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \
    rm -r julia-$JULIA_VERSION-linux-x86_64.tar.gz


# Insatall Julia package
USER jovyan
RUN julia -e 'ENV["PYTHON"] = raw"/usr/bin/python3";using Pkg;Pkg.update();Pkg.add(["IJulia","PyCall"]);Pkg.build(["IJulia","PyCall"]);'
RUN julia -e 'using Pkg;Pkg.add(["DataFrames","PyPlot","Distributions","Statistics","JuliaFormatter","CPUTime","Gadfly","GLM","Optim","Plots","Query","RDatasets","SpecialFunctions","StatisticalRethinking","StatsBase","StatsFuns","StatsPlots","AdvancedHMC","BAT","Bijectors","CmdStan","DiffEqBayes","DistributionsAD","ForwardDiff","MCMCChains","MeasureTheory","ParameterizedFunctions","Turing","LinearAlgebra","DifferentialEquations","Roots","SymPy","ForneyLab"]);Pkg.precompile()'
WORKDIR "${HOME}"
