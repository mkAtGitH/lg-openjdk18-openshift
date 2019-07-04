FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

# PROXY

# this will add ability to completely ignore configured proxy option
# if environment variable "UNSET_PROXY" is set to "true", proxy 
# environment variable in a container will be unset
COPY ./proxy-options /opt/run-java/proxy-options


# CERTIFICATES
USER root
# add LG certificates to a system wide trusted CAs
RUN echo "" >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN echo "# LG CA certificates" >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN echo "" >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN echo "# LG-TLSServer-CA-G1" >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN echo "# LibertyGlobalEnterprise-Root-CA-G1" >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN cat ./LG-TLSServer-CA-G1.pem >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
RUN cat ./LibertyGlobalEnterprise-Root-CA-G1.pem >> /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem

# add it to jdk
RUN keytool -import -keystore /usr/lib/jvm/jre/lib/security/cacerts -storepass changeit -trustcacerts -noprompt -file ./LG-TLSServer-CA-G1.pem -alias LG-TLSServer-CA-G1 
RUN keytool -import -keystore /usr/lib/jvm/jre/lib/security/cacerts -storepass changeit -trustcacerts -noprompt -file ./LibertyGlobalEnterprise-Root-CA-G1.pem -alias LibertyGlobalEnterprise-Root-CA-G1
USER 1001
