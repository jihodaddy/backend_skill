# msa 이론
  ## 모노리틱 아키텍처(Monolithic Architecture)
  - 기존의 전통적인 시스템을 모노리틱 아키텍처(Monolithic Architecture)라함
  - 서버 측 애플리케이션이 단일체로 작은 변화에도 새로운 버전으로 전체를 빌드해서 배포해야 함
  - 여러개의 모노리스가 수평으로 확장된 상태에서는 시스템 모두를 다시 빌드하고 배포 과정이 필요
  - 또한 데이터베이스는 통합되어 하나이므로 탄력 대응이 힘들고 사전에 성능을 감당하기 위한 스케일 업 과정이 필요
  ## 마이크로 서비스(Microservice) 
  - 서버 측이 여러개의 조각으로 구성되어 있어 별개의 인스턴스로 로딩
  - 또한 각기 저장소가 다르므로 업무 단위로 모듈 경계가 명확하게 구분됨
  - 확장시 특정 기능별로 확장할 수 있고 변경시 해당 서비스만 다시 빌드하고 배포하면 됨, 여러 언어로 개발도 가능
  ## SOA(Service Oriented Architecture) 
  - 소프트웨어 공학에서 말하는 모듈화 개념의 발전 흐름
    - 단순히 기능을 하향시 분해해서 설계해 나가는 **구조적(Structured) 방법론**
    - 객체 단위로 모듈화하기 위한 **객체지향(Object-Oriented)방법론**
    - 모듈화의 단위가 기능별로 재사용할 수 있는 좀 더 큰 컴포넌트가 되는 **CBD(Component Based Development)**
    - 컴포넌트를 모아 비즈니스적으로 의미 있고 완결적인 서비스 단위로 모듈화하는 **SOA(Service Oriented Achitecture)**


  - DDD( Domain-Driven Design ) 도메인 주도 설계
  - 연관 객체의 묶음을 **AGGREGATE**
  - Aggregates에 포함된 특정 Entity를 **Root Entity**라 함
  - 그리고 Repository를 만들때 Aggregate의 Root Entity에 대해서만 Repository를 제공하라 함

# DDD의 주요 설계 원칙
  - Loose Coupling(느슨한 결합)과 High Cohesion(높은 응집)
  - 도메인들 간에 느슨한 결합, 도메인 내에서는 높은 응집해야 함.
  - 도메인은 전체 서비스를 잘라낸 단위, 잘못 나누면 많은 혼란이 가중됨.
 
 # MSA 설계 원칙
  ## Strong Module Boundaries(명확한 모듈 경계)
    - MSA구조에서 마이크로 서비스의 가장 큰 장점은 모듈 경계가 명확
    - 시스템 변경 사항이 발생하면 변경할 특정 도메인 내 마이크로 서비스 단위만 이해하고 처리해도 가능
    - 제대로 된 경께를 가지지 못한다면 MSA로 인한 마이크로서비스로의 분리는 장점이 아닌 핸디캡이 될 수 있음
  ## Independent Deployment(독립적 배포)
    - MSA는 Loose Coupling이나 High Cohesion와 같은 의존성 관계를 고려하여 시스템을 설계, 구축
    - 각각의 마이크로서비스를 독립적으로 배포하기가 용이함
  ## Technology Diversity(기술 다양성)
    - 각각의 마이크로서비스의 독립서이 강화되면서, 마이크로서비스 내의 기술선택이 자유로워짐
    - 다만 너무 다양한 기술의 도입은 복잡성, 비효율 증가될 수 있음
  

  

