# @author George Babarus
# @description

ARG IMAGE_VERSION="latest"

FROM quay.io/centos/centos:$IMAGE_VERSION
LABEL maintainer="George Babarus"

ARG DEBIAN_FRONTEND=noninteractive

ENV pip_packages "ansible"

# Install dependencies.
RUN yum -y update && \
    yum -y install python3 python3-pip && \
    yum clean all


RUN pip3 install $pip_packages

CMD ["/usr/sbin/init"]