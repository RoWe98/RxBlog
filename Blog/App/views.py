import markdown
from captcha.helpers import captcha_image_url
from captcha.models import CaptchaStore
from django.contrib.auth import logout, login, authenticate
from django.contrib.auth.hashers import make_password, check_password
from django.core.mail import send_mail

from django.db.models import Q
from django.forms import ModelForm
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.urls import reverse

from App.forms import UserRegisterForm, RegisterForm, LoginForm, CaptchaTestForm
from App.models import UserProfile, SiteConfig
from App.utils import send_message, send_email, upload
from article.models import Article, Categories


# 获取站点配置信息
def get_config():
    friends_addr_list = []
    site_config = SiteConfig.objects.first()
    friends_addr = site_config.site_owner_friends
    # 遍历获取友链 以；分隔
    for site in friends_addr.split(';'):
        friends_addr_list.append(site)
    # github地址和图标以及站点描述
    github_addr = site_config.site_owner_github_addr
    icon = site_config.icon
    site_desc = site_config.site_owner_desc_short

    return friends_addr_list, github_addr, icon, site_desc



# 获取分类信息
def get_categories():
    articles = Article.objects.all().order_by('-click_num')
    categories_dict = {}
    categories = Categories.objects.all()
    print(categories)
    # 获取分类字典 格式 {‘分类名’：‘当前分类文章数’}
    for categorie_name in categories:
        for article_name in articles:
            articles_num = Article.objects.filter(categories=categorie_name.id).count()
            categories_dict[categorie_name.name] = articles_num
    return categories_dict, categories



# 主页
def index(request):

    # 从SiteConfig中获取友链和github地址以及图标和站点描述
    friends_addr_list, github_addr, icon, site_desc = get_config()

    # 按点击率从高到低排序
    articles = Article.objects.all().order_by('-click_num')
    # 获取文章数
    article_num = Article.objects.count()

    article_num_list = []
    for i in range(10 - article_num):
        article_num_list.append('')
    print(articles)

    # 获取分类字典和分类 分类字典格式 {‘分类名’：‘当前分类文章数’}
    categories_dict, categories = get_categories()

    print(categories_dict)
    print(friends_addr_list)
    # render返回值
    # 文章集合； 文章数； 文章数列表； 分类字典； 分类集合； 友链； github地址； 图标； 站点介绍
    return render(request, 'index.html', context={'articles': articles,
                                                  'article_num': article_num,
                                                  'article_num_list': article_num_list,
                                                  'categories_dict': categories_dict,
                                                  'categories': categories,
                                                  'friends_addr_list': friends_addr_list,
                                                  'github_addr': github_addr,
                                                  'icon':icon,
                                                  'site_desc': site_desc
                                                  })


# 注册
def user_register(request):
    if request.method == 'GET':
        return render(request, 'register2.html')
    elif request.method == 'POST':
        regForm = RegisterForm(request.POST)  # 使用form获取数据
        if regForm.is_valid():  # 校验成功
            # 从干净数据中取值
            username = regForm.cleaned_data.get('username')
            email = regForm.cleaned_data.get('email')
            password = regForm.cleaned_data.get('password')
            mobile = regForm.cleaned_data.get('mobile')
            github_addr = regForm.cleaned_data.get('github_addr')
            print(username)
            print(email)
            print(password)
            print(mobile)
            print(github_addr)
            # 校验是否注册
            if not UserProfile.objects.filter(Q(username=username) | Q(mobile=mobile)).exists():
                # 注册到数据库中
                password = make_password(password)  # 对密码进行加密
                user = UserProfile.objects.create(username=username, password=password,
                                                  mobile=mobile, email=email, github_addr=github_addr)
                print(1)
                if user:
                    return redirect(reverse('app:login'))
            else:
                data = {
                    'msg': '用户名或者手机号码已经存在'
                }
                return render(request, 'register2.html', context=data)
        return render(request, 'register2.html', context={'msg': '注册失败，重新填写'})


# 用户登录
def user_login(request):
    if request.method == 'GET':
        return render(request, 'login_2.html')
    else:
        loForm = LoginForm(request.POST)
        if loForm.is_valid():
            username = loForm.cleaned_data.get('username')
            password = loForm.cleaned_data.get('password')

            """" 方式一：登录
            # 数据库查询
            user = UserProfile.objects.filter(username=username).first()
            flag = check_password(password, user.password)# 密码校验
            if flag:
                # 把用户登录成功的信息存入session,并跳转到主页
                request.session['username'] = username
                return redirect(reverse('app:index'))
            """

            # 方式二 登录 前提必须继承AbstractUser
            user = authenticate(username=username, password=password)
            if user:
                login(request, user)  # 将用户对象保存到底层的request中
            return redirect(reverse('app:index'))

        return render(request, 'login_2.html', context={'errors': loForm.errors})


# 用户注销
def user_logout(request):
    # 清空Session信息，在Django_Session表中删除session+cookie+字典
    # request.session.flush()
    logout(request)
    return redirect(reverse('app:index'))


""""
def form_register(request):
    if request.method == 'GET':
        regForm = UserRegisterForm()
        return render(request, 'test.html', context={'regForm':regForm})
    else:
        regForm = UserRegisterForm(request.POST)
        print('----->', regForm)
"""


def code_login(request):
    if request.method == 'GET':
        return render(request, 'codelogin.html')
    else:
        mobile = request.POST.get('mobile')
        code = request.POST.get('code')

        # 根据mobile在session中取值
        check_code = request.session.get(mobile)
        if code == check_code:
            return redirect(reverse('app:index'))
        else:
            return render(request, 'codelogin.html', context={'msg': '验证码有误'})


