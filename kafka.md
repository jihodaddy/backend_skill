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

## Kafka 연동 순서
  - `Producer` & `Consumer` class 작성
  - `yml` 또는 `properties` 설정
  - `Controller` 작성
  - 테스트 수행( command로 `Zookeeper` 와 `Kafka` 실행
  - Spring boot 서버 구동해 구독하고 있는 정보 확인
  - http 요청으로 Kafka서버의 Topic 메세지 전달 및 Listener 출력 
  
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
- `spring.kafka.consumer`
  - `bootstrap-servers`
    - Kafka 연결에 사용될 호스트:포트쌍
    - 글로벌 설정도 있지만 consumer 전용으로 오바리이딩
- `group-id`
  - Consumer는 유일하게 식별 가능한 그룹 id를 작성
- `auto-offset-reset`
  - Kafka 초기 offset이 없거나, 더이상 offset이 없을때 수행
    - `latest` : 가장 최근에 생산된 메시지 offset reset
    - `earliest` : 가장 오래된 메시지로 offset reset
    - `none` : offset 정보없을때, Exception 발생
- `key-deserializer` / `value-deserializer`
  - Kafka에서 데이터를 수신할 때, key / value 역직렬화
  - KafkaTemplate과 매핑
  - (Json 데이터일 경우, `JsonDeserializer`)
- `spring.kafka.producer`
  - `bootstrap-servers`
    - consumer와 동일
  - `key-serializer` / `value-serializer`
    - Kafka에서 데이터를 송신할 때, key / value 직렬화


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
        this.kafkaTemplate.send("jihodaddy", message);
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
