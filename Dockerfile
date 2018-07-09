FROM t4skforce/jenkins-slave

USER root

WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install python python-pip python-virtualenv python3 python3-pip python3-virtualenv curl \
  && apt-get -qqy --no-install-recommends install python-* python3-* \
  && pip3 install --default-timeout=240 -U setuptools tox \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && chown -R jenkins:jenkins /home/jenkins
WORKDIR /home/jenkins
USER jenkins
