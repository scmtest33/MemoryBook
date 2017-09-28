<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>친구 찾기</title>
</head>

<body>
<br>
<p class="pageTitle">LOOKING FOR FRIEND</p>
<p class="pageSubTitle">친구를 찾고 추가해보세요</p>
<br>
<!-- 검색 -->
      <div class="searchInput col-md-offset">
         <div class="search-form">
                  <label for="search" class="sr-only">Search</label>
                  <input type="text" class="form-control" name="findId" id="findId" placeholder="이름 또는 Email을 입력하세요" onkeydown="javascript:if(event.keyCode == 13) searchList();">
           </div>
      </div>
      <div class="btn-default noteSearch_btn" id="findBtn" onclick="findMember();"><img src="/memory/resources/img/search_icon.jpg"></div>
	<br><br>
	<div id="panel"></div>


<script>
	//회원찾기
	function findMember() {
		$.ajax ({
			url: "/memory/member/findMember",
			type: "POST",
			data: {
				"findId" : $("input[name=findId]").val()
				},
			success : function(result) {
						$("#searched").empty();
						$("#findId").val("");
						var btn;
						$("#panel").append("<div class='panel panel-default searchResult' id='searched'></div>");
						$(result).each(function(index, item) {
							var addRow = '<table class="table table-filter">';
								addRow += '<tbody><tr>';
								addRow += '<td><div class="media">';
								addRow += '<td><a href="#" class="media-photo"><img src="/memory/data/mem_image/'+item.mem_image+'" class="media-photo img-circle"></a></td>';
								addRow += '<td><div class="media-body"><h4 class="userName" id="userName'+ index +'">'+ item.name + '</h4> <p class="userEmail" id="userEmail">'+ item.email +'</p></div></td>';
								addRow += '<td class = "addFriend">' + '<img id = addF'+index+' src = "/memory/resources/img/add.png">' + '</td>';
								addRow += '</div></td>';
								addRow += '</tr></tbody>';
								addRow += '</tr></table>';
								$("#searched").append(addRow);
							
								$("#addF"+index).click(function(){
								$.ajax({
									url: "/memory/member/addFriend",
									dataType: "json",
									type: "post",
									data: {"myEmail": '${email}', "friend_Email" : item.email},
									success: function(result){
										if(result){
											swal({
												  title: '친구등록 완료',
												  text: '친구가 추가되었습니다.',
												  type: 'success',
												  confirmButtonText: '확인'
												})	
											$("#table3").empty();
											$("#listTable").empty();
											$("#friendList").empty();
											friendList();
										}else {
											swal({
												  title: 'Error!',
												  text: '이미 등록된 친구입니다.',
												  type: 'error',
												  confirmButtonText: '확인'
												})
										}
									}
								});
							});
								
						});
						
		    		}
		});
		return false;
    };
	
</script>

</body>
</html>