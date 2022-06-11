# Lombok 사용시 주의사항

### @AllArgsConstructor, @RequireArgsConstructor 의 사용 금지

- @AllArgsConstructor의 경우 위와 같이 생성요소의 위치가 변하는 것 만으로 생성자의 파라미터 순서를 바꿔서 필드 선언에 맞춰서 변경시켜 버린다. 이 경우에는 IDE가 제공해주는 리팩토링이 작동하지 않고 동일한 타입의 파라미터로 오류가 발생하지 않아 개발자도 인식하기가 어려운 인자 값이 바뀌어 들어가게 되는 버그가 발생하게 된다. 이는 @RequiredArgsConstructor도 마찬가지로 버그가 발생할 수 있다.
- 위의 어노테이션은 편리하게 생성자를 생성해주는 어노테이션으로 프로젝트 중에서 많이 사용되는 롬복 어노테이션이지만 이것이 치명적인 버그를 생성할 수 있음에 주의해야 한다

### 대신에 @Builder (파라미터를 순서가 아닌 인자 이름으로 인식)를 사용 해서 이를 방지하자.

### @EqualsAndHashCode의 무분별한 사용 자제

- 동일한 객체이지만 Set에 저장한 뒤에 필드 값을 변경하면 hashCode가 변경되어 찾을 수 없게 된다.

- 따라서, 불변 클래스를 제외하고는 아무 파라미터 없는 @EqualsAndHashCode의 사용은 금지하고, 일반적으로 비교에서 사용하지 않는 Data 성 객체는 equals & hashCode를 따로 구현하지 않아야 한다. (항상 @EqualsAndHashCode(of={"필드명시"})의 형태로 동등성 비교에 필요한 필드를 명시하는 형태로 사용해야 한다. )

- 온전한 Immutable 필드를 대상으로만 equals & hashCode를 만들기는 매우 어려우므로 최소한 꼭 필요하고 일반적으로 변하지 않는 필드에 대해서만 만들도록 해야 한다.

### @Data 의 사용 금지

- @Data는 파라미터 없는 @EqualsAndHashCode와 @RequiredArgsConstructor 등을 포함한 변경가능한 데이터 클래스를 만들어주는 조합형 어노테이션으로 이 때문에 사용을 아예 금지하고 위와 같이 필요한 부분을 명시하여 사용하는 것이 좋다.

- 또한 무분별한 @Data 어노테이션을 사용할 경우 양방향 연관관계에서의 순환참조 문제가 발생할 수 있다. @ToString 사용시에는 분명하게 @ToString사용임을 명시하고 @ToString(exclude="...")나 @ToString(of="...")처럼 어노테이션을 사용해서 불필요한 부분은 제외하도록 하자.

### @Value 의 사용 금지

- @Value 어노테이션은 변경 불가능한 클래스를 만들어주는 조합 어노테이션이지만 이 또한 @EqualsAndHashCode ( 불변 클래스라 큰 문제는 되지 않는다), @AllArgsConstructor (문제 발생) 를 포함하여 사용을 금지시키고 필요한 부분을 명시하는 것이 좋다.

### @Builder는 생성자나 static 객체 생성 메서드에 직접 바로 적용

- @Builder를 사용하면 객체 생성이 더 명확하고 쉬워지지만 이는 기본적으로 @AllArgsConstructor를 내포하고 있다.생성자를 package private으로 만들기 때문에 외부에서 생성자를 호출하는 일이 쉽게 발생하지 않아 이 자체로는 평상시에 문제가 되지 않지만 해당 클래스의 다른 메소드에서 이렇게 자동으로 생성된 생성자를 사용하거나 할 때 문제가 발생될 수 있다.

- 따라서 @Builder 어노테이션은 가급적 클래스 보다는 직접 만든 생성자 혹은 static 객체 생성 메서드에 붙이는 것을 권장한다.

### @Log 의 사용은 @Slf4j로 가급적 사용

- @Log 어노테이션을 이용해 각종 Logger를 자동생성할 수 있다. (기본적으로 private static final로 생성, static 필드 혹은 Logger 객체 이름을 변경하고자 한다면 lombok.config를 사용)

- 그런데 @Slf4j는 Logger와 같이 field 변수로 만들 필요가 없어 static final로 지정하여 별다른 처리없이 static method 에서도 호출이 가능하므로 가급적 @Slf4j를 사용하자.

### Lombok

따라서 실무 프로젝트에서는 가급적 @Getter, @Setter, @ToString만 사용하도록 하고 그 외의 것들은 사용을 자제하거나 매뉴얼을 보고 보수적으로 사용하도록 하자. (@EqualsAndHashCode는 불변필드만 명시적으로 지정하면서 자제해서 사용하거나 가급적 IDE 코드 제너레이션 등을 통해 코드를 직접 만들어 사용)
