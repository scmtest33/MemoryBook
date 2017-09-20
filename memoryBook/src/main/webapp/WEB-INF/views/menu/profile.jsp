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
<title>Profile</title>
</head>
<body>
	<h1>Profile</h1>
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
				<input type="button" value="Modify" data-toggle="modal" data-target="#myModal_Modify">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="Unregister" data-toggle="modal" data-target="#myModal_Unregister">
			</td>
		</tr>
	</table>
	
	
	<div class="modal fade" id="myModal_Modify" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- 회원정보수정 Modal-->
		      <div class="modal-content memberModify">
		        <div class="modal-header">
		        	<button type="button" class="close" id="modalClose" data-dismiss="modal">&times;</button>
		        	<br><br>
		        	<h4 class="modal-title modifyTitle" id="modifyTitle">Memory Lane Modify</h4>
		        	<br>
		        </div>
		        <br>
		        			        	
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
			    			 <label for="password">password:</label>
			    			 <input type="password" class="form-control" id="pwd1" name="pwd1" placeholder="비밀번호를 입력하세요" required="" autofocus="" />
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			 <label for="passwordConf">password:</label>
			    			 <input type="password" class="form-control" id="pwd2" name="pwd2" placeholder="비밀번호를 확인하세요" required="" autofocus="" />
			    			 <span id="checkPwd"></span>
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
			    			<label for="infomation">Infomation</label><br>
			    			<input id="gender" name="gender" type="radio" value="0"> 전체 공개 &nbsp&nbsp&nbsp
							<input id="gender" name="gender" type="radio" value="1"> 나만 공개
							</div>   		
			    		</tr>
					    <tr>
					    	<td id="btns" colspan="2">
					    		<input type="submit" value="수정" class="btn btn-default memberModify_btns Modify_ok">
					    	</td>
					    </tr>
					    <tr>
					    	<td id="btns" colspan="2">
							    <div id="cancleBtn1" class="btn btn-default memberModify_btns Modify_no">취소</div>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		        </div>
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
					    	<td id="btns" colspan="2"">
					    		<input type="submit" value="회원탈퇴" class="btn btn-default memberOut_btns out_ok">
					    	</td>
					    </tr>
					    <tr>
					    	<td id="btns" colspan="2"">
							    <div id="cancleBtn2" class="btn btn-default memberOut_btns out_no">취소</div>
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

</script>
</html>