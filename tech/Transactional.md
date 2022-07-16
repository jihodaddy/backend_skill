# transactional

## 트랜잭션이란?

데이터베이스의 상태를 변경하는 작업 또는 한번에 수행되어야 하는 연산들을 의미한다.
begin, commit 을 자동으로 수행해준다.
예외 발생 시 rollback 처리를 자동으로 수행해준다.
트랜잭션은 4가지의 성질을 가지고 있다.

- 원자성(Atomicity)
  한 트랜잭션 내에서 실행한 작업들은 하나의 단위로 처리한다. 즉, 모두 성공 또는 모두 실패.
- 일관성(Consistency)
  트랜잭션은 일관성 있는 데이타베이스 상태를 유지한다. (data integrity 만족 등.)
- 격리성(Isolation)
  동시에 실행되는 트랜잭션들이 서로 영향을 미치지 않도록 격리해야한다.
- 영속성(Durability)
  트랜잭션을 성공적으로 마치면 결과가 항상 저장되어야 한다.

## 트랜잭션 처리 방법?

스프링에서는 간단하게 어노테이션 방식으로 @Transactional을 메소드, 클래스, 인터페이스 위에 추가하여 사용하는 방식이 일반적이다. 이 방식을 선언적 트랜잭션이라 부르며, 적용된 범위에서는 트랜잭션 기능이 포함된 프록시 객체가 생성되어 자동으로 commit 혹은 rollback을 진행해준다.

```Java
@Transactional
public void addUser(UserDTO dto) throws Exception {
	// 로직 구현
}
```

## @Transactional 옵션

- `isolation`
  트랜잭션에서 일관성없는 데이터 허용 수준을 설정한다
- `propagation`
  트랜잭션 동작 도중 다른 트랜잭션을 호출할 때, 어떻게 할 것인지 지정하는 옵션이다
- `noRollbackFor`
  특정 예외 발생 시 rollback하지 않는다.
- `rollbackFor`
  특정 예외 발생 시 rollback한다.
- `timeout`
  지정한 시간 내에 메소드 수행이 완료되지 않으면 rollback 한다. (-1일 경우 timeout을 사용하지 않는다)
- `readOnly`
  트랜잭션을 읽기 전용으로 설정한다.

### 1. isolation (격리레벨)

적용방법

```java
@Transactional(isolation=Isolation.DEFAULT)
public void addUser(UserDTO dto) throws Exception {
	// 로직 구현
}
```

- DEFAULT : 기본 격리 수준

  - 기본이며, DB의 lsolation Level을 따른다.

- READ_UNCOMMITED (level 0) : 커밋되지 않는 데이터에 대한 읽기를 허용

  - 어떤 사용자가 A라는 데이터를 B라는 데이터로 변경하는 동안 다른 사용자는 B라는 아직 완료되지 않은(Uncommitted 혹은 Dirty)데이터 B를 읽을 수 있다.
  - Problem1 - `Dirty Read 발생`

- READ_COMMITED (level 1) : 커밋된 데이터에 대해 읽기 허용

  - 어떠한 사용자가 A라는 데이터를 B라는 데이터로 변경하는 동안 다른 사용자는 해당 데이터에 접근할 수 없다.
  - Problem1 - `Dirty Read 방지`

- REPEATEABLE_READ (level 2) : 동일 필드에 대해 다중 접근 시 모두 동일한 결과를 보장

  - 트랜잭션이 완료될 때까지 SELECT 문장이 사용하는 모든 데이터에 shared lock이 걸리므로 다른 사용자는 그 영역에 해당되는 데이터에 대한 수정이 불가능하다.
  - 선행 트랜잭션이 읽은 데이터는 트랜잭션이 종료될 때까지 후행 트랜잭션이 갱신하거나 삭제가 불가능 하기 때문에 같은 데이터를 두 번 쿼리했을 때 일관성 있는 결과를 리턴한다.
  - Problem2 - `Non-Repeatable Read 방지`

- SERIALIZABLE (level 3) : 가장 높은 격리, 성능 저하의 우려가 있음
  - 데이터의 일관성 및 동시성을 위해 MVCC(Multi Version Concurrency Control)을 사용하지 않음.
  - (MVCC는 다중 사용자 데이터베이스 성능을 위한 기술로 데이터 조회 시 LOCK을 사용하지 않고 데이터의 버전을 관리해 데이터의 일관성 및 동시성을 높이는 기술)
  - 트랜잭션이 완료될 때까지 SELECT 문장이 사용하는 모든 데이터에 shared lock이 걸리므로 다른 사용자는 그 영역에 해당되는 데이터에 대한 수정 및 입력이 불가능하다.
  - Problem3 - `Phantom Read 방지`

격리수준에 따른 문제
| IsolationLevel | Dirty Read | Non-Repeatable Read | Phantom Read |
|---|--|---|---|
| Read Uncommitted | O | O | O |
| Read Committed | - | O | O |
| Repeatable Read | - | - | O |
| Serializable| - | - | - |

