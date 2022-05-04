# JPA 정리

## Thymeleaf 설정

* thymeleaf 공식 사이트: http://www.thymeleaf.org/
* 스프링부트에서 thymeleaf 매핑
  * `resources/templates/` +{ViewName} + `.html`
  
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

## pox.xml
### H2
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.6.7</version>
		<relativePath/>
		<!-- lookup parent from repository -->
	</parent>
	<groupId>jpabook</groupId>
	<artifactId>start</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>start</name>
	<description>Demo project for Spring Boot</description>
	<properties>
		<java.version>11</java.version>
	</properties>
	<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-thymeleaf</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>com.h2database</groupId>
			<artifactId>h2</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<optional>true</optional>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<excludes>
						<exclude>
							<groupId>org.projectlombok</groupId>
							<artifactId>lombok</artifactId>
						</exclude>
					</excludes>
				</configuration>
			</plugin>
		</plugins>
	</build>

</project>

```
### postgresql
```xml
<dependencies>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-thymeleaf</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<!-- <dependency>
			<groupId>com.h2database</groupId>
			<artifactId>h2</artifactId>
			<scope>runtime</scope>
		</dependency> -->
		<dependency>
			<groupId>org.postgresql</groupId>
			<artifactId>postgresql</artifactId>
			<version>42.3.3</version>
		</dependency>
		<dependency>
			<groupId>org.javassist</groupId>
			<artifactId>javassist</artifactId>
			<version>3.23.1-GA</version>
		</dependency>

		<!-- 하이버네이트 -->
		<!-- <dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-entitymanager</artifactId>
			<version>5.4.9.Final</version>
		</dependency> -->

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>

		<!-- slf4j-api -->
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>2.0.0-alpha5</version>
		</dependency>
		<!-- logback-classic -->
		<dependency>
			<groupId>ch.qos.logback</groupId>
			<artifactId>logback-classic</artifactId>
			<version>1.3.0-alpha14</version>
			<scope>test</scope>
		</dependency>

		<!-- 스프링 테스트 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>5.3.18</version>
			<scope>test</scope>
		</dependency>

	</dependencies>
```
## application.yml
### H2
`main/resources/application.yml`
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
### postgresql
```xml
server:
    port: 8080

spring:
    datasource:
        driver-class-name: org.postgresql.Driver
        url: jdbc:postgresql://localhost:5432/postgres
        username: postgres
        password: 1234
    jpa:
        show-sql: true
        hibernate:
            ddl-auto: create
        database-platform: org.hibernate.dialect.PostgreSQLDialect
