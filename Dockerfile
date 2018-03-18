FROM centos/systemd

MAINTAINER Niu Zhenyong <niuzhenyong@qq.com>

RUN yum install -y openssh-server && \
    yum clean all

RUN sed -i -r 's/^(.*pam_nologin.so)/#\1/' /etc/pam.d/sshd && \
    sed -i -r 's/^#PermitRootLogin yes/PermitRootLogin no/g' /etc/pam.d/sshd && \
    sed -i -r 's/^#ClientAliveInterval 0/ClientAliveInterval 60/g' /etc/pam.d/sshd && \
    sed -i -r 's/^#ClientAliveCountMax 3/ClientAliveCountMax 3/g' /etc/pam.d/sshd && \
    echo "#!/bin/sh" > /usr/local/bin/entrypoint.sh && \
    echo "if [ ! -z \${USERNAME} ] && [ ! -z \${PASSWORD} ]; then" >> /usr/local/bin/entrypoint.sh && \
    echo "    adduser \${USERNAME}" >> /usr/local/bin/entrypoint.sh && \
    echo "    echo \"\${USERNAME}:\${PASSWORD}\" | chpasswd" >> /usr/local/bin/entrypoint.sh && \
    echo "fi" >> /usr/local/bin/entrypoint.sh && \
    echo "" >> /usr/local/bin/entrypoint.sh && \
    echo "exec /usr/sbin/init" >> /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENV USERNAME=niu PASSWORD=niu

VOLUME [ "/home" ]

EXPOSE 22

CMD ["/usr/local/bin/entrypoint.sh"]