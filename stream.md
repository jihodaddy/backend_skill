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

## 순회(iterate)

forEach 메서드를 사용하여 스트림을 순회할 수 있습니다.

```java
List<Integer> list = List.of(3, 2, 1, 5, 7);
list.stream().forEach(System.out::println);
```

- 다만 forEach 메서드는 병렬 스트림을 사용했을 때 순서를 보장할 수 없습니다.
- 따라서 스트림을 순서대로 순회하고 싶은 경우 forEachOrdered 메서드를 사용해야 합니다.

```java
List<Integer> list = List.of(3,2,1);

//매 실행마다 출력 결과가 동일하지 않다.
list.parallelStream().forEach(System.out::println);

//매 실행마다 동일한 출력 결과
list.parallelStream().forEachOrdered(System.out::println);
```

## 결과 합치기(reduce)

- `reduce`연산을 이용해 모든 스트림 요소를 처리하여 결과를 구할 수 있습니다.
- 이 메서드는 아래의 세 가지 형태로 오버로딩 되어 있습니다.

```java
//형태1
Optional<T> reduce(BinaryOperator<T> accumulator);

//형태2
T reduce(T identity, BinaryOperator<T> accumulator);

//형태3
<U> U reduce(U identity, BiFunction<U, ? super T, U> accumulator,
            BinaryOperator<U> combiner);
```

### 형태1

- 먼저 인자가 하나만 있는 형태입니다.
- 인자로는 BinaryOperator를 사용하는데 이는 두 개의 같은 타입 요소를 인자로 받아  
  동일한 타입의 결과를 반환하는 함수형 인터페이스를 사용합니다.

```java
List<Integer> list = List.of(1,2,3);
Optional<Integer> result = list.stream().reduce((a,b) -> a + b);    // 6
//list.stream().reduce(Integer::sum);
```

### 형태2

- 다음으로 두 개의 인자를 받는 형태는 항등값과 BinaryOperator를 받습니다.
  아래와 같이 초기값을 줄 수도 있습니다.

```java
List<Integer> list = List.of(1,2,3);
Integer result = list.stream().reduce(1, Integer::sum); // 7

System.out.println(result);
```

### 형태3

- 마지막으로 세 개의 인자를 받는 형태입니다.
- 항등값, BiFunction, BinaryOperator를 받습니다.
- 값을 누적하는 연산의 경우 병렬 연산의 결과를 결합해야 하는데, 여기서 세 번째 인자가 그 역할을 합니다.
- 그러니까 병렬 처리를 하는 경우에 각자 다른 스레드의 결과를 합쳐줍니다.

```java
List<Integer> list = List.of(3, 7, 9);
Integer result = list.parallelStream()
        .reduce(1, Integer::sum, (a, b) -> {
            System.out.println("in combiner");
            return a + b;
        });

System.out.println(result);
// 출력 결과
// in combiner a:8 b:10
// in combiner a:4 b:18
// 22
```

- 일반 스트림에서는 combiner가 수행되지 않으므로 결과값도 다릅니다.
- 즉 병렬 스트림에서만 동작합니다. 초기값 1에 스트림의 요소 값을 더한 값을 계산합니다. (1+3=4, 1+9=10, 1+7=8)
- 그리고 다음 과정에서 combiner 연산에서는 여러 스레드에서 나누어 연산한 값을 합칩니다. (8+10=18, 4+18=22)

## 계산하기: 최소값, 총합, 평균등

### 최소값 ( min() ) 또는 최대값( max() )

```java
// Optional을 리턴
OptionalDouble min = DoubleStream.of(4.1, 3.4, -1.3, 3.9, -5.7).min();
min.idPresent(System.out::println);

// 5
int max = IntStream.of(2, 4, 5, 3).max().getAsInt();
```

### 갯수( count() )

```java
// 결과 4
long count = IntStream.of(2, 4, 1, 3).count()
```

### 평균( average() )

