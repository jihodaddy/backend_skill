# 카프카

## Kafka 설치
  - Docker 설치
  - Windows 설치
    - https://kafka.apache.org/downloads 에서 Binary download
    - zookeeper.properties 파일 dataDir 경로에 {카프카 설치경로}/zookeeper-data 추가
    - server.properties 파일 log.dirs 경로에 {카프카 설치경로}/kafka-logs 추가
    - zookeeper 실행
    - cmd
      `.\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties`

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
## Kafka 실행
  - Broker 는 kafka의 서버를 뜻함, 동일 노드 내에서 여러개의 Broker를 띄울 수 있다.
  - 여러개의 Broker가 띄워져 있으면 이 분산 Message Queue를 관리 해주는 역활을 하는 것이 Zookeeper이다. 
  - kafka 서버를 띄우기 전에 Zookeeper 반드시 띄워야 한다.

## 코드
  - Consumer (Service) 
  ```java
    import org.springframework.kafka.annotation.KafkaListener;
    import org.springframework.stereotype.Service;
    import java.io.IOException;
  
    @Service
    public class KafkaSampleConsumerService {
    
      @KafkaListener(topics = "jihodaddy", groupId = "kafka-sample")
      public void consume(String message) throws IOException {
       System.out.println("receive message : " + message);
      }
    }


  ```
  - Producer( Controller, Service)
  - `Producer Service`
  ```java
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.kafka.core.KafkaTemplate;
    import org.springframework.stereotype.Service;

    @Service
    public class KafkaSampleProducerService {

      @Autowired
      private KafkaTemplate<String, String> kafkaTemplate;

      public void sendMessage(String message) {
        System.out.println("send message : " + message);
        this.kafkaTemplate.send("oingdaddy", message);
      }
    }
  ```
  - `Producer Controller` 
  ```java
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.web.bind.annotation.PostMapping;
  import org.springframework.web.bind.annotation.RequestMapping;
  import org.springframework.web.bind.annotation.RestController;
  import com.example.demo.service.KafkaSampleProducerService;

  @RestController
  public class KafkaSampleProducerController {
  
    @Autowired
    private KafkaSampleProducerService kafkaSampleProducerService;
  
    @PostMapping(value = "/sendMessage")
    public void sendMessage(String message) {
      kafkaSampleProducerService.sendMessage(message);
    }
  }
  ```
