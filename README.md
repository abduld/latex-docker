# latex-docker

    docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data cwpearson/latex:full "$@"
