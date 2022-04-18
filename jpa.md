# JPA

## @Entity
  - table과 일대일로 매칭되는 객체 단위
  - 주의사항
    - 기본 생성자 필수
    - final클래스, enum, interface, inner class에는 사용할 수 없음
    - 저장할 필드에 final 사용 불가
## @Table
  - 엔티티와 매핑할 테이블을 지정
  - 생략 시 매핑한 엔티티 이름을 테이블 이름으로 사용
  - 
