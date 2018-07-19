#!/usr/bin/env bash
set -e
for VERSION in $PYTHON_VERSIONS;do
  MAJOR_VERSION="${VERSION::3}"
  echo $VERSION $MAJOR_VERSION
  cd /tmp/
  curl -Ln https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz --output Python-${VERSION}.tgz
  tar zxf Python-${VERSION}.tgz
  cd /tmp/Python-${VERSION}
  mkdir -p /opt/python-${MAJOR_VERSION}
  ./configure --prefix=/opt/python-${MAJOR_VERSION} --enable-optimizations > /dev/null
  make > /dev/null
  make install
  ls -la /opt/python-${MAJOR_VERSION}/bin/
  ln -s /opt/python-${MAJOR_VERSION}/bin/python${MAJOR_VERSION} /usr/local/bin/python${MAJOR_VERSION}
  ln -s /opt/python-${MAJOR_VERSION}/bin/pip${MAJOR_VERSION} /usr/local/bin/pip${MAJOR_VERSION}
done
