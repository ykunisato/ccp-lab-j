FROM jupyter/datascience-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

## Install Python module
USER root
RUN conda update pip -y
# MNE python(https://mne.tools/stable/index.html) without 3D plotting and source analysis
RUN pip install mne
# Axelrod
RUN pip install axelrod
# Cartopy
RUN conda install -c conda-forge cartopy
# DEAP
RUN pip install deap
# japanize-matplotlib
RUN pip install japanize-matplotlib
# MeCab
RUN pip install mecab-python3
# UniDic
RUN pip install unidic-lite
# mplfinance
RUN pip install --upgrade mplfinance
# NetworkX
RUN pip install networkx
# PuLP
RUN pip install PuLP
# pyaudio
RUN conda update -n base conda
RUN conda install --channel https://conda.anaconda.org/anaconda pyaudio
# pyMC3
RUN conda install -c conda-forge pymc3
# rpy2
RUN conda install rpy2
RUN conda install tzlocal
# SimPy
RUN pip install simpy
# VPython
RUN conda install -c vpython vpython
# xlrd
RUN conda install -c anaconda xlrd
# PsychRNN-v1.0.0-alpha
RUN pip install psychrnn==1.0.0-alpha
# pyDDM
RUN pip install pyddm
# mlxtend
RUN conda install mlxtend

## Install julia Pkg
RUN julia -e 'using Pkg; Pkg.update()'
# Stats
RUN julia -e 'using Pkg; Pkg.add("CPUTime")'
RUN julia -e 'using Pkg; Pkg.add("Distributions")'
RUN julia -e 'using Pkg; Pkg.add("Gadfly")'
RUN julia -e 'using Pkg; Pkg.add("GLM")'
RUN julia -e 'using Pkg; Pkg.add("Optim")'
RUN julia -e 'using Pkg; Pkg.add("Plots")'
RUN julia -e 'using Pkg; Pkg.add("PyCall")'
RUN julia -e 'using Pkg; Pkg.add("PyPlot")'
RUN julia -e 'using Pkg; Pkg.add("Query")'
RUN julia -e 'using Pkg; Pkg.add("RDatasets")'
RUN julia -e 'using Pkg; Pkg.add("SpecialFunctions")'
RUN julia -e 'using Pkg; Pkg.add("StatisticalRethinking")'
RUN julia -e 'using Pkg; Pkg.add("StatsBase")'
RUN julia -e 'using Pkg; Pkg.add("StatsFuns")'
RUN julia -e 'using Pkg; Pkg.add("StatsPlots")'
# stan and turing
RUN julia -e 'using Pkg; Pkg.add("AdvancedHMC")'
RUN julia -e 'using Pkg; Pkg.add("BAT")'
RUN julia -e 'using Pkg; Pkg.add("Bijectors")'
RUN julia -e 'using Pkg; Pkg.add("CmdStan")'
RUN julia -e 'using Pkg; Pkg.add("DiffEqBayes")'
RUN julia -e 'using Pkg; Pkg.add("DistributionsAD")'
RUN julia -e 'using Pkg; Pkg.add("ForwardDiff")'
RUN julia -e 'using Pkg; Pkg.add("MCMCChains")'
RUN julia -e 'using Pkg; Pkg.add("MeasureTheory")'
RUN julia -e 'using Pkg; Pkg.add("ParameterizedFunctions")'
RUN julia -e 'using Pkg; Pkg.add("Soss")'
RUN julia -e 'using Pkg; Pkg.add("Turing")'
## ODE
RUN julia -e 'using Pkg; Pkg.add("CalculusWithJulia")'
RUN julia -e 'using Pkg; Pkg.add("LinearAlgebra")'
RUN julia -e 'using Pkg; Pkg.add("DifferentialEquations")' 
RUN julia -e 'using Pkg; Pkg.add("Roots")' 
RUN julia -e 'using Pkg; Pkg.add("SymPy")' 
## Active Inference
RUN julia -e 'using Pkg; Pkg.add("ForneyLab")'

# notebook extentions
RUN pip install jupyterlab-git
RUN pip install jupyter_contrib_nbextensions
RUN jupyter labextension install @lckr/jupyterlab_variableinspector@3.0.7
RUN jupyter nbextension enable @lckr/jupyterlab_variableinspector/main

# nfer-actively 
USER jovyan
RUN pip install inferactively-pymdp