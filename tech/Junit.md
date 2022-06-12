# JUnit 생명주기

### @BeforeAll

JUnit4의 @BeforeClass 를 대신하여 사용하는 어노테이션이다.
모든 테스트가 실행되기 전에 @BeforeAll이 명시된 메서드가 실행된다.
테스트가 실행되기전에 한번만 실행이 되며, 반드시 static 메서드 여야한다.

### @BeforeEach

JUnit4의 @Before를 대신하여 사용하는 어노테이션이다.
해당 어노테이션이 있는 메서드는 @Test 어노테이션이 있는 테스트 메서드 이전에 실행된다.
해당 메서드는 static이 될수 없다.

### @AfterAll

JUnit4의 @AfterClass를 대신하여 사용하는 어노테이션이다.
모든 테스트가 종료 된 후에 @AfterAll 이 명시된 메서드가 실행된다.
테스트가 종료 된 후에 한번만 실행되고, 반드시 static 메서드 여야한다.

### @AfterEach

JUnit4의 @After를 대신하여 사용하는 어노테이션이다.
해당 어노테이션이 있는 메서드는 @Test 어노테이션이 있는 테스트 메서드 실행 이후에 실행된다.
해당 메서드는 static이 될 수 없다.
