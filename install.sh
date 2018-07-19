#!/usr/bin/env bash
set -e

symlink () {
  [ -e $2 ] && rm $2
  [ -e $1 ] && ln -s $1 $2
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
  ls -la /opt/python-${MAJOR_VERSION}/bin/
  
  symlink "/usr/local/bin/python${MAJOR_VERSION}" "/usr/local/bin/python${MAJOR_VERSION}"
  symlink "/usr/local/bin/pip${MAJOR_VERSION}" "/usr/local/bin/pip${MAJOR_VERSION}"
  symlink "/usr/local/bin/pyvenv-${MAJOR_VERSION}" "/usr/local/bin/pyvenv-${MAJOR_VERSION}"
  symlink "/usr/local/bin/easy_install-${MAJOR_VERSION}" "/usr/local/bin/easy_install-${MAJOR_VERSION}"
  symlink "/usr/local/bin/idle-${MAJOR_VERSION}" "/usr/local/bin/idle-${MAJOR_VERSION}"

done
