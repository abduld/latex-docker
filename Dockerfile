FROM nopreserveroot/latexmk-tlcontrib-sysfonts:2020.02.01
LABEL maintainer="dakkak@illinois.edu"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && apt-get install -qy --no-install-recommends --no-install-suggests \
  gcc \
  graphviz \
  inkscape \
  make \
  python \
  python-dev \
  python-tk \
  python-pip \
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


# Backups only make the cache bigger
RUN tlmgr option -- autobackup 0

# Update a cached version first (else later step might fail)
RUN tlmgr update --self

RUN tlmgr update --all

RUN pip install --upgrade pip \
  && rm -r ~/.cache/pip
RUN pip install --upgrade setuptools \
  && rm -r ~/.cache/pip
RUN pip install pandas seaborn pyyaml statsmodels pandoc-plantuml-filter pygments-mathematica \
  && rm -r ~/.cache/pip

RUN pip3 install --upgrade pip \
  && rm -r ~/.cache/pip
RUN pip3 install --upgrade setuptools \
  && rm -r ~/.cache/pip
RUN pip3 install pandas seaborn pyyaml statsmodels pandoc-plantuml-filter pygments-mathematica \
  && rm -r ~/.cache/pip

ADD entry.sh /entry.sh

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/entry.sh"]
