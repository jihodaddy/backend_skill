# BeanUtils.copyProperties() 객체복사 메서드
- Spring의 BeanUtil클래스의 copyProperties: 원본객체 복사할 떄 사용하는 메서드
- 기존 객체를 Setter에 담에 보내려면 코드도 많아지고 번거로워지기 때문에 이용
- DTO, ENTITY간 전환하거나 할떄 필드변수 갯수가 많아지거나 하는 경우 편리하게 이용 가능

```java
  public static void copyProperties(Object source, Object target) throws BeansException {
    copyProperties(source, target, (Class)null, (String[])null);
}
```
- **source** 인자에는 **Getter** 메소드 존재해야 함(원본 객체)
- **target** 인자에는 **Setter** 메소드 존재해야 함(복사 대상 객체)
```java
  public static void copyProperties(Object source, Object target, String... ignoreProperties) throws BeansException {
    copyProperties(source, target, (Class)null, ignoreProperties);
}
```
- **ignoreProperties** 복사를 원하지 않는 프로퍼티 명(가변인자)

- 예시
- getter/setter
```java
  public static void main(String[] args) {
        Source source = new Source("홍길동", 40, "hong@test.com");
        Target target = new Target("이순신", 30, "lee@test.com");
        
        // 필드 갯수가 많아지면 코드가 길어짐
        target.setName(source.getName());
        target.setAge(source.getAge());
        target.setEmail(source.getEmail());
      
    }

}
```
- copyProperties
```java
   public static void main(String[] args) {
        Source source = new Source("홍길동", 40, "hong@test.com");
        Target target = new Target("이순신", 30, "lee@test.com");
        
        BeanUtils.copyProperties(source, target);
    }
```


[참고](https://zzang9ha.tistory.com/304)
