all: build_and_push

build_base:
	docker build . -f Dockerfile -t dakkak/latex:latest
	./docker_slim/docker-slim build dakkak/latex:latest
	docker tag dakkak/latex:latest dakkak/latex:20.04


push_base: build_base
	docker push dakkak/latex:latest
	docker push dakkak/latex:20.04

build_and_push: push_base
