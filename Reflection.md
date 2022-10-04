## 자바 리플렉션
리플렉션이란 인스턴스로 클래스의 정보를 분석하기 위한 기법
### public void setAccessible(boolean flag)
- 필드나 메서드의 접근제어 지시자에 의한 제어를 변경한다
```java
if (field != null){

field.setAccessible(true); // 접근 제어자가 private 일 경우

}
```

```java
import java.lang.reflect.Field;  
  
public class Test {  
    String name = "홍길동";  
    String address = "서울 강남구";  
  
    public static void main(String[] args) throws Exception {  
        Test test = new Test();  
        test.getValue("address");  
    }  
  
    void getValue(String key) throws Exception {  
        Class<?> cls = this.getClass();  
        Field field = cls.getDeclaredField(key);  
        System.out.println(field.getName()); // address
        System.out.println(field.get(this)); // 서울 강남구  
    }  
}
```