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

<title>드래그 리스트</title>
</head>

<body>
	<!-- 이메일 보내기 Modal -->
	<div class="modal fade" id="mailModal_drag" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-envelope" class="mail_modal_title"></i> Share a drag
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

	<!-- 드래그 읽기 모달 -->
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
		<div class="list_title">
		<div class="deleteZone" ondrop="drop(event)" ondragover="allowDrop(event)">
		</div>
			<br>
			<p class="pageTitle">${name}님이 드래그한 드래그 리스트</p>
			<p class="pageSubTitle">${name}님이 걸어온 길을 공유해 보세요</p>
		</div>
		<br><br>
		</div>
		<!-- 드래그내용 뿌리기 -->
		<div id="dragList" class="cardList"></div>
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
			swal({
				  title: 'Error!',
				  text: '오류코드: ' + status,
				  type: 'error',
				  confirmButtonText: '확인'
				})
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
			swal({
				  title: 'Error!',
				  text: '오류코드: ' + status,
				  type: 'error',
				  confirmButtonText: '확인'
				})
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
			$("#title_drag").html("<div>[ 드래그 데이터  "+time2+" ]</div><h3>" + title +"</h3>");
			$("#date_drag").html(time);
			$("#content_drag").html(content);
			$("#update_drag").html("<div class='badge quote-badge' dragNote-toggle='tooltip' title='수정'><a href='' class='btn_modal'><i class='fa fa-eraser' dragNote-toggle='tooltip' title='수정' data-dismiss='modal' onclick='updateDrag("+dragNo+");'></i></a></div>&nbsp;"
								  +"<div class='badge quote-badge' dragNote-toggle='tooltip' title='삭제'><a href='' class='btn_modal'><i class='fa fa-trash' dragNote-toggle='tooltip' title='삭제' data-dismiss='modal' onclick='deleteDrag("+dragNo+");'></i></a></div>&nbsp;"
								  +"<div class='badge quote-badge'dragNote-toggle='tooltip' title='메일로 보내기'><a href='' class='btn_modal'><i class='fa fa-envelope-o' dragNote-toggle='tooltip' title='메일로 보내기' data-toggle='modal' data-target='#myModal_drag' data-dismiss='modal' onclick='saveDragNo("+dragNo+");'></i></a></div>&nbsp;"
								  +"<div class='badge quote-badge' dragNote-toggle='tooltip' title='다운로드'><a href='/memory/download/downloadDrag?dragNo=" + dragNo +"' class='btn_modal'><i class='fa fa-download'></i></a></div></p>");
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '로드실패 또는 이미 삭제 된 내용입니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
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
			swal({
				  title: 'Error!',
				  text: '리스트 생성을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
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
			swal({
				  title: 'Error!',
				  text: '자료 읽기를 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
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
		$('#noteUpdateBtn').css('display', 'block');
		$('#noteSubmitBtn').css('display', 'none');
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
			CKEDITOR.instances.ckeditor.setData(content);
			getCategory();
			open_editorDrag();
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '노트 등록을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}

	// 드래그 삭제
 	function deleteDrag(dragNo) {
		var dragNo = dragNo;
		var memberNo = ${memberNo};
		
		swal({
			  title: '정말 드래그를 삭제하시겠습니까?',
			  text: '삭제 후에는 복구하실 수 없습니다.',
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '네',
			  cancelButtonText: '아니오',
			  confirmButtonClass: 'swal2-confirm btn btn-success',
			  cancelButtonClass: 'swal2-cancel btn btn-danger',
			  buttonsStyling: false
		}).then(function () {
				$.ajax({
					url:"/memory/drag/deleteDrag",
					dataType:"json",
					data: {"dragNo":dragNo},
					type: "POST",
					success: function (result){
						swal("삭제 완료", result.msg,'success');
						makeDragList();
						mainDragList();
						},
					error: swal({
						  title: 'Error!',
						  text: '드래그데이터 삭제를 실패하였습니다.',
						  type: 'error',
						  confirmButtonText: '확인'
						})
				});
			})
	}
    </script>
</body>
</html>