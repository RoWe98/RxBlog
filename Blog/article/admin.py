from django.contrib import admin

# Register your models here.
from article.models import Article, Categories

admin.site.register(Article)
admin.site.register(Categories)
