FROM t4skforce/jenkins-slave

USER root

RUN apt-get update -qqy \
	&& apt-get -qqy --no-install-recommends install python python-pip \
  && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /tmp/*

USER jenkins
