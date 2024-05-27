# 使用官方的Ubuntu基础镜像
FROM ubuntu:latest

# 设置环境变量，以确保在非交互模式下运行
ENV DEBIAN_FRONTEND=noninteractive

# 复制并运行setup.sh脚本
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# 暴露Apache服务器的端口
EXPOSE 80

# 以systemctl方式启动apache2
CMD ["/bin/bash", "-c", "systemctl start apache2 && tail -f /dev/null"]

