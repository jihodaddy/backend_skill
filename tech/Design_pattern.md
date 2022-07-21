# 디자인 패턴

## 1. 어댑터 패턴 ( Adapter Pattern )

호출당하는 쪽의 메소드를 호출하는 쪽의 코드에 대응하도록 중간에 변환기를 통해 호출하는 패턴

호환성이 없는 기존 클래스의 인터페이스를 변환해서 재사용하기 위해 필요.

ex) JDBC, JRE

서로 다른 두 인터페이스 사이에 통신이 가능하게 하는 것
합성, 즉 객체의 속성으로 만들어서 참조하는 디자인 패턴

```java
public class AdaptorSocket implements Electornic110V {

    private Electornic220V electornic220V;

    public AdaptorSocket(Electornic220V electornic220V) {
        this.electornic220V = electornic220V;
    }

    @Override
    public void powerOn() {
        electornic220V.connect();
    }
```

## 2. 프록시 패턴 ( Proxy Pattern )

제어 흐름을 조정하기 위한 목적으로 중간에 대리자(proxy)를 두는 패턴

프록시 패턴은 개방 폐쇄 원칙(OCP)과 의존 역전 원칙(DIP)이 적용된 설계 패턴이다.

스프링은 AOP에서 프록시 패턴을 사용.

```java
@Override
    public Html show() {

        if(html == null) {
            html = new Html(url);
            System.out.println("ProxyBrowser loading html : " + url);
        }
        System.out.println("ProxyBrowser use cache html : " + url);
        return html;
    }
```

## 3. 데코레이터 패턴 ( Decorator Pattern )

메서드 호출의 반환값에 변화를 주기 위해 중간에 장식자를 두는 패턴

기존 뼈대(클래스)는 유지하되, 이후 필요한 형태를 꾸밀 때 사용.
상속을 통해 확장하는 형태로 활용.

```java
public class AudiDecorator implements ICar {

    protected ICar audi;
    protected String modelName;
    protected int modelPrice;

    public AudiDecorator(ICar audi, String modelName, int modelPrice){
        this.audi = audi;
        this.modelName = modelName;
        this.modelPrice = modelPrice;
    }

    @Override
    public int getPrice() {
        return audi.getPrice() + this.modelPrice;
    }

    @Override
    public void showPrice() {
        System.out.println("Audi " + this.modelPrice + " Price is " + getPrice());
    }
}
```

## 4. 싱글턴 패턴 ( SingleTon Pattern )

클래스의 인스턴스, 즉 객체를 하나만 만들어 사용하는 패턴

인스턴스를 하나만 만들어 사용하기위한 패턴 (커넥션 풀, 스레드 풀, 디바이스 설정 등)

주로 서버와 Socket Connect.., 스프링의 Bean 등에 많이 활용!

< 싱슬턴 패턴 만들기 과정 >

new를 실행할 수 옶도록 생성자에 private 접근 제어자를 지정한다.
유일한 단일 객체를 반환할 수 있는 정적 메서드가 필요하다.
유일한 단일 객체를 참조할 정적 참조 변수가 필요하다.

```java
public class Singleton {
	static Singleton singletonObject; // 정적 참조 변수

	private Singleton() {}; // private 생성자

	// 객체 반환 정적 메서드
	public static Singleton getInstance() {
		if(singletonObject == null) {
			singletonObject = new Singleton();
		}
		return singletonObject;
	}
}

public class Client {
	public static void main(String[] args) {
		// private 생성자이므로 new를 통해 인스턴스를 생성할 수 없음
		// Singleton s = new Singleton();

		Singleton s1 = Singleton.getInstance();
		Singleton s2 = Singleton.getInstance();
		Singleton s3 = Singleton.getInstance();

		System.out.println(s1);
		System.out.println(s2);
		System.out.println(s3);
		/**
		 com.grace.oop.singleton.Singleton@26f0a63f
		 com.grace.oop.singleton.Singleton@26f0a63f
		 com.grace.oop.singleton.Singleton@26f0a63f
		 */
	}
}
```

## 5. 옵저버 패턴(Observer Pattern)

변화가 일어났을 때, 미리 등록된 다른 클래스에 통보해주는 패턴을 구현한 것.
event listner가 대표적인 사용 예이다.

```java
    private String name;
    private IButtonlistner buttonlistner;

    public Button(String name) {
        this.name = name;
    }

    public void click(String message) {
        buttonlistner.clickEvent(message);
    }

    public void addListner(IButtonlistner buttonlistner) {
        this.buttonlistner = buttonlistner;
    }
}

// Interface
public interface IButtonlistner {

    void clickEvent(String event);

}

// Main
public class ButtonMain {

    public static void main(String[] args) {

        Button button = new Button("Button");
        button.addListner(new IButtonlistner() {
            @Override
            public void clickEvent(String event) {
                System.out.println(event);
            }
        });
        button.click("click 1 send a message.");
        button.click("click 2 send a message.");
        button.click("click 3 send a message.");
    }
}
```

