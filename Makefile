all: build_and_push

build_base:
	docker build . -f Dockerfile -t dakkak/latex:latest


push_base: build_base
	docker push dakkak/latex:latest

build_and_push: push_base
