from django.conf.urls import url

from App import views

urlpatterns = [
    url(r'^index/', views.index, name='index'),
    url(r'^register/', views.user_register, name='register'),
    # url(r'^formregister/', views.form_register,name='注册'),
    url(r'^login/', views.user_login, name='login'),
    url(r'^codelogin/', views.code_login, name='code_login'),
    url(r'^logout/', views.user_logout ,name='logout'),
    url(r'^sendcode/', views.send_code, name='send_code'),
    url(r'forgetpwd/', views.forget_password, name='forger_pwd'),
    url(r'^valide_pwd/', views.valide_code, name='valide_pwd'),
    url(r'^update_pwd/', views.update_pwd, name='update_pwd'),
    url(r'^center/(\w*)', views.user_center, name='center'),
    url(r'^post/(\d+)', views.post, name='post'),
    url(r'^upload_pic/', views.uploadpic, name='upload_pic'),
    url(r'^articles_list/(\w*)', views.article_list, name='article_list'),
    url(r'^edit/', views.edit, name='edit'),
    url(r'^search/', views.search, name='search'),
    url(r'test/', views.test, name='test'),
    url(r'^guide/', views.guide, name='guide'),
    url(r'^add_article/', views.add_article,name='edit_article'),
    url(r'^add_config/', views.add_config, name='add_config'),
]