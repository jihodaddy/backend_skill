# 서블릿

- 클라이언트의 요청을 처리하고, 그 결과를 반환하는 Servlet 클래스의 구현 규칙을 지킨 자바 웹 프로그래밍 기술
- 자바를 사용하여 웹을 만들기 위해 필요한 기술

## Servlet 특징

- 클라이언트의 요청에 대해 동적으로 작동하는 웹 어플리케이션 컴포넌트
- html을 사용하여 요청에 응답
- Java Thread를 이용하여 동작
- MVC 패턴에서 Controller로 이용됨
- HTTP 프로토콜 서비스를 지원하는 javax.servlet.http.HttpServlet 클래스를 상속 받음
- UDP보다 처리 속도가 느림
- HTML 변경 시 Servlet을 재컴파일해야 하는 단점

## Servlet 동작 방식

- 사용자(클라이언트)가 URL을 입력하면 HTTP Request가 Servlet Container로 전송합니다.
- 요청을 전송받은 Servlet Container는 HttpServletRequest, HttpServletResponse 객체를 생성합니다.
- web.xml을 기반으로 사용자가 요청한 URL이 어느 서블릿에 대한 요청인지 찾습니다.
- 해당 서블릿에서 service메소드를 호출한 후 클리아언트의 GET, POST여부에 따라 doGet() 또는 doPost()를 호출합니다.
- doGet() or doPost() 메소드는 동적 페이지를 생성한 후 HttpServletResponse객체에 응답을 보냅니다.
- 응답이 끝나면 HttpServletRequest, HttpServletResponse 두 객체를 소멸시킵니다.

# Servlet Container (서블릿 컨테이너)
- 서블릿을 관리해주는 컨테이너
- 클라이언트의 요청(Request)을 받아주고 응답(Response)할 수 있게, 웹서버와 소켓으로 통신
- 대표적인 예로 톰캣(Tomcat)