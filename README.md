# Dockerfile for Jupyter notebook in Computational Clinical Psychology Lab

This is a repository of Dockerfile for Jupyter notebook used in [Computational Clinical Psychology Lab](https://kunisatolab.github.io/english/index.html). This Dockerfile contains

- Julia packages (ForwardDiff, LinearAlgebra, Optim, Gadfly, Plots, StatsPlots, DifferentialEquations, RDatasets, Distributions, StatsFuns, StatsBase, Distributions, Turing, Stan, StanOptimize, StanBase, StanVariational, StanDiagnose, CmdStan, StanSample, DiffEqBayes)
- [psychopy](https://www.psychopy.org/) But not working now for [NoSuchDisplayException Error](https://discourse.psychopy.org/t/running-psychopy-on-a-public-notebook-server-nosuchdisplayexception-cannot-connect-to-none/11538)
- [MNE python](https://mne.tools/stable/index.html) without 3D plotting and source analysis

Maintainer is Yoshihiko Kunisato (ykunisato@psy.senshu-u.ac.jp)

## Usage

1. Install ["Docker Desktop"](https://www.docker.com/products/docker-desktop)

2. Open "terminal"(Mac) or Command Prompt(Win, I don't know Win. Sorry!)

3. Type the following code to pull a Docker container. Change the "name" and "NotebookApp.token=" as you like.

```
docker run -d --name notebook -v `pwd`:/home/jovyan/work -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes ykunisato/ccp-lab-j start-notebook.sh --NotebookApp.token="token that you set"
```

4. Open the web browser and type "http://localhost:8888/" in the URL bar.

5. You will see the JupyterLab on the web browser. Type JupyterLab in token that you set.