## 6. 파사드 패턴(Facade Pattern)

파사드(Facade)는 건물의 앞쪽 정면이라는 뜻
: 여러개의 객체와 실제 사용하는 서브 객체 사이에 복잡한 의존관계가 있을 때, 중간에 facade라는 객체를 두고, 여기서 제공하는 interface만을 활용하여 기능을 사용하는 방식.

```java
public class SFtpClient {

    private FTP ftp;
    private Reader reader;
    private Writer writer;

    public SFtpClient(FTP ftp, Reader reader, Writer writer) {
        this.ftp = ftp;
        this.reader = reader;
        this.writer = writer;
    }

    public SFtpClient(String host, int port, String path, String fileName) {
        this.ftp = new FTP(host, port, path);
        this.reader = new Reader(fileName);
        this.writer = new Writer(fileName);
    }

    public void connect() {
        ftp.connect();;
        ftp.moveDirectory();
        writer.fileConnect();
        reader.fileConnect();
    }

    public void disconnect() {
        reader.fileConnect();
        writer.fileDisconnect();
        ftp.disConnect();
    }

    public void read() {
        reader.fileRead();
    }

    public void write() {
        writer.fileWrite();
    }
```

## 7. 전략 패턴 ( Strategy Pattern )

클라이언트가 전략을 생성해 전략을 실행할 컨텍스트에 주입하는 패턴

< 필요한 요소 >

전략 메서드를 가진 전략 객체(람다를 사용할려면 전략 객체에 하나의 메서드만 존재해야 한다.)
전략 객체(인터페이스)를 변하지 않는 컨텍스트 (전략 객체의 사용자/소비자)에 주입(DI) : 전략 패턴을 여러 형식이 있는데, 파라미터로 객체를 주입하는 형태가 컨텍스트에 바로 실행되는 전략패턴 방식으로 많이 사용됨.
전략 객체(Strategy)를 생성해 컨텍스트(ContextV2)에 전략 객체를 주입하여 해당 인터페이스를 구현하도록 한다. 상속이 아니라 위임을 하는 것이다.

❗ 객체지향의 꽃
: 유사한 행위들을 캡슐화하여, 객체의 행위를 바꾸고 싶은 경우 직접 변경하는 것이 아닌 전략(interface)만 변경할 수가 있어 상호교체(interfaceImpl1, interfaceImpl2 서로 교체 가능)가 가능해 유연하게 확장가능한 패턴
: SOLID 중에서 개방폐쇄 원칙(OCP)과 의존 역전 원칙(DIP)을 따른다.
: 스프링의 DI 의존성기술은 이 전략패턴을 사용한 것이다.

```java
    // Strategy : 전략 객체
    public interface Strategy {
    	void call();
	}

    /**
     * 전략객체를 파라미터로 전달 받는 방식 : 가장 대표적인 방식
     */
    @Slf4j
    public class ContextV2 {
        public void execute(Strategy strategy) {
            long startTime = System.currentTimeMillis();
            //비즈니스 로직 실행
            strategy.call(); //위임
            //비즈니스 로직 종료
            long endTime = System.currentTimeMillis();
            long resultTime = endTime - startTime;
            log.info("resultTime={}", resultTime);
        }
    }
```

## 8. 그외 패턴들

### 템플릿 메서드 패턴 ( Template Method Pattern )

`상위 클래스의 메서드에서 하위 클래스가 오버라이딩한 메서드를 호출하는 패턴`

간단하게 다형성을 이용한 디자인패턴이라 생각하면 된다.
단일 책임 원칙(SRP)을 지키고 있다
템플릿 메서드 패턴은 상속을 사용한다. 따라서 상속에서 오는 단점, 자식 클래스가 부모클래스에 의존하는 문제를 그대로 안고간다.

```java
/**
* 템플릿 메서드 패턴 적용
*/
@Test
void templateMethodV1() {
	AbstractTemplate template1 = new SubClassLogic1();
	template1.execute();
	AbstractTemplate template2 = new SubClassLogic2();
	template2.execute();
}
```

템플릿 메서드 패턴과 비슷한 역할을 하면서 상속의 단점을 제거할 수 있는 디자인 패턴이 바로 전략 패턴(Strategy Pattern)이다.

### 팩터리 메서드 패턴 ( Factory Mrthod Pattern )

`오버라이드된 메서드가 객체를 반환하는 패턴`

팩터리 메서드는 객체를 생성 반환하는 메서드이다.
팩터리 패턴은 하위 클래스에서 팩터리 메서드를 오버라이딩해사 객체를 반환하게 하는 것.
의존 역전 원칙(DIP)을 활용하고 있다
처음 클래스를 배울 때 클래스를 붕어빵틀, 객체를 붕어빵이라고 배웠는데 사실, 붕어빵틀은 팩토리 메서드였다!

