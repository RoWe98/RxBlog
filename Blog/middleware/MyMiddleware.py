from django.shortcuts import redirect
from django.urls import reverse
from django.utils.deprecation import MiddlewareMixin

login_list = ['/app/center/',]

class MiddleWare1(MiddlewareMixin):

    def process_request(self, request):
        print('------------>1')
        path = request.path
        if path in login_list:
            print(request.user)
            if not request.user.is_authenticated:
                return redirect(reverse('app:login'))

