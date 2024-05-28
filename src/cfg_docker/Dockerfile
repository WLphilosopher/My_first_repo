# 使用官方的Ubuntu基础镜像
FROM ubuntu:latest

# 设置环境变量，以确保在非交互模式下运行
ENV DEBIAN_FRONTEND=noninteractive

# 更新并安装Apache2
RUN apt-get update && apt-get install -y apache2

# 复制并运行setup.sh脚本
COPY set.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# 暴露Apache服务器的端口
EXPOSE 80

# 启动Apache2并保持运行
CMD ["/bin/bash", "-c", "service apache2 start && tail -f /dev/null"]
