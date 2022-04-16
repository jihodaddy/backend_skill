# 스프링 시큐리티

## 보안관련 용어
  - 접근주체(Principal): 보호된 대상에 접근하는 유저
  - **인증(Authenticate)** : 현재 유저가 누구인지 확인(ex.로그인)
    - 애플리캐이션의 작업을 수행할 수 있는 주체임을 증명
  - **인가(Authorize)**: 현대 유저가 어떤 서비스, 페이지에 접근할 수 있는 권한이 있는지 검사
  - **권한(Authorization)**: 인증된 주체가 애플리케이션의 동작을 수행할 수 있도록 허락되있는지를 결정
    - 권한 스인이 필요한 부분으로 접근하려면 인증 과정을 통해 주체가 증명되어야 함
    - 권한 부여에도 두가지 영역이 존재하는데 웹 요청 권한, 메소드 호출 및 도메인 인스턴스에 대한 접근 권한 부여

## 스프링 시큐리티 시작

**Maven**
```
  <dependencies>
<!-- ... other dependency elements ... -->
<dependency>
	<groupId>org.springframework.security</groupId>
	<artifactId>spring-security-web</artifactId>
</dependency>
<dependency>
	<groupId>org.springframework.security</groupId>
	<artifactId>spring-security-config</artifactId>
</dependency>
</dependencies>
```
