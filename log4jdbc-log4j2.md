# Log4jdbc-log4j2

### 사용이유
- 스프링에서 SQL문을 실행한 로그를 효과적이고 직관적으로 볼수 있도록 하는 라이브러리.


### Maven 라이브러리 (pom.xml 디펜던시 추가)
```
<!-- https://mvnrepository.com/artifact/org.bgee.log4jdbc-log4j2/log4jdbc-log4j2-jdbc4 -->
<dependency>
    <groupId>org.bgee.log4jdbc-log4j2</groupId>
    <artifactId>log4jdbc-log4j2-jdbc4</artifactId>
    <version>1.16</version>
</dependency>
```

### .properties파일

#Database Configuration   
db.jdbc-url=jdbc:`log4jdbc`:postgresql://localhost:5432/test   
db.driver-class-name=`net.sf.log4jdbc.sql.jdbcapi.DriverSpy`

### log4jdbc.log4j2.properties 생성
    - src/main/resources 폴더 위치에 파일생성.
```
log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator    ---1
log4jdbc.dump.sql.maxlinelength=0   ---2
```
    1. log4j2 대신 slf4j를 쓰고 싶을때 사용되는 옵션
        - log4j2로만 쓰거나 log4j2/slf4j를 같이 쓰면, 로그가 복잡해짐
    2. maxlinelength는 sql문을 최대 몇 라인까지 출력할 것인지 결정.

### Slf4j로 찍히는 log4jdbc 로그 설정
- applicaion.yml에 설정
    ```
    logging:
      level:
        org.springframework.cloud: info
        jdbc.sqlonly: OFF
        jdbc.sqltiming: DEBUG
        jdbc.audit: OFF
        jdbc.resultset: OFF
        jdbc.resultsettable: OFF
        jdbc.connection: OFF
    ```
- `jdbc.sqlonly` : SQL문만을 로그로 남긴다. 가독성을 위해, preparedStatement는 관련된 arguments 값으로 대체된다.
- `jdbc.sqltiming` : SQL문과 해당 SQL을 실행하는데 걸린 시간을 포함한다.
(참고로 시간 정보는 millisecond로 나온다)
- `jdbc.audit` : ResultSets를 제외한 모든 JBDC 호출 정보를 로그로 남긴다. 이는 매우 큰 볼륨을 가지는 결과물이므로, 특별히 JDBC 문제를 추적할 때 외엔 권하지 않는다.
- `jdbc.resultset` : JDBC 결과를 포함합니다. ResultSet 오브젝트에 대한 모든 호출이 로깅되므로 매우 방대합니다.
- `jdbc.resultsettable` : JDBC 결과를 테이블로 기록합니다. 
- `jdbc.connection` : 수행 도중 열리고 닫히는 연결 내용을 포함합니다. 연결 누수 문제를 찾는데에 유용합니다.
