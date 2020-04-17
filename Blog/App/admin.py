from django.contrib import admin

# Register your models here.
from App.models import UserProfile

class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['username', 'mobile', 'email', 'github_addr']

admin.site.register(UserProfile, UserProfileAdmin)