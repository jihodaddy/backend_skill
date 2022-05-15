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
      
      ```
      # Broker의 ID로 Cluster내에서 Broker를 구분하기위해 사용.
      broker.id=0

      # 생성되지 않은 토픽을 자동으로 생성할지 여부. 기본값은 true.
      auto.create.topics.enable=false

      # Broker가 받은 데이터를 관리위한 저장공간.
      log.dirs=C:/work/kafka_2.12-2.1.0/data/kafka

      # Broker가 사용하는 호스트와 포트를 지정, 형식은 PLAINTEXT://your.host.name:port 을 사용
      listeners=PLAINTEXT://:9092

      # Producer와 Consumer가 접근할 호스트와 포트를 지정, 기본값은 listeners를 사용.
      advertised.listeners=PLAINTEXT://localhost:9092

      # 서버가 받을 수 있는 메세지의 최대 크기, 기본값 1MB.
      # Consumer에서는 fetch.message.max.bytes를 사용하는데
      # message.max.bytes >= fetch.message.max.bytes로 조건에 맞게 잘 설정해야한다.
      message.max.bytes=1000000

      # 네트워크 요청을 처리하는 쓰레드의 수, 기본값 3.
      num.network.threads=3

      # I/O가 생길때 마다 생성되는 쓰레드의 수, 기본값 8.
      num.io.threads=8

      # 서버가 받을 수 있는 최대 요청 사이즈이며, 서버 메모리가 고갈 되는걸 방지함.
      # JAVA의 Heap 보다 작게 설정해야 함, 기본값 104857600.
      socket.request.max.bytes=104857600

      # 소켓 서버가 사용하는 송수신 버퍼 (SO_SNDBUF, SO_RCVBUF) 사이즈, 기본값 102400.
      socket.send.buffer.bytes=102400
      socket.receive.buffer.bytes=102400

      # 토픽당 파티션의 수를 의미하며, 입력한 수만큼 병렬처리를 할 수 있지만 데이터 파일도 그만큼 늘어남. 기본값 1.
      num.partitions=1

      # 세그먼트 파일의 기본 사이즈, 기본값 1GB.
      # 토픽별로 수집한 데이터를 보관하는 파일이며, 세그먼트 파일의 용량이 차면 새로운 파일을 생성.
      log.segment.bytes=1073741824

      # 세그먼트 파일의 삭제 주기, 기본값 hours, 168시간( 7일 ).
      # 옵션 [ bytes, ms, minutes, hours ] 
      log.retention.hours=168

      # 세그먼트 파일의 삭제 주기에 따른 처리, 기본값은 delete.
      # 옵션 [ compact, delete ]
      # compact는 파일에서 불필요한 records를 지우는 방식.
      log.cleanup.policy=delete

      # 세그먼트 파일의 삭제 여부를 체크하는 주기, 기본값 5분.
      log.retention.check.interval.ms=300000

      # 세그먼트 파일의 삭제를 처리할 쓰레드의 수. 기본값 1.
      log.cleaner.threads=1

      # 오프셋 커밋 파티션의 수, 한번 배포되면 수정할 수 없음. 기본값 50.
      offsets.topic.num.partitions=50

      # 토픽에 설정된 replication의 인수가 지정한 값보다 크면 새로운 토픽을 생성하고
      # 작으면 브로커의 수와 같게 된다. 기본값 3.
      offsets.topic.replication.factor=1

      # 주키퍼의 접속 정보.
      zookeeper.connect=localhost:2181

      # 주키퍼 접속 시도 제한시간.
      zookeeper.connection.timeout.ms=6000

      ```

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

## 간단한 Kafka 
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
  
  ## Kafka 예제
  
  ### Producer api
  ```java
    String topicName = "test"; 
    String key = "Key1"; 
    String value = "Value-1"; 

    // 카프카와 연결하는 서버 설정
    Properties props = new Properties(); 
    props.put("bootstrap.servers", "localhost:9092,localhost:9093");
    props.put("key.serializer","org.apache.kafka.common.serialization.StringSerializer"); 
    props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer"); 

    //카프카에 데이터 전송
    Producer<String, String> producer = new KafkaProducer <>(props); 
    ProducerRecord<String, String> record = new ProducerRecord<>(topicName, key ,value); 
    producer.send(record); 
    producer.close(); 
  ```
  ### Consumer api
  ```java
    String topicName = "test"; 
    String groupName = "new_test_topic_group"; 

    Properties props = new Properties(); 
    props.put("bootstrap.servers", "localhost:9092,localhost:9093");
    props.put("group.id", groupName); 
    props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer"); 
    props.put("value.deserializer", "org.apache.kafka.common.serialization.StringSerializer"); 
    props.put("enable.auto.commit", "false"); 

    try (Kafka Consumer<String, String> consumer) { 
      consumer = new KafkaConsumer<>(props); 
      consumer.subscribe(Arrays.asList(topicName)); 
      while (true){ 
      ConsumerRecords<String, String  records = consumer.poll(100); 
      for (ConsumerRecord<String, String> record : records)
        System.out.println(String.valueOf(record.key()) + record.value()); 
      consumer.commitAsync(); 
      } 
    } catch(Exception e){ 
      e.printStackTrace(); 
    } finally{ 
      consumer.commitSync(); 
      consumer.close(); 
} 
  ```
