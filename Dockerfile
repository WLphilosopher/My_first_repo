# 使用 Ubuntu 作为基础镜像
FROM ubuntu:latest

# 设置环境变量以避免交互式设置期间的警告
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件包并安装 Apache2
RUN apt-get update && apt-get install -y apache2 && \
    # 清理 apt 缓存
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 启动 Apache2 服务器
CMD ["apachectl", "-D", "FOREGROUND"]

# 创建用户 susan
RUN useradd -m -p $(openssl passwd -1 password) susan

# 创建文件上传目录并更改权限
RUN mkdir /home/susan/uploads && \
    chown -R susan:susan /home/susan/uploads && \
    chmod -R 755 /home/susan/uploads

# 复制 upload.html 和 upload.php 文件到 Apache2 默认目录
COPY upload.html /var/www/html/
COPY upload.php /var/www/html/

# 创建 user.txt 和 root.txt 文件
RUN echo "This is the content of user.txt" > /home/susan/user.txt && \
    echo "This is the content of root.txt" > /root/root.txt

# 暴露 Apache2 默认端口
EXPOSE 80
