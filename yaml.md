# YAML 설정파일 

```xml
spring:
   main: 
     allow-bean-definition-overriding: true
```
- Spring Boot 2.1 부터는 Bean Overriding이 불가능 하게 되면서 yml 파일에 추가
- Invalid bean definition with name 'errorPageFilter'  에러시 사용

### 로거 설정
- `spring.output.ansi.enabled : always` 로 주면 콘솔에서 뜨는 로그에 색이 입혀짐.
- `logging.path` : 로그 파일이 저장되는 디렉토리
- `logging.file` : 로그 파일 이름 (default: spring.log)
- `logging.file.max-size` : 저장할 로그 최대 용량 (default: 10MB)
- `logging.level.<패키지 경로>` : 디버그 레벨 을 주면, 해당 패키지 내 로그들은 해당 로그레벨로 로깅됨

### bindings 

### environments
