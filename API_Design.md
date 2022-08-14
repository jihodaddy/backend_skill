### 1. API 디자인이란 무엇인가?

-   API 는 함수를 통해서 데이터를 입력하고, 또는 출력하는 피드백을 제공한다. 이러한 함수들은 애플리케이션끼리 정보를 검색, 전달하거나 특정한 작업을 유도할 수 있다.
-   API 는 기본적으로 소프트웨어를 재사용 가능한 블록으로 만들어 다른 누군가가 손쉽게 조립해 무엇이든 할 수 있게 해준다.
-   API 의 개발자 경험(DX, Developer experience) 이란 API 를 사용하는 개발자들의 경험을 의미한다.
-   API 를 디자인할 때 실제로 무슨 일이 벌어질 것인지 세부 구현을 고민해야 한다.
-   **API 디자인을 할 때는 반드시 커스터머의 측면과 프로바이더 측면으로 인터페이스의 두 가지 면을 고려해야 한다.**
-   좋은 API 를 디자인하기 위해서는 인터페이스뿐만 아닌 모든 컨텍스트를 고려해야 한다.

### 2. 사용자를 위한 API 디자인하기

-   서로 연관된 포괄적인 요구사항들을 정리할 수 있도록 **컨슈머의 관점**에 중점을 두어야 한다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/2-%EC%82%AC%EC%9A%A9%EC%9E%90%EB%A5%BC%20%EC%9C%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#21-%EC%9D%BC%EC%83%81-%EC%86%8D-%EC%82%AC%EC%9A%A9%EC%9E%90-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%EB%A5%BC-%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EB%8A%94-%EC%98%AC%EB%B0%94%EB%A5%B8-%EA%B4%80%EC%A0%90)2.1 일상 속 사용자 인터페이스를 디자인하는 올바른 관점

    -   작업 방식에 집중하면 인터페이스가 복잡해진다.
    -   사용자가 할 수 있는 일에 집중하면 인터페이스는 단순해진다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/2-%EC%82%AC%EC%9A%A9%EC%9E%90%EB%A5%BC%20%EC%9C%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#22-%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4-%EB%94%94%EC%9E%90%EC%9D%B8-%EB%B0%A9%EB%B2%95)2.2 소프트웨어 인터페이스 디자인 방법

    -   API 를 소프트웨어의 제어판처럼 바라보기
    -   컨슈머의 관점에 집중해 단순한 API 만들기

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/2-%EC%82%AC%EC%9A%A9%EC%9E%90%EB%A5%BC%20%EC%9C%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#23-api-%EC%9D%98-%EB%AA%A9%ED%91%9C-%EC%8B%9D%EB%B3%84-%EA%B3%BC%EC%A0%95)2.3 API 의 목표 식별 과정

    -   API 를 디자인할 때 기본적으로 다음과 같은 사항들을 깊이 있고, 정확하게 이해해야 한다.
        -   누가 사용자인가?
        -   그들은 무엇을 할 수 있는가?
        -   그들은 그걸 어떻게 하는가?
        -   그들은 그것을 하기 위해 무엇이 필요한가?
        -   그들은 무엇을 반환받는가?
        -   입력은 어디를 통해서 들어오는가?
        -   출력은 어디에서 어떻게 쓰이는가?
    -   API 목표 캔버스
        -   누가 - API 를 사용하는 사용자들(또는 프로파일들)을 나열
        -   무엇을 - API 로 사용자들이 할 수 있는 것을 나열
        -   어떻게 - 무엇을 단계별로 분해해 나열
        -   입력(원천) - 각 단계를 진행하기 위해 필요한 요소들과 그것들의 원천을 나열(누락된 누가, 무엇을, 또는 어떻게를 찾기 위함)
        -   출력(사용처) - 각 단계의 반환과 그 쓰임새를 나열(누락된 누가, 무엇 또는 어떻게를 찾기 위함)
        -   목표 - 명시적이고 간결하게 각각의 어떻게 + 입력 + 출력을 재구성

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/2-%EC%82%AC%EC%9A%A9%EC%9E%90%EB%A5%BC%20%EC%9C%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#24-api-%EB%94%94%EC%9E%90%EC%9D%B8%EC%97%90%EC%84%9C-%ED%94%BC%ED%95%B4%EC%95%BC-%ED%95%A0-%ED%94%84%EB%A1%9C%EB%B0%94%EC%9D%B4%EB%8D%94-%EA%B4%80%EC%A0%90)2.4 API 디자인에서 피해야 할 프로바이더 관점

    -   불필요하게 데이터 모델을 사용자들에게 노출해 불편함을 유발하지 않도록 주의해야 한다.
    -   내부의 비즈니스 로직을 노출하는 것은 API 의 컨슈머가 이해하기도 어렵고 사용하기도 어렵게 만든다. **사용자들이 해당 API 로 무엇을 할 수 있는지에 집중하도록 하자.**
    -   드러나지 않아야 하는 소프트웨어 아키텍쳐와 API 디자인을 매핑시키는 것은 컨슈머가 API 를 이해하기도 사용하기도 어렵게 만든다. **소프트웨어 아키텍쳐는 항상 숨겨져야 한다.**

### 3. 프로그래밍 인터페이스 디자인 하기

