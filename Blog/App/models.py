from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.
from mdeditor.fields import MDTextField


class UserProfile(AbstractUser):
    mobile = models.CharField(max_length=11, verbose_name='手机号', unique=True)
    github_addr =models.CharField(max_length=32, verbose_name='GitHub地址')
    icon = models.ImageField(upload_to='uploads/%Y/%m/%d')
    desc = models.CharField(max_length=100, verbose_name='描述', default='desc')



    class Meta:
        db_table= 'user_profile'
        verbose_name = '用户表'
        verbose_name_plural = verbose_name

class SiteConfig(models.Model):
    site_owner = models.ForeignKey(UserProfile, verbose_name='博客站长')
    site_owner_desc_short=models.CharField(max_length=256, verbose_name='简述')
    site_owner_desc = MDTextField(verbose_name='站长介绍')

    site_owner_friends = models.TextField(help_text='友链的地址,使用;隔开', verbose_name='友链地址')
    site_owner_github_addr = models.URLField(verbose_name='github地址')
    icon = models.ImageField(upload_to='', verbose_name='头像')

    class Meta:
        db_table='site_config'
        verbose_name = '博客配置表'




