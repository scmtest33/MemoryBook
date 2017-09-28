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

<title>노트 리스트</title>
</head>

<body>
	<!-- 메일보내기 Modal -->
	<div class="modal fade" id="mailModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-envelope mail_modal_title"></i> Share a
						note
					</h2>
				</div>
				<br>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;노트를 공유할 메일 주소를 입력해주세요.</p>
				<div class="modal-body">
					<div class="input-group">
						<span class="input-group-addon modal_input">
						<i class="fa fa-envelope"></i></span> <input id="email" type="text" class="form-control modal_input" name="email" placeholder="받는 사람">
					</div>
				</div>
				<div class="modal-footer">
					<div id="emailNoteSubmitBtn" class="btn btn-default"
						data-dismiss="modal">
						<i class="fa fa-share"></i>보내기
					</div>
					<div class="btn btn-default" data-dismiss="modal" onclick=mail_clear()>취소</div>
				</div>
			</div>

		</div>
	</div>

	<!-- 노트모달 -->
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<div id='titleNote' class="w3-margin w3-padding modal_detail_title"></div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div id='date' class="w3-margin w3-padding modal_detail_date"></div>
							<div id='content' class="w3-margin w3-padding modal_detail_content"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<span id='update' class="w3-margin w3-padding modal_detail_footer"> </span>
				</div>
			</div>
		</div>
	</div>
	<!-- 메인뷰 및 검색 -->
	<div id="noteView" class="viewList">
		<div class="list_title">
		<div class="deleteZone" ondrop="drop(event)" ondragover="allowDrop(event)">
		</div>
			<br>
			<p class="pageTitle">DRAG NOTE</p>
			<p class="pageSubTitle">자신만의 노트로 담아보세요!</p>
			<p class="desc_brunch">
