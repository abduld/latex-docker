#!/bin/sh

set -e

scheme="$1"

retry() {
  retries=$1
  shift

  count=0
  until "$@"; do
    exit=$?
    wait="$(echo "2^$count" | bc)"
    count="$(echo "$count + 1" | bc)"
    if [ "$count" -lt "$retries" ]; then
      echo "Retry $count/$retries exited $exit, retrying in $wait seconds..."
      sleep "$wait"
    else
      echo "Retry $count/$retries exited $exit, no more retries left."
      return "$exit"
    fi
  done
}

echo "==> Install TeXLive"
mkdir -p /tmp/install-tl
cd /tmp/install-tl
MIRROR_URL="$(wget -q -S -O /dev/null http://mirror.ctan.org/ 2>&1 | sed -ne 's/.*Location: \(\w*\)/\1/p' | head -n 1)"
wget -nv "${MIRROR_URL}systems/texlive/tlnet/install-tl-unx.tar.gz"
wget -nv "${MIRROR_URL}systems/texlive/tlnet/install-tl-unx.tar.gz.sha512"
wget -nv "${MIRROR_URL}systems/texlive/tlnet/install-tl-unx.tar.gz.sha512.asc"
gpg --import /texlive_pgp_keys.asc
gpg --verify ./install-tl-unx.tar.gz.sha512.asc
sha512sum -c ./install-tl-unx.tar.gz.sha512
mkdir -p /tmp/install-tl/installer
tar --strip-components 1 -zxf /tmp/install-tl/install-tl-unx.tar.gz -C /tmp/install-tl/installer
retry 3 /tmp/install-tl/installer/install-tl -scheme "$scheme" -profile=/texlive.profile

# Backups only make the cache bigger
tlmgr option -- autobackup 0

# Update a cached version first (else later step might fail)
tlmgr update --self

# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex

# The test framework itself
tlmgr install l3build

# Required to build plain and LaTeX formats:
# TeX90 plain for unpacking, pdfLaTeX, LuaLaTeX and XeTeX for tests
tlmgr install cm etex knuth-lib latex-bin tex tex-ini-files unicode-data \
  xetex
 
# Assuming a 'basic' font set up, metafont is required to avoid
# warnings with some packages and errors with others
tlmgr install metafont mfware texlive-scripts

# Contrib packages: done as a block to avoid multiple calls to tlmgr
tlmgr install   \
  amsfonts      \
  ec            \
  fontspec      \
  hyperref      \
  iftex         \
  kvoptions     \
  oberdiek      \
  pdftexcmds    \
  lh            \
  lualibs       \
  luaotfload    \
  tex-gyre      \
  stringenc     \
  url

# Additional support for typesetting
tlmgr install  \
  amscls       \
  atbegshi     \
  atveryend    \
  auxhook      \
  babel-german \
  bigintcalc   \
  bitset       \
  bookmark     \
  cbfonts      \
  csquotes     \
  dvips        \
  epstopdf     \
  epstopdf-pkg \
  etexcmds     \
  etoolbox     \
  fancyvrb     \
  fc           \
  geometry     \
  gettitlestring \
  graphics-def \
  helvetic     \
  hologo       \
  hycolor      \
  imakeidx     \
  infwarerr    \
  intcalc      \
  kvdefinekeys \
  kvoptions    \
  kvsetkeys    \
  letltxmacro  \
  ltxcmds      \
  ly1          \
  makeindex    \
  mflogo       \
  palatino     \
  pdfescape    \
  pl           \
  refcount     \
  rerunfilecheck \
  sauter       \
  times        \
  uniquecounter \
  vntex        \
  wasy         \
  wsuipa       \
  xkeyval      \
  zref


