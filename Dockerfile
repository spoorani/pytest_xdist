FROM dockerhub.cisco.com/spvss-ivp-ci-release-docker/base/alpine3:20180702083144-3.7.0

ARG        BUILD_DATE
ARG        VCS_REF
ARG        IMAGE_TAG
ARG        BASE_INFO

ENV PYTEST_VERSION 3.4.1
ENV PYTEST_REQUESTS_VERSION 2.18.4
ENV PYTEST_XDIST_VERSION 1.22.2

COPY scripts/socketserver.py /opt/pytest-xdist/

COPY scripts/docker-entrypoint.sh /

RUN apk add --update \
  python \
  py-pip \
  curl \
  && pip install \
     pytest==${PYTEST_VERSION} \
     pytest-xdist==${PYTEST_XDIST_VERSION} \
     requests==${PYTEST_REQUESTS_VERSION} \
  && pip install ${PIP_REPO} --upgrade \
  && chmod 755 /opt/pytest-xdist/socketserver.py \
  && chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
