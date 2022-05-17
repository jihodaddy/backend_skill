# RESTful API

## URL Rules
  - 마지막에 **/** 포함하지 않음
  - `_`(언더바) 대신 `-`(대시) 사용
  - 소문자사용
  - 메소드는 URL에 포함하지 않는다
  - 함수같이 컨트롤 리소스 나타내는 URL은 동작을 표함하는 표현(동사) 허용
## 인증
  - `/auto` : OAuth, JWT 같은 인증 관련 리소스
  - `/login`: id, pw 이용한 로그인 작업
## HTTP methods
  - POST, GET, PUT, DELETE 4가지 methods 반드시 제공
## HTTP status, status code
  - status 만으로 상태 에러 나타냄