```
* `spring.jpa.hibernate.ddl-auto`에 create,create-drop,update,validate 옵션들을 줄 수 있음. (`spring.jpa.generate-ddl=true`로 설정해주어야 사용 가능. 기본 default 값이 false임.)
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




## 필드와 컬럼 매핑
### 데이터베이스 스키마 자동 생성
- DDL을 애플리케이션 실행 시점에 자동 생성
- 테이블 중심에서 객체 중심으로
- 데이터베이스 방언을 활용해서 데이터베이스에 맞는 적절한 DDL 생성
- 이렇게 생성된 DDL은 개발 장비에서만 사용, 운영에서 쓰면 안된다.
- 생성된 DDL은 운영서버에서는 사용하지 않거나, 적절히 다듬은 후 사용
### 자동 생성 속성
- create: 기존 테이블 삭제 후 다시 생성
- create-drop: create와 같으나 종료시점에 drop
- update: 변경 분만 반영 -> 운영에서는 바로 장애가 난다. 데이터가 몇 천만 건 있으면 웬만하면 lock 걸린다.
- validate: 엔티티와 테이블이 정상 매핑되었는지만 확인, 개발에서 쓰면 괜찮다.
- none: 사용하지 않음
- 운영 장비에는 절대 validate를 제외하고 사용해선 안된다.
- 개발 초기 단계에는 create 또는 update
- 테스트 서버에는 update 또는 validate
- 스테이징과 운영 서버에는 validate 또는 none
### 어노테이션
- 데이터베이스에 어떤 식으로 매핑이 될지를 결정, 자바 코드에 영향X

- @Column: db 컬럼명과 필드명을 매핑
- @Temporal: 시간 관련, 요즘에는 그냥 LocalDate 같은 거 쓰면 된다.
- @Enumerated: Enum 관, 현업에서는 무조건 EnumType.STRING을 써야한다. 다른 타입은 index순으로 들어간다. default가 ORDIBAL이니 조심.   
### @Column
- 가장 많이 사용됨
- name: 필드와 매핑할 컬럼 이름
- insertable, updatable -> 읽기 전용
- nullable: null 허용여부 결정, DDL 생성시 사용
- unique: 유니크 제약 조건, DDL 생성 시 사용
- length: 길이 제한
### @Lob
- db 필드의 내용이 너무 길면 바이너리 파일로 DB가 바로 밀어넣어야 할 때 사용
- CROB: Charactor 저장, String 타일에 @Lob하면 CROB이 된다.
- BROB: Byty 저장, byte 파일에 @Lob하면 BROB이 된다.
### @Transient
- 이 필드는 DB와 매핑하지 않는다는 뜻
- DB에는 매핑하고 싶지 않은데 객체에는 넣어두고 싶을 때 사용
## 식별자 매핑
- @Id
- @GeneratedValue
### GeneratedValue의 전략
- IDENTITY: 데이터베이스에 위임,MYSQL에서 사용
- SEQUENCE: 데이터베이스 시퀀스 오브젝트 사용, ORACLE에서 사용, @SequenceGenerator 필요
- TABLE: 키 생성용 테이블 사용, 모든 DB에서 사용, @TableGenerator 필요
- AUTO: 방언에 따라 자동 지정, 기본값
### 권장하는 식별자 전략
- 기본키 제약 조건: NULL X, 유일, 변하면 안됨
- 미래까지 기본키 제약 조건을 만족하는 자연키는 찾기 힘들다. 주민 번호도 변할 수 있다. 대체키(인조키)를 사용하자.
- 권장: Long + 대체키 + 키 생성전략 사용 -> ORM에서는 이게 좋다.

## Select Query
- Repository 인터페이스는 Entity의 기본적인 CRUD 가능하도록 제공
- Method
	- findBy : 쿼리 요청
	- countBy : 쿼리 결과 행 수를 요청
	- orderBy : 쿼리 결과를 정렬
	- existsBy : 해당 조건의 항목이 존재하는지 확인
- Keyword
	- And : 여러 컬럼을 and로 쿼리
	- Or : 여러 컬럼을 or로 쿼리
	- Containing : like 쿼리 (%param%)
	- Between : 컬럼 두 값 사이에 있는 항목 쿼리
	- OrderBy : 쿼리 결과를 정렬
	- In : 여러 값 중에 하나인 항목 쿼리
	- Exists : 해당 조건의 항목이 존재하는지 확인

## @GeneratedValue 
- (사용방법 : @GeneratedValue(starategy = GenerationType.IDENTITY))
- 하이버네이트(Hibernate)에서는 여러개의 데이터를 한번에 Insert, Update하게 해주는 기능인Batch기능을 지원
```
  jpa:
    hibernate:
      ddl-auto: create
    properties:
      hibernate:
        generate_statistics: true
        dialect: org.hibernate.dialect.H2Dialect
        show_sql: true
        format_sql: true
        order_inserts: true
        order_updates: true
        jdbc:
          batch_size: 1000
