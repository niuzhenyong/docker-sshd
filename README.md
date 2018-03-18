# docker-sshd
基于 Docker 容器的 SSHD 服务器

    docker run --privileged --name sshd -d -p {目标端口}:22 -v {数据存放目录}:/home -v /etc/localtime:/etc/localtime -e USERNAME={用户名} -e PASSWORD={用户密码} --restart=always niuzhenyong/docker-sshd
