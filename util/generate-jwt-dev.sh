curl -s -X POST "http://localhost:3000/realms/marche-conclu/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=dev-client" \
  -d "grant_type=password" \
  -d "username=test" \
  -d "password=test" \
| jq -r '.access_token' | tee .jwt

