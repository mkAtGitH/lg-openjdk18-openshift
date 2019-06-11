FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

ADD ./proxy-options /opt/run-java/proxy-options
ADD dbtest.tar.xz /opt