-   API 목표를 프로그래밍 인터페이스로 변형하기

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/3-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%20%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#31-rest-api-%EC%86%8C%EA%B0%9C)3.1 REST API 소개

    -   예시) GET /products/{productId}
    -   경로 : 서버상의 리소스를 식별할 수 있는 주소(여기서는 productId)
    -   HTTP 메서드 : 이 리소스를 가지고 무슨 행위를 하고 싶은지 표시해주는 역할(여기서는 GET)
    -   **REST**는 Representational State Transfer 를 의미한다.
    -   자원을 이름(자원의 표현)으로 구분하여 해당 자원의 상태(정보)를 주고 받는 모든 것을 의미한다.
    -   월드 와이드 웹(www)과 같은 분산 하이퍼미디어 시스템을 위한 소프트웨어 개발 아키텍처의 한 형식
    -   HTTP URI(Uniform Resource Identifier)를 통해 자원(Resource)을 명시하고, HTTP Method(POST, GET, PUT, DELETE)를 통해 해당 자원에 대한 CRUD Operation을 적용하는 것을 의미한다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/3-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%20%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#32-api-%EB%AA%A9%ED%91%9C%EB%A5%BC-rest-api-%EB%A1%9C-%EB%B3%80%ED%99%98%ED%95%98%EB%8A%94-%EA%B3%BC%EC%A0%95)3.2 API 목표를 REST API 로 변환하는 과정

    -   API 목표 캔버스로 리소스와 리소스 사이 관계 식별
        -   리소스들은 다른 리로스들과 관계가 있을 수도, 없을 수도 있다. 또한 일정한 타입의 리소스 여러 개를 포함하는 리소스도 있다. 이런 리소스를 **콜렉션 리소스** 또는 단순하게 **콜렉션** 이라고 말한다.
    -   API 목표 캔버스를 이용해 액션과 액션의 파라미터 그리고 반환값 식별
        -   REST API 는 **액션과 리소스를 통해서 목표를 표현한다.**
        -   액션은 목표의 주요 동사이고, 목표의 핵심 리소스에 영향을 준다.
    -   경로를 포함한 리소스 표현
        -   REST 리소스의 경로는 반드시 유일해야 한다.
        -   API 는 사용자들이 경로를 해석하기 쉬워야 하기에 경로에서 더 많은 정보를 제공할수록 더 좋다.
    -   HTTP 로 액션 표현
        -   PATCH HTTP 메서드는 리소스의 부분 수정을 할 때 주로 쓰인다.
        -   PUT HTTP 메서드는 경로에 부합하는 리소스를 완전히 교체하고, 없는 경우 새로 생성해낼 수 있다. 후자 같은 경우에는 POST 로 추가하는 액션과 완전히 동일한 효과가 발생해야 하며, POST 와 마찬가지로 리퀘스트의 파라미터들은 바디에 포함되어야 한다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/3-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%20%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#33-api-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0)3.3 API 데이터 디자인하기

    -   컨슈머가 반드시 데이터를 이해하도록 만드는 동시에 내부 동작 원리를 노출하지 않는 디자인을 만들어야 한다.
    -   반드시 각 속성이 프로바이더 관점이 아닌 컨슈머 관점으로 디자인 되도록 주의를 기울여야 한다.
    -   **속성의 타입을 정할 땐, 되도록 기본 데이터 타입을 써서 여러 프로그래밍 언어에서 지원할 수 있도록 해주어야 한다.**(숫자,일자,불리언 등등)
    -   액션의 컨텍스트에 맞게 리스폰스를 재조정 해야한다.
    -   **파라미터는 반드시 필요한 데이터만을 제공해야 하고 불필요한 정보는 제공해서는 안된다. 또한, 백엔드가 자체적으로 처리할 수 있는 데이터를 포함해서도 안된다.**
    -   액션을 표현하는 데는 동사가 쓰인다. 즉, **액션 리소스**는 함수를 표현한다고 보면 왼다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/3-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%20%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#34-restful-%ED%95%9C-%EC%86%8C%ED%94%84%ED%8A%B8%EC%9B%A8%EC%96%B4-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98%EB%A5%BC-%EC%9C%84%ED%95%9C-%EC%97%AC%EC%84%AF-%EA%B0%80%EC%A7%80-%EC%A0%9C%EC%95%BD-%EC%82%AC%ED%95%AD)3.4 RESTful 한 소프트웨어 아키텍처를 위한 여섯 가지 제약 사항

    -   클라이언트 / 서버 분리 : 서로 커뮤니케이션하는 클라이언트와 서버, 가령 모바일 애플리케이션의 동작 방식과 API 를 제공하는 서버의 동작 방식에 대해 분리해서 생각해야 한다.
    -   스테이트리스(Stateless) : 리퀘스트를 처리하는데 필요한 모든 정보는 해당 리퀘스트에 포함되어 있어야 한다. 서버는 리퀘스트를 처리하는데 필요한 클라이언트의 그 어떤 컨텍스트도 서버의 세션에 담지 않는다.
    -   캐시 가능성(Cacheability) : 리퀘스트에 대한 리스폰스는 저장 가능 여부(클라이언트가 동일한 요청을 다시 하지 않고 재사용할 수 있도록) 및 기간을 표시해야 한다.
    -   레이어드 시스템(Layered system) : 클라이언트가 서버와 상호작용을 할 때, 오직 서버만을 알고 있어야 한다. 서버를 이루는 인프라스트럭쳐는 뒷단에 숨겨져 있어야 한다. 클라이언트는 오직 시스템에서 하나의 레이어만 볼 수 있어야 한다.
    -   코드 온 디멘드(Code on demand) : 서버는 필요하다면 클라이언트에 실행 가능한 코드를 전송할 수 있어야 한다.(예: Javascript) 이 제약사항은 선택적이다.
    -   유니폼 인터페이스(Uniform interface) : 모든 상호작용은 식별된 리소스의 개념에 따라 이루어져야 한다. 이는 식별된 리소스의 조작은 리소스의 상태 표현들과 표준 메서드들을 통해서만 이뤄짐을 의미한다. 또한, 상호작용은 리소스의 표현이 무엇을 의미하는지와 이 리소스들로 무엇을 할 수 있는지 알려줄 수 있는 메타데이터를 제공해야 한다.

### 4. API 명세 포맷을 이용한 API 디자인

