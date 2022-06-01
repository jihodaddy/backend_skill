# REST

- REST의 정의

  - "Representational State Trandfer"의 약자
    - 자원을 이름(자원의 표현)으로 구분하여 해당 자원의 상태(정보)를 주고 받는 모든 것을 의미
    - 자원의 표현에 의한 상태 전달
      - 소프트웨어가 관리하는 자원(Resource)의 이름을 정해 데이터가 요청되어지는 시점에서 자원의 상태(정보)를 전달
  - 분산 하이퍼미디어 시스템을 위한 소프트웨어 개발 아키텍처의 한 형식
    - REST는 기본적으로 기존기술과 HTTP 프로토콜을 그대로 활용하기 때문에 웹의 장점을 최대한 활용할 수 있는 아키텍처 스타일
    - REST는 네트워크 상에서 Client와 Server 사이의 통신 방식 중 하나

- REST의 구체적인 개념
  - HTTP URI(Uniform Resource Identifier) 를 통해 자원을 명시하고
  - HTTP Method(POST, GET, PUT, DELETE)를 통해 해당 자원에 대한 CRUD Operation을 적용하는 것을 의미
  - 웹 사이트의 이미지, 텍스트, DB내용 등의 모든 자원에 고유한 ID인 HTTP URI를 부여
