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
	<!-- Modal -->
	<div class="modal fade" id="myModal_drag" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-envelope" class="mail_modal_title"></i> Share a
						drag
					</h2>
				</div>
				<br>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;드래그를 공유할 메일 주소를 입력해주세요.</p>
				<div class="modal-body">
					<div class="input-group">
						<div class="input-group-addon modal_input">
							<i class="fa fa-envelope modal_input"></i>
						</div>
						<input id="email_drag" type="text" class="form-control modal_input" name="email_drag" placeholder="받는 사람">
					</div>
				</div>
				<div class="modal-footer">
					<div id="emailDragSubmitBtn" class="btn btn-default"
						data-dismiss="modal">
						<i class="fa fa-share"></i>보내기
					</div>
					<div class="btn btn-default" data-dismiss="modal" onclick=mail_clear()>취소</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="downloadDragModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">

				<div class="modal-body">
					<h1>[드래그 다운로드]</h1>
					<br>
					<h2>드래그를 다운로드 하겠습니까?</h2>
					<br> <a id="downloadDragPath" class="btn btn-default">다운로드</a>
					<input type="button" class="btn btn-default" data-dismiss="modal">취소
				</div>
			</div>
		</div>
	</div>


	<!-- 드래그모달 -->
	<div class="modal fade" id="detailModal_drag" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<div aria-hidden="true">&times;</div><div class="sr-only">Close</div>
					</button>
					<div id='title_drag' class="w3-margin w3-padding modal_detail_title"></div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div id='date_drag' class="w3-margin w3-padding modal_detail_date"></div>
							<div id='content_drag' class="w3-margin w3-padding modal_detail_content"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div id='update_drag' class="w3-margin w3-padding modal_detail_footer"> </div>
				</div>
			</div>
		</div>
	</div>

	<!-- 메인뷰 -->
	<div id="dragView" class="viewList">
		<!-- 검색 -->
		<div class="list_title">
		<div class="deleteZone" ondrop="drop(event)" ondragover="allowDrop(event)">
		</div>
			<br>
			<h3 class="tit_brunch">드래그 리스트</h3>
			<p class="desc_brunch">
				<div class="part">드래그를 공유해 보세요.<br></div>
				<div class="part">
					<div class="col-md-4 col-md-offset search_window">
						<div action="" class="search-form">
							<div class="form-group has-feedback"
								onkeydown="javascript:if(event.keyCode == 13) searchList_drag();">
								<label for="search" class="sr-only">Search</label>
									<input type="text" class="form-control" name="searchWrd"
									id="searchWrd" placeholder="드래그 검색">
									<div class="glyphicon glyphicon-search form-control-feedback"></div>
							</div>
						</div>
					</div>
				</div>
		</div>
		<br><br><br>
			<!-- 드래그내용 뿌리기 -->
		</div>
		<div id="dragView" class="cardList"></div>
	<!-- 본문내용 끝 -->

	<script>
	//드래그 검색
	function searchList_drag(){
		var searchWrd = $("#searchWrd").val();
		var memberNo = ${memberNo};
		$.ajax({
			type: "POST",
			url : "/memory/drag/dragList",
			data: {"searchWrd" : searchWrd,
				   "memberNo" : memberNo
			 	},
			dataType : "json"
		})
		.done(function (result) {
			makeDragCards(result);
			$("#searchWrd").val("");
			return false;
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
		
	}

	//메일로 드래그 보내기
	$("#emailDragSubmitBtn").click(function(){
		var memberNo = localStorage.getItem("memberNo");
		var dragNo = localStorage.getItem("emailDragNo");
		var emailTo = $("#email_drag").val()
		$.ajax({
			type: "POST",
			url : "/memory/drag/mailDrag",
			data: {"dragNo" : dragNo,
				   "memberNo" : memberNo,
				   "emailTo"  : emailTo
			},
			dataType : "json"
		})
		.done(function (result) {
			alert(result.msg, "success");
	        $("#email_drag").val("");
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	})
	function saveDragNo(dragNo){
		localStorage.setItem("emailDragNo",dragNo);
	}
	function mail_clear(){ //취소버튼 눌렀을때 메일주소 입력란 초기화
		$("#email").val("");
	}

	//드래그 디테일
	function dragDetail(dragNo){
		$.ajax({
			type: "POST",
			url : "/memory/drag/dragDetail",
			data: {"dragNo" : dragNo},
			dataType : "json"
		})
		.done(function (result) {
			var title = result.dragUrlTitle;
			var content = result.dragContent;
			// 시간 뿌리기
			var date = new Date(result.dragRegDate);
			var time = date.getFullYear() + "-" 
			         + (date.getMonth() + 1) + "-" 
			         + date.getDate() + " "
			         + date.getHours() + ":"
			         + date.getMinutes() + ":"
			         + date.getSeconds();
			var time2 = date.getFullYear() + "-" 
			         + (date.getMonth() + 1) + "-" 
			         + date.getDate();         
			//시간뿌리기 끝
//	 		document.getElementById("dragView").style.display = "block";
			$("#title_drag").html("<div>[ 드래그 데이터  "+time2+" ]</div><h3>" + title +"</h3>");
			$("#date_drag").html(time);
			$("#content_drag").html(content);
			$("#update_drag").html("<div class='badge quote-badge' dragNote-toggle='tooltip' title='수정'> <a href='#' class='btn_modal'><i class='fa fa-eraser' dragNote-toggle='tooltip' title='수정' data-dismiss='modal' onclick='updateDrag("+dragNo+");'></i></a></div>&nbsp;<div class='badge quote-badge' dragNote-toggle='tooltip' title='삭제'> <a href='#' class='btn_modal'><i class='fa fa-trash' dragNote-toggle='tooltip' title='삭제' data-dismiss='modal' onclick='deleteDrag("+dragNo+");'></i></a></div>&nbsp;<div class='badge quote-badge'dragNote-toggle='tooltip' title='메일로 보내기'> <a href='#' class='btn_modal'><i class='fa fa-envelope-o' dragNote-toggle='tooltip' title='메일로 보내기' data-toggle='modal' data-target='#myModal_drag' data-dismiss='modal' onclick='saveDragNo("+dragNo+");'></i></a></div>&nbsp;<div class='badge quote-badge' dragNote-toggle='tooltip' title='다운로드'><a href='/memory/download/downloadDrag?dragNo=" + dragNo +"' class='btn_modal'><i class='fa fa-download'></i></a></div></p>");
//	 		document.getElementById("editorBtnDiv").style.display = "none";
			
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}
		
	// 메인에 드래그 뿌리기
	function mainDragList() {
		var memberNo = localStorage.getItem("memberNo");
		$.ajax({
			type: "POST",
			url : "/memory/drag/dragList",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			makeDragList(result);
			makeDragCards(result);
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}
	
	// 드래그리스트 자료 가져오기
	function makeDragList() {
		var memberNo = ${memberNo};
		$.ajax({
			type: "POST",
			url : "/memory/drag/dragList",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			var html = "";
			for (var i = 0; i < result.length; i++) {
				var drag = result[i];	
				var dragNo = drag.dragNo;
				console.log("드래그번호"+dragNo)
				html += " <div class='dragList' ondragstart='drag(event)' draggable='true' id='drag"+drag.dragNo+"' onclick='dragDetail("+drag.dragNo+")'data-toggle='modal' data-target='#detailModal_drag'>";
				html += " <div class='dragTitle'>" + drag.dragUrlTitle +" </div>";
				html += " <hr>";
				html += " <div class='dragContent'>" + drag.dragContent +" </div>";
				// 시간 뿌리기
				var date = new Date(drag.dragRegDate);
				var time = date.getFullYear() + "-" 
				         + (date.getMonth() + 1) + "-" 
				         + date.getDate() + " "
				         + date.getHours() + ":"
				         + date.getMinutes() + ":"
				         + date.getSeconds();
				html += "<div class='dragFooter'>"+ time +"</div>";
				//시간 뿌리기 끝
				html += "</div>";
				html += "</div>";
			}
			if (result.length == 0) {
				html += "<div class='container'>";
				html += "<h6>등록 된 드래그가 없습니다.</h6>";
				html += "</div>";
			}
			$("#dragList").html(html);
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
	}
	
	//드래그 리스트 생성
	function makeDragListAll(result) {
		var html = "";
    	for (var i = 0; i < result.length; i++) {

    		var drag = result[i];	
    		var dragNo = drag.dragNo;
    		
    		html += "<div class='dragList' ondragstart='drag(event)' draggable='true' id='drag"+ drag.dragNo+"'  >";
    		html += "<p class='quotation-mark1' id='drag"+ drag.dragNo+"'> “ </p> ";
    		html += "<br>";
    		html += "<br>";
    		html += "<div class='quote-text quote-text-content' id='drag"+ drag.dragNo+"'>";
    		html += "		<p id='drag"+ drag.dragNo+"'>" + drag.dragContent.replace("amp;", "&") + "</p><br>";
    		html += "</div>";
    		html += " <hr>";
    		html += " <div class='blog-post-actions'>";
    		// 시간 뿌리기
    		var date = new Date(drag.dragRegDate);
    		var time = date.getFullYear() + "-" 
    		         + (date.getMonth() + 1) + "-" 
    		         + date.getDate() + " "
    		         + date.getHours() + ":"
    		         + date.getMinutes() + ":"
    		         + date.getSeconds();
    		html += "<p class='blog-post-bottom'>"+ time +"</p>";
    		if(drag.dragUrlTitle != null){
    			html += "<p class='blog-post-bottom pull-left' class='drag_URL'>출처 : "+ drag.dragUrlTitle +"</p>";
    		}else {
    			html += "<p class='blog-post-bottom pull-left' class='drag_URL'>출처 : 알 수 없음</p>";
    		}
    		html += "</div>";
    		//시간 뿌리기 끝
    		html += "</div>";
    	}
    	if (result.length == 0) {
    		html += "<div class='w3-container w3-card-2 w3-white w3-round w3-margin w3-padding'>";
    		html += "<h6>드래그가 없습니다.</h6>";
    		html += "</div>";
    	}
		$("#dragList").html(html);
	}
	
	//드래그 다운로드
	function downloadDrag(dragNo){
		var url = "/memory/download/downloadDrag?dragNo=" + dragNo;
		$("#downloadDragPath").attr("href", url);
	}

	$("#downloadDragPath").click(function(){
		$("#downloadDragModal").modal('hide');
	})

	//드래그 내용 수정 및 수정내용을 노트에 등록
	function updateDrag(dragNo){
		localStorage.setItem("dragNoToUpdate",dragNo);
    	document.getElementById("noteUpdateBtn").style.display = "block";
		document.getElementById("noteSubmitBtn").style.display = "none"
		$.ajax({
			type: "POST",
			url : "/memory/drag/dragDetail",
			data: {"dragNo" : dragNo},
			dataType : "json"
		})
		.done(function (result) {
			var title = result.noteTitle;
			var content = result.noteContent;
			$("input[name=noteTitle]").val(title);
			$(".nicEdit-main").html(content);
			localStorage.setItem("selectedItem", "categoryNo" + result.categoryNo);
			getCategory();
			open_editor();
		})
		.fail(function(jqXhr, textStatus, errorText){
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		});
		
	}

	// 드래그 삭제
	function deleteDrag(dragNo) {
		var dragNo = dragNo;
		var memberNo = ${memberNo};
		
		var del_chk;
		del_chk = confirm("정말 드래그를 삭제하시겠습니까?");
		
		if (del_chk) {
			$.ajax({
				url:"/memory/drag/deleteDrag",
				dataType:"json",
				data: {"dragNo":dragNo},
				type: "POST"
				}).done(function (result){
					alert(result.msg,'success');
					makeDragList();
					mainDragList();
			});
		}
	}
    </script>
</body>
</html>