shop:
	docker compose -f docker-compose.dev.yml --profile shared --profile shop up --build | grep --line-buffered --color=always 'shop-service' 

account:
	docker compose -f docker-compose.dev.yml --profile shared --profile account up --build | grep --line-buffered --color=always 'account-service'

notification:
	docker compose -f docker-compose.dev.yml --profile shared --profile notification up --build | grep --line-buffered --color=always 'notification-service'

order:
	docker compose -f docker-compose.dev.yml --profile shared --profile order up --build | grep --line-buffered --color=always 'order-service'

payment:
	docker compose -f docker-compose.dev.yml --profile shared --profile payment up --build | grep --line-buffered --color=always 'payment-service'

