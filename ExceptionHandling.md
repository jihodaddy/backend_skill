# Custom Exception Handling

## Java Exception
  - **Checked Exception** : 예외처리 필수, 트랜잭션 롤백 안됨, 검증: `컴파일`단계 
  - **Unchecked Exception** : 예외처리 필수 아님, 트랜잭션 롤백(기본값으로 들어있어 진행), 검증: `런타임` 단계
  ### Checked Exception
  - 예외처리 필수 : `try catch`나 상위 메소드로 넘겨줘야 함.
  - Transaction 기본 롤백 대상 아니라서 롤백 처리하려면 추가 처리 필요
  - 컴파일 단계에서 체크
    
  ### Unchecked Exception
  - 예외 처리 필수 아님: 예측할수 없는 예외라 필수 처리 불가능
  - Transaction 롤백 대상
  - 런타임 단계에서 체크
  ### HTTP 응답상태코드 (rfc2616 참고)
  - **성공**
    - 200 : OK, 요청 정상 처리 
    - 201 : Created, 생성 요청 성공
    - 202 : Accepted, 비동기 요청 성공
    - 204 : No Content, 요청 정상 처리, 응답 데이터 없음. 
  - **실패**
    - 400 : Bad Request, 요청이 부적절 할 때, 유효성 검증 실패, 필수 값 누락 등. 
    - 401 : Unauthorized, 인증 실패, 로그인하지 않은 사용자 또는 권한 없는 사용자 처리
    - 402 : Payment Required
    - 403 : Forbidden, 인증 성공 그러나 자원에 대한 권한 없음. 삭제, 수정시 권한 없음. 
    - 404 : Not Found, 요청한 URI에 대한 리소스 없을 때 사용. 
    - 405 : Method Not Allowed, 사용 불가능한 Method를 이용한 경우. 
    - 406 : Not Acceptable, 요청된 리소스의 미디어 타입을 제공하지 못할 때 사용.
    - 408 : Request Timeout
    - 409 : Conflict, 리소스 상태에 위반되는 행위 시 사용.
    - 413 : Payload Too Large
    - 423 : Locked
    - 428 : Precondition Required
    - 429 : Too Many Requests

  - 500 : 서버 에러 
  ### Exception 처리 위한 클래스
  - **ErrorCode** : 모든 예외 케이스 관리
  - **CustomException** : 기본 제공 Exception 외에 사용
  - **ErrorResponse** : JSON 형식 에러 응답 형식 지정
  - **GlobalExceptionHandler** : Custom Exception Handler
  - **@ControllerAdvice** : Controller 전역에서 발생할 수 있는 예외를 잡아 Throw, (ex. RestControllerAdvice로도 사용가능)
  - **@ExceptionHandler** : 특정 클래스 발생할 수 있는 예외 잡아 Throw

  ### 구현
  
  - ErrorCode.java
  ```java 
@Getter
@AllArgsConstructor
public enum ErrorCode {

  /* 
   * 400 BAD_REQUEST: 잘못된 요청
   */

  BAD_REQUEST(HttpStatus.BAD_REQUEST, "잘못된 요청입니다."),


  /*
    * 404 NOT_FOUND: 리소스를 찾을 수 없음
    */
  POSTS_NOT_FOUND(HttpStatus.NOT_FOUND, "게시글 정보를 찾을 수 없습니다."),

  /*
    * 405 METHOD_NOT_ALLOWED: 허용되지 않은 Request Method 호출
    */
  METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "허용되지 않은 메서드입니다."),

  /*
    * 500 INTERNAL_SERVER_ERROR: 내부 서버 오류
    */
  INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "내부 서버 오류입니다."),

  ;
  private final HttpStatus status;
  private final String message;

}
  ```
  - ErrorResponse.java
  ```java
@Getter
@Builder
public class ErrorResponse {

  // final 수정할 수 없음. 그러므로 초기값 필수,
  // 객체를 참조할때는 내부값은 변경될수 있음. 가리키는 객체는 변경안됨.
  private final LocalDateTime timestamp = LocalDateTime.now();
  private final int status;
  private final String error;
  private final String code;
  private final String message;

  // public ErrorResponse(ErrorCode errorCode) {
  //   this.status = errorCode.getStatus().value();
  //   this.error = errorCode.getStatus().name();
  //   this.code = errorCode.name();
  //   this.message = errorCode.getMessage();
  // }

  public static ResponseEntity<ErrorResponse> toResponseEntity(ErrorCode errorCode) {
    return ResponseEntity
        .status(errorCode.getStatus())
        .body(ErrorResponse.builder()
            .status(errorCode.getStatus().value())
            .error(errorCode.getStatus().name())
            .code(errorCode.name())
            .message(errorCode.getMessage())
            .build());
  }

}

  ```
  - CustomException.java
  ```java
@Getter
@AllArgsConstructor
public class CustomException extends RuntimeException{
  
  private final ErrorCode errorCode;
}

  ```
  - GlobalExceptionHandler.java
  ```java
@RestControllerAdvice //Controller 전역에서 발생할 수 있는 예외를 잡아 Throw
//Controller에 ResponseBody 적용된 형태라 보면 됨
@Slf4j
public class GlobalExceptionHandler {
  
  @ExceptionHandler(value = { CustomException.class })
    protected ResponseEntity<ErrorResponse> handleCustomException(CustomException e) {
        log.error("handleCustomException throw CustomException : {}", e.getErrorCode());
        return ErrorResponse.toResponseEntity(e.getErrorCode());
    }


  //  Custom Exception
//   @ExceptionHandler(RuntimeException.class) // 특정 클래스 발생할 수 있는 예외 잡아 Throw
//   public ResponseEntity<ErrorResponse> handleRuntimeException(final CustomException e) {
//     log.error("handleCustomException: {}", e.getErrorCode());
//     return ResponseEntity
//         .status(e.getErrorCode().getStatus().value())
//         .body(new ErrorResponse(e.getErrorCode()));
//   }

//   @ExceptionHandler(NotFoundException.class)
//   public ResponseEntity<ErrorResponse> handleStatusException(final CustomException e) {
//     log.error("handleCustomException: {}", e.getMessage());
//     return ResponseEntity
//             .status(ErrorCode.POSTS_NOT_FOUND.getStatus().value())
//             .body(new ErrorResponse(e.getErrorCode()));
//   }

// /*   
//  * HTTP 405 Exception
//  */
//   @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
//   protected ResponseEntity<ErrorResponse> handleHttpRequestMethodNotSupportedException(
//       final HttpRequestMethodNotSupportedException e) {
//     log.error("handleHttpRequestMethodNotSupportedException: {}", e.getMessage());
//     return ResponseEntity
//         .status(ErrorCode.METHOD_NOT_ALLOWED.getStatus().value())
//         .body(new ErrorResponse(ErrorCode.METHOD_NOT_ALLOWED));
//   }
//  /* 
//  * HTTP 500 Exception
//  */
//   @ExceptionHandler(Exception.class)
//   protected ResponseEntity<ErrorResponse> handleException(final Exception e) {
//     log.error("handleException: {}", e.getMessage());
//     return ResponseEntity
//               .status(ErrorCode.INTERNAL_SERVER_ERROR.getStatus().value())
//         .body(new ErrorResponse(ErrorCode.INTERNAL_SERVER_ERROR));
//   }
  
}

  ```
  - Test Controller
  ```java
@RestController
@RequestMapping("/post
public class PostApiController {

  // 강제로 오류 발생
  @GetMapping("/apitest")
  public String apitest() {
    //throw new CustomException(ErrorCode.INTERNAL_SERVER_ERROR);
    throw new CustomException(ErrorCode.BAD_REQUEST);
  }
  
}

  ```
  