tlmgr install \
  collection-fontsrecommended \
  collection-fontutils \
  biber \
  biblatex \
  latexmk \
  texliveonfly \
  amsmath \
  babel \
  carlisle \
  ec \
  geometry \
  graphics \
  hyperref \
  lm  \
  marvosym \
  oberdiek \
  parskip \
  graphics-def \
  url \
  fontawesome \
  xkeyval \
  bbl2bib \
  bib2gls \
  bibdoiadd \
  bibexport \
  bibmradd \
  biburl2doi \
  bibzbladd \
  convertgls2bib \
  listbib \
  ltx2crossrefxml \
  multibibliography \
  urlbst \
  texmfstart \
  texosquery \
  texosquery-jre5 \
  texosquery-jre8 \
  thumbpdf \
  tlcockpit \
  tlshell \
  typeoutfileinfo \
  updmap \
  updmap-sys \
  updmap-user \
  vpl2ovp \
  vpl2vpl \
  xhlatex \
  xindex \
  a2ping \
  a5toa4 \
  adhocfilelist \
  afm2afm \
  allcm \
  allec \
  allneeded \
  arara \
  arlatex \
  autoinst \
  bundledoc \
  checkcites \
  checklistings \
  chkweb \
  cjk-gs-integrate \
  cluttex \
  context \
  contextjit \
  ctanbib \
  ctanify \
  ctanupload \
  ctan-o-mat \
  de-macro \
  depythontex \
  deweb \
  dosepsbin \
  dtxgen \
  dvi2fax \
  dviasm \
  dviinfox \
  dvired \
  e2pall \
  epstopdf \
  findhyph \
  fmtutil \
  fmtutil-sys \
  fmtutil-user \
  fontinst \
  fragmaster \
  ht \
  htcontext \
  htlatex \
  htmex \
  httex \
  httexi \
  htxelatex \
  htxetex \
  installfont-tl \
  jfmutil \
  kpsepath \
  kpsetool \
  kpsewhere \
  kpsexpand \
  latex-git-log \
  latex-papersize \
  latex2man \
  latex2nemeth \
  latexdef \
  latexdiff \
  latexdiff-vc \
  latexfileversion \
  latexindent \
  latexmk \
  latexpand \
  latexrevise \
  listings-ext.sh \
  ltxfileinfo \
  ltximg \
  lua2dox_filter \
  luaotfload-tool \
  luatools \
  lwarpmk \
  make4ht \
  match_parens \
  mf2pt1 \
  mk4ht \
  mkjobtexmf \
  mkt1font \
  mktexfmt \
  mptopdf \
  mtxrun \
  mtxrunjit \
  ot2kpx \
  pdf180 \
  pdf270 \
  pdf90 \
  pdfatfi \
  pdfbook \
  pdfbook2 \
  pdfcrop \
  pdfflip \
  pdfjam \
  pdfjam-pocketmod \
  pdfjam-slides3up \
  pdfjam-slides6up \
  pdfjoin \
  pdflatexpicscale \
  pdfnup \
  pdfpun \
  pdftex-quiet \
  pdfxup \
  pfarrei \
  pkfix \
  pkfix-helper \
  ps2eps \
  ps2frag \
  pslatex \
  purifyeps \
  pythontex \
  repstopdf \
  rpdfcrop \
  rungs \
  simpdftex \
  srcredact \
  sty2dtx \
  tex4ebook \
  texconfig \
  texconfig-dialog \
  texconfig-sys \
  texcount \
  texdef \
  texdiff \
  texdirflatten \
  texdoc \
  texdoctk \
  texexec \
  texfot \
  texlinks \
  texliveonfly \
  texloganalyser
  
  
tlmgr install adjustbox babel-german babel-spanish background bidi collectbox csquotes everypage filehook footmisc footnotebackref framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor sourcecodepro sourcesanspro titling ucharcat ulem unicode-math upquote xecjk xurl zref


echo "==> Clean up"
rm -rf \
  /opt/texlive/texdir/install-tl \
  /opt/texlive/texdir/install-tl.log \
  /opt/texlive/texdir/texmf-dist/doc \
  /opt/texlive/texdir/texmf-dist/source \
  /opt/texlive/texdir/texmf-var/web2c/tlmgr.log \
  /root/.gnupg \
  /setup.sh \
  /texlive.profile \
  /texlive_pgp_keys.asc \
  /tmp/install-tl
  

pip install pandoc-plantuml-filter
pip install pygments-mathematica

# ensure we have the latest of the above packages
tlmgr update --all
