# JPA - fetch type(로딩 기법)

- 테이블 간 연관 관계는 객체의 참조를 통해 이루어 짐
- 서비스가 커질수록, 참조하는 객체가 많아지고, 그 만큼 데이터의 양이 많아지면 부담이 되는데
- 참조하는 객체들의 데이터를 가져오는 시점을 정할 수 있는데 이것을 Fetch Type이라 함
- 두가지 타입이 있음
  - `EASER (즉시 로딩)` : 엔티티 매니저를 통해 엔티티를 조회하면 연관관계에 매핑되어 있는 엔티티도 함께 조회
  - `LAZY (지연 로딩)` : 연관관계에 있는 엔티티를 가져오지 않고, getter로 접근할 떄 가져옴

### 동작

- FetchType=EASER

  - ManyToOne(연관관계 주인일때)에서의 기본 FetchType은 EASER
  - EASER 일 경루 Join을 통해 모든 쿼리를 한번에 가져옴

- FetchType=LAZY
  - 다대일에서 List를 가져오는 상황에서 N+1 Problem이 발생할 수 있음
  - OneToMany(종일때)의 기본 FetchType은 LAZY

### 동작 시점

- JPA Entity Manager에 의해 관리되는 Persistence Context에 Entity가 Managed 상태로 올라올 떄의 동작
- queryDSL 과 같은 쿼리 빌더를 이용해 아무리 Join 문을 짜도 (Fetch Join을 하지 않는 이상 메인 도메인의 엔티티만 Persistence Context에 올라옴
- 연관 관계에 대한 Fetch도 메인 도메인만 일어남

### N+1 Problem

- ManyToOne, OneToOne 컬럼의 FetchType을 LAZY로 하였을 때
- 해결방법

  - JPQL의 Fetch Join을 이용
  - ManyToOne, OneToOne의 FetchType=LAZY => EASER로 변경
  - `@EntityGraph` 이용해, 한 쿼리에 대해서만 EASER laod를 지정

  ### 참고

  [Join과 Fetchjoin 차이](https://cobbybb.tistory.com/18)
  [Fetch조인과 EntitiyGraph](https://jaime-note.tistory.com/54)
