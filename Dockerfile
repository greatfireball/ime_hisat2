ARG osversion=xenial
FROM ubuntu::${osversion}

ARG VERSION=master
ARG VCS_REF
ARG BUILD_DATE
ARG osversion

RUN echo "osversion: "${osversion}", VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", VERSION: "${VERSION}

LABEL maintainer="frank.foerster@ime.fraunhofer.de" \
      description="Dockerfile providing the HiStat2 mapper" \
      version=${VERSION} \
      org.label-schema.vcs-ref=${VCS_REF} \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url="https://github.com/greatfireball/ime_histat2.git"

RUN apt-get update && apt-get install -y git wget unzip

WORKDIR /tmp/
RUN wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip && \
    unzip hisat2-2.1.0-Linux_x86_64.zip && \
    mv hisat2-2.1.0 /opt/ && \
    rm hisat2-2.1.0-Linux_x86_64.zip && \
    ln -s /opt/hisat2* /opt/hisat

ENV PATH /opt/hisat:$PATH

WORKDIR /data

