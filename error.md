## JPA 오류
  ### Invocation of init method failed
    - Spring framework 사용시 xml 설정을 잘못하는 경우 나오는 애러
  ### 오류: "post" 칼럼은 "post" 릴레이션(relation)에 없음
    - postgresql은 일반적인 Table, column 대신 Relation(table), attribute(column)을 사용함.
    - `search_path` : postgresql을 새 데이터베이스 생성시 public 스키마가 자동 생성, 즉 DB접근 시, Default로 public스키마로 접근
    - search_path는 탐색할 스키마의 순서를 지정해주는 변수
    - 퀴리 `show search_path;` 실행시 `schemaA, schemaB, schemaC` 이라하면
      - schemaA 부터 검색함
  ### GenerationTarget encountered exception accepting command : Error executing DDL "
    - 
## Kafka 오류 해결

### could not be established. Broker may not be available. 오류

- server.properties 파일 메모장 열기
- `listeners=PLAINTEXT://:9092` 주석 해제

```
  ...

  # The id of the broker. This must be set to a unique integer for each broker.
  broker.id=0

  ############################# Socket Server Settings #############################

  # The address the socket server listens on. It will get the value returned from 
  # java.net.InetAddress.getCanonicalHostName() if not configured.
  #   FORMAT:
  #     listeners = listener_name://host_name:port
  #   EXAMPLE:
  #     listeners = PLAINTEXT://your.host.name:9092
  listeners=PLAINTEXT://:9092
  
  ...
```
