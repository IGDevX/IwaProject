USERID=$(cut -d '.' -f2 .jwt | base64 -d | jq -r '.sub')

echo "{\"userId\":\"$USERID\",\"message\":\"Hello from one-liner\"}" | \
docker exec -i marcheconclu-kafka-1 /opt/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server localhost:9092 \
  --topic notifications

