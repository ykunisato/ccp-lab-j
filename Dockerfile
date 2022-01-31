FROM jupyter/datascience-notebook
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

USER root
RUN conda update pip -y
# Install MNE python(https://mne.tools/stable/index.html) without 3D plotting and source analysis
RUN pip install mne
# Install Axelrod
RUN pip install axelrod
# Install Cartopy
RUN conda install -c conda-forge cartopy
# Install DEAP
RUN pip install deap
# Install japanize-matplotlib
RUN pip install japanize-matplotlib
# Install MeCab
RUN pip install mecab-python3
# Install UniDic
RUN pip install unidic-lite
# Install mplfinance
RUN pip install --upgrade mplfinance
# Install NetworkX
RUN pip install networkx
# Install PuLP
RUN pip install PuLP
# Install pyaudio
RUN conda update -n base conda
RUN conda install --channel https://conda.anaconda.org/anaconda pyaudio
# Install pyMC3
RUN conda install -c conda-forge pymc3
# Install rpy2
RUN conda install rpy2
RUN conda install tzlocal
# Install SimPy
RUN pip install simpy
# Install VPython
RUN conda install -c vpython vpython
# Install xlrd
RUN conda install -c anaconda xlrd
# Install PsychRNN-v1.0.0-alpha
RUN pip install psychrnn==1.0.0-alpha
# Install pyDDM
RUN pip install pyddm
# Install mlxtend
RUN conda install mlxtend

# Install cuda(https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.0/ubuntu20.04-x86_64/base/Dockerfile)
#RUN apt-get update && apt-get install -y --no-install-recommends \
#    gnupg2 curl ca-certificates && \
#    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
#    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
#    apt-get purge --autoremove -y curl \
#    && rm -rf /var/lib/apt/lists/*

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
#RUN apt-get update && apt-get install -y --no-install-recommends \
#    cuda-cudart-11-0=11.0.221-1 \
#    cuda-compat-11-0 \
#    && ln -s cuda-11.0 /usr/local/cuda && \
#    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
#RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
#    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

#ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
#ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# Install julia Pkg
## Stats
RUN julia -e 'using Pkg; Pkg.update()' && \
    julia -e 'using Pkg; Pkg.add("CPUTime")' && \
    julia -e 'using Pkg; Pkg.add("Distributions")' && \
    julia -e 'using Pkg; Pkg.add("Gadfly")' && \
    julia -e 'using Pkg; Pkg.add("GLM")' && \
    julia -e 'using Pkg; Pkg.add("Optim")' && \
    julia -e 'using Pkg; Pkg.add("Plots")' && \
    julia -e 'using Pkg; Pkg.add("PyCall")' && \
    julia -e 'using Pkg; Pkg.add("PyPlot")' && \
    julia -e 'using Pkg; Pkg.add("Query")' && \
    julia -e 'using Pkg; Pkg.add("RDatasets")' && \
    julia -e 'using Pkg; Pkg.add("SpecialFunctions")' && \
    julia -e 'using Pkg; Pkg.add("StatisticalRethinking")' && \
    julia -e 'using Pkg; Pkg.add("StatsBase")' && \
    julia -e 'using Pkg; Pkg.add("StatsFuns")'&& \
    julia -e 'using Pkg; Pkg.add("StatsPlots")'
## stan and turing
RUN julia -e 'using Pkg; Pkg.add("AdvancedHMC")' && \
    julia -e 'using Pkg; Pkg.add("BAT")' && \
    julia -e 'using Pkg; Pkg.add("Bijectors")' && \
    julia -e 'using Pkg; Pkg.add("CmdStan")' && \
    julia -e 'using Pkg; Pkg.add("DiffEqBayes")' && \
    julia -e 'using Pkg; Pkg.add("DistributionsAD")' && \
    julia -e 'using Pkg; Pkg.add("ForwardDiff")' && \
    julia -e 'using Pkg; Pkg.add("MCMCChains")' && \
    julia -e 'using Pkg; Pkg.add("MeasureTheory")' && \
    julia -e 'using Pkg; Pkg.add("ParameterizedFunctions")' && \
    julia -e 'using Pkg; Pkg.add("Soss")' && \
    julia -e 'using Pkg; Pkg.add("Turing")'
## ODE
RUN julia -e 'using Pkg; Pkg.add("CalculusWithJulia")' && \
    julia -e 'using Pkg; Pkg.add("LinearAlgebra")' && \
    julia -e 'using Pkg; Pkg.add("DifferentialEquations")'  
## Active Inference
RUN julia -e 'using Pkg; Pkg.add("ForneyLab")'

# install extentions
RUN pip install jupyterlab-git
RUN pip install jupyter_contrib_nbextensions
RUN jupyter labextension install @lckr/jupyterlab_variableinspector@3.0.7
RUN jupyter nbextension enable @lckr/jupyterlab_variableinspector/main

# Install infer-actively 
USER jovyan
RUN pip install inferactively-pymdp