# RxBlog Installation tips

## Things you must do before deploy

**1. Install the Anaconda3**

- Install the Anaconda3 (We recommand to deploy on centos7 )
  ```wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2.4.1-Linux-x86_64.sh```
     bash Anaconda3-2.4.1-Linux-x86_64.sh
  ```

- Install the anaconda Environment

  - Switch into the extra folder and keyin
  - ```conda env create -f environment.ymal```


## 1.install the requirement libs

    pip install -r requirement.txt
    
## 2.create the mysql database

**login your mysql bash and keyin the following commands**
    
    create database myblog charset=utf8
    Switch into the extra forder and keyin
    ```use myblog
       source myblog.sql
    ```

## 3.Edit the setting.py file

**get into the Blog folder and edit the settings.py file**

**find the KEYWORD ```DATABASES```, then replace your own database username and password to the file**
  
## 4.Switch int the Blog folder which including the manage.py file

**keyin the following commands on your terminal**

    python manage.py makemigrations
    python mange.py migrate

## 5.Start the Blog

    python manage.py runserver 0.0.0.0:8000
    
**Then open your own broswer and keyin ```your ip:8000/app/index```**
