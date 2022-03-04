# Dockerfile for Jupyter notebook in Computational Clinical Psychology Lab

This is a repository of Dockerfile for Jupyter notebook used in [Computational Clinical Psychology Lab](https://kunisatolab.github.io/english/index.html). This Dockerfile contains

- Python package(inferactively-pymdp,bokeh,scipy,seaborn,scikit-learn,sympy,mne,mecab-python3,pymc3,psychrnn,pyddm...)
- Julia packages ("PyCall","DataFrames","PyPlot","Distributions","Statistics","JuliaFormatter","CPUTime","Gadfly","GLM","Optim","Plots","Query","RDatasets","SpecialFunctions","StatisticalRethinking","StatsBase","StatsFuns","StatsPlots","AdvancedHMC","BAT","Bijectors","CmdStan","DiffEqBayes","DistributionsAD","ForwardDiff","MCMCChains","MeasureTheory","ParameterizedFunctions","Soss","Turing","LinearAlgebra","DifferentialEquations","Roots","SymPy","ForneyLab")

This Dockerfile is dependent on jupyter/scipy-notebook and compatible with Arm64 (Apple silicone).


Maintainer is Yoshihiko Kunisato (ykunisato@psy.senshu-u.ac.jp)

## Usage

1. Install ["Docker Desktop"](https://www.docker.com/products/docker-desktop)

2. Open "terminal"(Mac) or "Command Prompt"(Windows)

3. Type the following code to pull a Docker container. Change the "name" and "NotebookApp.token=" as you like.


**terminal on Mac**


```
docker run -d --name notebook -v `pwd`:/home/jovyan/work -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes ykunisato/ccp-lab-j start-notebook.sh --NotebookApp.token="token that you set"
```

**terminal on Mac(Apple Silicon)**

```
docker run -d --name notebook -v `pwd`:/home/jovyan/work -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes ykunisato/ccp-lab-j:m1-julia1-7-2 start-notebook.sh --NotebookApp.token="token that you set"
```


**Command Prompt on Windows**


```
docker run -d --name notebook -v "%cd%":/home/jovyan/work -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes ykunisato/ccp-lab-j start-notebook.sh --NotebookApp.token="token that you set"
```


4. Open the web browser and type "http://localhost:8888/" in the URL bar.

5. You will see the JupyterLab on the web browser. Type JupyterLab in token that you set.
