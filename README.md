# 部署须知

## 1. 安装Anaconda3

- 安装Anaconda3（建议安装在CentOS7上）



  wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2.4.1-Linux-x86_64.sh
  bash Anaconda3-2.4.1-Linux-x86_64.sh



- 安装Anaconda虚拟环境

  - 切换到extra文件夹内输入
  - ```conda env create -f environment.yaml```


## 2.数据库的部署与创建

**进入extra文件夹内，登录到您的mysql终端内输入**


  create database myblog charset=utf8;
  use myblog;
  source myblog.sql

## 3.settings.py文件的设置

**进入包含settings.py的Blog文件夹**

找到关键字```DATABASE```把里面的```USER```和```PASSWORD```改为您自己的服务器用户名和密码
同时把```HOST```字段改为您的服务器地址，如果是部署在本地服务器上就改为```localhost```
若部署在远端服务器上就改为您服务器的地址


## 4.迁移数据库文件

**进入包含manage.py的Blog文件夹然后在终端输入**

  python manage.py makemigrations
  python manage.py migrate


## 5.启动博客系统

**在包含manage.py的Blog文件夹打开终端输入**

  python manage.py runserver 0.0.0.0:8000

**打开浏览器输入**

  你的ip地址:8000

即可访问





# RxBlog Installation tips

## Things you must do before deploy

**1. Install the Anaconda3**

- Install the Anaconda3 (We recommand to deploy on centos7 )

    ```wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2.4.1-Linux-x86_64.sh```
    
    ```bash Anaconda3-2.4.1-Linux-x86_64.sh```
  

- Install the anaconda Environment

  - Switch to the extra folder and enter
  - ```conda env create -f environment.ymal```


## 1.install the requirement libs

    pip install -r requirement.txt
    
## 2.create the mysql database

**login your mysql bash and enter the following commands**
    
    create database myblog charset=utf8
    Switch into the extra forder and enter
    use myblog
    source myblog.sql
    

## 3.Edit the setting.py file

**Switch to the Blog folder and edit the settings.py file**

find the keyword ```DATABASES```and change the user and password fields inside to your own
  
## 4.Switch to the Blog folder which including the manage.py file

**Enter the following commands in your terminal**

    python manage.py makemigrations
    python mange.py migrate

## 5.Start the Blog

    python manage.py runserver 0.0.0.0:8000
    
**Then open your own broswer and enter ```your ip:8000/app/index```**