- 요구사항을 담은 interface 생성

```java
public interface Language {

    public void compile();

    public String getLanguageType();
}
```

- 상속받은 클래스를 구분해 줄 클래스 생성

```java
public class LanguageType {

    public static final String JAVA = "java";

    public static final String PYTHON = "python";

}
```

- interface를 상속받아 구현할 클래스 생성

```java
public class Java implements Language{

    @Override
    public void compile() {
        System.out.println("Java Compile");
    }

    @Override
    public String getLanguageType() {
        return LanguageType.JAVA;
    }
}

public class Python implements Language{

    @Override
    public void compile() {
        System.out.println("Python Compile");
    }

    @Override
    public String getLanguageType() {
        return LanguageType.PYTHON;
    }
}
```

- 파라미터에 따라 객체를 반환해줄 Factory 클래스 생성

```java
// 기본 Factory 클래스
@Component
public class LanguageFactory {

    public Language getLanguage(String languageType) {

        if(languageType.equal(LanguageType.JAVA)){
            return new Java();
        } else if(languageType.equal(LanguageType.Python)) {
            return new Python();
        } else {
            return null;
        }//end else

    }//getLanguage

}//class

// 개선된 Factory 클래스
@Component
public class LanguageFactory {

    @Autowired
    private List<Language> languageList;

    public Language getLanguage(String languageType) {
        for(Language language : languageList) {
            if(languageType.equals(language.getLanguageType()))
                return language;
        }//end for
        return null;
    }//getLanguage

}//class
Factory 클래스를 사용하여 객체를 받아 사용하는 클래스 생성
@Service
public class UseFactory {

    @Autowired
    private LanguageFactory factory;

    @Override
    public void useLanguageFactory() {
        Language java = factory.getLanguage(LanguageType.JAVA);
        Language python = factory.getLanguage(LanguageType.PYTHON);

        java.compile();
        System.out.println(java.getClass());

        python.compile();
        System.out.println(python.getClass());

    }//useLanguageFactory

}//class
```

### 탬플릿 콜백 패턴 ( Template Callback Pattern - 견본/회신 패턴 )

전략 패턴에서 템플릿과 콜백 부분이 강조된 패턴이라 생각하면 된다.

`전략을 익명 내부 클래스로 구연한 전략 패턴`

콜백 정의
프로그래밍에서 콜백(callback) 또는 콜애프터 함수(call-after function)는 다른 코드의 인수로서
넘겨주는 실행 가능한 코드를 말한다. 콜백을 넘겨받는 코드는 이 콜백을 필요에 따라 즉시 실행할 수도
있고, 아니면 나중에 실행할 수도 있다. (위키백과 참고)

쉽게 말하면 callback은 코드가 호출(call)은 되는데 코드를 넘겨준 곳의 뒤(back)에서 실행된다는 뜻이다.

자바 언어에서 콜백
자바 언어에서 실행 가능한 코드를 인수로 넘기려면 객체가 필요하다. 자바8부터는 람다를 사용할 수 있다.
자바 8 이전에는 보통 하나의 메소드를 가진 인터페이스를 구현하고, 주로 익명 내부 클래스를 사용했다.
최근에는 주로 람다를 사용한다.

- 전략 패턴의 변형으로 스프링에서만 부르는 특별한 형태의 전략 패턴
- 스프링에서 jdbcTemplate, RestTemplate, RedisTemplate 등 XxxTemplate가 있다면 템플릿 콜백 패턴을 쓴 것이다.
- 개방 폐쇄 원칙(OCP)과 의존 역전 원칙(DIP)이 적용된 설계 패턴이다.

```java
public interface Strategy {
	public abstract void runStrategy();
}

public class Soldier {
	void runContext(String weapon) {
		System.out.println("전투 시작");
		executeWeapon(weapon).runStrategy();
		System.out.println("전투 종료");
	}

	private Strategy executeWeapon(final String weapon) {
		return new Strategy() {
			@Override
			public void runStrategy() {
				System.out.println(weapon);
			}
		};
	}
}

public class Client {
	public static void main(String[] args) {
		Soldier rambo = new Soldier();
		rambo.runContext("총 총 총 총 총");
		System.out.println();
		rambo.runContext("활 활 활 활 활");

	}
}
/** 출력값
전투 시작
총 총 총 총 총
전투 종료

전투 시작
활 활 활 활 활
전투 종료
*/
```

템플릿 콜백 패턴 - 람다

```java
/**
* 템플릿 콜백 패턴 - 람다
*/
@Test
void callbackV2() {
	TimeLogTemplate template = new TimeLogTemplate();
	template.execute(() -> log.info("비즈니스 로직1 실행"));
	template.execute(() -> log.info("비즈니스 로직2 실행"));
}
```
