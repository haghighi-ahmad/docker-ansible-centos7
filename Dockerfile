FROM centos/systemd
MAINTAINER Ahmad Haghighi <haghighi@fedoraproject.org>
ENV container=docker

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
RUN mkdir -p /etc/ansible && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

RUN mkdir -p /run/systemd/system

VOLUME ["/sys/fs/cgroup"]
#CMD ["/usr/lib/systemd/systemd", "--system"]
CMD ["/usr/sbin/init"]
