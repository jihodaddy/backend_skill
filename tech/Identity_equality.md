# 동일성(Identity) 와 동등성(Equality)

## 동일성(==)

- 동일성은 동일하다는 뜻으로 두 개의 객체가 완전히 같은 경우를 의미한다. 여기서 완전히 같다는 뜻은 두 객체가 사실상 하나의 객체로 봐도 무방하며, 주소 값이 같기 때문에 두 변수가 같은 객체를 가리키게 된다.
- 객체의 주소 값 비교 = 실제 인스턴스가 같다 = 참조하는 값이 서로 같다.

## 동등성(equals)

- 동등성은 동등하다는 뜻으로 두 개의 객체가 같은 정보를 갖고 있는 경우를 의미한다. 동등성은 변수가 참조하고 있는 객체의 주소가 서로 다르더라도 내용만 같으면 두 변수는 동등하다고 이야기할 수 있다. 동일하면 동등하지만, 동등하다고 동일한 것은 아니다. 그리고 해당 변수가 동등한지 equals 연산자를 통해 판별할 수 있다.
- 객체가 다르건 같건 상관없이 표현하는 문자가 같은지 다른지 만을 비교 = 인스턴스가 가지고 있는 값이 같다. (자바에서의 동등성 비교는 equals 메소드를 구현해야한다.)

### 기본형(Primitive Type)

- 기본형은 객체가 아니기 때문에 객체타입에서 지원하는 동등성 비교(equal)를 할 수 없으며
  기본형에서의 동일성 비교는 두 변수의 값이 같은가? 로 해석

```java
public class test {
    public static void main(String[] args) {
        int a = 1;
        int b = 1;

        int c = 3;
        int d = 4;

        System.out.println(a == b); //동일성: 두 변수가 가르키는 값을 비교
        System.out.println(c == d);
        }
}
```

```
true
false
```

### 참조형(Reference Type)의 동일성(==) 동등성(equals) 비교

- 참조형은 String test = new String("hi") 와 같이 new 연산을 통해 생성할 수 있다.
- 이를 통해 힙 영역의 메모리 공간이 생겨 그곳에 배치된다.
- 그러나 String 타입만은 new 생성자가 아닌 리터럴방식("") 으로도 String 객체를 생성할수 있는데 이 방식의 경우 Constant Pool 이라는 다른 영역에 배치가 된다.
- 두 생성 방식의 차이점은
- new 연산은 그냥 무조건 새로운 공간을 생성하기 때문에 두 동등성(equals)은 같을수 있으나 동일성(==)은 무조건 달라진다.
- 리터럴 방식은 생성시에 "1", "1" 동일한 문자열을 생성하게 된다면 새로 만들지 않고 있던놈을 그냥 반환해주기 때문에 동등성(equals),동일성(==)이 같을수가 있다

### new 연산자로 생성한 참조형의 동일성 동등성 비교

```java
public class test {
    public static void main(String[] args) {

          String a = new String("1");
          String b = new String("1");

          String c = new String("1");
          String d = new String("2");

          System.out.println(a==b);//동일성: 객체의 주소 값 비교
          System.out.println(a.equals(b));//동등성: 표현하는 문자가 같은지 다른지 비교

          System.out.println(c==d);
          System.out.println(c.equals(d));

          }
}
```

```
false
true

false
false
```

### 리터럴로 생성한 참조형의 동일성 동등성 비교(Constant Pool 적용)

```java
public class test{
    public static void main(String[] args) {

          String a="2"; //Constant pool 1
          String b="2";

          String c="2";
          String d="3"; //Constant pool 2
          String e=new String("3");

          System.out.println(a==b);
          System.out.println(a.equals(b));

          System.out.println(c==d);
          System.out.println(c.equals(d));

          System.out.println(d==e);
          System.out.println(d.equals(e));
    }
}
```

```
true
true

false
false

false
true
```
