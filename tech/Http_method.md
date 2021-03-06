# HTTP Method

- HTTP 메소드는 클라이언트가 웹 서버에서 사용자 요청의 목적이나 종류를 알리는 수단이다.
- 최초의 HTTP에서는 GET 메소드 하나밖에 없었지만 이후 다양한 메소드들이 생겨났다

## HTTP 메소드 종류와 특징

- HTTP 메소드 종류는 총 9가지
- 주요 메소드 5가지
  - `GET`: 리소스 조회
  - `POST`: 요청 데이터 처리, 주로 데이터 등록에 사용
  - `PUT`: 리소스를 대체, 해당 리소스가 없으면 생성
  - `PATCH`: 리소스를 일부만 변경
  - `DELETE`: 리소스 삭제
- 기타 메소드 4가지

  - `HEAD`: GET과 동일하지만 메세지 부분을 제외하고, 상태 줄과 헤더만 반환
  - `OPTIONS`: 대상 리소스에 대한 통신 가능 옵션을 설명(주로 CORS에서 사용)
  - `CONNECT`: 대상 자원으로 식별되는 서버에 대한 터털을 설정
  - `TRACE`: 대상 리소스에 대한 경로를 따라 메세지 루프백 테스트를 수행

  ## HTTP 메소드의 속성

  - 안전(Safe Methods) : 계속해서 호출해도 리소스를 변경하지 않음
  - 멱등(Idempotent Methods): 계속 호출해도 결과가 똑같음
  - 캐쉬가능(Cacheable Methods): 캐싱해 데이터를 효율적으로 가져올 수 있음(실제로는 GET과 HEAD만 주로 캐싱이 쓰임)

  ## HTTP 상태코드

  보통 100번대에서 500번대를 사용하는데 크게 다음과 같이 나눌 수 있다.

- 1xx (Informational): 요청이 수신되어 처리중
- 2xx (Successful): 요청 정상 처리
- 3xx (Redirection): 요청을 완료하려면 추가 행동이 필요
- 4xx (Client Error): 클라이언트 오류, 잘못된 문법등으로 서버가 요청을 수행할 수 없음
- 5xx (Server Error): 서버 오류, 서버가 정상 요청을 처리하지 못함

## HTTP 상태코드 종류와 의미

먼저 100 번대는 요청이 수신되어 처리중이라는 뜻인데 거의 사용하지 않으므로 생략하기로 하겠다.

다음으로, 200번대는 성공의 의미를 뜻하는데 더 자세하게는 다음과 같다.

- 200 OK : 요청 성공
- 201 Created : 요청 성공해서 새로운 리소스가 생성됨
- 202 Accepted : 요청이 접수되었으나 처리가 완료되지 않았음
- 204 No Content : 서버가 요청을 성공적으로 수행했지만, 응답 페이로드 본문에 보낼 데이터가 없음

300 번대는 리다이렉션인데 이는 location 헤더가 있으면 location 위치로 자동 이동하는 것을 리다이렉트라함.

- 301 Moved Permanently : 리다이렉트시 요청 메서드가 GET으로 변하고, 본문이 제거될 수 있음
- 302 Found : 리다이렉트시 요청 메서드가 GET으로 변하고, 본문이 제거될 수 있음
- 303 See Other : 리다이렉트시 요청 메서드가 GET으로 변경
- 304 Not Modified : 캐시를 목적으로 사용
- 307 Temporary Redirect : 리다이렉트시 요청 메서드와 본문 유지(요청 메서드를 변경하면 안된다.)
- 308 Permanent Redirect : 리다이렉트시 요청 메서드와 본문 유지(처음 POST를 보내면 리다이렉트도 POST 유지)

400번대는 클라이언트 측에서 오류가 발생했다고 알려주는 것이다. 자세한 사항은 다음과 같다.

- 400 Bad Request : 클라이언트가 잘못된 요청을 해서 서버가 요청을 처리할 수 없음
- 401 Unauthorized : 클라이언트가 해당 리소스에 대한 인증이 필요함
- 403 Forbidden : 서버가 요청을 이해했지만 승인을 거부함
- 404 Not Found : 요청 리소스를 찾을 수 없음

500번대는 서버 측에서 오류가 발생했다고 알려주는 것이다. 자세한 사항은 다음과 같다.

- 500 Internal Server Error : 서버 문제로 오류 발생, 애매하면 500 오류
- 503 Service Unavailable : 서비스 이용 불가
