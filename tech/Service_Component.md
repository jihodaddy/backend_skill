# Service 와 Component의 차이

## @Component

Spring에서 관리되는 객체임을 표시하기 위해 사용하는 가장 기본적인 annotation이다. 즉, scan-auto-detection과 dependency injection을 사용하기 위해서 사용되는 가장 기본 어노테이션이다.
Component는 스프링 빈으로 등록하겠다고 표시하는 애노테이션입니다. 즉 스프링 ApplicationContext에 표시를 해두면, 컨테이너가 빈으로 등록을 한다
여기서 ApplicationContext는 Beanfactory를 상속한 인터페이스이며, 우리가 스프링 컨테이너라고 부르는 곳이다.

## @Controller

Web MVC 코드에 사용되는 어노테이션이다. @RequestMapping 어노테이션을 해당 어노테이션 밑에서만 사용할 수 있다.

## @Repository

이것은 Annotation based Configuration, @Repository의 작업은 플랫폼 별 예외를 잡아서 Spring의 통합 검사되지 않은 예외 중 하나로 다시 던지는 것입니다. 이를 위해 PersistenceExceptionTranslationPostProcessor이 제공되며 다음과 같이 Spring의 애플리케이션 컨텍스트에 추가해야 한다.

```Java
<bean class="org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor"/>
```

이 빈 포스트 프로세서는 @Repository로 주석이 달린 모든 빈에 권고자를 추가하여 플랫폼 별 예외를 포착 한 다음 Spring의 확인되지 않은 데이터 액세스 예외 중 하나로 다시 발생시킨다.

리포지토리(데이터 액세스 개체 또는 DAO라고도 함)의 역할 또는 스테레오타입을 수행하는 모든 클래스에 대한 마커입니다. 이 마커의 용도 중에는 예외 번역에 설명된 대로 예외의 자동 번역이 있습니다.

## @Service

비즈니스 로직이나 respository layer 호출하는 함수에 사용된다. 다른 어노테이션과 다르게 @Component에 추가된 기능은 없다. 하지만 나중에 Spring 측에서 추가적인 exception handling을 해줄 수도 있으니 비즈니스 로직에는 해당 어노테이션을 사용하자.

일반적으로 컴포넌트 클래스들에 @Component를 붙일 수 있지만, @Repository, @Service, @Controller를 붙인다면 도구들이 클래스들을 처리하는데 더 적합하도록 할 수 있고 관점(aspects)에 더 연관성을 부여할 수 있다. - AOP 를 통한 처리가 쉽게 가능하다
