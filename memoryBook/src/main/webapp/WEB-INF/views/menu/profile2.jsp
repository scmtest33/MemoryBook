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
<div id="memberProfile">
	<h1>Profile</h1>
	<table>
		<tr>
			<td id="getImage"></td>
		</tr>
		<tr>
			<td><h2>Name :</h2></td>
			<td><h2>${name}</h2></td>
		</tr>
		<tr>
			<td><h2>Email :</h2></td>
			<td><h2>${email}</h2></td>
		</tr>
		<tr>
			<td><h2>My Information :</h2></td>
			<td><c:if test="${infoNumber==0}">
					<h2>전체 공개</h2>
				</c:if> <c:if test="${infoNumber==1}">
					<h2>나만 공개</h2>
				</c:if></td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<button id="memberModify">Modify</button>
			</td>
		</tr>
		<tr>
			<td>
				<button data-toggle="modal" data-target="#myModal_Unregister">Unregister</button>
			</td>
		</tr>
	</table>

	<!-- 탈퇴 모달 -->
	<div class="modal fade" id="myModal_Unregister" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content memberOut">
				<div class="modal-header">
					<button type="button" class="close" id="modalClose"
						data-dismiss="modal">&times;</button>
					<br>
					<br>
					<h4 class="modal-title outTitle" id="unregisterTitle">Memory
						Lane Unregister</h4>
					<br>
				</div>
				<br>

				<div class="modal-body" id="unregisterBody">

					<form name="unregisterfrm" id="unregisterfrm"
						action="/memory/member/unregister" method="post">
						<table>
							<tr>
								<div class="form-group">
									탈퇴하실려면 비밀번호를 입력하세요.<br>탈퇴시 작성하신 노트,드래그,친구정보가 전부 삭제됩니다.
								</div>
							</tr>
							<tr>
								<div class="form-group">
									<label for="loginPassword">Password:</label> <input
										type="password" class="form-control" id="mem_pwd"
										name="mem_pwd" placeholder="비밀번호를 다시 입력해주세요"
										required="required" />
								</div>
							</tr>
							<tr>
								<td id="btns" colspan="2"><input type="submit" value="회원탈퇴"
									class="btn btn-default memberOut_btns out_ok"></td>
							</tr>
							<tr>
								<td id="btns" colspan="2">
									<button class="btn btn-default memberModify_btns Modify_no"
										id="cancelBtn2" data-dismiss="modal">취소</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
	<div id="memberEdit">
		<%@ include file="profile_edit.jsp" %>
	</div>
</body>
<script>
	$(function() {
		$("#getImage").html("<img id='profile_img' class='profile_img' src='/memory/data/mem_image/${mem_image}'>");
	});
	
	$("#memberModify").click(function (){
		$('#memberProfile').css('display', 'none');
		$('#memberEdit').css('display', '');
	}); 

	//비밀번호 확인
	$("#pwd2").on("keyup", function() {
		var mo = document.infoModify;
		var pw1 = mo.pwd1.value;
		var pw2 = mo.pwd2.value;
		if (pw1 != pw2) {
			$('#checkPwd').css('color', 'red');
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
		} else {
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
			type : "POST",
			url : "/memory/member/upload",
			data : data,
			processData : false,
			contentType : false,
			success : function(result) {
					if (result == "error") {
						alert("이미지 파일이 아닙니다.");
						} else if (result == "IOException") {
							alert("업로드 실패");
						} else {
							$("#getImage").html("<img id='profile_img' class='profile_img' src='/memory/data/mem_image/"+result+"'>");
						}
					},
					error : function(jqXhr, textStatus, errorText) {
						alert("오류: " + errorText + "<br>" + "오류코드: " + status);
					}
		});
	}
</script>
</html>