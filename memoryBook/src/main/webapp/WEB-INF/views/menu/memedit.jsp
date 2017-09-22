<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8" >
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>회원정보 수정</title>
</head>
<body>
	<h1>회원정보 수정</h1>
	<table>
		<tr>
			<td>
				<button data-toggle="modal" data-target="#myModal_Modify" onclick="open_modal()">Modify</button>
			</td>
		</tr>
		<tr>
			<td>
				<button data-toggle="modal" data-target="#myModal_Unregister">Unregister</button>
			</td>
		</tr>
	</table>
	
	<div class="modal-body" id="modifyBody" >
		          	
		        <form name="infoModify" id="infoModify" action="/memory/member/infoUpdate" method="post">       
			    	<table>
			    		<tr>
			    			<div class="form-group">
			    			회원님의 정보를 수정해보세요.
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			<label for="email">Email</label>
							    <input type="text" class="form-control" id="email" name="email" value="${email}" disabled="disabled" required="required"/>
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			<label for="name">Name</label>
							    <input type="text" class="form-control" id="name" name="name" value="${name}" placeholder="이름을 다시 입력해주세요" required="required"/>
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			 <label for="password">Password:</label>
			    			 <input type="password" class="form-control" id="pwd1" name="pwd1" placeholder="비밀번호를 입력하세요" required="" autofocus="" />
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			 <label for="passwordConf">Password:</label>
			    			 <input type="password" class="form-control" id="pwd2" name="pwd2" placeholder="비밀번호를 확인하세요" required="" autofocus="" />
			    			 <span id="checkPwd"></span>
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			<label for="infomation">My Information</label><br>
			    			<input id="infoNumber" name="infoNumber" type="radio" value="0"> 전체 공개 &nbsp&nbsp&nbsp
							<input id="infoNumber" name="infoNumber" type="radio" value="1"> 나만 공개
							</div>   		
			    		</tr>
					    <tr>
					    	<td id="btns" colspan="2">
					    		<input type="button" id="updateBtn" class="btn btn-default memberModify_btns Modify_ok" value="수정" onclick="mem_update()">
					    	</td>
					    	<td id="btns" colspan="2">
							    <button class="btn btn-default memberModify_btns Modify_no" id="cancelBtn1" data-dismiss="modal">취소</button>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		        </div>
	
<script>
//비밀번호 확인
$("#pwd2").on("keyup",function(){
	var mo = document.infoModify;
	var pw1 = mo.pwd1.value;
	var pw2 = mo.pwd2.value;
	if(pw1!=pw2){
		$('#checkPwd').css('color', 'red');
		document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
	}else{
		$('#checkPwd').css('color', 'green');
	document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다."; 
	}
})

//프로필 사진
function uploadImage() {
	var data = new FormData();
	var files = $("#imageFile").get(0).files;
	if (files.length > 0) {
		data.append("imageFile", files[0]);
		}
	$.ajax({
		type: "POST",
		url : "/memory/member/upload",
		data: data,
		processData: false,
		contentType: false,
		success: function (result) {
			if(result == "error") {
				alert("이미지 파일이 아닙니다.");
			} else if (result == "IOException") {
				alert("업로드 실패");
			} else {
			$("#getImage").html("<img id='profile_img' class='profile_img' src='/memory/data/mem_image/"+result+"'>");
			}
		},
		error: function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		}
	});
}

function open_modal() {
	$('.modal-backdrop').toggle();
}

function mem_update() {
	//라디오 버튼 Name 가져오기
    var radio_btn = document.getElementsByName("infoNumber");

    //라디오 버튼이 체크되었나 확인하기 위한 변수
    var infoNumber_check = 0;
        //만약 라디오 2번버튼이 체크가 되어있다면 true
        if(infoNumber[1].checked==true){
            //라디오 버튼2번이 체크되면 infoNumber_check를 1로 만들어준다.
            infoNumber_check++;
        }
    
    if(infoNumber[0].checked==false && infoNumber[1].checked==false){
        alert("공개방법을 선택해주세요");
        return;
    }
   	$.ajax ({
		url: "/memory/member/infoUpdate",
    	type: "POST",
    	data: {
 			"name" : $("input[name=name]").val(),    			
    		"email" : $("input[name=email]").val(),
    		"mem_pwd" : $("input[name=pwd1]").val(),
    		"infoNumber" : infoNumber_check
    		},
    	success: function(result) {
    			if(result) {
					alert("회원수정완료");
    				$('#myModal_Modify').modal('hide').on('hidden.bs.modal', functionThatEndsUpDestroyingTheDOM);
//					$('.modal-backdrop').remove();
     			} else alert("회원수정 실패");
    	}

     	});
     	return false;
    };
</script>
</html>