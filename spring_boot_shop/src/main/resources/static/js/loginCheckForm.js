// loginCheckForm.js

window.onload = function(){
// 로그인화면 유효성 검사
document.getElementById('loginForm').onsubmit = function(){
		
    //아이디 유효성 검사
    var id = document.getElementById('id');
    if(id.value == ""){
        alert("ID를 입력하세요.");
        id.focus();
        return false;
    }

    if(6 > id.value.length || id.value.length > 10){	//(!(6 <= id.value && id.value <= 10))
        alert("아이디는 6~10자로 입력하세요");
        id.value =""; // null 됨.
        id.focus();
        return false;
    }

    //비밀번호 유효성검사
    //입력안한 경우
    var password = document.getElementById('password');
    
    if(password.value == ""){
        alert("비밀번호를 입력하세요.");
        password.focus();
        return false;
    };
};

};