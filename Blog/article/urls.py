from django.conf.urls import url

from article import views

urlpatterns=[
    url(r'info/', views.info, name='info'),
]