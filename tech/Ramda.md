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

| 종류         | 설명                      |
| ------------ | ------------------------- |
| Stream < T > | 범용 Stream               |
| IntStream    | 값 타입이 Int인 Stream    |
| LongStream   | 값 타입이 Long인 Stream   |
| oubleStream  | 값 타입이 Double인 Stream |

### Stream의 중간 연산 명령어

| 종류                                                            | 설명                                                 |
| --------------------------------------------------------------- | ---------------------------------------------------- |
| Stream < T > distinct()                                         | Stream의 요소 중복 제거                              |
| Stream < T > sorted()                                           | Stream 요소 정렬                                     |
| Stream < T > filter(Predicate < T > predicate)                  | 조건에 충족하는 요소를 Stream으로 생성               |
| Stream < T > limit(long maxSize)                                | maxSize 까지의 요소를 Stream으로 생성                |
| Stream < T > skip(ling n)                                       | 처음 n개의 요소를 제외하는 stream 생성               |
| Stream < T > peek(Consumer< T > action)                         | T타입 요소에 맞는 작업 수행                          |
| Stream < R > flatMap(Function< T, stream<? extends R>> Tmapper) | T타입 요소를 1:N의 R타입 요소로 변환하여 스트림 생성 |
| Stream < R > map(Function<? super T, ? extends R> mapper)       | 입력 T타입을 R타입 요소로 변환한 스트림 생성         |
| Stream mapToInt(),mapToLong(),mapToDobule()                     | 만약 map Type이 숫자가 아닌 경우 변환하여 사용       |

### Stream의 최종 연산 명령어

| 종류                                                   | 설명                                                |
| ------------------------------------------------------ | --------------------------------------------------- |
| void forEach(Consumer <? super T> action)              | Stream 의 각 요소에 지정된 작업 수행                |
| long count()                                           | Stream 의 요소 개수                                 |
| Optional < T > sum (Comparator <? super T> comparator) | Stream 의 요소 합                                   |
| Optional < T > max (Comparator <? super T> comparator) | Stream 요소의 최대 값                               |
| Optional < T > min (Comparator <? super T> comparator) | Stream 요소의 최소 값                               |
| Optional < T > findAny()                               | Stream 요소의 랜덤 요소                             |
| Optional < T > findFirst()                             | Stream 의 첫 번째 요소                              |
| boolean allMatch(Pradicate < T > p)                    | Stream 의 값이 모두 만족하는지 boolean 반환         |
| boolean anyMatch(Pradicate < T > p)                    | Stream 의 값이 하나라도 만족하는지 boolean 반환     |
| boolean noneMatch(Pradicate < T > p)                   | Stream 의 값이 하나라도 만족하지않는지 boolean 반환 |
| Object[] toArray()                                     | Stream 의 모든 요소를 배열로 반환                   |

### collector 연산

Stream의 요소를 수집하여 요소를 그룹화 하거나 결과를 담아 반환하는데 사용한다.

- Collectors.toList()
- Collectors.toSet()
- Collectors.toMap()
- Collectors.groupingBy
- Collectors.partioningBy
- Collectors.summarizingInt()

```java
//Stream API를 이용한 간단한 짝수 판별
IntStream.range(1, 11 ).filter(i-> i%2==0)
     .forEach(System.out::println);
```

```
2
4
6
8
10
```

예제

```java
// 0~1000까지의 값 중 500이상이며 짝수이면서 5의 배수인 수의 합을 구하라
System.out.println(
      IntStream.range(0, 1001)
            .skip(500)
            .filter(i-> i%2==0)
            .filter(i-> i%5==0)
            .sum()
);
```

```
실행 결과
38250
```
