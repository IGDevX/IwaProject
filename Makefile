shop:
	docker compose -f docker-compose.dev.yml --profile shared --profile shop up --build | grep --line-buffered --color=always 'shop-service' 

account:
	docker compose -f docker-compose.dev.yml --profile shared --profile account up --build | grep --line-buffered --color=always 'account-service'