-   OAS(OpenAPI Specification) 는 널리 사용되는 REST 명세 포맷이다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/4-API%20%EB%AA%85%EC%84%B8%20%ED%8F%AC%EB%A7%B7%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8.md#41-api-%EB%AA%85%EC%84%B8-%ED%8F%AC%EB%A7%B7%EC%9D%B4%EB%9E%80-%EB%AC%B4%EC%97%87%EC%9D%B8%EA%B0%80)4.1 API 명세 포맷이란 무엇인가?

    -   **API 명세**는 API 의 세부사항을 표현하기 위한 데이터 포맷이다.
    -   OAS 는 프로그래밍 언어에 상관없이 사용하는 REST API 명세 포맷이다.
    -   OAS 문서는 YAML 이나 JSON 으로 작성할 수 있는데, 저자는 읽고 쓰기 좋은 YAML 을 추천!
        -   YAML 에서 큰따옴표는 속성과 값에서 허용되지 않는다.
        -   JSON 의 구조는 중괄호({})와 쉼표(,)로 구분 지어지지만 YAML 에서는 줄바꿈과 들여쓰기로 대체된다.
        -   배열에서 쓰던 대괄호([])와 쉼표(,)들은 YAML 에서는 대시(-)와 줄바꿈으로 대체된다.
        -   JSON 과 다르게 YAML 은 문장의 시작에 해시마크(#)를 넣어 주석 처리가 가능하다.
    -   **intellij 에서 swagger 를 검색해서 플러그인을 설치하면 OSA 문서를 작성하고 바로 html 파일로 볼 수 있다.**
    -   OAS 포맷은 프로그래밍 인터페이스를 어떤 코드를 작성할 필요 없이 만들어 낼 수 있는 API 디자인 도구들이 있다!
    -   API 명세 포맷은 API 목표와 컨셉, 데이터를 프로그래밍 가능한 표현으로 설계할 때 사용해야 한다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/4-API%20%EB%AA%85%EC%84%B8%20%ED%8F%AC%EB%A7%B7%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8.md#42-oas-%EB%A5%BC-%ED%86%B5%ED%95%9C-api-%EB%A6%AC%EC%86%8C%EC%8A%A4%EC%99%80-%EC%95%A1%EC%85%98-%EC%84%A4%EB%AA%85)4.2 OAS 를 통한 API 리소스와 액션 설명

    -   OAS 문서 생성
        -   명세의 버전과 API 버전의 숫자는 반드시 큰따옴표로 둘러 싸야 한다.
        -   예시)

            ```
            openapi : "3.0.0"  # OAS 버전
            info: # API 일반 정보
                title: Shopping API
                version: "1.0"
            paths: {} # 빈 경로
            ```

    -   리소스 설명
        -   description 이 필수는 아니다. 하지만 API 리소스에 대한 설명을 제공하면 API 의 전체 수명주기동안 유용하게 쓰일 수 있다.
        -   **OAS 문서에서 설명하는 리소스는 반드시 동작을 포함하고 있어야 한다.** 그렇지 않다면 문서는 유효하지 않다.
        -   예시)

            ```
            openapi : "3.0.0"  
            info: 
                title: Shopping API
                version: "1.0"
            paths: # API 의 리소스
                /products: # 리소스의 경로
                    description: 상품 카탈로그 # 리소스의 설명
            ```

    -   리소스의 동작 설명
        -   summary 속성은 액션에 대한 짧은 설명이며, 구체적인 사항은 없다.
        -   YAML 에서 string 속성을 여러행으로 작성 할 때 반드시 **파이프(|)** 문자로 시작해야 한다.
        -   OAS 문서에서 동작은 반드시 적어도 하나의 response 속성을 가지고 있어야 한다.
        -   예시)

            ```
            openapi: "3.0.0"
            info:
                title: 쇼핑 API
                version: "1.0"
            paths:
                /products: # 리소스
                    description: 상품 카탈로그
                    get: # 액션의 HTTP 메서드
                        summary: 상품 조회 # 액션의 짧은 설명
                        description: |
                            카탈로그에서 비정형 질의 파라미터로 
                            조회한 상품들
                        responses: # 액션 리스폰스 리스트
                            "200": # 200 OK HTTP 상태 리스폰스
                                description: |
                                    비정형 질의에 일치하는 상품들
                    post:
                        summary: 상품 추가
                        description: |
                            상품 정보 파라미터에 해당하는
                            상품을 카탈로그에 추가
                        responses:
                            "200":
                            description: 카탈로그에 상품이 추가됨
            ```

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/4-API%20%EB%AA%85%EC%84%B8%20%ED%8F%AC%EB%A7%B7%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8.md#43-openapi-%EC%99%80-json-schema-%EB%A1%9C-api-%EB%8D%B0%EC%9D%B4%ED%84%B0-%ED%91%9C%ED%98%84%ED%95%98%EA%B8%B0)4.3 OpenAPI 와 JSON Schema 로 API 데이터 표현하기
    
    -   OAS 는 JSON Schema 사양을 기반으로 모든 데이터를 표현한다.
    -   쿼리 파라미터 묘사
        -   parameters 속성은 리스트이거나 배열이며, YAML 에서는 배열이나 리스트에 속하는 개별 원소들은 대시(-)로 시작한다.
            
            -   name: 실제 경로상(products?free-query={free query})에서 보이는 파라미터의 이름
            -   in: 파라미터가 어디에 위치하는지를 의미한다. 이번의 경우에는, query 파라미터임을 나타내고, 이는 경로의 맨 뒤에 ?(물음표) 다음에 위치한다는 의미이다.
            
            ```
            openapi: "3.0.0"
                info:
                    title: 쇼핑 API
                    version: "1.0"
                paths:
                    /products: # 리소스
                        get: # 액션의 HTTP 메서드
                            summary: 상품 조회 # 액션의 짧은 설명
                            description: |
                                카탈로그에서 비정형 질의 파라미터로 
                                조회한 상품들
                            parameters:
                            - name: free-query # 파라미터 이름
                              description: | # 파라미터 설명 
                                상품의 이름(name), 참조값(reference), 또는 상품 설명의 일부(partial description)
                              in: query # 파라미터의 위치
                              required: false # 파라미터의 필수여부
                              schema: # 파라미터의 데이터 구조 설명
                                type: string # 파라미터의 타입(string)
                            responses:
                                "200":
                                description: |
                                    비정형 질의 파라미터에 부합하는 상품들
            ```
            
    -   JSON Schema 를 통한 데이터 묘사
        
        -   properties: 프로퍼티들에 대해 기술
        -   required : 필수인 속성
        
        ```
        type: object
        description: A product
        required: # 필수인 속성들
          - reference
          - name
          - price
          - supplier
        properties: # 프로퍼티들에 대한 설명
          reference:
              type: string
              description: Product`s unique identifier
              example: ISBN-92930293
          name:
              ...
          price:
              ...
          description:
              ...
          supplier: # 프로퍼티 중에서 오브젝트 타입에 대한 설명
              type: object
              description: Product`s supplier
              required:
                  - deference
                  - name
              properties:
                  reference:
                      ...
        ```
        
    -   리스폰스 묘사
        
        -   content: 리스폰스 바디의 미디어 타입
        -   schema: 리스폰스 바디의 JSON 스키마
        -   type: 리스폰스 바디의 타입
        -   items: 리스폰스 바디 타입의 아이템 Schema
        
        ```
        responses:
            "200":
            description: |
                비정형 질의 파라미터에 부합하는 상품들
            content: # 리스폰스 바디의 정의
                application/json: # 리스폰스 바디의 미디어 타입
                    schema: 리스폰스 바디의 JSON 스키마
                        type: array # 리스폰스 타입은 배열이다
                        description: 상품의 배열 
                        required:
                            - reference
                            - name
                            - price
                            - supplier
                        properties:
                            reference:
                                description: 상품을 식별하는 고유 ID
                                type: string
                            name:
                                ...
                            ...
        ```
        
    -   바디 파라미터 묘사
        
        ```
        requestBody:
          description: 상품의 정보
          content:
              applictaion/json:
                  schema: # 바디 파라미터의 스키마
                      required:
                          - name
                          - price
                          - supplierReference
                      properties:
                          name:
                              type: string
                          price:
                              type: number
                          description:
                              type: string
                          supplierReference:
                              type: string
        ```
        
    -   OAS 에서 API 를 효율적으로 묘사하기
        -   컴포넌트 재사용하기
            
            -   스키마, 파라미터, 리스폰스등을 재사용 할 수 있고, **$ref** 속성으로 사전에 정의된 스키마의 경로를 적어주면 된다.
            
            ```
            openapi: "3.0.0"
            [...]
            components: # 재사용 가능한 컴포넌트
                schemas: # 재사용 가능한 스키마
                    product: # 재사용 가능한 스키마의 이름
                        type: object
                        description: 상품
                        required:
                        [...]
            paths:
                /products: 
                    post:
                        summary: 상품 추가
                        description: 상품을 카탈로그에 추가한다.
                        responses:
                            "200":
                            description: 카탈로그에 상품이 추가됨
                            content:
                                application/json:
                                    schema: 
                                        $ref: "#/components/schemas/product" # 사전에 정의된 스키마를 참조
            
            ```
            
        -   패스 파라미터(Path Parameter) 묘사하기
            
            -   /products/{productId} 경로에서 productId 를 변수로 취급하는데 이를 **패스 파라미터**라고 한다.
            
            ```
            paths:
                /products:
                [...]
                /products/{productId}: # 상품 리소스와 파라미터
                    description: 상품
                    delete: # 상품 삭제 액션
                        summary: 상품 삭제
                        prametes: # 상품 삭제 액션의 파라미터들
                            - name: productId # 패스 파라미터의 이름
                              in: path # 파라미터의 위 치
                              required: true # 파라미터의 필수 여부
                              description: 상품의 식별자
                              schema:
                                type: string
            ```
            
            -   패스파라미터 역시 컴포넌트로 재사용 가능하다.
            
            ```
            components:
                prameters:
                    productId:
                        [...] # 패스 파라미터 정의
            paths:
                /products:
                [...]
                /products/{productId}: # 상품 리소스의 경로와 패스 파라미터
                /delete:
                    parameters:
                        - $ref: #/compotents/parameters/productId # 사전 정의된 파라미터 참조
            ```

