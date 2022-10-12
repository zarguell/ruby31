######################## Base Args ########################
ARG BASE_REGISTRY=docker.io
ARG BASE_IMAGE=zarguell/ubi8
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as builder

# ARG BASE_REGISTRY=registry1.dso.mil
# ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8
# ARG BASE_TAG=8.6

# FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as builder

USER 0

ENV GEM_HOME /usr/local/bundle

COPY ruby-3.1.2.tar.gz gdbm.tar.gz scripts/*.sh *.gem /

ARG PACKAGES="gcc-c++ patch readline zlib zlib-devel libffi-devel libedit \
    openssl-devel make bzip2 autoconf automake libtool sqlite-devel libpq-devel"

RUN dnf install -y --setopt=tsflags=nodocs $PACKAGES \
    && chmod +x /install-ruby.sh /install-gdbm.sh \
    && /install-gdbm.sh \
    && /install-ruby.sh \
    && rm -f /install-ruby.sh /install-gdbm.sh \
    && gem install \
        /stringio.gem \
        /psych.gem \
        /rdoc.gem \
    && rm -rf /var/cache/dnf/ /var/tmp/* /tmp/* /var/tmp/.???* /tmp/.???*

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

RUN dnf update -y \
    && dnf clean all \
    && rm -rf /var/cache/dnf/ /var/tmp/* /tmp/* /var/tmp/.???* /tmp/.???*

COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder /usr/local/lib/ /usr/local/lib/
COPY --from=builder /usr/local/include/ /usr/local/include/
COPY --from=builder /usr/local/bundle /usr/local/bundle

ENV RUBY_MAJOR=3 \
    RUBY_MINOR=1

ENV HOME=/opt/app-root/src
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1
ENV PATH $HOME/bin:$GEM_HOME/bin:$PATH

RUN useradd -u 1001 -g 0 -M -d /opt/app-root/src default && \
    mkdir -p "$GEM_HOME" && \
    chmod 755 "$GEM_HOME" && \
    mkdir -p /opt/app-root/src && \
    chown -R 1001:0 /opt/app-root && \
    chown -R 1001:0 "$GEM_HOME"

USER 1001

HEALTHCHECK NONE

CMD ["irb"]
