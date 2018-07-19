FROM t4skforce/jenkins-slave

ENV PYTHON_VERSIONS '2.7.15 3.4.8 3.5.5 3.6.6 3.7.0'

USER root

COPY install.sh /tmp/install.sh
WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install python python-pip python-virtualenv python3 python3-pip python3-virtualenv jython pypy curl \
  && pip3 install --default-timeout=240 setuptools wheel tox virtualenv pylint \
  && pip3 install --default-timeout=240 pipenv \
  && chmod +x /tmp/install.sh \
  && ./install.sh \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && chown -R jenkins:jenkins /home/jenkins
WORKDIR /home/jenkins
USER jenkins
