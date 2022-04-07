import random
import uuid
from pathlib import Path
import subprocess

from django.http import HttpResponse
from django.conf import settings

def task(request):
    picked = random.choice(list(Path(settings.IMAGES_FOLDER).glob('*.jpg')))

    process = subprocess.Popen(['convert', '-strip', '-interlace','Plane', '-gaussian-blur', '0.05', '-quality',  '85%', picked, f"{settings.IMAGES_OUT_FOLDER}/{uuid.uuid4()}.jpg"])
    process.wait()

    return HttpResponse('done')
