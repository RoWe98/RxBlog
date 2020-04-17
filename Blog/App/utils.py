import uuid
import qiniu
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.request import CommonRequest
import random
import math
import json
import io
from PIL import Image
from django.conf import settings

from django.core.mail import send_mail

from App.models import UserProfile
from Blog.settings import EMAIL_HOST_USER
from Blog.settings import ALI_ACCESSKEY,ALI_ACCESSSECERT

def send_message(phone_num):
    client = AcsClient(ALI_ACCESSKEY, ALI_ACCESSSECERT, 'cn-hangzhou')
    request = CommonRequest()
    request.set_accept_format('json')
    request.set_domain('dysmsapi.aliyuncs.com')
    request.set_method('POST')
    request.set_protocol_type('https')  # https | http
    request.set_version('2017-05-25')
    request.set_action_name('SendSms')

    request.add_query_param('RegionId', "cn-hangzhou")
    request.add_query_param('PhoneNumbers', phone_num)
    request.add_query_param('SignName', "瑞克斯的博客系统")
    request.add_query_param('TemplateCode', "SMS_182400338")

    check_code = math.floor(1e5 * random.random())
    code = {
        "code": check_code
    }

    request.add_query_param('TemplateParam', code)

    response = client.do_action_with_exception(request)
    # python2:  print(response)
    # print(str(response, encoding='utf-8'))
    return json.loads(str(response, encoding='utf-8')),check_code



# 发送邮件
def send_email(email,request):
    subject = '个人博客找回密码'
    user = UserProfile.objects.filter(email=email).first()
    rand_code = uuid.uuid4()
    rand_code = str(rand_code)
    request.session[rand_code]=user.id
    message = '''
        可爱的用户:<br>
             您好!<br>
             此连接用于找回密码，请点击连接：<a href='http://127.0.0.1:8000/app/update_pwd/?c=%s'>更新密码</a>，<br>
        如果连接不能点击，请复制：<br>
                    http://127.0.0.1:8000/app/update_pwd/?c=%s<br>
        到您的浏览器地址栏<br>
                                                    RxBlog团队<br>
    '''%(rand_code,rand_code)
    result = send_mail(subject,message,EMAIL_HOST_USER,[email,], html_message=message)
    return result


q = qiniu.Auth(settings.QINIU_ACCESS_KEY, settings.QINIU_SECRET_KEY)



# 七牛云上传信息
def upload(img):

    _img = img.read()
    size = len(_img) / (1024*1024)

    image = Image.open(io.BytesIO(_img))
    key = str(uuid.uuid1()).replace('-','')
    name = 'upfile.{0}'.format(image.format)
    if size > 1:
        # 压缩
        x, y = image.size
        im = image.resize((int(x / 1.73), int(y / 1.73)), Image.ANTIALIAS)  # 等比例压缩 1.73 倍
    else:
        # 不压缩
        im = image

    im.save('./media/' + name)  # 在根目录有个media文件
    path = './media/' + name

    token = q.upload_token(settings.QINIU_BUCKET_NAME, key, 3600, )

    qiniu.put_file(token, key, path)
    url = 'http://qiniusave.luoshaoqi.com/{}'.format(key)

    return url

