### 5. 직관적인 API 디자인하기

-   컨셉에 맞는 직관적인 표현 만들기
-   관련된 에러의 성공 피드백 식별하기
-   효율적인 사용 흐름(Flow) 디자인하기

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/5-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#51-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8-%ED%91%9C%ED%98%84)5.1 직관적인 표현
    -   이름, 데이터 포맷 데이터와 관련된 의사결정은 API 의 사용성을 크게 향상시킬 수도 반대로 크게 손상시킬 수 있다.
    -   명확한 이름 정하기
        -   **이름을 정할 때는(그 목적이 무엇이건) 세 단어에서 두 단어의 조합까지만 하기를 권한다.**
        -   사용하기 쉬운 데이터 타입과 포맷 정하기

            -   API 를 디자인할 때 적절한 데이터 포맷을 선택하는 것은 API 를 명시적으로 표현하기 위해 적절한 이름을 선택하는 것만큼 중요하다.
            -   데이터 타입과 포맷을 정할 때는 반드시 인간 중심적인 사고를 바탕으로 정해야 하며, 항상 정확한 표현을 제공해야 한다.
            -   복잡한 포맷을 사용하는 경우 정보를 확실하고 충분하게 제공하려 노력해야 한다.
            -   컨텍스트에 대한 이해 없이도 이해 할 수 있도록 노력해야 한다.
            -   사용하기 어려운 데이터
    
    
            {
            "number": 1234567,
            "balanceDate": 1534960860,
            "creationDate": 1423267200,
            "type": 1
            }

            -   사용하기 쉬운 데이터

            {
            "number": "00012345678",
            "balanceDate": "2020-08-22T18:01:00z",
            "creationDate": "2021-02-07",
            "type": "checking"
            }

        -   바로 사용할 수 있는 데이터 선택하기

            -   명확하지 않은 데이터 대신 의미있는 데이터를 사용한다.
            -   바로 쓰기 어려운 데이터

            GET /accounts/4566222-abdfh3-fkblj2f-ddskdfjd
            {
            "type": 2,
            "balance": 500,
            "overdraftLimit": 100,
            "creationDate": "2015-02-07"
            }

            -   사용 가능한 데이터
                -   식별하기 어려운 uuid 보다는 식별할 수 잇는 고유값을 사용한다.

            GET /accounts/0001234567
            {
            "type": 2,
            "typeName": "checking", //데이터를 추가하여 type 이란 의미를 알수 없는 데이터를 설명
            "balance": 500,
            "currency": "USD", //컨슈머가 추가적인 작업을 할 필요가 없도록 부가적인 데이터도 제공
            "overdraftLimit": 100,
            "safeToSpend":600,
            "creationDate": "2015-02-07"
            }

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/5-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#52-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8-%EC%83%81%ED%98%B8%EC%9E%91%EC%9A%A9)5.2 직관적인 상호작용
    -   이름은 명확할수록 좋으며, 모호한 약어는 피해야 한다.
    -   데이터 타입과 포맷은 이해하기 쉬워야 한다.
    -   데이터는 제공하는 사용자가 입력하기 쉬워야 한다.
    -   발생 가능한 모든 에러 피드백 식별하기
        
        -   규격에 맞지 않는 에러: 잘못된 값이 들어와서 발생하는 에러
        -   기능적 에러: 비즈니스 로직에 부합하지 않는(예를 들면 송금 금액보다 계좌 잔액이 적은 경우) 경우 발생하는 에러
        -   서버 에러: 데이터 베이스 장애 또는 서버 로직 처리 상의 에러 등
        -   에러를 나열할 때는 항상 컨슈머의 관점으로 바라봐야 한다.
        -   규격에 맞지 않는 리퀘스트 에러와 기능적 에러에 대한 HTTP 상태 코드
            
            유즈 케이스
            
            사용 예
            
            HTTP 상태코드
            
            잘못된 파라미터
            
            GET /accounts/123 리퀘스트에 존재하지 않는 계좌에 대해서 조회
            
            404 Not Found
            
            필수 속성의 누락
            
            amount 가 누락됨
            
            400 Bad Request
            
            잘못된 데이터 타입
            
            "startDate":1423332060
            
            400 Bad Request
            
            기능적 에러
            
            금액이 소비 한도를 초과
            
            403 Forbidden
            
            기능적 에러
            
            보내는 계좌에서 받는 계좌로의 이체가 금지됨
            
            403 Forbidden
            
            기능적 에러
            
            지난 5분이내에 동일한 송금이 발생한 전력이 있음
            
            409 Conflict
            
            예상치 못한 서버 에러
            
            구현에 버그가 숨겨져 있음.
            
            500 Internal Server Error
            
        -   **에러 리스폰스는 포괄적인 타입(generic type) 형태로 자세하게 보여주자.**
        
        {
            "source": "amount",
            "type": "MISSING_MANDATORY_PROPERTY",
            "message": "금액은 필수입니다."
        }
        
        -   여러개의 에러 반환하기
        
        {
            "message": "Invalid request",
            "errors": [
                {
                    "source": "source",
                    "type": "MISSING_MANDATORY_PROPERTY",
                    "message": "Source is mandatory"
                },
                {
                    "source": "destination",
                    "type": "MISSING_MANDATORY_PROPERTY",
                    "message": "Destination is mandatory"
                },
            ] 
        }
        

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/5-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#53-%EC%A7%81%EA%B4%80%EC%A0%81%EC%9D%B8-%ED%9D%90%EB%A6%84)5.3 직관적인 흐름
    
    -   에러 방지
        -   가능한 오류를 분석하여 이를 예방할 수 있는 추가 값 데이터를 결정한다.
        -   기존 목표의 성공 피드백을 향상시켜 이러한 데이터를 제공한다.
        -   이러한 데이터를 제공하기 위한 새로운 목표를 수립한다.


### 6. 예측 가능한 API 디자인하기

