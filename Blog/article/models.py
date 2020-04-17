from django.db import models
from mdeditor.fields import MDTextField
from taggit.managers import TaggableManager
# Create your models here.

# title desc content author date click_num tags images

# 分类
from App.models import UserProfile


class Categories(models.Model):
    name = models.CharField(max_length=50, verbose_name='分类名')

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'categories'
        verbose_name = '分类表'
        verbose_name_plural = verbose_name

# 　文章
class Article(models.Model):
    title = models.CharField(max_length=100, verbose_name='标题')
    desc = models.CharField(max_length=256, verbose_name='简介')
    content = MDTextField(verbose_name='内容')
    date = models.DateField(auto_now=True, verbose_name='发表日期')
    click_num = models.IntegerField(default=0, verbose_name='点击数')
    love_num = models.IntegerField(default=0, verbose_name='点赞数')
    #image = models.FileField(upload_to="up_image", verbose_name='封面', blank=True)
    image = models.ImageField(upload_to='', blank=True)

    # 多对多的关系　文章名《－》标签
    categories = models.ManyToManyField(to=Categories, verbose_name='分类')
    # 文章 作者 1-》多　
    relfield_style = 'fk-ajax'  # 修复只显示搜索框 不显示下拉框的问题
    author = models.ForeignKey(to=UserProfile, on_delete=models.CASCADE, verbose_name='作者')

    tags = TaggableManager()

    def __str__(self):
        return self.title

    class Meta:
        db_table = 'article'
        verbose_name = '文章表'
        verbose_name_plural = verbose_name

