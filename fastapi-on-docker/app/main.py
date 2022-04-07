import random
import uuid
from pathlib import Path
import subprocess

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    picked = random.choice(list(Path('/images').glob('*.jpg')))

    process = subprocess.Popen(['convert', '-strip', '-interlace','Plane', '-gaussian-blur', '0.05', '-quality',  '85%', picked, f"/images/output/{uuid.uuid4()}.jpg"])
    process.wait()

    return 'done'