-   일관성을 유지하여 직관적인 API 만들기
-   사용 간소화 및 사용자 적응 기능을 추가하기
-   사용자 가이드를 위한 메타데이터(metadata)와 메타골(metagoal) 추가

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/6-%EC%98%88%EC%B8%A1%20%EA%B0%80%EB%8A%A5%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#61-%EC%9D%BC%EA%B4%80%EC%84%B1-%EC%9C%A0%EC%A7%80%ED%95%98%EA%B8%B0)6.1 일관성 유지하기

    -   **일관된 디자인에는 변형이나 모순이 없다. 일관된 디자인은 사용자의 이전 경험을 활용하여 직관적인 인터페이스를 만드는 데 도움이 된다.**
    -   일관성 없는 디자인은 다양성 또는 모순을 불러들여 인터페이스를 이해하고 사용하기 어렵게 만든다.
    -   일관된 데이터 디자인하기
        -   일관적인 이름을 사용하기
        -   특정 데이터 타입에 대한 포맷이 정해졌다면 같은 데이터 타입은 모두 같은 포맷을 적용하는 편이 좋다.
        -   **/transfers/delayed/{transferId} 보다는 /delayed-transfers/{transferId} 와 같이 사용하는 것이 이해하기가 더 쉽다.**

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/6-%EC%98%88%EC%B8%A1%20%EA%B0%80%EB%8A%A5%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#62-%EC%A0%81%EC%9D%91-%EA%B0%80%EB%8A%A5%ED%95%98%EA%B2%8C-%ED%95%98%EA%B8%B0)6.2 적응 가능하게 하기

    -   다른 포맷으로 제공하거나 응답하기
        -   하나의 리소스는 컨슈머에게 프로바이더를 통해서 JSON, CSV 등과 같은 다양한 표현을 이용해 매우 다양한 포맷으로 제공할 수 있다.
        -   콘텐츠 네고시에이션이란 단일 리소스에 대해서 여러 가지 표현을 통해서도 상호작용을 가능하게 해주는 HTTP 메카니즘이다.
        -   HTTP 서버가 리퀘스트에 대한 응답을 보낼 때는 반드시 반환하는 문서의 **미디어타입(media type)** 을 명시해줘야 한다. 이를 위해서 리스폰스 헤더에 **Content-type**이 쓰인다.
        -   컨슈머는 **Accept 리퀘스트 헤더**를 이용해서 받고 싶은 미디어 타입을 리퀘스트에 포함하여 요청 할 수 있다.
    -   국제화와 현지화
        -   Accept-Language 와 Content-Language 헤더를 이용한다.
        -   만약 지원하지 않는 언어일 경우 서버는 **406 Not Acceptable** 을 반환한다. 이 상태 코드는 컨슈머가 요청한 미디어 타입이 지원되지 않음을 의미한다. 그렇지만 명시적으로 UNSUPPORTED_LANGUAGE 와 같은 에러 코드와 명확한 피드백 메시지를 명시적으로 제공하는 것도 좋은 방법이다.
        -   국제화 : Accept-Language 헤더를 컨슈머가 요청한 언어에 맞추어 현지화 된 리스폰스를 기대한다는 의미이다.
        -   현지화 : 해당 언어 지역에 맞게 미터법 등과 같은 것을 변경해서 제공하는 것
    -   필터, 페이지, 정렬 적용하기

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/6-%EC%98%88%EC%B8%A1%20%EA%B0%80%EB%8A%A5%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#63-%ED%83%90%EC%83%89-%EA%B0%80%EB%8A%A5%ED%95%98%EA%B2%8C-%ED%95%98%EA%B8%B0)6.3 탐색 가능하게 하기

    -   메타데이터 제공하기
    -   하이퍼미디어 API 제공하기


### 7. 간결하고 체계적인 API 디자인하기

-   API 의 데이터, 피드백, 목표의 구성
-   데이터, 목표 및 API 의 세분성 관리

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/7-%EA%B0%84%EA%B2%B0%ED%95%98%EA%B3%A0%20%EC%B2%B4%EA%B3%84%EC%A0%81%EC%9D%B8%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#71-api-%EA%B5%AC%EC%A1%B0%ED%99%94)7.1 API 구조화

    -   연관관계가 있는 데이터들을 그룹화하기
    -   피드백 구조화하기
    -   목표 구조화하기
        -   하나의 동작은 필요하다면 여러 개의 카테고리에 포함될 수 있다.
        -   목표들을 기능적인 관점에서 그룹화 하도록 하자.
        -   **REST API 를 디자인할때, URL 경로가 바로 목표를 대변한다고 착각해서는 안된다. 반드시 각 목표의 기능적인 측면에 집중해야지, 표현에 집중해서는 안된다.**

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/7-%EA%B0%84%EA%B2%B0%ED%95%98%EA%B3%A0%20%EC%B2%B4%EA%B3%84%EC%A0%81%EC%9D%B8%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#72-api-%EC%82%AC%EC%9D%B4%EC%A7%95)7.2 API 사이징

    -   **객체가 지나치게 많은 기능을 제공하거나 너무 많은 제어나, 너무 많은 정보를 제공하면 일반적으로 사용성이 심각하게 떨어져서 사용할 수 없다. 이러한 객체들은 지나치게 비대하고, 불편한데다가, 사용자를 겁에 질리게 만드는 경향이 있다.**
    -   올바른 세분화를 택하면 API 의 목표가 이질적인 두 가지(혹은 그 이상)의 동시에 다른 일들을 하지 않도록 한다.

### 8. 안전한 API 디자인하기

