# 람다 - java

람다 함수는 프로그래밍 언어에서 사용되는 개념으로 익명 함수(Anonymous functions)를 지칭하는 용어입니다.

현재 사용되고 있는 람다의 근간은 수학과 기초 컴퓨터과학 분야에서의 람다 대수이다. 람다 대수는 간단히 말하자면 수학에서 사용하는 함수를 보다 단순하게 표현하는 방법입니다.

## 람다의 장단점

### 장점

1. 코드의 간결성 - 람다를 사용하면 불필요한 반복문의 삭제가 가능하며 복잡한 식을 단순하게 표현할 수 있습니다.
2. 지연연산 수행 - 람다는 지연연상을 수행 함으로써 불필요한 연산을 최소화 할 수 있습니다.
3. 병렬처리 가능 - 멀티쓰레디를 활용하여 병렬처리를 사용 할 수 있습니다.

### 단점

1. 람다식의 호출이 까다롭습니다
2. 람다 stream 사용 시 단순 for문 혹은 while문 사용 시 성능이 떨어집니다.
3. 불필요하게 너무 사용하게 되면 오히려 가독성을 떨어 뜨릴 수 있습니다.

## 람다의 표현식

1. 람다는 매개변수 화살표(->) 함수몸체로 이용하여 사용 할 수 있습니다.
2. 함수몸체가 단일 실행문이면 괄호{}를 생략 할 수 있습니다.
3. 함수몸체가 return문으로만 구성되어 있는 경우 괄호{}를 생략 할 수 없습니다.

```java
//정상적인 유형
() -> {}
() -> 1
() -> { return 1; }

(int x) -> x+1
(x) -> x+1
x -> x+1
(int x) -> { return x+1; }
x -> { return x+1; }

(int x, int y) -> x+y
(x, y) -> x+y
(x, y) -> { return x+y; }

(String lam) -> lam.length()
lam -> lam.length()
(Thread lamT) -> { lamT.start(); }
lamT -> { lamT.start(); }


//잘못된 유형 선언된 type과 선언되지 않은 type을 같이 사용 할 수 없다.
(x, int y) -> x+y
(x, final y) -> x+y
```

## Stream API

다양한 데이터를 표준화된 방법으로 다루기 위한 라이브러리

```java
example.stream().filter(x -> x<2).count
```

stream() <- 스트림생성
filter < - 중간 연산 (스트림 변환) - 연속에서 수행 가능합니다.
count <- 최종 연산 (스트림 사용) - 마지막에 단 한 번만 사용 가능합니다.

### Stream의 특징

Stream은 데이터를 변경하지 않습니다.
Stream은 1회용 입니다.
Stream은 지연 연산을 수행합니다
Stream은 병렬 실행이 가능합니다

### Stream 의 종류

Stream의 종류

| Stream <T> | 범용 Stream |

| IntStream | 값 타입이 Int인 Stream |
| LongStream | 값 타입이 Long인 Stream |
| oubleStream | 값 타입이 Double인 Stream |
