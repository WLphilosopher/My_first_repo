# 使用官方的 Ubuntu 作為基礎映像
FROM ubuntu:latest

# 更新系統套件庫並安裝 Apache 伺服器
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# 啟動 Apache 伺服器
CMD ["apachectl", "-D", "FOREGROUND"]

# 創建文件上傳目錄
RUN mkdir /var/www/html/uploads

# 更改目錄權限
RUN chown -R www-data:www-data /var/www/html/uploads && \
    chmod -R 755 /var/www/html/uploads

# 複製 upload.html 和 upload.php 文件到容器中
COPY upload.html /var/www/html/
COPY upload.php /var/www/html/

# 開放 Apache 伺服器的 80 端口
EXPOSE 80
