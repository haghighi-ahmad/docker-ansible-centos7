FROM centos:7
LABEL maintainer="Ahmad Haghighi"
ENV container=docker

# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Update system + Install ansible and other requirements.
RUN yum makecache fast && yum -y install deltarpm epel-release \
    && yum -y update \
    && yum -y install \
     python2-pip \
     python36-pip \
     ansible \
     sudo \
     which \
     initscripts \
     python2-dnf \
     python36 \
     python2 \
    && yum clean all

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local ' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
