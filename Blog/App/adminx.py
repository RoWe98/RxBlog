import xadmin
from App.models import UserProfile

# xadmin.site.register(UserProfile)
from xadmin import views


class BaseSettings(object):
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(object):
    site_title = 'RxBlog'
    site_footer = 'RoWe98 all rights reserved'


xadmin.site.register(views.BaseAdminView, BaseSettings)
xadmin.site.register(views.CommAdminView, GlobalSettings)