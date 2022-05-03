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
log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
log4jdbc.dump.sql.maxlinelength=0
```
    - maxlinelength는 sql문을 최대 몇 라인까지 출력할 것인지 결정.