def send_code(request):
    print(1)
    mobile = request.GET.get('mobile')
    # 发送验证码
    json_result, check_code = send_message(mobile)
    status = json_result.get('code')
    print(status)
    data = {}
    if status == 200:
        check_code_now = check_code
        # 使用session保存验证码
        request.session['mobile'] = check_code
        data['status'] = 200
        data['msg'] = '验证码发送成功'
    else:
        data['status'] = 500
        data['msg'] = '验证码发送失败'

    return JsonResponse(data)


# 忘记密码

def forget_password(request):
    if request.method == 'GET':
        # form = CaptchaTestForm()
        hashkey = CaptchaStore.generate_key()
        image_url = captcha_image_url(hashkey)
        form = CaptchaTestForm()
        return render(request, 'forget_pwd2.html', context=locals())
    else:
        # 获取提交的邮箱,并发送邮件
        email = request.POST.get('email')
        # 给邮箱地址发送邮件
        result = send_email(email, request)
        data = {
            "msg": "邮件已发送"
        }
        return render(request, 'send_mail_success.html', context=data)


# 验证验证码
def valide_code(request):
    if request.is_ajax():
        key = request.GET.get('key')
        code = request.GET.get('code')
        captcha = CaptchaStore.objects.filter(hashkey=key).first()
        if captcha.response == code.lower():
            # 正确的验证码
            data = {'status': 1}
        else:
            # 错误的验证码
            data = {'status': 0}
        return JsonResponse(data)


# 更新密码
def update_pwd(request):
    if request.method == 'GET':
        c = request.GET.get('c')

        return render(request, 'update_pwd.html', context={'c': c})
    else:
        code = request.POST.get('code')
        uid = request.session.get(code)
        user = UserProfile.objects.get(pk=uid)

        # 获取密码
        pwd = request.POST.get('password')
        repwd = request.POST.get('repassword')
        if pwd == repwd and user:
            pwd = make_password(pwd)
            user.password = pwd
            user.save()
            return render(request, 'update_pwd.html', context={'msg': "用户密码更新成功"})
        else:
            return render(request, 'update_pwd.html', context={'msg': "用户密码更新失败"})




# 个人中心
# 传入值： 用户id
# render渲染传入值：
# 用户id； 简介； 网页设置queryset site_config； github地址； 图标； 文章集合
def user_center(request, user_name):

    site_config = SiteConfig.objects.first()
    user = site_config.site_owner
    owner_desc_short = site_config.site_owner_desc_short
    site_config.site_owner_desc = markdown.markdown(site_config.site_owner_desc.replace("\r\n", ' \n'),
                                                    extentions=[
                                                        'markdown.extensions.extra',
                                                        'markdown.extensions.codehilite',
                                                        'markdown.extensions.toc',
                                                    ], safe_mode=True, enable_attributes=False)
    github_addr = site_config.site_owner_github_addr
    icon = site_config.icon
    articles = Article.objects.filter(author=1)
    print(articles)

    data={
        "user": user,
        "owner_desc_short": owner_desc_short,
        "site_config": site_config,
        "github_addr": github_addr,
        "icon": icon,
        "articles": articles
    }
    print(user)
    return render(request, 'about.html', context=data)



# 文章详情页面
# 传入值: 文章主键
# 返回值： render渲染详情页面
# render传入值：
# 文章集合， 当前分类的文章， 分类字典（格式{‘分类名’：‘当前分类文章数’}）， 分类
def post(request, article_id):
    articles = Article.objects.all().order_by('-click_num')

    article = Article.objects.filter(pk=article_id).first()
    categories_article = Categories.objects.filter(article=article_id).first()
    print(article.content)

    # count click num
    article.click_num +=1
    article.save(update_fields=['click_num'])

    article.content = markdown.markdown(article.content.replace("\r\n", ' \n'),
                                         extentions=[
                                             'markdown.extensions.extra',
                                             'markdown.extensions.codehilite',
                                             'markdown.extensions.toc',
                                         ], safe_mode=True, enable_attributes=False)

    print(article.content)

    categories_dict, categories = get_categories()

    context = {'article': article,
               'articles': articles,
               'categories_article': categories_article,
               'categories_dict': categories_dict,
               'categories': categories,
               }
    return render(request, 'info.html', context)


# 上傳圖片到七牛雲
def uploadpic(request):
    if request.method == 'GET':
        return render(request, 'upload.html')
    else:
        img = request.FILES['file']
        url = upload(img)
        print(url)
        return HttpResponse(url)

# 返回文章集合
def article_list(request, categorie_name):
    category_id = Categories.objects.get(name=categorie_name)
    print(type(category_id))
    print(categorie_name)
    articles = Article.objects.filter(categories=category_id)
    print(articles)
    categories_dict, categories = get_categories()
    data = {
        "articles": articles,
        "categorie_name": categorie_name,
        'categories_dict': categories_dict,
    }
    return render(request, 'articlelist.html', context=data)

# 編輯頁面路由
def edit(request):
    return redirect('/xadmin/')


#
def search(request):
    article_title = request.POST.get("keyboard")
    print(article_title)
    articles = Article.objects.filter(title__contains=article_title)
    print(articles)

    categories_dict, categories = get_categories()

    data={
        "articles": articles,
        'categories_dict': categories_dict,
    }
    return render(request, 'articlelist.html', context=data)


def test(request):
    return render(request, 'login_2.html')


# 引导页面
def guide(request):
    try:
        users = UserProfile.objects.get(username='tom')
        for user in users:
            print(user)
    except Exception as e:
        user = UserProfile.objects.create_superuser('jackson', '345862542@qq.com','1006')
        user.save()
    return HttpResponse(1)