# Properties environment 설정

## 외부 설정
  - Spring Boot 동일한 애플리케이션 코드를 다른 환경에서 작업할 수 있도록 설정을 외부에서 전달 할 수 있음
    - .properties 파일
    - YAML 파일
    - 환경변수
    - 커맨드 라인 인자   
  **프로퍼티 값은 @Value 어노테이션을 통해 빈에 직접 주입하거나, Spring의 Environment 추상화를 통해 접근하거나 @ConfigurationProperties를 통해 객체에 바인딩할 수 있습니다.**  
  
### 순서
- Context -> Environment -> Propertysources
  
- 참고: https://www.latera.kr/reference/java/2019-09-29-spring-boot-config-externalize/
