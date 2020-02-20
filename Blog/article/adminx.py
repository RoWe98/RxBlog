import xadmin
from App.models import SiteConfig
from article.models import Article, Categories


class ArticleAdmin(object):
    list_display=['title', 'desc', 'click_num', 'categories', 'love_num', 'author', 'image']
    search_fields = ['title']
    list_editable = ['click_num', 'love_num']
    list_filter=['date', 'author']

xadmin.site.register(Article, ArticleAdmin)
xadmin.site.register(Categories)
xadmin.site.register(SiteConfig)