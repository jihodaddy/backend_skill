<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		<link rel="stylesheet" href="<c:url value='/css/login.css'/>" type="text/css">
	    <script src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
	    <script src="<c:url value='/js/loginCheckForm.js'/>"></script>
	    <script src="<c:url value='/js/login.js'/>"></script>
	    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	</head>
	<body>
			<!-- TOP  -->
	<%-- 	<jsp:include page="/WEB-INF/views/layout/top.jsp" flush='ture'></jsp:include> --%>
	
		<div id="wrap">
	
				  <div class="form-wrap">
			        <div class="button-wrap">
			            <div id="btn"></div>
			            <button type="button" class="toggle_btn" onclick="login()">LOG IN</button>
			            <button type="button" class="toggle_btn" onclick="register()">REGISTER</button>
			        </div>
			        <div class="social-icons">
			            <img src="img/kakao.png" alt="kakao"><a href="/kakaologin">카카오로그인</a>
			              <div id="naver_id_login"><img src="img/naver.png" alt="naver"></div>
			              <!-- 네이버로그인  -->
			              <script type="text/javascript">
						  	var naver_id_login = new naver_id_login("DScCq08roHfAQvUwI7ZD", "http://localhost:8000/loginresult");
						  	var state = naver_id_login.getUniqState();
						  	naver_id_login.setButton("white", 2,40);
						  	naver_id_login.setDomain("http://localhost:8000");
						  	naver_id_login.setState(state);
						  	naver_id_login.setPopup();
						  	naver_id_login.init_naver_id_login();
						  </script>
			              
			        </div>
			        <form id="login" action="" class="input-group">
			            <input type="text" class="input-field" placeholder="Emai Addressl" required>
			            <input type="password" class="input-field" placeholder="Enter Password" required>
			            <input type="checkbox" class="checkbox"><span>Remember Password</span>
			            <button class="submit">Login</button>
			        </form>
			        <form id="register" action="" class="input-group">
			            <input type="text" class="input-field" placeholder="User name or Email" required>
			            <input type="email" class="input-field" placeholder="Your Email" required>
			            <input type="password" class="input-field" placeholder="Enter Password" required>
			            <input type="checkbox" class="checkbox"><span>Terms and conditions</span>
			            <button class="submit">REGISTER</button>
			        </form>
			    </div>	
			
			<script>
			  var x = document.getElementById("login");
			  var y = document.getElementById("register");
			  var z = document.getElementById("btn");
			  
			  
			  function login(){
			      x.style.left = "50px";
			      y.style.left = "450px";
			      z.style.left = "0";
			  }
			
			  function register(){
			      x.style.left = "-400px";
			      y.style.left = "50px";
			      z.style.left = "110px";
			  }
			</script>
					
		
		</div>		
		
	</body>
</html>