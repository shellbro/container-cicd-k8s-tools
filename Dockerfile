FROM shellbro/centos:7.7-0

COPY kubernetes.repo /etc/yum.repos.d
RUN yum -y makecache fast && yum install -y git kubectl && yum clean all \
    && >&2 kubectl version --client --short
