# latex-docker

Inspired by [blang/latex-docker](https://github.com/blang/latex-docker)

There are 5 tags available at [dakkak/latex](https://hub.docker.com/r/dakkak/latex/):

All python packages are duplicated in python3 as well.

| tag                  | ubuntu packages                                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------------------------- |
| dakkak/latex:base    | `gcc`, `graphviz`, `inkscape`, `make`, `python`, `python-dev`,  `python-tk`, `python-pip`, `texlive-base`, `java` |
| dakkak/latex:science | base + `texlive-science`                                                                                          |
| dakkak/latex:tikz    | science + `texlive-latex-extra`, `texlive-pictures`, `pgf`                                                        |
| dakkak/latex:heavy   | base + `texlive-full` without languages, documentation                                                            |
| dakkak/latex:full    | heavy + `texlive-full`                                                                                            |

| tag                  | pip packages                      |
| -------------------- | --------------------------------- |
| dakkak/latex:base    | `pandas`, `seaborn`, `setuptools` |
| dakkak/latex:science | base                              |
| dakkak/latex:tikz    | base                              |
| dakkak/latex:heavy   | base                              |
| dakkak/latex:full    | base                              |

`dakkak/latex:latest` points to `dakkak/latex:full`

To run this in bash, try something like:

    docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data dakkak/latex:heavy "$@"

To run in a makefile, try something like:

    USR := $(shell id -u)
    GRP := $(shell id -g)
    PWD := $(shell pwd)
    DOCKER = docker run --rm -i --user="${USR}:${GRP}" --net=none -v "${PWD}":/data dakkak/latex:tikz
    all:
	    ${DOCKER} pdflatex <latex file>
