from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-qcqc!rpkgcjg#cqpd#oakrfq!jqomct!@iy79a$7i!bs))&oaj"

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ROOT_URLCONF = __name__

WSGI_APPLICATION = "tiny_django.wsgi.application"

# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}


from django.http import HttpResponse
from django.urls import re_path


def home(request):
    return HttpResponse("Welcome to the Tinyapp's Homepage!", content_type="text/plain")


urlpatterns = [
    re_path(r"^$", home),
]
