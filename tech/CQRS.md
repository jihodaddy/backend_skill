# CQRS 와 이벤트 소싱

- CQRS(Conmmand and Query Responsibility Segregation, 명령과 조회의 책임 분리)

  - CQRS에서 명령은 시스템의 상태를 변경하는 작업을 의미하며 조회는 시스템의 상태를 반환하는 작업을 의미
  - 즉, 시스템의 상태를 변경하는 작업과 시스템의 상태를 반환하는 작업의 책임을 분리하는 것

- QRS를 설명하는 정보들이 표현하는 구현체의 모습이 제각각이고 여기서 혼란이 시작될 가능성이 있습니다.
- CQRS를 설명할 때 명령 처리기 패턴(Command Processor Pattern)을 얘기하기도 하고
- 다른 경우는 다계층 아키텍처(Multitier Architecture)나 이벤트 소싱(Event Sourcing)을 다룹니다.
- 이것들 모두와 DDD(Domain-Driven Design)를 조합하기도 합니다.

- 더 복잡해지거나 (JPA 예)

  - 어떤 로딩(eager, lazy)을 사용할지는 기능에 따라 다름

- 주문을 취소하는 기능
  - Order, OrderLine 만 있으면 되므로 Order를 로딩할때 User를 eager로 로딩할 필요가 없음
- 주문의 목록을 조회하는 기능
  - 사용자 정보를 함께 보여줘야 하므로 User 를 Join 해서 eager로 로딩
    단일 모델을 유지하려고 노력하다 보면 다른 부분에서 복잡한 일이 생기게 됨
