FROM shellbro/centos:7.7.1908-1582981332

COPY kubernetes.repo /etc/yum.repos.d
COPY install-kustomize /tmp

RUN yum -y makecache fast && yum -y install gettext kubectl && yum clean all &&\
    >&2 rpm -q kubectl &&\
    /tmp/install-kustomize && rm /tmp/install-kustomize &&\
    >&2 kustomize version --short &&\
    groupadd -g 1001 non-root && useradd -u 1001 -g 1001 non-root &&\
    mkdir /repo && chown non-root:non-root /repo

USER non-root
