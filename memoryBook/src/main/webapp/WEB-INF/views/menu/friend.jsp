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

	<!-- 노트모달 -->
	<div class="modal fade" id="friendDetailModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<div id='friendTitle' class="w3-margin w3-padding modal_detail_title"></div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div id='friendDate' class="w3-margin w3-padding modal_detail_date"></div>
							<div id='friendContent' class="w3-margin w3-padding modal_detail_content"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<span id='update' class="w3-margin w3-padding modal_detail_footer"> </span>
				</div>
			</div>
		</div>
	</div>
	

<!-- 친구리스트 -->
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
	

//노트 디테일
function friendNoteDetail(friendNoteNo){
	$.ajax({
		type: "POST",
		url : "/memory/note/noteDetail",
		data: {"noteNo" : friendNoteNo},
		dataType : "json"
	})
	.done(function (result) {
		var title = result.noteTitle;
		var content = result.noteContent;
		// 시간 뿌리기
		var date = new Date(result.noteRegDate);
		var time = date.getFullYear() + "-" 
		         + (date.getMonth() + 1) + "-" 
		         + date.getDate() + " "
		         + date.getHours() + ":"
		         + date.getMinutes() + ":"
		         + date.getSeconds();
		//시간 뿌리기 끝
		$("#friendTitle").html("<span>[ "+ result.categoryName +" ]</span><h3>" + title +"</h3>");
		$("#friendDate").html(time);
		$("#friendContent").html(content);
		
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status+"1");
	});
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
				var friendCategoryNo = friendCategory[i].categoryNo;
				var friendCategoryName = friendCategory[i].categoryName;
				html += "<li class='active' onclick='getNoteByFriendrCategoryNo("+friendCategoryNo+")' ondragstart='drag(event)' draggable='true' id='category"+friendCategoryNo+"' aria-expanded='false' style='min-width:20px;'>"
				html += "<a href='#' ondragstart='drag(event)' draggable='true' id='category"+friendCategoryNo+"' style='min-width:20px;'>"+friendCategoryName+"</a>";
				html += "<a style='min-width:20px; display:none;' id='categoryUpdate"+friendCategoryNo+"'>"+friendCategoryName+"</a>";
				html += "</li>"; 
			}
			$("#fNoteCategoryList").html(html);
			
			getFriendCategory();
			
		})
		.fail(function(jqXhr, textStatus, errorText){
			//alert("오류: " + errorText + "<br>" + "오류코드: " + status+"2"); 초기 친구노트 에러
		});
	}
	

	//메인에 카테고리 별로 리스트 뿌리기
	function getNoteByFriendrCategoryNo(friendCategoryNo){
		var friendCategoryNo = friendCategoryNo;
		var friendNo = localStorage.getItem("friendNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/freindNoteCartegoryList",
			data: {"friendNo" : friendNo,
				   "friendCategoryNo" : friendCategoryNo		
			},
			dataType : "json"
		})
		.done(function (result) {
			makeFriendNoteCards(result);
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status+"3");
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
			//alert("오류: " + errorText + "<br>" + "오류코드: " + status+"4"); 초기 친구노트 에러
		});
	}

	function makeFriendNoteCards(result) {
		var html = "";
		for (var i = 0; i < result.length; i++) {
			var friendNote = result[i];	
			var friendNoteNo = friendNote.noteNo;
			var friendcategoryNo = friendNote.categoryNo;
			
			html += "<div class='gallery' onclick='friendNoteDetail("+friendNoteNo+")' style='box-shadow: 1px 2px 5px #bbb;' ondragstart='drag(event)' draggable='true' id='note"+friendNoteNo+"' data-toggle='modal' data-target='#friendDetailModal'  >";
			// 이미지 뿌리기
			var friendNoteContent = friendNote.noteContent;
			if(friendNoteContent.indexOf('<img') != -1) {
				var friendNoteImgSrc = friendNoteContent.split('src="')[1].split('"')[0];
				html += '<figure><img id="note'+ friendNoteNo+'" src="' +  friendNoteImgSrc + '" alt="" onclick="friendNoteDetail('+ friendNoteNo+')" ></figure>';
			} else {
				html += '<figure><img id="note'+ friendNoteNo+'" src="/memory/resources/img/D.png" width="180" height="140" alt="" onclick="friendNoteDetail('+ friendNoteNo+')" ></figure>';
			}
			html += "<div class='desc'><p>" +  friendNote.noteTitle + "</p></div>";
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
			alert("오류: " + errorText + "<br>" + "오류코드: " + status+"5");
		});
	}
    </script>
</body>
</html>