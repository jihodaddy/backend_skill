# msa 이론
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
  
 ### 예시
  - 주문 도메인
    - Order는 하나의 배송지(shippingAddress)와 
    - 하나 이상의 품목(LineItem)을 가지며
    - 하나 이상의 주문결제(OrderPayment)를 가짐
      - OrderPayment는 추상 클래스로 모바일결제(MobilePayment)와 (신용카드)CreditPayment상속
  

