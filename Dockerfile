FROM t4skforce/jenkins-slave

ENV PYTHON_VERSIONS '2.7.15 3.4.8 3.5.5 3.6.6 3.7.0'
ENV BUILD_REQUIREMENTS 'libssl-dev libffi-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libc6-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev'

USER root

COPY install.sh /tmp/install.sh
WORKDIR /tmp/
RUN apt-get update -qqy \
  && apt-get -qqy install ${BUILD_REQUIREMENTS} build-essential python python-pip python-virtualenv python3 python3-pip python3-virtualenv jython pypy openssl curl \
  && pip3 install --default-timeout=240 -U setuptools wheel > /dev/null \
  && pip3 install --default-timeout=240 -U tox virtualenv pylint pipenv bumpversion twine > /dev/null \
  && chmod +x /tmp/install.sh \
  && ./install.sh \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && apt-get --auto-remove -y purge ${BUILD_REQUIREMENTS} \
  && chown -R jenkins:jenkins /home/jenkins
WORKDIR /home/jenkins
USER jenkins
