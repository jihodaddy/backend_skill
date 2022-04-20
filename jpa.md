# JPA 정리

## Thymeleaf 설정

* thymeleaf 공식 사이트: http://www.thymeleaf.org/
* 스프링부트에서 thymeleaf 매핑
  * ```resources/templates/``` +{ViewName} + ```.html```
  
  * MainController.java
  ```java
  @Controller
  public class MainController{
    @GetMapping("hello")
    public String hello(Model model){
      model.addAttribute("data", "hello world!!");
      return "hello";
    }
  }
  ```
  
  * hello.html
  ```html
  <!DOCTYPE HTML>
  <html xmlns:th="http://www.thymeleaf.org">
    <head>
        <title>Hello</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>
      <body>
        <p th:text="'안녕하세요. ' + ${data}" >안녕하세요. 손님</p>
      </body>
  </html>
  ```

## JPA 환경설정

```main/resources/application.yml```
 ```xml
 spring:
  datasource:
    url: jdbc:h2:tcp://localhost/~/jpashop;MVCC=TRUE
    username: sa
    password:
    driver-class-name: org.h2.Driver

  jpa:
    hibernate:
      ddl-auto: create
    properties:
      hibernate:
        show_sql: true
        format_sql: true

logging:
  level:
    org.hibernate.SQL: debug
 ```


### @Entity
  - table과 일대일로 매칭되는 객체 단위
  - 주의사항
    - 기본 생성자 필수
    - final클래스, enum, interface, inner class에는 사용할 수 없음
    - 저장할 필드에 final 사용 불가
### @Table
  - 엔티티와 매핑할 테이블을 지정
  - 생략 시 매핑한 엔티티 이름을 테이블 이름으로 사용

### @id
  - 데이타베이스 의 기본키(Premary Key)
### @Conlumn
  - 데이터베이스의 테이블에 있는 컬럼과 동일하게 1:1 매칭되기 때문에
  - Entity 클래스 안에 내부변수로 정의됨
### @GenerateVlaue
  - MySQL의 auto increment, ORACLE의 sequence
### @EmbeddedId
  - PK단일키가 아닌 복합키로로 테이블의 PK를 정의 할때 
  - 먼저 Value를 생성후 @EmbeddedId 어노테이션을 이용해 Value가 Entity에 삽입 가능함 명시
  - @EmbeddedId 어노테이션을 이용해 Entity에 해당 Value를 PK로 사용한다고 지정
### @enumerated
  - java의 enum 형태로 되어있는 코드 값이나 구분값을 데이타 타입으로 사용하고자 할때 사용
### @Transient
  - Entity 객체에 임시로 값을 담는 용도로 사용
