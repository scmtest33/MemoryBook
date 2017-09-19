<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Simple Sidebar - Start Bootstrap Template</title>

<!-- Bootstrap core CSS -->
<link href="/memory/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="/memory/resources/css/simple-sidebar.css" rel="stylesheet">
<script src="/memory/resources/js/jquery-3.2.1.min.js"></script>
</head>
<script>
$("#cancleBtn").click(function (){
	location.href='/memory/index';
});

$("#menu-toggle").click(function(e){
	e.preventDefault();
	$("#wrapper").toggleClass("toggled");
});


</script>
<body>

	<h1>Profile</h1>
	<script>
		
	</script>
	<table>
		<tr>
			<td><h2>Name : </h2></td>
			<td><h2>${sessionScope.name}</h2></td>
		</tr>
		<tr>
			<td><h2>Email : </h2></td>
			<td><h2>${sessionScope.email}</h2></td>
		</tr>
		<tr>
			<td><h2>Information : </td>
			<td><h2>나만공개</h2></td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<input type="button" value="Modify" onclick="">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="Unregister" data-toggle="modal" data-target="#myModal_m">
			</td>
		</tr>
	</table>
	
	<div class="modal fade" id="myModal_m" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content" style="width:400px;margin: 0 auto;">
		        <div class="modal-header">
		        	<button type="button" class="close" id="modalClose" data-dismiss="modal">&times;</button>
		        	<br><br>
		        	<h4 class="modal-title" id="dragNoteTitle" style="text-align: center;">Memory Lane Unregister</h4>
		        	<br>
		        </div>
		        <br>
		        			        	
		        <div class="modal-body" id="unregisterModal" >
		          	
		        <form name="unregisterfrm" id="unregisterfrm" action="/memory/member/unregister" method="post">       
			    	<table id="loginInfo">
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
					    	<td id="btns" colspan="2" style="width: 368px;">
					    		<input type="submit" value="회원탈퇴" class="btn btn-default" style="width: 368px;background: #B2CCFF; margin: 0 auto;">
<!-- 							    <button id="unregisterBtn" class="btn btn-default"  style="width: 368px;background: #B2CCFF; margin: 0 auto;">회원탈퇴</button>    -->
					    	</td>
					    </tr>
					    <tr>
					    	<td id="btns" colspan="2" style="width: 368px;">
							    <div id="cancleBtn" class="btn btn-default"  style="width: 368px;background: #FFFFFF; margin: 0 auto;">취소</div>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		<!--           <div id="googleLoginDiv" align="center" class="g-signin2" data-onsuccess="onSignIn" style="width: 368px; text-align: center;"></div> -->
		        </div>
		      </div>
		    </div>
		  </div>
</body>
</html>