<!-- 				<span class="part">드래그만으로 원하는 텍스트를 담아보세요.<br></span> -->
				<!-- 검색 -->
				<div class="searchInput col-md-offset">
					<div class="search-form">
		            		<label for="search" class="sr-only">Search</label>
		            		<input type="text" class="form-control" name="searchWrd" id="searchWrd" placeholder="노트 검색" onkeydown="javascript:if(event.keyCode == 13) searchList();">
		        	</div>
				</div>
		<div class="btn-default noteSearch_btn" id="noteSearch_btn" onclick="searchList();"><img src="/memory/resources/img/search_icon.jpg"></div>
		<div class="btn btn-default noteWrite_btn" id="noteWrite">노트작성</div><br>
		</div>
		<br><br><br>
		<!-- 카테고리 선택 -->
		<ul class="nav nav-tabs" id="categoryList">

		</ul>
		<div class="tab-content">
			<br>
			<br>
			<!-- 노트카드 뿌리기 -->
			<div id="noteCardList" class="noteCardList List"></div>
		</div>
	</div>
	
	<div class="noteEditor" id="noteEditor">
		<br><br><br>
		<%@ include file="noteWrite.jsp" %>
	</div>

	<!-- profile modal -->
	<div id="profileModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">설정</h4>
				</div>
				<div class="modal-body">

					<div class="container">
						<h2>이메일 설정</h2>
						<br>
						<p>보낼 이메일을 설정해주세요</p>
						<br>
						<form class="form-inline">
							<div class="form-group">
								<label for="email">Email:</label> <input type="email"
									class="form-control" id="email" placeholder="Enter email">
							</div>
							<div class="form-group">
								<label for="pwd">Password:</label> <input type="password"
									class="form-control" id="pwd" placeholder="Enter password">
							</div>
							<button type="submit" class="btn btn-default">설정</button>
						</form>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<!-- 본문내용 끝 -->

	<script>
	//노트 검색
	function searchList(){
		var searchWrd = $("#searchWrd").val();
		var memberNo = localStorage.getItem("memberNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/noteList",
			data: {"searchWrd" : searchWrd,
				   "memberNo" : memberNo
			 	},
			dataType : "json"
		})
		.done(function (result) {
			makeNoteCards(result);
			$("#searchWrd").val("");
			return false;
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '검색오류가 발생했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
		
	}

	//메일로 노트 보내기
	$("#emailNoteSubmitBtn").click(function(){
		var memberNo = localStorage.getItem("memberNo");
		var noteNo = localStorage.getItem("emailNoteNo");
		var emailTo = $("#email").val()
		$.ajax({
			type: "POST",
			url : "/memory/note/mailNote",
			data: {"noteNo" : noteNo,
				   "memberNo" : memberNo,
				   "emailTo"  : emailTo
			},
			dataType : "json"
		})
		.done(function (result) {
			swal({
				  title: '노트를 메일로 보냈습니다.',
				  type: 'success',
				  confirmButtonText: '확인'
				})		
	        $("#email").val("");
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '메일전송을 실패하였습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	})
	function saveNoteNo(noteNo){
		localStorage.setItem("emailNoteNo",noteNo);
	}
	function mail_clear(){ //취소버튼 눌렀을때 메일주소 입력란 초기화
		$("#email").val("");
	}

	//노트 디테일
	function noteDetail(noteNo){
		$.ajax({
			type: "POST",
			url : "/memory/note/noteDetail",
			data: {"noteNo" : noteNo},
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
			$("#titleNote").html("<span>[ "+ result.categoryName +" ]</span><h3>" + title +"</h3>");
			$("#date").html(time);
			$("#content").html(content);
			$("#update").html("<span class='badge quote-badge' dragNote-toggle='tooltip' title='수정'><a class='btn_modal'><i class='fa fa-eraser' dragNote-toggle='tooltip' title='수정' data-dismiss='modal' onclick='updateNote("+noteNo+");'></i></a></span>&nbsp;"
							 +"<span class='badge quote-badge' dragNote-toggle='tooltip' title='삭제'> <a class='btn_modal'><i class='fa fa-trash' dragNote-toggle='tooltip' title='삭제' data-dismiss='modal' onclick='deleteNote("+noteNo+");'></i></a></span>&nbsp;"
							 +"<span class='badge quote-badge' dragNote-toggle='tooltip' title='메일로 보내기'><a class='btn_modal'><i class='fa fa-envelope-o' dragNote-toggle='tooltip' title='메일로 보내기' data-toggle='modal' data-target='#mailModal' data-dismiss='modal' onclick='saveNoteNo("+noteNo+");'></i></a></span>&nbsp;"
							 +"<span class='badge quote-badge' dragNote-toggle='tooltip' title='다운로드'><a href='/memory/download/downloadNote?noteNo=" + noteNo +"' class='btn_modal'><i class='fa fa-download'></i></a></span></p>");
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
	
	//노트 캘린더
/*	makeCalendar();
	function makeCalendar() {
//	 	var events = [];
//	 	if (result != null) {
//	 		for (var i = 0; i < result.length; i++) {
//	 			var event = result[i];
//	 			var date = new Date(event.eventDate);
//	 			var time = date.getFullYear() + "-" 
//	 			+ (date.getMonth() + 1) + "-" 
//	 			+ date.getDate();
//	 			events.push({title: event.eventName, start: time, url: event.eventNo});
//	 		}
//	 	}
		
 	    $('#calendar').fullCalendar({
	        dayClick: function(date) {
	        	var date = date.format()
	        	$.ajax({
	        		type: "POST",
	        		url : "/memory/note/noteByDate",
	        		data: {"memberNo" : localStorage.getItem("memberNo"),
	        			   "date" : date
	        		},
	        		dataType : "json"
	        	})
	        	.done(function (result) {
	        		var html = "";
	        		for (var i = 0; i < result.length; i++) {

	        			var note = result[i];	
	        			var noteNo = note.noteNo;
	        			
	        			console.log("노트번호"+noteNo)
	        			html += " <div class='quote-box w3-margin w3-padding' ondragstart='drag(event)' draggable='true' id='note"+note.noteNo+"' >";
//	         			html += " <blockquote class='quote-box'>;
	        			html += " <p class='quotation-mark' onclick='noteDetail("+note.noteNo+")'data-toggle='modal' data-target='#detailModal' > “ </p><br> ";
	        			html += " <p class='quote-text' onclick='noteDetail("+note.noteNo+")'data-toggle='modal' data-target='#detailModal'>" + note.noteTitle +" </p>";
	        			html += " <hr>";
	        			html += " <div class='blog-post-actions'>";
	        			// 시간 뿌리기
	        			var date = new Date(note.noteRegDate);
	        			var time = date.getFullYear() + "-" 
	        			         + (date.getMonth() + 1) + "-" 
	        			         + date.getDate() + " "
	        			         + date.getHours() + ":"
	        			         + date.getMinutes() + ":"
	        			         + date.getSeconds();
	        			html += "<p class='blog-post-bottom pull-left'>"+ time +"</p>";
	        					         
	        			html += "<p class='blog-post-bottom pull-right'>";         
	        			html += "   <span class='badge quote-badge'dragNote-toggle='tooltip' title='메일로 보내기'><a href='#'><i class='fa fa-envelope-o' dragNote-toggle='tooltip' title='메일로 보내기' data-toggle='modal' data-target='#mailModal' onclick='saveNoteNo("+noteNo+");'></i></a></span>";
	        			html += "	<span class='badge quote-badge'dragNote-toggle='tooltip' title='다운로드'><a href='/memory/download/downloadNote?noteNo=" + noteNo +"'><i class='fa fa-download'></i></a></span></p>";
	        			//시간 뿌리기 끝
	        			html += "</div>";
	        			html += "</div>";
	        			
	        	
	        		}
	        		if (result.length == 0) {
	        			html += "<div class='container'>";
	        			html += "<h6>작성된 노트가 없습니다.</h6>";
	        			html += "</div>";
	        		}
	        		$("#noteList").html(html);

	        	})
	        	.fail(function(jqXhr, textStatus, errorText){
	        		swal({
	  				  title: 'Error!',
	  				  text: '노트목록 로딩을 실패했습니다.',
	  				  type: 'error',
	  				  confirmButtonText: '확인'
	  				})
	        	});
	        }
	        ,editable : false
	        ,eventLimit : true
//	         ,events: events
//	         ,eventClick: function(event) {
//	             loadEventTimeline(event.url);
//	             return false
	        
	    })
	} */
	
	//메인에 카테고리 뿌리기
	function getMainCategory(){
		var memberNo = localStorage.getItem("memberNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/getCategory",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			var html = '<li class="active"><a data-toggle="tab" onclick="mainNoteList()">전체</a></li>';
			var categoryList = result.categoryList;
			for(var i = 0; i < categoryList.length; i++){
				var category = categoryList[i];
				var categoryNo = category.categoryNo;
				html += "<li class='active' onclick='getNoteByCategoryNo("+category.categoryNo+")' ondragstart='drag(event)' draggable='true' id='category"+category.categoryNo+"' aria-expanded='false' class='category_list'>"
				html += "<a data-toggle='tab' ondblclick='categoryUpdate(event);' href='#' ondragstart='drag(event)' draggable='true' id='category"+category.categoryNo+"' style='min-width:20px;'>"+category.categoryName+"</a>";
				html += "<a data-toggle='tab' contenteditable='true' style='min-width:20px; display:none;' id='categoryUpdate"+category.categoryNo+"'>"+category.categoryName+"</a>";
				html += "</li>";
			}
			$("#categoryList").html(html);
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '카테고리 목록 생성을 실패했습니다',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}
	
	//카테고리 수정
	function categoryUpdate(event){
		var categoryToUpdate = event.target.id.substring(8); // 카테고리 고유번호 추출
		swal({
			  title: '카테고리 이름 변경',
			  text: '변경 할 새로운 카테고리명을 입력해 주세요',
			  input: 'text',
			  showCancelButton: true,
			  confirmButtonText: '확인',
			  cancelButtonText: '취소',
			  showLoaderOnConfirm: true,
			  preConfirm: function (text) {
			    return new Promise(function (resolve, reject) {
			      setTimeout(function() {
			        if (text === '') {
			          reject('카테고리명을 입력해 주세요')
			        } else {
			        	$.ajax({
			    			type: "POST",
			    			url : "/memory/note/noteCategoryUpdate",
			    			data: {"categoryNo" : categoryToUpdate, "categoryName" : text},
			    			dataType: "json",
			    			success: function () {
					    				resolve();
					    				getMainCategory();
					    				getMainCategory2();
					    			}
			    		})
			        }
			      })
			    })
			  },
			  allowOutsideClick: false
			}).then(function (text) {
			  swal({
			    type: 'success',
			    title: '카테고리 변경이 완료되었습니다.',
			  })
			})
	}

	//메인에 카테고리 별로 리스트 뿌리기
	function getNoteByCategoryNo(categoryNo){
		var categoryNo = categoryNo;
		var memberNo = localStorage.getItem("memberNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/noteCategoryList",
			data: {"memberNo" : memberNo,
				   "categoryNo" : categoryNo		
			},
			dataType : "json"
		})
		.done(function (result) {
			makeNoteCards(result);
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

	// 메인에 노트 뿌리기
	function mainNoteList() {
		var memberNo = localStorage.getItem("memberNo");
		$.ajax({
			type: "POST",
			url : "/memory/note/noteList",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			makeNoteCards(result);
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '노트목록 로딩을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}

	function makeNoteCards(result) {
		var html = "";
		for (var i = 0; i < result.length; i++) {

			var note = result[i];	
			var noteNo = note.noteNo;
			var categoryNo = note.categoryNo;
			html += "<div class='gallery' onclick='noteDetail("+note.noteNo+")' class='modal_input' ondragstart='drag(event)' draggable='true' id='note"+note.noteNo+"' data-toggle='modal' data-target='#detailModal'  >";
			// 이미지 뿌리기
			var noteContent = note.noteContent;
			if(noteContent.indexOf('<img') != -1) {
				var noteImgSrc = noteContent.split('src="')[1].split('"')[0];
				html += '<figure><img id="note'+note.noteNo+'" src="' + noteImgSrc + '" alt="" onclick="noteDetail('+note.noteNo+')" ></figure>';
			} else {
				html += '<figure><img id="note'+note.noteNo+'" src="/memory/resources/img/D.png" alt="" onclick="noteDetail('+note.noteNo+')" ></figure>';
			}
			html += "<div class='desc'><p>" + note.noteTitle + "</p></div>";
			html += "</div>";

		}
		if (result.length == 0) {
			html += "<div class='gallery'>";
			html += '	<img src="/memory/resources/img/D.png" alt="" width="300px" height="200px" >';
			html += "	<div  class='desc'><p> 노트가 없습니다. </p></div>";
			html += "</div>";
		}
		$("#noteCardList").html(html);
	}

	// 에디터 열기
	$("#noteWrite").click(function(e) {
		$('#noteView').css('display', 'none');
		$('#profileModal').css('display', 'none');
		$('#noteEditor').css('display', '');
		$('#noteUpdateBtn').css('display', 'none');
		$('#noteSubmitBtn').css('display', 'block');
    	getCategory();
		editor_chk = true;
    });
	
	function note_open() {
		$('#sideDragBar').css('display', 'none');
		$("#sideDragBar").show("slide", {direction: "left" }, 600);
		getCategory(); // 카테고리 셀렉박스에 옵션 넣기
	}

	// DB에서 카테고리 가져오기
	function getCategory(){
		var memberNo = ${memberNo};
		$.ajax({
			type: "POST",
			url : "/memory/note/getCategory",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			appendCategory(result.categoryList);
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '카테고리 목록 로딩을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}
	
	// DB에서 카테고리 가져오고 지정하기
	function setCategory(){
		var memberNo = ${memberNo};
		$.ajax({
			type: "POST",
			url : "/memory/note/getCategory",
			data: {"memberNo" : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			appendCategory(result.categoryList);
			var selcat = localStorage.getItem("selectedItem");
			console.log(localStorage.getItem("selectedItem"));
			$("#"+selcat).attr("selected", "selected");
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '카테고리 목록 로딩을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}
	
	//에디터 오픈
	function open_editor() {
		$('#noteView').css('display', 'none');
		$('#profileModal').css('display', 'none');
		$('#noteEditor').css('display', '');
		editor_chk = true;
	}

	//공개설정 옵션창 초기화
	function authInit() {
	$("#authSet").empty();
 		var addRow = "<td><label for='auth'>공개설정</label></td>";
			addRow += "<td>&nbsp;&nbsp;</td>"
        	addRow += "<td><input id='authSet' name='authSet' type='radio' value='0'> 친구랑 보기</td>"
			addRow += "<td>&nbsp;&nbsp;</td>"
			addRow += "<td><input id='authSet' name='authSet' type='radio' value='1'> 나만보기</td>" 
	$("#authSet").append(addRow);
	}
	
	function open_editorDrag() {
		$('#myDragList').css('display', 'none');
		$('#noteView').css('display', 'none');
		$('#profileModal').css('display', 'none');
		$('#noteEditor').css('display', '');
	}

	//노트 다운로드
	function downloadNote(noteNo){
		var url = "/memory/download/downloadNote?noteNo=" + noteNo;
		$("#downloadNotePath").attr("href", url);
		console.log(noteNo);
	}

	$("#downloadNotePath").click(function(){
		console.log(url);
		$("#downloadNoteModal").modal('hide');
	})

	//노트 업데이트
	function updateNote(noteNo){
		localStorage.setItem("noteNoToUpdate",noteNo);
		$('#noteUpdateBtn').css('display', 'block');
		$('#noteSubmitBtn').css('display', 'none');
		$.ajax({
			type: "POST",
			url : "/memory/note/noteDetail",
			data: {"noteNo" : noteNo},
			dataType : "json"
		})
		.done(function (result) {
			note_Chk = true;
			var title = result.noteTitle;
			var content = result.noteContent;
			var auth = result.noteAuth;
			$("input[name=noteTitle]").val(title);
			CKEDITOR.instances.ckeditor.setData(content);
			localStorage.setItem("selectedItem", "categoryNo" + result.categoryNo);
			$("#authSet").empty();
			var addRow = "<td><label for='auth'>공개설정</label></td>";
				addRow += "<td>&nbsp;&nbsp;</td>"
				if(auth == 0){
		        	addRow += "<td><input id='authSet2' name='authSet2' type='radio' value='0' checked='checked'> 친구랑 보기</td>"
					addRow += "<td>&nbsp;&nbsp;</td>"
					addRow += "<td><input id='authSet2' name='authSet2' type='radio' value='1'> 나만보기</td>"
				} else {
					addRow += "<td><input id='authSet2' name='authSet2' type='radio' value='0'> 친구랑 보기</td>"
					addRow += "<td>&nbsp;&nbsp;</td>"
					addRow += "<td><input id='authSet2' name='authSet2' type='radio' value='1' checked='checked'> 나만보기</td>"
				}
			$("#authSet").append(addRow);
			setCategory();
			open_editor();
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '에디터 로딩을 실패하였습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}

	// 노트 에디터 뿌리기
	$("#editorOpenBtn").click(function() {
		$('#noteView').css('display', 'none');
		$('#newsView').css('display', 'none');
		$("#editorView").show("slide", {direction: "left" }, 600);
		$("#editorOpenBtn").toggle();
		$("#editorCloseBtn").toggle();
	});

	// 노트 에디터 닫기
	$("#editorCloseBtn").click(function() {
		$("#editorView").hide("slide", {direction: "left" }, 700);
		$("#editorOpenBtn").toggle();
		$("#editorCloseBtn").toggle();
	});

// 노트 삭제
	function deleteNote(noteNo) {
	var noteNo = noteNo;
	var memberNo = ${memberNo};
	
	swal({
		  title: '정말 노트를 삭제하시겠습니까?',
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
			url:"/memory/note/deleteNote",
			dataType:"json",
			data: {"noteNo":noteNo},
			type: "POST"
			})
			.done(function (result){
				mainNoteList();
				mainNoteList2();
				swal({
					  title: '노트를 삭제하였습니다.',
					  type: 'success',
					  confirmButtonText: '확인'
					})
			})
			.fail(function(){
				swal({
				  title: 'Error!',
				  text: '노트 삭제를 실패하였습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
			});
		})
	}

	//카테고리 삭제
	function deleteCategory(categoryNo) {
		swal({
			  title: '정말 카테고리를 삭제하시겠습니까?',
			  text: '삭제시 해당 카테고리의 게시물도 전부 삭제됩니다.',
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
				url:"/memory/note/deleteCategory",
				dataType:"json",
				data: {"categoryNo":categoryNo},
				type: "POST"
				})
				.done(function (result){
					mainNoteList();
					getMainCategory();
					mainNoteList2();
					getMainCategory2();
					swal({
						  title: '카테고리를 삭제했습니다.',
						  type: 'success',
						  confirmButtonText: '확인'
						})
				})
				.fail(function(){
					swal({
					  title: 'Error!',
					  text: '카테고리 삭제를 실패하였습니다.',
					  type: 'error',
					  confirmButtonText: '확인'
					})
				});
			})
	}

	// 카테고리 인풋창 열기
	function showInput() {
		$('#categoryToAdd').css('display', 'block');
		$('#Category1').css('display', 'block');
		$('#Category2').css('display', 'block');
	    return false;
	}

	// 카테고리 인풋창 끄기
	function closeInput() {
		$('#categoryToAdd').css('display', 'none');
		$('#Category1').css('display', 'none');
		$('#Category2').css('display', 'none');
	    $("#categoryToAdd").val("");
	    return false;
	}

	// 카테고리 추가
	function addCategory(){
		var categoryName = $("#categoryToAdd").val();
		var memberNo = ${memberNo};
		
		if (categoryName == "") {
			swal({
				  title: 'Error!',
				  text: '카테고리명을 입력하세요',
				  type: 'error',
				  confirmButtonText: '확인'
				})
			return false;
		}
		
		$.ajax({
			type: "POST",
			url : "/memory/note/addCategory",
			data: {"categoryName" : categoryName,
					"memberNo"	  : memberNo},
			dataType : "json"
		})
		.done(function (result) {
			swal({
				  title: '카테고리등록 성공',
				  type: 'success',
				  confirmButtonText: '확인'
				})			
			appendCategory(result.categoryList);
			closeInput();
		})
		.fail(function(jqXhr, textStatus, errorText){
			swal({
				  title: 'Error!',
				  text: '카테고리등록을 실패했습니다.',
				  type: 'error',
				  confirmButtonText: '확인'
				})
		});
	}
	
	// 카테고리 셀렉박스에 옵션 추가
	function appendCategory(categoryList){
		 $("#category option").remove();
		 var addRow = "<option value='noselect'>카테고리선택</option>";
		 for(var i = 0; i < categoryList.length; i++){
				var category = categoryList[i];
				var categoryName = category.categoryName;
				var categoryNo = category.categoryNo;
				addRow += "<option value='"+categoryNo+"' id='categoryNo"+categoryNo+"'>"+categoryName+"</option>"
		}
		$("#category").append(addRow);
	}

	//Tooltip 효과
	$(document).ready(function(){
	    $('[dragNote-toggle="tooltip"]').tooltip();   
	});
    </script>
</body>
</html>