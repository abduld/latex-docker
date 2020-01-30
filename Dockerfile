FROM ubuntu:latest
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

RUN pip install --upgrade pip \
  && rm -r ~/.cache/pip
RUN pip install --upgrade setuptools \
  && rm -r ~/.cache/pip
RUN pip install pandas seaborn pyyaml statsmodels \
  && rm -r ~/.cache/pip

RUN pip3 install --upgrade pip \
  && rm -r ~/.cache/pip
RUN pip3 install --upgrade setuptools \
  && rm -r ~/.cache/pip
RUN pip3 install pandas seaborn pyyaml statsmodels \
  && rm -r ~/.cache/pip


ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"

COPY \
  setup.sh \
  texlive.profile \
  texlive_pgp_keys.asc \
   /

RUN chmod +x /setup.sh && /setup.sh

ADD entry.sh /entry.sh

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/entry.sh"]
