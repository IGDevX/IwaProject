shop:
	docker compose -f docker-compose.dev.yml --profile shared --profile shop up --build | grep --line-buffered --color=always 'shop-service' 

user:
	docker compose -f docker-compose.dev.yml --profile shared --profile user up --build | grep --line-buffered --color=always 'user-service'
