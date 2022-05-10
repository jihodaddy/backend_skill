# 
```
  server:
  port: 8080

---

spring:
  profiles: default
  main:
    allow-bean-definition-overriding: true
  output:
    ansi:
      enabled: always
  cloud:
    stream:
      kafka:
        binder:
          brokers: IP주소
        streams:
          binder:
            configuration:
              default:
                key:
                  serde: org.apache.kafka.common.serialization.Serdes$StringSerde
                value:
                  serde: org.apache.kafka.common.serialization.Serdes$StringSerde
      bindings:
        event-in:
          group: 그룹이름
          destination: 이름
          contentType: application/json
        event-out:
          destination: 이름
          contentType: application/json
logging:
  level:
    org.springframework.cloud: error
    jdbc.sqlonly: OFF
    jdbc.sqltiming: DEBUG
    jdbc.audit: OFF
    jdbc.resultset: OFF
    jdbc.resultsettable: OFF
    jdbc.connection: OFF
    #org.hibernate.type: trace
server:
  port: 8081
---
```
