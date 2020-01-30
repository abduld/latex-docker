all: build_and_push

build_base:
	docker build . -f Dockerfile.base -t dakkak/latex:base
build_science: build_base
	docker build . -f Dockerfile.science -t dakkak/latex:science
build_tikz: build_science
	docker build . -f Dockerfile.tikz -t dakkak/latex:tikz
build_heavy: build_base
	docker build . -f Dockerfile.heavy -t dakkak/latex:heavy
build_full: build_heavy
	docker build . -f Dockerfile.full -t dakkak/latex:full
	docker build . -f Dockerfile.full -t dakkak/latex:latest

push_base: build_base
	docker push dakkak/latex:base
push_science: build_science
	docker push dakkak/latex:science
push_tikz: build_tikz
	docker push dakkak/latex:tikz
push_heavy: build_heavy
	docker push dakkak/latex:heavy
push_full: build_full
	docker push dakkak/latex:full
	docker push dakkak/latex:latest

build_and_push: push_base push_science push_tikz push_heavy push_full
