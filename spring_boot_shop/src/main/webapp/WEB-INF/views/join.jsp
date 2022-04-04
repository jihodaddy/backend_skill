<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="<c:url value='/css/join.css'/>" rel="stylesheet" type="text/css">
    <script src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
    <script src="<c:url value='/js/joinCheckForm.js'/>"></script>
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>	
	<script src="<c:url value='/js/searchZip.js'/>"></script>
</head>
<body>
    <div id="wrapper">
    		
    		  <!-- TOP  -->
		<jsp:include page="/WEB-INF/views/layout/top.jsp" flush='ture'></jsp:include>
		
    		
    		<section>
            <div id="joinBox">
                <h2>회원가입</h2>
                <hr>
                <form name="newMemberForm" id="joinForm" method="post" action="<c:url value='/member/joinMember' />">
                    <table> 
                        <tr>
                            <th>아이디</th>
                            <td id="idBox">
                                <input type="text" name="memId" id="id" placeholder="아이디(6~10자 입력)">    
                            </td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td id="pwBox">
                                <input type="password" name="memPwd" id="password" placeholder="비밀번호">
                            </td>
                        </tr>
                        <tr>
                            <th>비밀번호 확인</th>
                            <td id="pwChkBox">
                                <input type="password" name="userPwChk" id="passwordChk" placeholder="비밀번호확인">
                            </td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td id="nameBox">
                                <input type="text" name="memName" id="name" placeholder="이름">    
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td id="emailBox">
                                <input type="text" name="memEmail" id="email" placeholder="이메일">@
                                <select name="email" id="emailSelect">
                                    <option value="선택하세요">선택하세요</option>
                                    <option value="gmail">gmail.com</option>
                                    <option value="naver" >naver.com</option>
                                    <option value="hanmail">hanmail.net</option>
                                    <option value="nate">nate.com</option>
                                </select>   
                            </td>
                        </tr>
                          <tr>
                            <th>휴대폰번호</th>
                            <td id="hpBox">
                                <input type="text" id="memHp1" name="memHp1" size="3"> 
			                    - <input type="text" id="memHp2" name="memHp2" size="4">
			                    - <input type="text" id="memHp3" name="memHp3" size="4"> 
                            </td>
                        </tr>
                   		<tr>
                            <th>동의</th>
                            <td>
                                <label><input type="checkbox" name="agreement" id="agreement1" value="모든약관" >모든 약관에 동의</label>
                                <label><input type="checkbox" name="agreement" id="agreement2" value="개인정보">개인정보 이용 동의</label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button type="submit" id="joinButton">회원가입</button>
                                <button type="reset" id="cancel">취소</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </section>
    
       
    
	</div>
	</body>
</html>