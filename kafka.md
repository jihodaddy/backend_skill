# 카프카

## Kafka 설치
  - Docker 설치
  - Windows 설치

## Dependency
```xml
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
  </dependency>
  <dependency>
    <groupId>org.springframework.kafka</groupId>
    <artifactId>spring-kafka</artifactId>
  </dependency>
```
## application.yml
```
spring:
  kafka:
    consumer:
      bootstrap-servers: localhost:9092
      group-id: kafka-test
      auto-offset-reset: earliest
      key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
      value-deserializer: org.apache.kafka.common.serialization.StringDeserializer
    producer:
      bootstrap-servers: localhost:9092
      key-serializer: org.apache.kafka.common.serialization.StringSerializer
      value-serializer: org.apache.kafka.common.serialization.StringSerializer
```

## 코드
  - Consumer (Service)
    - 
  - Producer( Controller, Service)
