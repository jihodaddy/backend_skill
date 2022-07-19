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

### 예제

예제에서 사용하는 Person 클래스는 아래와 같이 미리 작성되있음을 가정

```java
class Person {
    private String name;
    private int age;
    private String phoneNumber;

    public Person(String name, int age, String phoneNumber) {
        this.name = name;
        this.age = age;
        this.phoneNumber = phoneNumber;
    }

    // getter, setter 생략
}
```

# 생성

## 컬렉션(Collection)으로 생성

```java
//of 메서드는 자바9부터 지원
List<String> list = List.of("mad","play");
Stream<String> stream = list.stream();
```

## 배열(Array)로 생성

`Array.stream`메서드를 사용하여 배열로 스트림 생성

```java
String[] arr = new String[]{"mad","play"};
Stream<String> stream = Arrays.stream(arr);

//0번 인덱스만 선택(closed range)
Stream<String> specificStream = Arrays.stream(arr, 0, 1);

// "mad" 출력
specificStream.forEach(System.out::println);
```

## 병렬 스트림 생성

`steam`메서드 대신에 `parallelStream`메서드를 호출하면 병렬 스트림 생성

```java
List<String> list = List.of("mad", "play", "...");
Stream<String> stream = list.parallelStream();
```

## 기본 타입에 특화된 스트림 생성

```java
// 0, 1, 2
IntStream intStream = IntStream.range(0, 3);

// 0, 1, 2, 3
IntStream closedIntStream = IntStream.rangeClosed(0, 3);

// 0, 1, 2
LongStream longStream = LongStream.range(0, 3);

// 0.0, 0.3
DoubleStream doubleStream = DoubleStream.of(0, 3);
```

난수와 같이 랜덤하게 스트림을 생성할 수 있음. 다만 무한대로 생성되므로 `limit`와 같은
제한 메서들르 사용하여 무한으로 생성되지 않도록 해야함

```java
// 난수로 스트림 생성, 3개 제한
IntStream intStream = new Random().ints().limit(3);

// 난수로 스트림 생성, 3개 제한
DoubleStream doubles = new Random().doubles(3);
```

## 파일(Files)로 생성

`java.nio.Files`클래스를 이용하여 스트림 생성

```java
Path path = Paths.get("~");
Stream<Path> list = Files.list(path);

Path filePath = Paths.get("~.txt");
Stream<String> lines = Files.lines(path);
```

## BufferedReader의 lines()로 생성

`java.io.BufferedReader`클래스의 `lines`메서드로 문자열 스트림 생성

```java
// try-catch-resources
try (BufferedReader br = new BufferedReader(new FileReader("test.txt"))) {
    Stream<String> stream = br.lines();
    // do something
} catch (Exception e) {
    // exception handling
}
```

## Pattern으로 스트림 생성

```java
Stream<String> stream = Pattern.compile(",")
    .splitAsStream("mad,play");
stream.forEach(System.out::println);
// mad
// play
```

## Stream.builder()로 생성

```java
// 참고) Stream.builder 메서드 명세
// public static<T> Builder<T> builder() {
//     return new Streams.StreamBuilderImpl<>();
// }

Stream<String> stream = Stream.<String>builder()
    .add("mad").add("play").build();
```

## Stream.iterate() 로 생성

```java
// 0, 1, 2
Stream<Integer> stream = Stream.iterate(0, x -> x + 1).limit(3);
```

## Stream.generate() 로 생성

```java
// 1, 1, 1
Stream<Integer> stream = Stream.generate(() -> 1).limit(3);

// 난수 3개 저장
Stream<Double> randomStream = Stream.generate(Math::random).limit(3);
```

## Stream.concat() 으로 스트림을 연결하여 생성

```java
List<String> list1 = List.of("mad", "play");
List<String> list2 = List.of("mad", "life");
Stream<String> stream = Stream.concat(list1.stream(), list2.stream());
// mad, play, mad, life
```

## 비어있는 스트림 생성

```java
// 빈 스트림 생성
Stream<Object> empty = Stream.empty();
```

# 중간 연산자를

예제코드

```java
List<String> list = List.of("a", "ab", "abc", "abcd");

List<String> result = list.stream()
        .filter(x -> { // 중간 연산 1
            System.out.println(x + " in filter method");
            return x.length() >= 1;
        }).map(x -> { // 중간 연산 2
            System.out.println(x + " in map method");
            return x.toUpperCase();
        }).limit(2) // 중간 연산 3
        .collect(Collectors.toList()); // 나중에 살펴볼 단말 연산

System.out.println(result);
// a in filter method
// a in map method
// ab in filter method
// ab in map method
// [A, AB]
```

## filter 메서드로 필터링

```java
List<String> list = List.of("kim", "taeng");
list.stream().filter(s -> s.length() == 5);
// "taeng"

// without lambda expression
list.stream().filter(new Predicate<String>() {
    @Override
    public boolean test(String s) {
        return s.length() == 5;
    }
});
```

## map메서드로 특정 형태로 변환

```java
List<String> list = List.of("mad", "play");
list.stream().map(s -> s.toLowerCase());
// "MAD", "PLAY"

// without lambda expression
list.stream().map(new Function<String, String>() {
    @Override
    public String apply(String s) {
        return s.toLowerCase();
    }
});
```

## 기본 타입에 특화된 스트림으로 변환