- Dirty Read

  - 트랜잭션 1이 수정중인 데이터를 트랜잭션 2가 읽을 수 있다. 만약 드랜잭션 1의 작업이 정상 커밋되지 않아 롤백되면, 트랜잭션 2가 읽었던 데이터는 잘못된 데이터가 되는 것이다.
    (데이터 정합성에 어긋남)

- Non-repeatable read

  - 트랜잭션 1이 회원 A를 조회중에 트랜잭션 2가 회원 A의 정보를 수정하고 커밋한다면, 트랜잭션 1이 다시 회원A를 조회했을 때는 수정된 데이터가 조회된다. (이전 정보를 다시 조회할 수 없음). 이처럼 반복해서 같은 데이터를 읽을 수 없는 경우이다.

- Phantom read

  - 트랜잭션 1이 10살 이하의 회원을 조회했는데 트랜잭션 2가 5살 회원을 추가하고 커밋하면 트랜잭션 1이 다시 10살 이하 회원을 조회했을 때 회원 한명이 추가된 상태로 조회된다. 이처럼 반복 조회시 결과집합이 달라지는 경우이다.

- 트랜잭션 격리 수준의 필요성
  - 당연히 레벨이 높아질 수록 데이터 무결성을 유지할 수 있다.
  - 하지만, 무조건적인 상위 레벨을 사용할 시 Locking으로 동시에 수행되는 많은 트랜잭션들이 순차적으로 처리하게 되면서 DB의 성능은 떨어지게 되고 비용이 높아진다.
  - 그렇다고 Locking의 범위를 줄이게 되면 잘못된 값이 처리될 여지도 발생한다.
  - 그러므로 최대한 효율적인 방안을 찾아 상황에 맞게 사용하는 것이 중요하다.

### propagation (전파속성)

적용방법

```java
@Transactional(propagation=Propagation.REQUIRED)
public void addUser(UserDTO dto) throws Exception {
// 로직 구현
}
```

- REQUIRED (Defualt)
  이미 진행중인 트랜잭션이 있다면 해당 트랜잭션 속성을 따르고, 진행중이 아니라면 새로운 트랜잭션을 생성한다.

- REQUIRES_NEW
  항생 새로운 트랜잭션을 생성한다. 이미 진행중인 트랜잭션이 있다면 잠깐 보류하고 해당 트랜잭션 작업을 먼저 진행한다

- SUPPORT
  이미 진행 중인 트랜잭션이 있다면 해당 트랜잭션 속성을 따르고, 없다면 트랜잭션을 설정하지 않는다.

- NOT_SUPPORT
  이미 진행중인 트랜잭션이 있다면 보류하고, 트랜잭션 없이 작업을 수행한다.

- MANDATORY
  이미 진행중인 트랜잭션이 있어야만, 작업을 수행한다. 없다면 Exception을 발생시킨다.

- NEVER
  트랜잭션이 진행중이지 않을 때 작업을 수행한다. 트랜잭션이 있다면 Exception을 발생시킨다.

- NESTED
  진행중인 트랜잭션이 있다면 중첩된 트랜잭션이 실행되며, 존재하지 않으면 REQUIRED와 동일하게 실행된다.

### noRollbackFor (예외무시)

특정예외 발생 시 Rollback 처리 하지 않음.

적용방법

```java
@Transactional(noRollbackFor=Exception.class)
public void addUser(UserDTO dto) throws Exception {
// 로직 구현
}
```

### rollbackFor (예외추가)

특정 예외 발생 시 강제로 Rollback

적용방법

```java
@Transactional(rollbackFor=Exception.class)
public void addUser(UserDTO dto) throws Exception {
// 로직 구현
}
```

### timeout (시간지정)

지정한 시간 내에 해당 메소드 수행이 완료되지 않을 경우 rollback 수행
-1일 경우 no timeout
Default = -1

적용방법

```java
@Transactional(timeout=10)
public void addUser(UserDTO dto) throws Exception {
// 로직 구현
}
```

### readOnly (읽기전용)

true 시 insert, update, delete 실행 시 예외 발생
Default = flase

적용방법

```java
@Transactional(readonly = true)
public void addUser(UserDTO dto) throws Exception {
// 로직 구현
}
```

그래서 왜 (rollbackFor = Exception.class)를 해야해?
@Transactional 은 기본적으로 Unchecked Exception, Error 만을 rollback하고 있다.
그렇기 때문에 모든 예외에 대해서 rollback을 진행하고 싶을 경우
(rollbackFor = Exception.class) 를 붙여야 한다는 것을 깨달았다.
그 이유는 Checked Exception 같은 경우는 예상된 에러이며
Unchecked Exception, Error 같은 경우는 예상치 못한 에러이기 때문이란 것을 알게 되었다.

결론
자바와 스프링, 스프링부트 등 이 쪽을 공부한 지 벌써 5~6개월이 다 되어간다.
하지만 아직 배워야 할 것들이 많고, 내가 쓰고 있는 것들도 무슨 기능인지도 모르고 쓰는 경우가
많다는 걸 깨닫고 하나하나 배워 나아가는 중이다.
앞으로도 열심히 해야겠다.
