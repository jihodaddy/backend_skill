# JAVA STREAM

- Stream은 자바 8부터 추가된 기능으로 "컬렉션, 배열등의 저장 요소를 하나씩 참조하며 함수형 인터페이스(람다식)를 적용하며 반복적으로 처리할 수 있도록 해주는 기능"이다
- 불필요한 코딩(for, if 문법)을 걷어낼 수 있고 직관적이기 때문에 가독성이 좋아진다.
- Stream은 주로 Collection, Arrays에서 쓰인다.물론 두 개 뿐만 아니라 I/O resources(ex. File), Generators, Stream ranges, Pattern 등에서도 사용할 수 있다.
- 기본적인 Stream생성

```java
List<String> names = Arrays.asList("jeong", "pro", "jdk", "java");names.stream(); //Collection에서 스트림 생성 
Double[] dArray = {3.1, 3.2, 3.3};Arrays.stream(dArray);//배열로 스트림 생성 
Stream<Integer> str = Stream.of(1,2); // 스트림 직접 생성
```

## 유의점

### 일회성 사용

스트림은 한번 최종연산자를 거쳐서 결과를 도출해 내면 다시 사용할 수 없습니다. 다시 사용하고 싶다면 새로우 스트림을 열어야 합니다.

### 중간 연산자, 최종 연산자

스트림을 사용하는 데 있어서 중간 연산자와 최종 연산자를 유의해야합니다. 두 연산자의 차이는 반환형의 차이입니다.

```java
// filter() 코드
@Override
public final Stream<P_OUT> filter(Predicate<? super P_OUT> predicate) {
    Objects.requireNonNull(predicate);
    return new StatelessOp<P_OUT, P_OUT>(this, StreamShape.REFERENCE,
                                 StreamOpFlag.NOT_SIZED) {
        @Override
        Sink<P_OUT> opWrapSink(int flags, Sink<P_OUT> sink) {
            return new Sink.ChainedReference<P_OUT, P_OUT>(sink) {
                @Override
                public void begin(long size) {
                    downstream.begin(-1);
                }

                @Override
                public void accept(P_OUT u) {
                    if (predicate.test(u))
                        downstream.accept(u);
                }
            };
        }
    };
}
```

위의 중간연산자인 filter()의 반환형은 Stream<T> 형태로 반환하고

```java
@Override
public final long count() {
    return evaluate(ReduceOps.makeRefCounting());
}
```

최종연산자 중 하나인 count()는 long 형태를 반환하고 있습니다. 즉 Stream이 끝난 것입니다.

```java
List<String> strList = lists.stream()
	.filter(...) // 중간연산자
    	.map(...) // 중간연산자
    	.collect(Collectors.toList()); // 최종연산자
```

### Lazy 한 처리

결과가 필요하기 전까진 Chaining된 연산들을 실행하지 않습니다.

### 원본 데이터를 변경하지 않는다

## Stream 구조와 사용법

스트림의 구조는 크게 3가지로 나뉜다.

1. 스트림생성
2. 중개 연산
3. 최종 연산
   사용법: Collections같은 객체 집합.스트림생성().중개연산().최종연산();

[참조 블로그](https://wakestand.tistory.com/419)