```java
// 결과 7.1
double sum = DoubleStream.of(3.1, 2.6, 1.4).sum();

// // Optional을 반환한다.
OptionalDouble average = IntStream.of(3, 2, 1).average();

// 결과 2.0
average.ifPresent(System.out::println);
```

## 결과 모으기( Collect )

- 스트림을 List, Set 그리고 Map과 같은 다른 형태의 결과로 변환해줍니다.
- 아래와 같은 클래스가 있다고 가정하고 여러 가지 collect 연산을 진행해봅시다.

```java
class Food {
    public Food(String name, int cal) {
        this.name = name;
        this.cal = cal;
    }

    private String name;
    private int cal;

    @Override
    public String toString() {
        return String.format("name: %s, cal: %s", name, cal);
    }

    // getter, setter 생략
}

List<Food> list = new ArrayList<>();
list.add(new Food("burger", 520));
list.add(new Food("chips", 230));
list.add(new Food("coke", 143));
list.add(new Food("soda", 143));
```

### Collectors.toList : 리스트로 반환

```java
List<String> nameList = list.stream()
        .map(Food::getName) // name 얻기
        .collect(Collectors.toList());  // list로 수집
```

### 숫자값의 합, 평균 등 구하기

스트림 내 요소들의 합, 평균 등을 구할 수 있습니다.

```java
// name 길이의 합 구하기
Integer summingName = list.stream()
        .collect(Collectors.summingInt(s -> s.getName().length()));

// mapToInt 메서드로 칼로리(cal) 합 구하기
int sum = list.stream().mapToInt(Food::getCal).sum();

// 평균 구하기: averagingInt
Double averageInt = list.stream()
        .collect(Collectors.averagingInt(Food::getCal));

// 평균 구하기: averagingDouble
Double averageDouble = list.stream()
        .collect(Collectors.averagingDouble(Food::getCal));
```

위에서 살펴본 값들은 summarizingInt와 같은 통계를 얻을 수 있는 메서드를 이용하면 한번에 그 정보를 담을 수 있습니다.

```java
IntSummaryStatistics summaryStatistics = list.stream()
        .collect(Collectors.summarizingInt(Food::getCal));

summaryStatistics.getAverage(); // 평균
summaryStatistics.getCount(); // 개수
summaryStatistics.getMax(); // 최댓값
summaryStatistics.getMin(); // 최솟값
summaryStatistics.getSum(); // 합계
```

### 스트림 연산 결과를 하나의 문자열로 만들기

스트림의 연산 결과를 하나의 문자열로 합칠 수 있습니다. 3개의 오버로딩된 메서드를 제공하며 아래와 같이 여러 가지 방법으로 사용할 수 있습니다.

```java
// without arguments
String defaultJoining = list.stream()
        .map(Food::getName).collect(Collectors.joining());

// burgerchipscokesoda
System.out.println(defaultJoining);
```

구분자(delimiter)를 인자로 받아서 처리할 수 있습니다. 이어지는 문자열 사이에 위치하게 됩니다.

```java
// delimiter
String delimiterJoining = list.stream()
        .map(Food::getName).collect(Collectors.joining(","));

// burger,chips,coke,soda
System.out.println(delimiterJoining);
```

구분자와 prefix, suffix를 같이 사용할 수 있습니다. 결과의 맨 앞과 맨 뒤에 붙일 문자를 지정합니다.

```java
// delimiter, prefix, suffix
String combineJoining = list.stream()
        .map(Food::getName).collect(Collectors.joining(",", "[", "]"));

// [burger,chips,coke,soda]
System.out.println(combineJoining);
```

### 특정 조건으로 그룹 짓기

스트림 내의 요소들을 주어진 조건에 맞추어 그룹핑(Grouping)할 수 있습니다.

```java
// 칼로리(cal)로 그룹 만들기
Map<Integer, List<Food>> calMap = list.stream()
        .collect(Collectors.groupingBy(Food::getCal));

// { 230=[name: chips, cal: 230],
//   520=[name: burger, cal: 520],
//   143=[name: coke, cal: 143, name: soda, cal: 143]}
System.out.println(calMap);
```

