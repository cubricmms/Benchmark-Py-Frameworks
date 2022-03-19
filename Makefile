update:
	poetry update
	poetry export -o requirements.txt

.PHONY: clean
clean:
	find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
	find . -name 'requirements.txt' -delete

build: update
	docker-compose build

.PHONY: migrate
migrate:
	docker-compose exec web_django python manage.py migrate

flush:
	docker-compose exec web_django python manage.py flush --no-input

up:
	docker-compose up -d --build
	make migrate

down:
	docker-compose down

restart: down up

reset: flush migrate restart

logs:
	docker-compose logs