-   API 보안과 API 디자인의 교차점
-   접근 제어를 위한 사용자 친화적인 스코프 정의
-   접근 제어를 충족시키기 위해 API 디자인 적용
-   민감한 정보를 처리하기 위한 API 디자인 적용

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/8-%EC%95%88%EC%A0%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#81-api-%EB%B3%B4%EC%95%88%EC%9D%98-%EA%B0%9C%EC%9A%94)8.1 API 보안의 개요

    -   컨슈머 등록하기
        -   API 를 안전하게 만들기 위해서는 허용된 컨슈머만 API 를 사용하도록 해야 한다. 그러기 위해서 개발자들은 API 제공자의 **개발자 포털**을 사용할 수 있어야 한다.
        -   컨슈머가 API 의 어느 스코프까지 사용할지 선택하도록 해야한다. 여기서 **스코프**란 API 에 속한 하나에서 여러 목표들을 의미한다.
        -   API 개발자 포털을 제공할 수 없는 경우에는 데이터 베이스에 응용 프로그램 이름, 범위 및 자격 증명을 안전하게 저장하는 등의 방식으로 동일한 구성을 수행 할 수 있다.
    -   API 사용을 위해 자격증명 가져오기
        -   인증 서버 : 최종 사용자의 인증정보를 확인한다. 인증 토큰을 생성하고, 사용자 ID, 클라이언트 ID, 허용된 스코프 등을 포함해서 반환한다.
        -   웹 인증 프레임 워크 : Oauth 2.0 , OpenID Connect
    -   API 호출하기
        -   컨슈머의 리퀘스트는 액세스 토큰으로 추가된 데이터라는 컨텍스트에 묶여 있다.
        -   리퀘스트를 액세스 토큰과 함께 호출하면, 인증 서버는 액세트 토큰이 유효한지 확인하고, 필요한 정보를 추가하여 반환한다.
        -   API 서버는 액세스 토큰으로 받은 스코프에 따라 적절한 응답을 내려준다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/8-%EC%95%88%EC%A0%84%ED%95%9C%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#82-api-%EB%B6%84%ED%95%A0%EC%9D%84-%ED%86%B5%ED%95%9C-%EC%A0%91%EA%B7%BC-%EC%A0%9C%EC%96%B4-%ED%99%9C%EC%84%B1%ED%99%94)8.2 API 분할을 통한 접근 제어 활성화

    -   컨슈머가 접근 가능한 영역을 꼭 필요한 수준으로 제한을 둠으로써, 공격에 대한 가능성을 줄일 수 있다.(**최소 권한의 원칙**)
    -   유연하고 정제된 스코프 정의하기
        -   첫 번째 단계로 각 목표에 대한 주요 컨셉(또는 자원) 식별을 한다. 가장 먼저 목표를 대표할 수 있는 일반 명사를 식별해야 한다.
        -   두 번째로 목표의 대표 동사를 표현하기에 적합한 생성, 읽기, 수정, 삭제에 CRUD 액션을 식별해 낸다.
        -   컨셉과 액션을 이용해 스코프를 나누면 여전히 유연성을 유지하지만, 구성은 지나치게 정제되거나 복잡해지지 않는다.
    -   단순하지만 더 굵직한 스코프로 정의하기
        -   카테고리 : 기능적 관점으로 목표들을 구조화하여 API 를 어떻게 쓰는지 컨슈머에게 도움이 되고자 하는 목적
        -   스코프 : 컨슈머가 그들에게 필요한 목표에만 접근할 수 있도록 통제하고자 하는 목적
    -   API 명세 포맷으로 스코프 정의하기

        -   스코프 표현하기

        ```
        components:
            securitySchemas:
                BankingAPIScopse: # 재사용 가능한 스코프는 components.securitySchemas 에 정의되어 있다.
                    type: oatuh2
                    flows:
                        implicit:
                            authorizationUrl: "https://auth.bankingcompany.com/authorize" # URL 은 한 줄로 표시하는 편이 좋다.
                            scopes: # 보안 스키마는 하나 이상의 스코프를 포함할 수 있다.
                                "beneficiary:create": Create beneficiaries
                                "beneficiary:read": List beneficiaries
                                "beneficiary:delete": Delete beneficiaries
                                "beneficiary:manage": Create, list, and delete beneficiaries
        ```

        -   목표와 스코프의 연결

        ```
        paths:
            /beneficiaries:
                get:
                    tages:
                        - Transfer
                    description: Gets beneficiaries list
                    security: # 사용되는 보안 스키마들의 목록
                        - BankingAPIScopes: # components.securitySchemas 를 참조하여 이 목표에서 필요로 하는 스코프들의 열거
                            - "beneficiary:read"
                            - "beneficiary:manage"
                    - responses:
                        "200":
                            description: The beneficiaries list
        ```

### 9. API 디자인 발전시키기

-   브레이킹 체인지(Breaking change)를 유발하지 않고 API 발전시키기
-   브레이킹 체인지를 관리하기 위해 API 버전 지정하기
-   브레이킹 체인지를 유발하지 않는 확장 가능한 API 디자인하기
-   **브레이킹 체인지**: 규격을 바꿔 기존 사용자들이 사용할 수 없게 만드는 변화로

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/9-API%20%EB%94%94%EC%9E%90%EC%9D%B8%20%EB%B0%9C%EC%A0%84%EC%8B%9C%ED%82%A4%EA%B8%B0.md#91-api-%EC%A7%84%ED%99%94-%EB%94%94%EC%9E%90%EC%9D%B8)9.1 API 진화 디자인

    -   출력 데이터에 적용하는 브레이킹 체인지에 따른 결과

        변경

        결과

        속성의 이름을 변경

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

        속성의 위치 이동

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

        필수 속성의 제거

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

        필수 속성에서 선택 사항으로 변경

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

        속성의 타입 변경

        파싱 에러

        속성의 포맷 변경

        파싱 에러

        속성의 특징 변경(길이, 숫자 범위, 배열 요소의 길이 확장)

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

        속성의 의미 변경

        최악의 결과

        enum 값 추가

        구현에 따라 다름(UI 에서 데이터가 사라짐, 데이터 오염, 충돌, 기타 등등)

    -   입력 데이터와 파라미터에서 브레이킹 체인지 회피하기
        -   입력 데이터에 적용하는 브레이킹 체인지에 따른 결과

            변경

            결과

            출력 데이터에 적용했을 때와 비교

            속성의 이름을 변경

            API 에러

            동일

            속성의 위치 이동

            API 에러

            동일

            필수 속성의 제거

            API 에러

            동일

            선택 사항에서 필수 속성으로 변경

            API 에러

            반대(필수 속성을 선택 사항으로 변경했을 때와 동일)

            속성의 타입 변경

            API 에러

            동일

            속성의 포맷 변경

            API 에러

            동일

            속성의 특징 변경(길이, 숫자 범위, 배열 요소의 길이 축소)

            API 에러

            반대(특징을 확장한 때와 동일)

            속성의 의미 변경

            최악의 경우(주로 프로바이더에 영향을 미침)

            반대(컨슈머 영역에 영향을 미침)

            enum 값 제거

            API 에러

            반대(값을 추가할 때와 같음)

            **필수 속성 추가**

            API 에러

            에러 발생 안함(브레이킹 체인지강 아님)


    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/9-API%20%EB%94%94%EC%9E%90%EC%9D%B8%20%EB%B0%9C%EC%A0%84%EC%8B%9C%ED%82%A4%EA%B8%B0.md#92-api-%EB%B2%84%EC%A0%84-%EC%A0%95%ED%95%98%EA%B8%B0)9.2 API 버전 정하기
    
    -   시멘틱 버저닝
        -   **메이저 숫자**는 브레이킹 체인지가 발생할 때만 올라간다. 예) 필수 파라미터가 추가되는 경우
        -   **마이너 숫자**는 새로운 기능이 추가되고 하위 호환성이 유지되는 경우에 올라간다. 예) HTTP 메서드나 리소스 경로가 REST API 에 추가되는 경우
        -   **패치 숫자**는 하위 호환이 가능한 버그 수정의 경우에 올라간다.
    -   **API 세계에서의 시멘틱 버저닝은 단 두 자리의 숫자로만 구성되어 있다.**(브레이킹, 논브레이킹) 이 숫자들만 가지고도 하위 호환과 하위 호환이 되지 않는 API 의 변경사항을 추적할 수 있기 때문이다.
    -   브레이킹 체인지는 하위 호환이 불가능한 변경을 의미한다.
    -   쿼리 파라미터를 이용해서 API 버전을 변경하는 것은 API 디자인 관점에서 깔끔하지 않다.
    
    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/9-API%20%EB%94%94%EC%9E%90%EC%9D%B8%20%EB%B0%9C%EC%A0%84%EC%8B%9C%ED%82%A4%EA%B8%B0.md#93-api-%EB%A5%BC-%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%A0-%EB%95%8C-%ED%99%95%EC%9E%A5%EC%84%B1%EC%9D%84-%EB%AA%85%EC%8B%AC%ED%95%98%EA%B8%B0)9.3 API 를 디자인할 때 확장성을 명심하기
    
    -   **REST API 의 리소스들은 반드시 오브젝트라는 봉투에 담겨 확장성을 보장하고 브레이킹 체인지의 위협을 줄여야 한다.**
    -   불리언이 숫자나 문자열보다 확장성이 떨어진다. 상태값을 표현하는 겨우 true, false 이외의 상태값이 필요한 경우에는 확장이 어렵다.
    -   API 가 커질수록, 발전의 횟수가 늘어날수록, 당연하게 브레이킹 체인지의 위험도 커진다. 가급적이면 큰 API 를 만드는 대신에, 작은 API 를 여러개 만들도록 하자.