### 참, 거짓으로 그룹 짓기

partitioningBy는 인자로 Predicate 함수형 인터페이스를 받습니다. Predicate는 인자를 받아서 참 또는 거짓을 반환하기 때문에 boolean 값으로 그룹핑합니다.

```java
// 200 칼로리가 넘는 지로 구분
Map<Boolean, List<Food>> partitionMap = list.stream()
        .collect(Collectors.partitioningBy(o -> o.getCal() > 200));

// { false=[name: coke, cal: 143, name: soda, cal: 143],
//   true=[name: burger, cal: 520, name: chips, cal: 230]}
System.out.println(partitionMap);
```

### Map으로 결과 모으기

음식의 칼로리(cal)를 key, 이름을 value 값으로 맵을 생성해봅시다. 아래와 같이 Collectors.toMap 메서드를 사용해서 쉽게 구현할 수 있습니다.

```java
// Exception 발생!
Map<Integer, String> map = list.stream()
        .collect(Collectors.toMap(
                o -> o.getCal(),
                o -> o.getName()
        ));
System.out.println(map);
```

- 다만 위 메서드를 수행하면 아래와 같은 오류를 볼 수 있습니다.
- `java.lang.IllegalStateException: Duplicate key 143 (attempted merging values coke and soda)`

- 키에 값이 2개 이상 존재하게 되는 경우 컬렉터는 IllegalStateException을 던집니다.
- 따라서 키가 중복되는 예외 상황을 해결하기 위해 BinaryOperator 인자를 추가할 수 있습니다.

```java
// 동일한 키가 있는 경우 새 값으로 대체한다.
Map<Integer, String> map = list.stream()
        .collect(Collectors.toMap(
                o -> o.getCal(),
                o -> o.getName(),
                (oldValue, newValue) -> newValue));

// {230=chips, 520=burger, 143=soda}
System.out.println(map);
```

### collect 후에 연산 추가하기

collectingAndThen 메서드를 이용하면 특정 타입의 형태로 수집(collect)한 이후에 추가 연산을 진행할 수 있습니다.

```java
// 칼로리(cal)가 가장 높은 객체 반환
Food food = list.stream()
        .collect(Collectors.collectingAndThen(
                Collectors.maxBy(Comparator.comparing(Food::getCal)),
                (Optional<Food> o) -> o.orElse(null)));

// name: burger, cal: 520
System.out.println(food);
```

### 직접 Collector를 만들기

그 밖의 로직을 위해서 직접 Collector를 만들어서 사용할 수 있습니다.

```java
// 직접 collector 생
Collector<Food, StringJoiner, String> foodNameCollector = Collector.of(
        () -> new StringJoiner(" | "), // supplier: collector 생성
        (a, b) -> a.add(b.getName()), // accumulator: 두 값을 가지고 계산
        (a, b) -> a.merge(b), // combiner: 계산 결과 수집(합치기)
        StringJoiner::toString); // finisher

//만들 컬렉터를 스트림에 적용
String foodNames = list.stream().collect(foodNameCollector);

// burger | chips | coke | soda
System.out.println(foodNames);
```

## 조건 체크(Matching)

Predicate 조건식을 인자로 받아서 해당 조건을 만족하는 요소가 있는지 체크할 수 있습니다.

### 하나라도 만족하는가? (anyMatch)

```java
// 300 칼로리가 넘는 것이 하나라도 있는가?
boolean anyMatch = list.stream()
        .anyMatch(food -> food.getCal() > 300);
```

### 모두 조건을 만족하는가? (allMatch)

```java
// 모두 100 칼로리가 넘는가?
boolean allMatch = list.stream()
        .allMatch(food -> food.getCal() > 100);
```

### 모두 조건을 만족하지 않는가? (noneMatch)

```java
// 모두 1000 칼로리가 넘지 않는가?
boolean noneMatch = list.stream()
        .noneMatch(food -> food.getCal() < 1000);
```

[참조 블로그](https://wakestand.tistory.com/419)
[예제참조](https://madplay.github.io/post/java-streams-examples)
