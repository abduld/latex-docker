FROM ubuntu:20.04
LABEL maintainer="dakkak@illinois.edu"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy --no-install-recommends --no-install-suggests \
  gcc \
  graphviz \
  inkscape \
  make \
  python3 \
  python3-dev \
  python3-tk \
  python3-pip \
  xvfb \
  ghostscript \
  gnupg \
  graphviz \
  default-jre \
  perl \
  python-pygments \
  tar \
  fonts-freefont-ttf \
  fonts-font-awesome \
  wget \
  xzdec \
  libfile-fcntllock-perl \
  equivs \
  libwww-perl \
  fontconfig \
  unzip \
  dvidvi \
  tipa \
  && rm -rf /var/lib/apt/lists/*


RUN apt-get update -q && apt-get install -qy --no-install-recommends --no-install-suggests \
  texlive-latex-extra \
  texlive-formats-extra \
  latexdiff \
  texlive-binaries \
  texlive-base \
  texlive-latex-recommended \
  lcdf-typetools \
  texlive-font-utils \
  texlive-metapost \
  texlive-pstricks \
  purifyeps \
  dvidvi \
  texlive-publishers \
  texlive-science \
  fragmaster \
  texlive-fonts-recommended \
  prerex \
  texlive-humanities \
  texinfo \
  texlive-xetex \
  texlive-luatex \
  feynmf \
  texlive-fonts-extra \
  chktex \
  texlive-extra-utils \
  lmodern \
  tex4ht \
  psutils \
  tex-gyre \
  texlive-games \
  texlive-latex-base \
  dvipng \
  latex-cjk-all \
  cm-super \
  latexmk \
  lacheck \
  tipa \
  texlive-music \
  texlive-pictures \
  texlive-bibtex-extra \
  t1utils \
  texlive-full \
  chktex \
  biber \
  cm-super  \
  latexdiff \
  lmodern \
  t1utils \
  texlive-xetex \
  && rm -rf /var/lib/apt/lists/*

RUN tlmgr init-usertree

# Backups only make the cache bigger
RUN tlmgr option -- autobackup 0

# Update a cached version first (else later step might fail)
RUN tlmgr update --self

RUN tlmgr update --all

RUN pip3 install --upgrade pip \
  && rm -r ~/.cache/pip3
RUN pip3 install --upgrade setuptools \
  && rm -r ~/.cache/pip3
RUN pip3 install pandas seaborn pyyaml statsmodels pandoc-plantuml-filter pygments-mathematica \
  && rm -r ~/.cache/pip3

ADD entry.sh /entry.sh

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/entry.sh"]
