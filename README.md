# latex-docker


`dakkak/latex:latest` points to `dakkak/latex:full`

To run this in bash, try something like:

    docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data dakkak/latex:latest "$@"

To run in a makefile, try something like:

    USR := $(shell id -u)
    GRP := $(shell id -g)
    PWD := $(shell pwd)
    DOCKER = docker run --rm -i --user="${USR}:${GRP}" --net=none -v "${PWD}":/data dakkak/latex:latest
    all:
	    ${DOCKER} pdflatex <latex file>
