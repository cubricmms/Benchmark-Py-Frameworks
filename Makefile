update:
	poetry update
	poetry export -o requirements.txt

.PHONY: clean
clean:
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
	find . -name 'requirements.txt' -delete
	find . -name 'unsamples.zip' -delete

images:
	wget -nc "https://unsample.net/archive?count=30&width=1080&height=&quality=72&username=&collections=&terms=&orientation=&featured=&utm_source=unsample&utm_medium=referral&utm_campaign=api-credit&socket_id=EPc_j_z7uWF5HeZFAAMP" -O ./unsamples.zip 2> /dev/null || true
	unzip -q unsamples.zip -d unsamples

build: images
	docker-compose build

.PHONY: migrate
migrate:
	docker-compose exec web_django python manage.py migrate

flush:
	docker-compose exec web_django python manage.py flush --no-input

up:  build
	docker-compose up
	make migrate

down:
	docker-compose down

restart: down up

reset: flush migrate restart

logs:
	docker-compose logs

convert-images:
	cd unsamples && mkdir -p out && find * -maxdepth 0 -type f -name "*.jpg" -exec  convert {} -strip -interlace Plane -gaussian-blur 0.05 -quality 50% -type Grayscale out/{} \;
