notification:
	docker compose -f docker-compose.dev.yml \
	    --profile shared --profile notification \
	    up --build --attach notification-service

shop:
	docker compose -f docker-compose.dev.yml \
	    --profile shared --profile shop \
	    up --build --attach shop-service

account:
	docker compose -f docker-compose.dev.yml \
	    --profile shared --profile account \
	    up --build --attach account-service

order:
	docker compose -f docker-compose.dev.yml \
	    --profile shared --profile order \
	    up --build --attach order-service

payment:
	docker compose -f docker-compose.dev.yml \
	    --profile shared --profile payment \
	    up --build --attach payment-service

