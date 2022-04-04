/**
 *  checkForm.js : 폼 유효성 확인
 */

window.onload = function(){
	//회원가입 유효성검사
	document.getElementById('joinForm').onsubmit = function(){
		
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
		//다르게 입력한경우
		var passwordCheck = document.getElementById('passwordChk');
		
		if(password.value != passwordCheck.value){
			alert("비밀번호 확인이 일치하지 않습니다.");
			passwordCheck.value = "	";
			passwordCheck.focus();
			return false;
		}

		//이름 유효성 검사
		var name = document.getElementById('name');
		
		if(name.value == ""){
			alert("성명을 입력하세요.");
			name.focus();
			return false;
		};
		// 키보드 이벤트 처리
		// 첫 번째 전화번호(hp1) 입력란에 입력 값이 3개가 되면 다음 입력 (hp2)으로 포커스 이동
		// keyup 이벤트 
		$('#memHp1').on('keyup', function(){
			if($(this).val().length == 3){
				$('#hp2').focus();
			}		
		});	
		
		// 두 번째 전화번호(hp2) 입력값이 4개가 되면 hp3로 포커스 이동
		// keyup 이벤트
		$('#memHp2').on('keyup', function(){
			if($(this).val().length == 4){
				$('#hp3').focus();
			}		
		});
		
		
		var email = document.getElementById('email')
		if(email.value == ""){
			alert("e-mail 주소를 입력하세요.");
			email.focus();
			return false;
		};

		var email = document.getElementById('emailSelect')
		if(emailSelect.value == "선택하세요"){
			alert("e-mail 계정를 선택하세요.");
			email.focus();
			return false;
		}
		//이메일 수신여부 유효성 검사
		var chk = false;
		for(var i=0; i<joinForm.emailRcv.length; i++){
			if(joinForm.emailRcv[i].checked == true)
			chk = true;
		}	
		// 이메일 수신여부 하나도 선택하지 않은경우
		if(chk == false){
			alert("이메일 수신 여부를 선택하세요");
			return false;
		}

		//약관동의 유효성 검사
		var agreement1 = document.getElementById('agreement1');
		var agreement2 = document.getElementById('agreement2');
		
		if(agreement1.checked == false || agreement2.checked == false){
			alert('동의에 체크하지 않았습니다.');
			return false;
		} 


	};


	

};
