#!/usr/bin/env bash
set -e

create_symlink () {
  if [ -e "$2" ]; then
    rm "$2"
  fi
  if [ -e "$1" ]; then
    ln -s "$1" "$2"
  fi
}

for VERSION in $PYTHON_VERSIONS;do
  MAJOR_VERSION="${VERSION::3}"
  echo $VERSION $MAJOR_VERSION
  cd /tmp/
  curl -Ln https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz --output Python-${VERSION}.tgz
  tar zxf Python-${VERSION}.tgz
  cd /tmp/Python-${VERSION}
  mkdir -p /opt/python-${MAJOR_VERSION}
  ./configure --prefix=/opt/python-${MAJOR_VERSION} --cache-file=/opt/python-${MAJOR_VERSION}/config.cache --enable-optimizations > /dev/null
  make -s -j8
  make altinstall
    
  create_symlink "/opt/python-${MAJOR_VERSION}/bin/python${MAJOR_VERSION}" "/usr/local/bin/python${MAJOR_VERSION}"
  create_symlink "/opt/python-${MAJOR_VERSION}/bin/pip${MAJOR_VERSION}" "/usr/local/bin/pip${MAJOR_VERSION}"

done
