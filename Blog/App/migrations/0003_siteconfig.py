# -*- coding: utf-8 -*-
# Generated by Django 1.11.9 on 2020-01-31 21:36
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('App', '0002_userprofile_desc'),
    ]

    operations = [
        migrations.CreateModel(
            name='SiteConfig',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('site_owner_desc', models.CharField(max_length=256)),
                ('site_owner_friends', models.CharField(help_text='友链的地址,使用;隔开', max_length=256)),
                ('site_owner_github_addr', models.URLField()),
                ('site_owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': '博客配置表',
                'db_table': 'site_config',
            },
        ),
    ]
