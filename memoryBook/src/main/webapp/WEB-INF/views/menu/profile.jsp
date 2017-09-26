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
<title>Profile</title>
</head>
<body>
<div class="container" style="padding-top: 60px;">
  <h1 class="page-header">Profile</h1>
  <div class="row">
    <!-- left column -->
    <div class="col-md-4 col-sm-6 col-xs-12">
      <div class="text-center">
      <table align="center">
      	<tr>
      		<td id="getImage">
      		</td>
      	</tr>
      </table>
        <table>
	        <tr>
	        	<td>
	        		<input type="file" class="text-center center-block well well-sm" name="imageFile" id="imageFile">
	        	</td>
	        	<td>&nbsp
	        	</td>
	        	<td>
	        		<input type="button" class="text-center center-block well well-sm" value="등록" onclick="uploadImage()">
	        	</td>
	        <tr>
        </table>
        <table id="myInfoList" class="text-center center-block well well-sm">
		
	</table>
      </div>
    </div>
    <!-- edit form column -->
    <div class="col-md-8 col-sm-6 col-xs-12 personal-info">
      <div class="alert alert-info alert-dismissable">
        <a class="panel-close close" data-dismiss="alert">×</a> 
        <i class="fa fa-coffee"></i>
        	회원님의 정보를 수정해보세요.
      </div>
      <h3>Personal info</h3>
      <form class="form-horizontal" role="form">
      	<div class="form-group">
          <label class="col-lg-3 control-label">Email:</label>
          <div class="col-lg-8">
            <input class="form-control" type="text" name="email" value="${email}" disabled="disabled">
          </div>
        </div>
        <div class="form-group">
          <label class="col-lg-3 control-label">Name:</label>
          <div class="col-lg-8">
            <input class="form-control" type="text" id="name" name="name" placeholder="이름을 다시 입력해주세요" required="required">
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label">My Information:</label><br>
          <div class="col-lg-8">
		  	<input id="infoNumber" name="infoNumber" type="radio" value="0"> 전체 공개 &nbsp&nbsp&nbsp
		  	<input id="infoNumber" name="infoNumber" type="radio" value="1"> 나만 공개
		  </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label">Password:</label>
          <div class="col-md-8">
            <input class="form-control" type="password" id="pwd1" name="pwd1" placeholder="비밀번호를 입력하세요" required="" autofocus="">
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label">Confirm password:</label>
          <div class="col-md-8">
            <input class="form-control" type="password" id="pwd2" name="pwd2" placeholder="비밀번호를 확인하세요" required="" autofocus="" >
          </div>
        </div>
        <div class="form-group">
          <label class="col-md-3 control-label"></label>
          <div class="col-md-8">
            <input class="btn btn-primary" value="수정" type="button" onclick="mem_update()">
            <input class="btn btn-danger pull-right"  data-toggle="modal" data-target="#myModal_Unregister" value="탈퇴" type="button">
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

	<!-- 탈퇴 모달 -->
	<div class="modal fade" id="myModal_Unregister" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content memberOut">
		        <div class="modal-header">
		        	<button type="button" class="close" id="modalClose" data-dismiss="modal">&times;</button>
		        	<br><br>
		        	<h4 class="modal-title outTitle" id="unregisterTitle">Memory Lane Unregister</h4>
		        	<br>
		        </div>
		        <br>
		        			        	
		        <div class="modal-body" id="unregisterBody" >
		          	
		        <form name="unregisterfrm" id="unregisterfrm" action="/memory/member/unregister" method="post">       
			    	<table>
			    		<tr>
			    			<div class="form-group">
			    			탈퇴하실려면 비밀번호를 입력하세요.<br>탈퇴시 작성하신 노트,드래그,친구정보가 전부 삭제됩니다.
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
							    <label for="loginPassword">Password:</label>
							    <input type="password" class="form-control" id="mem_pwd" name="mem_pwd" placeholder="비밀번호를 다시 입력해주세요" required="required"/>
			    			</div>
			    		</tr>
					    <tr>
					    	<td id="btns" colspan="2">
					    		<input type="submit" value="회원탈퇴" class="btn btn-default memberOut_btns out_ok">
					    	</td>
					    	<td>
					    	&nbsp;&nbsp;
					    	</td>
						    	<td id="btns" colspan="2">
							    <button class="btn btn-default memberModify_btns Modify_no" id="cancelBtn2" data-dismiss="modal">취소</button>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		        </div>
		      </div>
		    </div>
		  </div>
	</body>
<script>
$(function(){
	myList();
	$("#getImage").html("<img class='profile1 img-circle' width='150px' height='150px' alt='avatar' src='/memory/data/mem_image/${mem_image}'>");
});


function myList(){
	$.ajax ({
		url: "/memory/member/myList",
		type: "get",
		success : function(result){
			$(result).each(function(index, item) {
				var addRow = '<tr><td><h3>Name : </h3></td>';
					addRow += '<td id="myName"><h3>'+ item.name + '</h3></td></td></tr>';
					addRow += '<tr><td><h3>Email : </h3></td>';
					addRow += '<td id="myEmail"><h3>'+ item.email +'</h3></td></tr>';
					addRow += '<tr><td><h3>My Infomation : </h3></td>';
					if(item.infoNumber == 0){
		                   addRow +='<td id="myInfomation"><h3>전체 공개</h3></td>';
		                }else{
		            	   addRow +='<td id="myInfomation"><h3>나만 공개</h3></td>';
		                }
					addRow += '</tr>';
					$("#myInfoList").append(addRow);

			})
		}
	})
}

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
			$("#getImage").html("<img class='profile1 img-circle' width='150px' height='150px' alt='avatar' src='/memory/data/mem_image/"+result+"'>");
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
						alert("회원수정완료")
						$('#myModal_Modify').on('hidden.bs.modal', function (e) {
						  $(this).find('#infoModify')[0].reset();
						});
						$("#myInfoList").empty();
						myList();
			    	
	     			} else alert("회원수정 실패");	
	    	}
     	});
     	return false;
    };
</script>
</html>