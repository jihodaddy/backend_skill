# Kafka 오류 해결

### could not be established. Broker may not be available. 오류

- server.properties 파일 메모장 열기
- `listeners=PLAINTEXT://:9092` 주석 해제

```
  # The id of the broker. This must be set to a unique integer for each broker.
  broker.id=0

  ############################# Socket Server Settings #############################

  # The address the socket server listens on. It will get the value returned from 
  # java.net.InetAddress.getCanonicalHostName() if not configured.
  #   FORMAT:
  #     listeners = listener_name://host_name:port
  #   EXAMPLE:
  #     listeners = PLAINTEXT://your.host.name:9092
  `listeners=PLAINTEXT://:9092`
```
