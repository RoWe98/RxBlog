# -*- coding: utf-8 -*-
# Generated by Django 1.11.9 on 2020-01-30 21:15
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('article', '0007_auto_20200130_2112'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='image',
            field=models.ImageField(blank=True, max_length=255, null=True, upload_to='', verbose_name='封面'),
        ),
    ]
