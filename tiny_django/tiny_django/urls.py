from django.http import HttpResponse
from django.urls import re_path


def home(request):
    return HttpResponse("Welcome to the Tinyapp's Homepage!", content_type="text/plain")


urlpatterns = [
    re_path(r"^$", home),
]
