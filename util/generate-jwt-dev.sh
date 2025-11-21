curl -s -X POST "http://localhost:3000/realms/marche-conclu/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=dev-client" \
  -d "grant_type=password" \
  -d "username=test" \
  -d "password=test" \
| jq -r '
  "access_token:", .access_token, "",
  "refresh_token:", .refresh_token, "",
  "expires_in:", (.expires_in|tostring), "",
  "refresh_expires_in:", (.refresh_expires_in|tostring), "",
  "token_type:", .token_type
'
