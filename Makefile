shop:
	docker compose -f docker-compose.dev.yml --profile shared --profile shop up --build

user:
	docker compose -f docker-compose.dev.yml --profile shared --profile user up --build