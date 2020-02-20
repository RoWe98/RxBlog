# RxBlog Installation tips

## 1.install the requirement libs

    pip install -r requirement.txt
    
## 2.create the mysql database

**login your mysql bash and keyin the following commands**
    
    create database myblog charset=utf8
    
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