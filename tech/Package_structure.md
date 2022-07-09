# 패키지 구조

## 종류

### 레이어 우선

```
io.github.jihodaddy.domain.modulename
io.github.jihodaddy.dao.modulename
io.github.jihodaddy.service.modulename
io.github.jihodaddy.web.modulename
```

- 장점
  - 도메인 모델 위주 개발에 적합하다.
  - 각 패키지간의 순환 참조가 발생할 가능성이 적어진다.
  - 중복 코드가 거의 발생하지 않는다.
- 단점
  - 추후 모듈 단위로 분리할 때 어려움이 있다.

### 모듈 우선

```
io.github.jihodaddy.modulename.domain
io.github.jihodaddy.modulename.dao
io.github.jihodaddy.modulename.service
io.github.jihodaddy.modulename.web
```

- 장점
  - 모듈 단위로 분리할 때 유리하다. (주로 모듈 단위로 기능을 이식할 때 유리하다.)
- 단점
  - 각 패키지간 순환 참조가 발생할 가능성이 높다.
  - (패키지 간 거리가 멀어 눈에 잘 보이지 않는다.)
  - 각 모듈에 중복된 코드가 발생할 가능성이 높다.
  - (중복 코드를 최소화 할 경우 순환 참조에 빠질 가능성이 높다.)
  - 도메인 간의 관계보다 각 모듈별로 각자 구현할 가능성이 높다.
  - (순환 참조는 회피할 수 있지만, 중복 코드가 수 없이 발생한다.)