박싱(Boxing) 비용을 피할 수 있도록 기본 데이터 타입에 특화된 스트림으로 변환할 수 있습니다.
`mapToInt, mapToLong, mapToDouble` 메서드를 사용하면 각각 `IntStream, LongStream, DoubleStream` 으로 변환할 수 있습니다.

```java
// IntStream 예
List<String> list = List.of("0", "1");
IntStream intStream = list.stream()
        .mapToInt(value -> Integer.parseInt(value));
intStream.forEach(System.out::println);
// 숫자 0, 1 출력

// without lambda expression
list.stream().mapToInt(new ToIntFunction<String>() {
    @Override
    public int applyAsInt(String value) {
        return Integer.parseInt(value);
    }
});
```

## flatmap 메서드로 단일 스트림 변환

flatmap 메서드는 중첩된 구조를 한 단계 없애고 단일 원소 스트림으로 만들어줍니다.

```java
List<String> list1 = List.of("mad", "play");
List<String> list2 = List.of("kim", "taeng");
List<List<String>> combinedList = List.of(list1, list2);

List<String> streamByList = combinedList.stream()
        .flatMap(list -> list.stream())
        .collect(Collectors.toList());

// mad, play, kim, taeng
System.out.println(streamByList);

// 2차원 배열
String[][] arrs = new String[][]{
        {"mad", "play"}, {"kim", "taeng"}
};

List<String> streamByArr = Arrays.stream(arrs)
        .flatMap(arr -> Arrays.stream(arr))
        .collect(Collectors.toList());

// mad, play, kim, taeng
System.out.println(streamByArr);
```

## distinct 메서드로 중복 제거

distinct 메서드는 스트림 내의 요소의 중복을 제거합니다. 기본형 타입의 경우 값(value)으로 비교하지만 객체의 경우 Object.equals 메서드로 비교합니다.

```java
// 예시를 위한 클래스 정의
class Foo {
    private String bar;
    public Foo(String bar) {
        this.bar = bar;
    }

    public String toString() {
        return "bar: " + bar;
    }
}

public void someMethod() {
    IntStream stream = Arrays.stream(
            new int[]{1, 2, 2, 3, 3});

    // 1, 2, 3
    stream.distinct()
            .forEach(System.out::println);

    Foo foo1 = new Foo("123");
    Foo foo2 = new Foo("123");
    List<Foo> list = List.of(foo1, foo2, foo1);

    // bar: 123
    // bar: 123
    list.stream().distinct()
        .forEach(System.out::println);
}
```

## sorted 메서드로 정렬하기

sorted 메서드를 이용하여 스트림 내 요소를 정렬할 수 있습니다.

```java
// 1, 2, 3
List.of(1, 2, 3).stream()
    .sorted();

// 3, 2, 1
List.of(1, 2, 3).stream()
    .sorted(Comparator.reverseOrder());
```

다만 IntStream, DoubleStream, LongStream과 같은 기본형 특화 스트림의 경우 sorted 메서드에 인자를 넘길 수 없습니다. 따라서 boxed 메서드를 이용해 객체 스트림으로 변환 후 사용해야 합니다.

```java
// 2, 1, 0
IntStream.range(0, 3)
        .boxed() // boxing
        .sorted(Comparator.reverseOrder());
```

## peek 메서드로 각각의 요소에 연산 수행하기

peek 메서드는 스트림 내의 각각의 요소를 대상으로 특정 연산을 수행하게 합니다. 원본 스트림에서 요소를 소모하지 않기 때문에 중간 연산 사이의 결과를 확인할 때 유용합니다. 주의할 점은 peek 연산은 단말 연산이 수행되지 않으면 실행조차 되지 않습니다.

```java
List<Integer> otherList = new ArrayList<>();
List.of(1, 2, 3).stream()
        .limit(2)
        .peek(i -> {
            // 실제로는 사용하면 안된다.
            otherList.add(i);
        })
        .forEach(System.out::println);

// 1, 2
System.out.println(otherList);

// 단말 연산인 forEach가 없으면 otherList는 비어있다.
```

## limit 메서드로 개수 제한하기

limit 메서드를 사용하면 스트림 내의 요소 개수를 제한할 수 있습니다.

```java
List<String> list = List.of("a", "b", "c").stream()
        .limit(2).collect(Collectors.toList());

// a, b
System.out.println(list);
Java


skip 메서드로 특정 요소 생략하기
skip 메서드를 사용하면 스트림 내의 첫 번째 요소부터 인자로 전달된 개수 만큼의 요소를 제외한 나머지 요소로 구성된 새로운 스트림을 리턴합니다.

List<String> list = Arrays.stream(new String[]{"a", "b", "c"})
        .skip(2).collect(Collectors.toList());

// c
System.out.println(list);
```

## boxed 메서드로 객체 스트림으로 변환하기

`IntStream, LongStream, DoubleStream`과 같은 기본 타입에 특화된 스트림을 일반 스트림으로 변환할 수 있습니다.

```java
IntStream intStream = IntStream.range(0, 3);

// 객체 타입의 일반 스트림으로 변환
Stream<Integer> boxedStream = intStream.boxed();
```

# 스트림 종료 연산

[참조 블로그](https://wakestand.tistory.com/419)
[예제참조](https://madplay.github.io/post/java-streams-examples)
