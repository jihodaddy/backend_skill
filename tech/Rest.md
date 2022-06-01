# REST

## REST의 정의

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

## REST의 장단점

- 장점
  - HTTP 프로토콜의 인프라를 그대로 사용하므로 REST API 사용을 위한 별도의 인프라를 구출할 필요가 없다.
  - HTTP 프로토콜의 표준을 최대한 활용하여 여러 추가적인 장점을 함께 가져갈 수 있게 해준다.
  - HTTP 표준 프로토콜에 따르는 모든 플랫폼에서 사용이 가능하다.
  - Hypermedia API의 기본을 충실히 지키면서 범용성을 보장한다.
  - REST API 메시지가 의도하는 바를 명확하게 나타내므로 의도하는 바를 쉽게 파악할 수 있다.
  - 여러가지 서비스 디자인에서 생길 수 있는 문제를 최소화한다.
  - 서버와 클라이언트의 역할을 명확하게 분리한다.
- 단점
  - 표준이 존재하지 않는다.
  - 사용할 수 있는 메소드가 4가지 밖에 없다.
  - HTTP Method 형태가 제한적이다.
  - 브라우저를 통해 테스트할 일이 많은 서비스라면 쉽게 고칠 수 있는 URL보다 Header 값이 왠지 더 어렵게 느껴진다.
  - 구형 브라우저가 아직 제대로 지원해주지 못하는 부분이 존재한다.
  - PUT, DELETE를 사용하지 못하는 점
  - pushState를 지원하지 않는 점

# REST API

- API(Application Programming Interface)란
  - 데이터와 기능의 집합을 제공하여 컴퓨터 프로그램간 상호작용을 촉진하며, 서로 정보를 교환가능 하도록 하는 것

# RESTful

- RESTful은 일반적으로 REST라는 아키텍처를 구현하는 웹 서비스를 나타내기 위해 사용되는 용어이다.
  ## RESTful의 목적
- 이해하기 쉽고 사용하기 쉬운 REST API를 만드는 것
- RESTful한 API를 구현하는 근본적인 목적이 성능 향상에 있는 것이 아니라 일관적인 컨벤션을 통한 API의 이해도 및 호환성을 높이는 것이 주 동기이니, 성능이 중요한 상황에서는 굳이 RESTful한 API를 구현할 필요는 없다.
  ## RESTful 하지 못한 경우
- Ex1) CRUD 기능을 모두 POST로만 처리하는 API
- Ex2) route에 resource, id 외의 정보가 들어가는 경우(/students/updateName)

[참조 블로그](https://gmlwjd9405.github.io/2018/09/21/rest-and-restful.html)
