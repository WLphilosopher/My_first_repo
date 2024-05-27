#!/bin/bash

# 创建用户
sudo useradd -m -p $(openssl passwd -1 password) susan

# 安装 Apache 服务器
sudo apt update
sudo apt install -y apache2

# 将 Apache 服务器设置为以 susan 用户身份运行
sudo sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=susan/g' /etc/apache2/envvars
sudo sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=susan/g' /etc/apache2/envvars

# 启动 Apache 服务器
sudo systemctl start apache2

# 创建文件上传目录
sudo mkdir /home/susan/uploads

# 更改目录权限
sudo chown -R susan:susan /home/susan/uploads
sudo chmod -R 755 /home/susan/uploads

# 创建 upload.html 文件
cat << 'EOF' | sudo tee /var/www/html/upload.html > /dev/null
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload File</title>
</head>
<body>
    <h2>Upload a File</h2>
    <form action="upload.php" method="post" enctype="multipart/form-data">
        <input type="file" name="fileToUpload" id="fileToUpload">
        <input type="submit" value="Upload File" name="submit">
    </form>
</body>
</html>
EOF

# 创建 upload.php 文件
cat << 'EOF' | sudo tee /var/www/html/upload.php > /dev/null
<?php
$target_dir = "/home/susan/uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;

if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        echo "File is an image - " . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        echo "File is not an image.";
        $uploadOk = 0;
    }
}

if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";
} else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "The file ". htmlspecialchars( basename( $_FILES["fileToUpload"]["name"])). " has been uploaded.";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
}
?>
EOF

# 创建 user.txt 和 root.txt 文件
echo "This is the content of user.txt" | sudo tee /home/susan/user.txt > /dev/null
echo "This is the content of root.txt" | sudo tee /root/root.txt > /dev/null

# 完成安装
echo "Setup completed successfully!"
