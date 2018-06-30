FROM t4skforce/jenkins-slave

USER root

WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install python python-pip python3 python3-pip curl \
  && curl -Ls https://www.python.org/ftp/python/3.5.5/Python-3.5.5.tgz --output python-3.5.tgz \
  && tar xzvf python-3.5.tgz \
  && cd Python-3.5.5 \
  && ./configure --prefix /usr/local \
  && make \
  && make install \
  && curl -Ls https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz --output python-3.6.tgz \
  && tar xzvf python-3.6.tgz \
  && cd Python-3.6.6 \
  && ./configure --prefix /usr/local \
  && make \
  && make install \
  && curl -Ls https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz --output python-3.7.tgz \
  && tar xzvf python-3.7.tgz \
  && cd Python-3.7.0 \
  && ./configure --prefix /usr/local \
  && make \
  && make install \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

USER jenkins
