FROM jupyter/scipy-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

## Install Python module
RUN pip3 install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu
RUN pip3 install jax \
    simpy \
    pymc3 \
    inferactively-pymdp \
    mne \
    pyddm \
    psychrnn \
    bokeh \
    mecab-python3 \
    japanize-matplotlib

#  pip install evojax

# Install Julia
USER root
ARG JULIA_VERSION="1.7.2"
RUN JULIA_MAJOR=`echo $JULIA_VERSION | sed -E  "s/\.[0-9]+$//g"` && \
    wget https://julialang-s3.julialang.org/bin/linux/aarch64/$JULIA_MAJOR/julia-$JULIA_VERSION-linux-aarch64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-aarch64.tar.gz && \
    cp -r julia-$JULIA_VERSION /opt/ && \
    ln -s /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \
    rm -r julia-$JULIA_VERSION-linux-aarch64.tar.gz

# Insatall Julia package
USER jovyan
RUN julia -e 'ENV["PYTHON"] = "";using Pkg;Pkg.update();Pkg.add(["IJulia","PyCall"]);Pkg.build(["IJulia","PyCall"]);' 
RUN julia -e 'using Pkg;Pkg.add(["DataFrames","PyPlot","Distributions","Statistics","JuliaFormatter","CPUTime","Gadfly","GLM","Optim","Plots","Query","RDatasets","SpecialFunctions","StatisticalRethinking","StatsBase","StatsFuns","StatsPlots","AdvancedHMC","BAT","Bijectors","CmdStan","DiffEqBayes","DistributionsAD","ForwardDiff","MCMCChains","MeasureTheory","ParameterizedFunctions","Turing","LinearAlgebra","DifferentialEquations","Roots","SymPy","ForneyLab","Genie"]);Pkg.precompile()'

WORKDIR "${HOME}"