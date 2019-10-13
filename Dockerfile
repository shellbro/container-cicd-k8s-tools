FROM shellbro/centos:7.7-0

COPY kubernetes.repo /etc/yum.repos.d
COPY install-kustomize /tmp

RUN yum -y makecache fast && yum install -y kubectl && yum clean all &&\
    >&2 kubectl version --client --short &&\
    /tmp/install-kustomize && /usr/bin/rm /tmp/install-kustomize &&\
    >&2 kustomize version --short
