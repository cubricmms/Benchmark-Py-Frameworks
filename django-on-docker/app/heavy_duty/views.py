from django.shortcuts import render
from django.http import JsonResponse


def task(request):
    return JsonResponse({"foo": "bar"})