### 10. 네트워크 효율적인 API 디자인하기

-   API 호출을 불필요하게 자주 요청하지 않도록 한다.
-   HTTP 기반의 API 라면, 압축을 활성화하고, 지속적인 연결을 통해 데이터 크기와 처리지연 문제를 감소시킬 수 있다.
-   캐싱과 조건부 리퀘스트를 활성화하면 단순히 데이터 크기뿐만 아니라 호출 횟수도 감소시킬 수 있다.
-   HTTP2 로 변경하기
    -   효율적으로 지속적인 연결과 병렬 리퀘스트 처리를 지원
    -   바이너리 트랜스포트 제공
    -   HTTP/1.1 하위 호환 가능
-   필터링을 제공하면 컨슈머들은 정말 필요한 것들만 요청하게 되어 주고받는 데이터의 크리를 절약할 수 있다.
-   **리소스에서 가장 대표적이고 유용한 속성들을 포함하는 표현을 선택하면 사용성이 있는 API 를 만들뿐 아니라 목록의 데이터를 가져온 이후에 벌어질 수 있는 불필요한 API 호출을 많이 회피할 수 있다.**
-   데이터 쿼리를 활성화하는 것은 어떠한 경우에는 적절한 방법이지만, 그렇지 않을수도 있다. 데이터 쿼리의 활성화는 전송되는 데이터의 크기와 API 호출 횟수를 줄일 수 있지만, 캐싱의 여지를 감소시켜 버린다.

### 11. 컨텍스트에 맞는 API 디자인하기

-   목표와 데이터에 맞게 커뮤니케이션 적용하기
-   컨슈머와 프로바이더의 요구사항과 한계를 고려하기
-   컨텍스트에 맞는 API 스타일 선택하기

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/11-%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8%EC%97%90%20%EB%A7%9E%EB%8A%94%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#111-%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%99%80-%EB%AA%A9%ED%91%9C%EC%99%80-%EC%84%B1%EA%B2%A9%EC%97%90-%EB%A7%9E%EB%8A%94-%EC%BB%A4%EB%AE%A4%EB%8B%88%EC%BC%80%EC%9D%B4%EC%85%98-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0)11.1 데이터와 목표와 성격에 맞는 커뮤니케이션 적용하기

    -   컨슈머에서 프로바이더까지의 통신은 항상 효율적인 방식으로 이뤄지진 않는다. 그리고 때로는 프로바이더가 주도권을 갖는 편이 더 유용하게 돌아갈 수도 있다.
    -   컨슈머/프로바이더의 통신 방향을 역으로 뒤집은 것은 **웹훅**(webhook)을 통해 할 수 있으며, 이는 종종 리버스 API 라고도 불린다.
    -   웹훅 API 를 디자인할 때도 프로바이더의 관점을 지양해야 하며, 사용 가능하고 발전 가능하게 디자인해야 한다.
    -   이벤트 흐름 스트리밍하기
        -   **SSE**(Server Sent Event) : 서버의 데이터를 실시간으로, 지속적으로 Streaming 하는 기술이다. SSE 는 웹 표준으로써 IE를 제외한 모든 브라우저에서 지원되며, IE 역시 polyfill 을 통해 지원이 가능하다.
        -   컨슈머는 콘텐트 타입을 **text/event-stream** 으로 보낸다.
        -   반환된 데이터는 정적이지도 않으며 아직 종결된 상태도 아니며 스트림 형태로 제공된다.
        -   SSE 는 HTTP 프로토콜에 의존하기 때문에 별도의 인프라 구성이 필요하지 않다.
        -   **SSE 를 사용하면 기본적으로 HTTP 연결이 오랜 시간 동안 열려 있을 수 있으므로, API 를 호스팅하는 인프라에서는 이러한 긴 병렬연결을 유지하고 성능 이슈가 없도록 튜닝이 필요하다.**
        -   SSE 는 서버에서 컨슈머로 향하는 단방향 통신만 제공하지만 WebSocket 은 단방향, 양방향 모두를 지원한다.
    -   multi request 를 하는 경우 응답 처리
        -   **207 Multi-Status** 리스폰스를 사용한다.
        -   207 Multi Status 리스폰스는 items 속성이 있는 오브젝트로, 리퀘스트에 포함된 요소의 개수와 동일한 개수의 요소를 반환한다.
        -   multi request 에 대한 각각의 status 를 담아서 내려주도록 하자.
        -   비즈니스 로직에 따라서는 처리 가능한 일부만 처리하는 것은 문제가 될 수도 있다. 만약 부분 처리 방식이 합당하지 않은 경우라면, API 는 성공시 전통적인 200 OK 와 실패의 경우엔 400 Bad Request 를 반활 할 수 있다.
        -   API 는 단일 리소스만 처리해야 한다는 법은 없다. 경우에 따라 한 번의 호출로 여러 리소스를 처리하는 것이 유용한 컨텍스트가 있다. 적절히 잘 사용하도록 하자.
    -   민감한 정보는 쿼리 파라미터로 취급해서는 안된다. 어딘가에 로그라도 남으면 안되니깐!

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/11-%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8%EC%97%90%20%EB%A7%9E%EB%8A%94%20API%20%EB%94%94%EC%9E%90%EC%9D%B8%ED%95%98%EA%B8%B0.md#112-%EC%BB%A8%ED%85%8D%EC%8A%A4%ED%8A%B8%EC%97%90-%EB%A7%9E%EB%8A%94-api-%EC%8A%A4%ED%83%80%EC%9D%BC-%EC%84%A0%ED%83%9D%ED%95%98%EA%B8%B0)11.2 컨텍스트에 맞는 API 스타일 선택하기

    -   REST 는 리소스 기반이며, gRPC 는 함수 기반이며, GraphQL 은 데이터 기반이며, 이것들은 저마다 장단점을 지니고 있다.
        -   gRPC(google Remote Procedure Call)
            -   단순하게 함수를 외부에 노출하는 방식이다. 예) 소유자 123의 정보를 읽어오는 것은 readOwner(123) 함수를 호출한다.
            -   gRPC 프레임워크는 HTTP 1.1 이나 2 프로토콜에 별도의 변경 없이 전송계층으로 사용한다.
            -   gRPC 는 표준 캐싱 메커니즘을 제공하지 않는다.
            -   프로토콜 버퍼 데이터 포맷을 사용 할 수 있어서 XML 이나 JSON 과 다르게 장황하지 않다.
            -   사용을 고려할 때
                -   내부 애플리케이션에서 또 다른 내부 애플리케이션의 통신으로 속도가 정말 중요한 경우
                -   캐싱에 관심이 없거나, HTTP 에 의존하지 않고 모든 것을 처리할 의사가 있는 경우
                -   API 를 외부에 공개하거나 파트너와 공유할 계획이 없는 경우
        -   GraphQL
            -   Facebook 에서 만든 API 용 쿼리 언어
            -   기본적으로 데이터 스키마에 접근하여 컨슈머가 정확히 필요한 데이터를 가져갈 수 있게 재공해주는 것이다.
            -   프로토콜에 구애받지 않고, 리퀘스트를 보내고 리스폰스를 받을 수 있다면 어떠한 프로토콜이건 다 사용할 수 있다.
            -   사용을 고려할 때
                -   고급 쿼리 기능이 필요한 경우
                -   API 를 외부에 공개하거나 파트너들과 공유할 계획이 전혀 없는 경우
                -   캐싱이 필요하지 않은 경우
                -   기저의 시스템들이 구현 수준에서 잘 보호 받고 있거나 무한대의 확장성을 보장받을 경우