```
- Spring Data JPA 의 saveAll 함수를 사용하면, 여러개의 데이터를 한번에 Insert 또는 Update 할 수 있다.
- 하지만, @GeneratedValue 키 값 생성 전략을 Identity나 Auto로 정해놓는 경우 하이버네이트(Hibernate)에서 Batch Insert 기능을 비활성화 시켜놓고 Insert 작업을 수행
- - 따라서, saveAll 과 같은 함수를 사용해도 데이터 개수만큼 INSERT 또는 UPDATE 쿼리가 나가게 됨.
- IDENTITY 타입
	- 기본키 생성을 데이터베이스에 위임 (MySQL, SQL Server, DB2에서 사용)
	- 예를 들어 MySQL 사용시 auto_increment로 지정해 DDL 생성
	- 1차 캐시에 @ID 와 @Entity로 지정한 것들이 들어감
	- GeneratedValue가 IDENTITY 타입이면 id생성을 데이터베이스에 위임
	- JPA는 1차 캐시에 넣을 때 id필드가 뭔지 알 수 없음
	- JPA : persist
- AUTO 타입
	- 방언에 따라 자동 지정
	- 각 데이터베이스가 제공하는 SQL문법에 따라 자동 생성
	- `save` 진행시 insert 쿼리 전에 hibernate_sequence 테이블의 nextval을 확인하고 insert됨.
	- @id값이 있으면 id에 해당하는 select 실행 후, update됨.
	```
		Hibernate: select next_val as id_val from hibernate_sequence for update
		Hibernate: update hibernate_sequence set next_val= ? where next_val=?
		Hibernate: insert into ex_entity (name, id) values (?, ?)
	```
- SEQUENCE 타입
	- 시퀀스오브젝트를 만들고 이걸 통해 id값을 가져온다(오라클만 가능)
	- @SequenceGenerator 필요
	- @SequenceGenerator 속성

		- name : 식별자 생성기의 이름, 필수 속성이다.
		- sequenceName : 데이터베이스에 등록되어 있는 시퀀스 이름
		- initialValue : DDL 생성 시에만 사용되고 DDL을 생성할 때 처음 시작하는 수를 지정하는 속성
		- allocationSize : 시퀀스를 한번에 몇 개 호출하는 지 지정하는 속성, 성능 최적화를 할 때 사용한다. 기본값이 50이므로 데이터베이스에서 시퀀스 값이 몇 씩 증가하는 지 설정에 맞게 이 값을 지정해야 한다.
		- catalog, schema : 데이터베이스 카탈로그와 스키마 이름 지정
- TABLE 타입
	- 키 생성 전용 테이블을 하나 만들고 여기에 이름과 값으로 사용할 컬럼을 만들어 데이터베이스 시퀀스를 흉내내는 전략
	- 장점: 모든 데이터베이스에 적용 가능
	- 단점: 성능이 떨어짐
	- @TableGenerator 사용 필수

## JpaRepository 내장 save 함수
- insert와 update로 나뉘는데 기준은 select 했을 떄 PK가 있으면 update, 없으면 insert
- id를 직접 입력하는 경우
	- commit(트랜잭션 커밋) 이후 쿼리실행.
- id 생성을 DB에 위임하는 경우( IDENTITY 식별자 생성 전략)
	- persist(영속화) 할때 쿼리 실행

```java
	@Transactional
	@Override
	public <S extends T> S save(S entity) {

		Assert.notNull(entity, "Entity must not be null.");

		if (entityInformation.isNew(entity)) {
			em.persist(entity);
			return entity;
		} else {
			return em.merge(entity);
		}
	}
```
- 새로운 엔티티 인지 확인해 persist하거나 merge함
### 새로운 Entity 구별
- isNew() 함수는 Entity의ID가 null인지 아닌지 구별해서
- null 이라면 새로운 Entity로 간주
- null이 아니라면 이미 존재하는 Entity로 간주
- @Id@GeneratedValue 어노테이션 사용한 ID인 경우 persist()호출한 이후 ID생성

-  `식별자(@Id)`가 null또는 0인 경우 new 상태로 인식(Long타입:null인 경우 newState, int와같은 Primitive경우 new)


## Entity에 복합키로만 이루어져있을떄(일대다대일로 이루어 진것) 사용법 확인해보기
