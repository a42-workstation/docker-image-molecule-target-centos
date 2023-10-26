# @author George Babarus
# @description

ARG IMAGE_VERSION="latest"
ARG IMAGE_STAGE="ubuntu"

FROM quay.io/centos/centos:$IMAGE_VERSION as centos
LABEL maintainer="George Babarus"

ENV pip_packages ""

# Install dependencies.
RUN yum -y update \
    && yum -y install python3 python3-pip \
    && pip install --upgrade pip \
    && if [ ! -z $pip_packages ]; then pip3 install $pip_packages; fi \
    && yum clean all

COPY bin/* /usr/local/bin/

CMD ["/usr/sbin/init"]


FROM centos as centos_with_user

ARG APP_USER
ARG APP_USER_ID
ARG APP_GROUP
ARG APP_GROUP_ID
ARG APP_USER_HOME

RUN docker-users-create

USER $APP_USER_ID:$APP_GROUP_ID

# Set working directory
WORKDIR $APP_USER_HOME/$APP_USER

FROM $IMAGE_STAGE as centos_final
