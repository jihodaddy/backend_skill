# JPA 복합키

### @OneToMany(cascade = {CascadeType.ALL}, fetch = FetchType.EAGER, orphanRemoval = true)
  - 자식 Entity의 변경이 있을 경우
  - JPA에서 변경된 자식을 먼저 INSERT하고 기존 자식을 NULL로 UPDATE
  - orphanRemoval 옵션을 true로 하면 기존 NULL처리된 자식을 DELETE한다.
  - PK(JoinColumn)값이 NULL로 변한 자식은 고아객체라 하여 연결점이 없는 객체
  - orphanRemoval가 고아 객체 삭제 역활

### insertable : SQL INSERT문에 해당 컬럼을 포함할지 여부
### updatable : SQL UPDATE문에 해당 컬럼을 포함할지 여부
  - insertable = false, updatable = false 인경우, 읽기 전용 필드라고 볼수있다.

 
