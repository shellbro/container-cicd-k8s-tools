FROM shellbro/centos:7.7-1

ARG UID=1000
ARG GID=1000
ARG LOGIN=user

COPY kubernetes.repo /etc/yum.repos.d
COPY install-kustomize /tmp

RUN yum -y makecache fast && yum -y install gettext kubectl &&\
    yum clean all &&\
    >&2 rpm -q kubectl &&\
    /tmp/install-kustomize && rm /tmp/install-kustomize &&\
    >&2 kustomize version --short &&\
    groupadd -g $GID $LOGIN && useradd -u $UID -g $GID $LOGIN &&\
    mkdir /repo && chown $LOGIN:$LOGIN /repo

USER $LOGIN
WORKDIR /home/$LOGIN
