import re

from captcha.fields import CaptchaField
from django import forms
from django.core.exceptions import ValidationError
from django.forms import Form, ModelForm, EmailField, widgets

from App.models import UserProfile


class UserRegisterForm(Form):
    username = forms.CharField(max_length=16,
                               min_length=6,
                               error_messages={
                                    'min_length':'用户名至少6位',
                               },label='用户名')
    email = forms.EmailField(error_messages={'required':'必须填写邮箱'},label='邮箱')
    mobile = forms.CharField(max_length=11,error_messages={'required':'必须填写手机号码'},label='手机号码')
    password = forms.CharField(error_messages={'required':'必须填写密码'}, widget=forms.widgets.PasswordInput)
    github_addr = forms.CharField(required=True,error_messages={'required':'必须填写Github地址'})

    """"
    favourite_colors = forms.MultipleChoiceField(
        required=True,
        widget=forms.CheckboxSelectMultiple,
        choices=(('blue','yellow','brown'),('red','Red'),('green','Green'))
    )
    """

    def clean_username(self):
        username = self.cleaned_data.get('username')
        result = re.match(r'[a-zA-Z]\w[5,]', username)
        if not result:
            raise ValidationError('用户名必须字母开头')
        return username



class RegisterForm(ModelForm):

    class Meta:
        model=UserProfile
        #fields='__all__'
        #exclude=[
        #    'first_name','date_joined','last_name',

        #]
        fields = [
            'username', 'email', 'password', 'mobile', 'github_addr'
        ]


    def clean_username(self):
        username = self.cleaned_data.get('username')
        """
        result = re.match(r'[a-zA-Z]\w[5,]', username)
        if not result:
            raise ValidationError('用户名必须字母开头')
        """
        return username



class LoginForm(Form):
    """
    class Meta:
        model = UserProfile
        fields = ['username','password']

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if not UserProfile.objects.filter(username=username).exists():
            raise ValidationError('用户名不存在')
        return username
    """
    username = forms.CharField(max_length=16,
                               min_length=3,
                               error_messages={
                                   'min_length': '用户名至少3位',
                               }, label='用户名')
    password = forms.CharField(error_messages={'required': '必须填写密码'}, widget=forms.widgets.PasswordInput)

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if not UserProfile.objects.filter(username=username).exists():
            raise ValidationError('用户名不存在')
        return username


# 验证码captcha的Form
class CaptchaTestForm(forms.Form):
    email = EmailField(widget=widgets.TextInput(attrs={'class': "c-input",
                                                       'placeholder': u"邮箱"}),
                       required=True, error_messages={'required': '必须填写邮箱'},
                       label='邮箱')
    captcha = CaptchaField()