### 12. API 문서화하기

-   참조 문서
-   사용자 가이드
-   구현 명세
-   변경이력

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/12-API%20%EB%AC%B8%EC%84%9C%ED%99%94%ED%95%98%EA%B8%B0.md#121-%EC%B0%B8%EC%A1%B0-%EB%AC%B8%EC%84%9C-%EB%A7%8C%EB%93%A4%EA%B8%B0)12.1 참조 문서 만들기

    -   **ReDoc**: OpenAPI 사양 파일을 기반 참조 문서를 생성하는 데 사용되는 도구
        -   redoc-cli([https://github.com/Rebilly/ReDoc/tree/master/cli](https://github.com/Rebilly/ReDoc/tree/master/cli))
        -   redoc-cli serve <OpenAPI 파일 경로> --options.showExtensions
        -   독립형 HTML 문서로 만들기 : redoc-cli bundle <OpenAPI 파일 경로> --options.showExtensions
    -   참조 문서는 단순히 최소 정보만 제공해서는 안된다. 참조 문서는 기술적, 기능적으로 유용한 설명과 예제를 제공해야 한다.
    -   사람이 읽을 수 있는 설명에는 속성의 역할과 다른 속성들과의 관계, 속성의 사용 시기 등 속성의 성격이 설명되어 있다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/12-API%20%EB%AC%B8%EC%84%9C%ED%99%94%ED%95%98%EA%B8%B0.md#122-%EC%82%AC%EC%9A%A9%EC%9E%90-%EC%95%88%EB%82%B4%EC%84%9C-%EC%9E%91%EC%84%B1%ED%95%98%EA%B8%B0)12.2 사용자 안내서 작성하기

    -   유즈케이스 문서화 하기

        -   PlantUML([http://plantuml.com](http://plantuml.com/))
        -   openAPI 명세파일에 마크 다운 형태로 작성하기

        ```
        [...]
        info:
            title: Banking API
            version: "1.0.0"
            description: |
                Banking API 는 계좌 정보 조회와 받는 계좌 정보, 송금 관리 등의 기능이 가능합니다.
                # 사용예시 
                ## 특정계좌 혹은 기존에 보냈던 계좌로 금액 송금하기
                _송금하기_기능은 이용자가...
                
                ![그림](http://developer.bain....)
        
                ## 예약 송금, 자동 송금 취소하기
                - 송금 목록 조회
                - 송금 취소하기
        [...]
        ```

    -   표준 OpenAPI 명세 파서는 x- 로 시작하는 모든 속성들은 모두 무시한다.

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/12-API%20%EB%AC%B8%EC%84%9C%ED%99%94%ED%95%98%EA%B8%B0.md#123-%EB%AC%B8%EC%84%9C%EC%9D%98-%EA%B0%9C%EC%A0%95%EA%B3%BC-%ED%8F%90%EA%B8%B0)12.3 문서의 개정과 폐기

    -   OpenAPI 명세에 따르면, **deprecated** 플래그는 데이터 모델의 파라미터, 목표, 속성에 사용할 수 있다. 여기서는 더 이상 사용되지 않는 요소에 대한 설명은 대신 사용할 수 있는 항목을 나타낸다.

### 13. 성장하는 API

-   API 생명주기
-   API 디자인 지침

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/13-%EC%84%B1%EC%9E%A5%ED%95%98%EB%8A%94%20API.md#131-api-%EC%83%9D%EB%AA%85%EC%A3%BC%EA%B8%B0)13.1 API 생명주기

    -   분석 단계: API 의 목표, 요구사항을 충족하는 데 필요한 것, 컨슈머가 해결하려는 것, 실제 사용자에 대한 정보, 그리고 API 가 제공하는 이점과 같은 주제를 탐색한다.
    -   디자인 단계: 분석 단계에세 심층적으로 조사했던 내용을 프로그래밍 인터페이스 컨트랙트로 변경한다.
    -   구현 단계: 인터페이스 컨트랙트의 구현이 애플리케이션을 통해 외부로 공개된다.
    -   발행 단계: 새로운 발견, 새로운 질문에 따라 분석, 디자인, 구현을 반복하면서 실제로 대상 컨슈머들이 API 를 사용 할 수 있게 되는 단 계

    #### [](https://github.com/bingbingpa/dev-book/blob/b468d1886123991b8212ce513ec10c31acefbb24/web-api-design/13-%EC%84%B1%EC%9E%A5%ED%95%98%EB%8A%94%20API.md#132-api-%EB%94%94%EC%9E%90%EC%9D%B8-%EC%A7%80%EC%B9%A8-%EB%A7%8C%EB%93%A4%EA%B8%B0)13.2 API 디자인 지침 만들기

    -   참조 지침
        -   API 디자인에서 일관성을 유지하려면 API 를 디자인할 때 적용할 원칙과 규칙을 정의해야 한다. 참조 지침은 작성해야 하는 최소한의 API 디자인 지침이다.
        -   참조 지침인 이러한 모든 원칙과 규칙들을 열거하고 설명하는 문서이다.
    -   유스케이스 지침 : 바로 사용 가능한 **레시피** 또는 솔루션을 제공해야 한다.
    -   지속적으로 지침 만들기
        -   API 디자인 지침을 작성할 때 한 번에 모든 가능성과 모든 엣지 케이스를 다루는 최고의 지침을 만들려고 하지 말자. 대신 기본 필수 주제를 간단하고 직관적으로 다루는 것으로 시작하라.
        -   완전성과 정확성을 목표로 하라.
    -   API 스타일북: API 스타일 참조 사이트([http://apistylebook.com](http://apistylebook.com/))
