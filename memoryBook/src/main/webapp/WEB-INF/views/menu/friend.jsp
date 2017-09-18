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

<title>Simple Sidebar - Start Bootstrap Template </title>

<script src="/memory/resources/js/jquery-3.2.1.min.js"></script>
<script src='/memory/resources/js/fullcalendar-3.2.0/lib/moment.min.js'></script>
<script src='/memory/resources/js/fullcalendar-3.2.0/fullcalendar.js'></script>
</head>

<body>
<table>
	<tr id="friendList" >
	</tr>
</table>
<br>
<br>
	<!-- 메인뷰 및 검색 -->
	<div id="noteView" style="z-index: 7;" >
		<!-- 카테고리 선택 -->
		<ul class="nav nav-tabs" id="fNoteCategoryList">

		</ul>
		<div class="tab-content">
			<br>
			<br>
			
			<!-- 노트카드 뿌리기 -->
			<div id="fNoteCardList" style='position: relative; width: 100%; height: 500px;'>
			
			</div>
		</div>
	</div>
	<!-- 본문내용 끝 -->

	<script>
	//노트 검색
	$(function(){
		friendList();
	});
	
	
	//내 친구 목록 불러오기
function friendList(){
		$.ajax ({
			url: "/memory/member/getFriendList",
			type: "POST",
			success : function(result){
				$(result).each(function(index, item) {
					var addRow  = '<td id="fname'+index+'">'+item.name+'<td>'+"&nbsp;"+'</td>';
					$("#friendList").append(addRow);
					$("#fname"+index).click(function(){
						$("#fNoteCategoryList").empty(); 
						$("#fNoteCardList").empty(); 
						$.ajax({
							url: "/memory/member/getFriendmemNo",
							dataType: "json",
							type: "post",
							data: {"email": item.friend_Email},
							success: function(result){
								localStorage.setItem("friendNo",result);
								var friendNo = localStorage.getItem("friendNo");
								getMainFriendCategory();
								mainFriendNoteList();
							}
						});
				
					});
				})
			}
		})
	}
	//메인에 카테고리 뿌리기
	function getMainFriendCategory(){
		var friendNo = localStorage.getItem("friendNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/getFriendCategory",
			data: {"friendNo" : friendNo},
			dataType : "json"
		})
		.done(function (result) {
			var html = '<li class="active"><a data-toggle="tab" onclick="mainFriendNoteList()">전체</a></li>';
			var friendCategory = result.friendCategory;
			for(var i = 0; i < friendCategory.length; i++){
				var friendCategory = friendCategory[i];
				var friendCategoryNo = friendCategory.categoryNo;
				html += "<li class='active' onclick='getNoteByFriendrCategoryNo("+friendCategory.categoryNo+")' ondragstart='drag(event)' draggable='true' id='category"+friendCategory.categoryNo+"' aria-expanded='false' style='min-width:20px;'>"
				html += "<a data-toggle='tab' ondblclick='categoryUpdate(event);' href='#' ondragstart='drag(event)' draggable='true' id='category"+friendCategory.categoryNo+"' style='min-width:20px;'>"+friendCategory.categoryName+"</a>";
				html += "<a data-toggle='tab' contenteditable='true' style='min-width:20px; display:none;' id='categoryUpdate"+friendCategory.categoryNo+"'>"+friendCategory.categoryName+"</a>";
				html += "</li>";
			}
			$("#fNoteCategoryList").html(html);
			
			getFriendCategory();
			
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}
	

	//메인에 카테고리 별로 리스트 뿌리기
	function getNoteByFriendrCategoryNo(categoryNo){
		var friendCategory = categoryNo;
		var friendNo = localStorage.getItem("friendNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/freindNoteCartegoryList",
			data: {"friendNo" : friendNo,
				   "friendCategory" : friendCategory		
			},
			dataType : "json"
		})
		.done(function (result) {
			makeFriendNoteCards(result);
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}

	// 메인에 노트 뿌리기
	function mainFriendNoteList() {
		var friendNo = localStorage.getItem("friendNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/friendNoteList",
			data: {"friendNo" : friendNo},
			dataType : "json"
		})
		.done(function (result) {
			makeFriendNoteCards(result);
			getFriendCategory();
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}

	function makeFriendNoteCards(result) {
		var html = "";
		for (var i = 0; i < result.length; i++) {

			var friendNote = result[i];	
			var friendNoteNo = friendNote.noteNo;
			var friendcategoryNo = friendNote.categoryNo;
			html += "<div class='gallery' onclick='noteDetail("+friendNote.noteNo+")' style='box-shadow: 1px 2px 5px #bbb;' ondragstart='drag(event)' draggable='true' id='note"+friendNote.noteNo+"' data-toggle='modal' data-target='#detailModal'  >";
			// 이미지 뿌리기
			var friendNoteContent = friendNote.noteContent;
			if(friendNoteContent.indexOf('<img') != -1) {
				var friendnoteImgSrc = friendNoteContent.split('src="')[1].split('"')[0];
				html += '<figure><img id="note'+ friendNote.noteNo+'" src="' +  friendNoteImgSrc + '" alt="" onclick="noteDetail('+ friendNote.noteNo+')" ></figure>';
			} else {
				html += '<figure><img id="note'+ friendNote.noteNo+'" src="/memory/resources/img/D.png" width="180" height="140" alt="" onclick="noteDetail('+ friendNote.noteNo+')" ></figure>';
			}
			html += "	<div  class='desc'><p>" +  friendNote.noteTitle + "</p></div>";
			html += "</div>";

		}
		if (result.length == 0) {
			html += "<div class='gallery'>";
			html += '	<img src="/memory/resources/img/D.png" alt="" width="300px" height="200px" >';
			html += "	<div  class='desc'><p> 노트가 없습니다. </p></div>";
			html += "</div>";
		}
		$("#fNoteCardList").html(html);
	}


	// DB에서 카테고리 가져오기
	function getFriendCategory(){
		var friendNo = localStorage.getItem("friendNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/getFriendCategory",
			data: {"friendNo" : friendNo},
			dataType : "json"
		})
		.done(function (result) {
			appendCategory(result.friendCategory);
			var selcat = localStorage.getItem("selectedItem");
			$("#"+selcat).attr("selected", "selected");
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}
    </script>
</body>
</html>