FROM t4skforce/jenkins-slave

USER root

WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install python python-pip python3 python3-pip curl \
  && pip3 install --default-timeout=240 -U setuptools tox \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && chown -R ${user}:${group} /home/${user}

USER jenkins
