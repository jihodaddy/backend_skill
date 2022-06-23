# Sync 와 Ansync 차이 (Sync, Ansync, Blocking, Non-blocking)

동기(synchorunous)

- 요청을 보낸후 응답을 받아야하지만 다음 동작이 이루어지는 방식
- 모든 일이 순차적으로 실행됌

비동기(asynchrounous)

- 요청을 즉시 처리하지 않아도 그 대기 시간동안 또 다른 동작이 이루어지는 방식
- 모든 일이 병렬적으로 실행

블로킹 Blocking

- A 함수가 B 함수를 호출 할 때, B 함수가 자신의 작업이 종료되기 전까지 A 함수에게 제어권을 돌려주지 않는 것
  논블로킹 Non-blocking
- A 함수가 B 함수를 호출 할 때, B 함수가 제어권을 바로 A 함수에게 넘겨주면서, A 함수가 다른 일을 할 수 있도록 하는 것.
  동기 Synchronous
- A 함수가 B 함수를 호출 할 때, B 함수의 결과를 A 함수가 처리하는 것.
  비동기 Asynchronous
- A 함수가 B 함수를 호출 할 때, B 함수의 결과를 B 함수가 처리하는 것. (callback)
