# 백엔드 개발에 필요한 지식!

- 웹 생태계의 스펙   
  HTML, HTTP(1.1 , HTTP/2)   
- 기본 SDK, 라이브러리/프레임워크 이해와 활용   
- 클라이언트를 위한 API 설계   
- 서버/컴퍼넌트/객체 간의 역할 분담/의존성/통신 방법 설계   
- 저장소 활용   
  - DBMS 설계   
  - Cache 적용   
      - Global/Local cache 적용범위, 라이프 싸이클, 솔루션 선택   
  - 파일 저장 정책/솔루션 선택 활용   
- 검색엔진 연동 방식 결정   
- 빌드 도구   
  - Maven/Gradle   
- 배포 전략      
- 성능 테스트/프로파일링/튜닝   
  - JVM 레벨의 튜닝 (GC 옵션 등)   
    - 웹 서버(Nginx,Tomcat)등의 설정/튜닝   
  - OS 설정의 주요 값 확인   
- 인접 기술에 대한 이해   
  - DBMS, Front End 등   
- 서버 개발자에만 해당하지는 않는 항목   
  - 테스트 코드 작성/리팩토링 기법   
    - 버전 관리 전략   
    - branch 정책 등   

## 개발자의 수준
- 레벨0: 이미 쓰고 있는 개발도구의 사용법을 알려주거나 가이드 문서를 줘도 잘 못 씀
- 레벨1: 알려주거나 같은 팀에서 만든 가이드 문서에 있는 만큼만 쓸 수 있음
- 레벨2
  - 개발도구의 공식 레퍼런스를 보고 사용법을 스스로 익힐 수 있음
  - 자신이 경험한 사용법을 문서화해서 팀 내에 전파할 수 있음
- 레벨3
  - 여러 개발도구를 비교 분석해서 상황에 적합한 도구를 선택할 수 있음
  - 공식 레퍼런스 문서에서 부족한 부분을 수정해서 기여할 수 있음
- 레벨4
  - 개발도구의 문제를 소스 코드를 수정해서 Fork/패치해서 사용할 수 있음

## 테스트
- 협업 및 지속적인 개선 목적인 경우 테스트 코드가 더욱 중요
    - 유지보수 기간의 생산성을 높여주고 새로 프로젝트에 투입될 사람에게도 이득을 주는 테스트
    - 프로젝트 오픈 일정 직전까지의 코드 변경과 버그 발견에 도움을 주는 테스트
    - 오늘 당장 프로그램을 목표한 곳까지 작성하는 일을 더 빨리 마치게 해주는 테스트

## 자료구조/알고리즘
## 개발 프레임워크
- 백엔드 개발 프레임워크의 트렌드

## 용어의 범위
- 용어의 정의가 명확하지 않다면 갈등 생기기 쉬움
- 정확히 용어의 정희 파악하기!

## 개발,배포 방식
실무에서 어떻게 협업을 하고 개발, 배포를 하나요? 개발팀이나 프로젝트의 성격에 따라서 일하는 방식은 다양합니다. 제가 참여하는 프로젝트 중 하나의 예를 들면 아래와 같습니다.

- 주 1회 배포
  - 월요일 쯤에 회의로 이번 주 배포 범위를 확정. 목/금요일에 주로 배포
  - 치명적인 버그에 대한 Hot fix는 주1회 주기에 상관없이 배포
  - 최대한 무정지 배포
- 버전 관리/ 코드 리뷰
  - master에서 추가할 기능별로 feature branch(topic branch)를 따고 주로 master를 목표로 PR(pull request) 요청
  - Github의 마일스톤으로 버전을 입력하고 PR마다 매핑
  - 한번에 반영하기 힘든 기능이나 큰 단계의 버전업은 별도의 feature branch로 merge하기도 함
  - 리뷰를 충분히 받았는지는 PR을 올린 사람이 판단하여 merge
  - 배포일이 다가오는데 기능 오류가 없는 것으로 검증된 branch는 일단 merge후 사후 리뷰를 하기도 함
- DB 스키마 관리
  - 개발환경에서는 Liquibase 로 관리
  - 운영환경에는 Liquibase에서 생성된 SQL을 사내 스키마 관리 시스템을 통해서 요청
- 테스트
  - PR를 올리면 CI서버에서 빌드 실행. API 서버의 테스트 코드와 FE코드에 검사도구인 Eslint의 검증을 통과해야 merge 가능
  - 현재는 서버 모듈만 테스트 코드 작성
    - 통합 테스트: JUnit + Rest assured + (Spring MVC Test framework 또는 Embeded Tomat 활용) 이용
    - 단위 테스트: JUnit + Mockito 활용
    - 특별히 의식하지는 않았는데 Line coverage 는 74% 정도
- Docker를 이용한 테스트 환경 활용
  - 마크업 등 UI변경을 확인해야 하는 경우는 PR에 'Docker build'라는 라벨을 붙임
  - 그러면 docker 이미지가 만들어져서 사내 docker 이미지 배포용 cluster에 해당 branch를 확인할 수 있도록 배포가 됨
  - docker로 배포된 서버에서 어느 정도 테스트 후 merge
- 주1회 배포전 QA시간을 따로 잡고 개발팀 전체가 함께 테스트. (전담 QA가 없는 프로젝트인 경우)
- 테스트 시나리오는 그 주 변경된 기능과 영향받는 기능 위주로 작성
- 큰 기능 추가, 전체적인 코드 변경 시점에는
  - 스테이징 서버에서 1~2주 정도 개발팀이 미리 운영 데이터로 시스템을 써보기도 함
    - 전체 기능에 대한 테스트 시나리오를 다 수행해보기도 함

참조: <https://d2.naver.com/news/3435170>

## [쿼리작성팁](https://github.com/jihodaddy/spring_boot_mini_project/blob/609b9c9f1da2e0449c24870be5784089f8ff0089/sql_tip.md)
## [JPA 정리](https://github.com/jihodaddy/backend_skill/blob/cab0755015b42a994466a5d1e36c8f1e97b112d5/jpa.md)
## [UTIL 소스 참고](https://github.com/joonolee/framework2/tree/master/framework2/src/framework/util)
