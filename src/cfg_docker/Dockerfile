# 使用官方的Ubuntu基础镜像
FROM ubuntu:latest

# 设置环境变量，以确保在非交互模式下运行
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装Apache和SSH服务器
RUN apt-get update && \
    apt-get install -y apache2 openssh-server && \
    apt-get clean

# 复制并运行setup.sh脚本
COPY set.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# 配置SSH服务器
RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# 暴露Apache和SSH服务器的端口
EXPOSE 80 22

# 启动Apache和SSH服务器
CMD ["/bin/bash", "-c", "service ssh start && apachectl -D FOREGROUND"]
