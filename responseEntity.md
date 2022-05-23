# ResponseEntity
  - httpentity를 상속받는, 결과 데이터와 HTTP 상태코드를 젝접 제어할 수 있는 클래스
  - ResponseEntity에는 HttpRequest에 대한 응답 데이터가 포함
## 구조
  - HttpStatus
  - HttpHeaders
  - HttpBody
### HTTP Header 와 Body 차이
  - header : 요청/응답
  - body : 내용

### 예시
```java
Controller

@RestController
@RequiredArgsConstructor
public class ResponseEntityController {

    private final ResponseEntityService service;

    @GetMapping("/user/{id}")
    public ResponseEntity<MyDto> findByid(@PathVariable Long id) {
        User user = service.getUser();
        MyDto dto = new MyDto();

        HttpHeaders header = new HttpHeaders();
        header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));

        dto.setStatus(StatusEnum.OK);
        dto.setData(user);
        dto.setMessage("메세지메세지!");

        return new ResponseEntity<>(dto, header, HttpStatus.OK);
    }
}

```
