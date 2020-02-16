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
  pandoc \
  pandoc-citeproc \
  pandoc-citeproc-preamble \
  pandoc-plantuml-filter \
  pandoc-sidenote \
  python3-pypandoc \
  python3-pandocfilters \
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
  texlive-xetex \
  && rm -rf /var/lib/apt/lists/*

RUN tlmgr init-usertree

# Backups only make the cache bigger
RUN tlmgr option -- autobackup 0

# Update a cached version first (else later step might fail)
RUN tlmgr update --self

RUN tlmgr update --all

RUN tlmgr install amsfonts \
              amsmath \
              babel \
              booktabs \
              fancyvrb \
              geometry \
              graphics \
              hyperref \
              iftex \
              listings \
              lm \
              lm-math \
              logreq \
              oberdiek \
              setspace \
              tools \
              ulem \
              unicode-math \
              xcolor \
              || exit 1

# Needed for when --highlight-style used with something other than pygments.
RUN tlmgr install framed || exit 1

################################################################################
# Install extra packages for XeTex, LuaTex, and BibLaTex.                      #
################################################################################
RUN tlmgr install bidi \
              csquotes \
              fontspec \
              luatex \
              lualatex-math \
              mathspec \
              microtype \
              pdftexcmds \
              polyglossia \
              upquote \
              xecjk \
              xetex \
              || exit 1

# Make sure all reference backend options are installed
RUN tlmgr install biber \
              biblatex \
              bibtex \
              natbib \
              || exit 1

# These packages were identified by the tests, they are likely dependencies of
# dependencies that are not encoded well.
RUN tlmgr install footnotehyper \
              letltxmacro \
              xurl \
              || exit 1
              
RUN pip3 install --upgrade pip 
RUN pip3 install --upgrade setuptools 
RUN pip3 install pandas seaborn pyyaml statsmodels pandoc-plantuml-filter pygments-mathematica 

ADD entry.sh /entry.sh

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/entry.sh"]
