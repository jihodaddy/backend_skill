# DI 와 IOC

## DI(Dependency Injection)

`DI(Dependency Injection)`란 스프링이 다른 프레임워크와 차별화되어 제공하는 의존 관계 주입 기능으로,
객체를 직접 생성하는 게 아니라 외부에서 생성한 후 주입 시켜주는 방식이다.
DI(의존성 주입)를 통해서 모듈 간의 결합도가 낮아지고 유연성이 높아진다.

- xml 방법

```xml
<bean id="inventoryService" class="com.example.InventoryService" />
<bean id="productService" class="com.example.ProductService" />
  <constructor-arg ref="inventoryService" />
</bean>
```

- @Configuration 어노테이션 방법

```java
@Configuration
public class ServiceConfiguration {

  @Bean
  public InventoryService inventoryService() {
    return new InventoryService();
  }

  @Bean
  public ProductService productService() {
    return new ProductService(inventoryService());
  }
}
```

## Ioc(Inversion of Control)

IoC(Inversion of Control)란 `제어의 역전` 이라는 의미로, 말 그대로 메소드나 객체의 호출작업을 개발자가 결정하는 것이 아니라, 외부에서 결정되는 것을 의미한다.
컨테이너가 직접 빈을 생성/관리하기 때문에 개발자는 코드에 new 등으로 선언하지 않아도 되며 이는 각 클래스들의 의존도를 줄여준다.
쉽게 말해서 스프링컨테이너가 필요에 따라 개발자 대신에 bean을 관리해주는 행위라고 생각하면 된다.
IoC는 제어의 역전이라고 말하며, 간단히 말해 "제어의 흐름을 바꾼다"라고 한다.
객체의 의존성을 역전시켜 객체 간의 결합도를 줄이고 유연한 코드를 작성할 수 있게 하여 가독성 및 코드 중복, 유지 보수를 편하게 할 수 있게 한다.

### IOC 용어정리

`bean` : 스프링에서 제어권을 가지고 직접 만들어 관계를 부여하는 오브젝트
스프링을 사용하는 애플리케이션에서 만들어지는 모든 오브젝트가 빈은 아니다. 스프링의 빈은 스프링 컨테이너가 생성하고 관계설정, 사용을 제어해주는 오브젝트를 말한다.

`bean factory` : 스프링의 IoC를 담당하는 핵심 컨테이너
Bean을 등록/생성/조회/반환/관리 한다. 보통 bean factory를 바로 사용하지 않고 이를 확장한 application context를 이용한다. BeanFactory는 bean factory가 구현하는 interface이다. (getBean() 등의 메서드가 정의되어 있다)

`application context` : bean factory를 확장한 IoC 컨테이너
Bean의 등록/생성/조회/반환/관리 기능은 bean factory와 같지만, 추가적으로 spring의 각종 부가 서비스를 제공한다. ApplicationContext 는 application context 가 구현해야 하는 interface이며, BeanFactory를 상속한다.

`configuration metadata` : application context 혹은 bean factory가 IoC를 적용하기 위해 사용하는 메타정보
스프링의 설정정보는 컨테이너에 어떤 기능을 세팅하거나 조정하는 경우에도 사용하지만 주로 bean을 생성/구성하는 용도로 사용한다.

`container (ioC container)` : IoC 방식으로 bean을 관리한다는 의미에서 bean factory나 application context를 가리킨다.
application context는 그 자체로 ApplicationContext 인터페이스를 구현한 오브젝트를 말하기도 하는데, 하나의 애플리케이션에 보통 여러개의 ApplicationContext 객체가 만들어진다. 이를 통칭해서 spring container라고 부를 수 있다.
