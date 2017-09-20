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
<title>노트 작성</title>
<script src="/memory/resources/js/ckeditor/ckeditor.js"></script>
</head>

<body>
	<!-- 에디터 -->
	<div id="editorView" class="editorView">
		<div>
			<br>
			<p class="pageTitle">노트 작성</p>
			<p class="pageSubTitle">편집창 아래 드래그 박스에서 원하는 항목을 클릭하여 노트를 작성해보세요</p>
		</div>

		<!-- 입력창 -->
		<div class="editor">
			<br>
			<form name="noteFrm" id="noteFrm" method="POST"	enctype="multipart/form-data">
				<table class='pull-left'>
					<tr>
						<td><label for="category">카테고리</label></td>
						<td>&nbsp;&nbsp;</td>
						<td><select name="category" id="category"
							class="form-control">
						</select></td>
						<td>&nbsp;&nbsp;</td>
						<td><i class="fa fa-plus-circle w3-xlarge cate_close_btn"
							onclick="showInput();" class="cate_open_btn"></i></td>
						<td>&nbsp;&nbsp;</td>
						<td><input type="text" id="categoryToAdd"
							name="categoryToAdd" class="cate_btn_add" /></td>
						<td>&nbsp;&nbsp;</td>
						<td><i id="Category1" class="fa fa-check-circle w3-xlarge cate_btns" onclick="addCategory();"></i>
						</td>
						<td>&nbsp;&nbsp;</td>
						<td><i id="Category2" class="fa fa-times-circle w3-xlarge cate_btns" onclick="closeInput();"></i>
						</td>
					</tr>
				</table>
				<br> <br>
				<table>
					<tr>
						<td><input type="text" id="noteTitle" name="noteTitle"
							class="noteTitle" placeholder="제목을 입력하세요" /></td>
					</tr>
					<tr>
						<td><textarea class="ckeditor" id="ckeditor" name="ckeditor"></textarea></td>
					</tr>
				</table>
				<br>
				<div class="btn btn-default editor_btns editor_btns_hide" id="listSW">드래그List</div>
				<table class="pull-right editor_space">
					<tr>
						<td class="btn_space">
							<div class="btn btn-default editor_btns"
								id="noteSubmitBtn">저장</div>
						</td>
						<td class="btn_space">
							<div class="btn btn-default editor_btns editor_btns_hide"
								id="noteUpdateBtn">수정</div>
						</td>
						<td class="btn_space">
							<div class="btn btn-default editor_btns editor_btns_hide" 
								id="cancelBtn">취소</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="editorDraglist" class="w3-sidebar w3-round sideDragBar">
			<div class="sideDragBar_title">
				<i class="fa fa-inbox w3-xlarge"></i> DRAGS
			</div>
			<div id="dragList_editor"></div>
		</div>
	</div>
	<!-- 본문내용 끝 -->

	<script>
	// 글 쓰기/수정 로직 외 카테고리,리스트,삭제 등의 로직은 note.jsp에 있습니다. (로직은 note.jsp와 연동됩니다)
	
	// 노트 등록
	$("#noteSubmitBtn").click(function() {
		var frm = document.noteFrm;
		if (frm.noteTitle.value == "") {
			alert("제목을 입력하세요.");
			frm.noteTitle.focus();
			return false;
		}
		if (frm.category.value == "") {
			alert("카테고리를 선택하세요.",'success');
			return false;
		}
//	 	if (!confirm("노트를 등록하시겠습니까?"))
//	 		return;

		var memNo = ${memberNo};
		var editor = CKEDITOR.instances.ckeditor.getData();
		
		$.ajax({
			url : "/memory/note/note",
			type : "POST",
			data : {"memberNo" : memNo, "noteTitle" : $("input[name=noteTitle]").val(), "noteContent" : editor, "categoryNo" : $("#category").val()},
		})
		.done(function (result) {
			alert(result.msg, "success");
			mainNoteList();
			$("input[name=noteTitle]").val("");
			CKEDITOR.instances.ckeditor.setData("");
			main_open();
			console.log("정상작동");
			editor_chk = false;
		})
		.fail(function (jqXhr, textStatus, errorText) {
			alert("오류 : " + errorText);
		});
		
		return false;
	});
	
	// 노트 수정
	$("#noteUpdateBtn").click(function() {
		var frm = document.noteFrm;
		if (frm.noteTitle.value == "") {
			alert("제목을 입력하세요.");
			frm.noteTitle.focus();
			return false;
		}
		if (frm.category.value == "") {
			alert("카테고리를 선택하세요.");
			return false;
		}
//	 	if (!confirm("정말 수정하시겠습니까?"))
//	 		return;

		var memNo = ${memberNo};
		var editor = CKEDITOR.instances.ckeditor.getData();
		
		$.ajax({
			url : "/memory/note/noteUpdate",
			type : "POST",
			data : {"memberNo" : memNo, "noteTitle" : $("input[name=noteTitle]").val(), "noteContent" : editor,
				"categoryNo" : $("#category").val(), "noteNo" : localStorage.getItem("noteNoToUpdate")}
		})
		.done(function (result) {
			alert(result.msg, "success");
			mainNoteList();
			noteDetail(result.noteNo);
			$("input[name=noteTitle]").val("");
			CKEDITOR.instances.ckeditor.setData("");
			$("#category").val("");
			editor_chk = false;
			main_open();
		})
		.fail(function (jqXhr, textStatus, errorText) {
			alert("오류 : " + errorText);
		});
		
		return false;
	});
	
	//드래그 리스트 on/off
	$("#listSW").click(function(e) {
		$("#editorDraglist").toggle();
    });
	
	//글 작성 및 수정취소
	$("#cancelBtn").click(function(e) {
		editorCancelChk();
    });
	
	// 드래그내용 입력시 필요한 드래그리스트 출력
    function makeDragCards(result) {
    	var html = "";
		for (var i = 0; i < result.length; i++) {
			var drag = result[i];	
			var dragNo = drag.dragNo;
			html += "<div class='gallery' onclick='dragDetail("+drag.dragNo+")' class='modal_input' ondragstart='drag(event)' draggable='true' id='drag"+drag.dragNo+"'>";
			// 이미지 뿌리기
			var dragContent = drag.dragContent;
			if(dragContent.indexOf('<img') != -1) {
				var dragImgSrc = dragContent.split('src="')[1].split('"')[0];
				html += '<figure><img id="drag'+drag.dragNo+'" src="' + dragImgSrc + '" alt="" onclick="dragDetail('+drag.dragNo+')" ></figure>';
			} else {
				html += '<figure><img id="drag'+drag.dragNo+'" src="/memory/resources/img/D.png" width="180" height="140" alt="" onclick="dragDetail('+drag.dragNo+')" ></figure>';
			}
			html += "<div class='desc'><p>" + drag.dragUrlTitle + "</p></div>";
			html += "</div>";

		}
		if (result.length == 0) {
			html += "<div class='gallery'>";
			html += '<figure><img src="/memory/resources/img/D.png" alt="" width="300px" height="200px"></figure>';
			html += "<div class='desc'><p> 드래그가 없습니다 </p></div>";
			html += "</div>";
		}
    	$("#dragList_editor").html(html);
    }
	
    //노트에 드래그 입력하기.
    $("div[id^=drag]").click(function(event){
    	var addDragNo = event.target.id.substring(4);
    	if (editor_chk) {
    		$.ajax({
    			url : "/memory/drag/selectDrag",
    			type: "POST",
    			data: {"dragNo" : addDragNo},
    			dataType: "json"
    		})
    		.done(function (result) {
    			CKEDITOR.instances.ckeditor.setData(CKEDITOR.instances.ckeditor.getData() + result.dragContent.replace("amp;", "&") + "<br>");
    		})
    		.fail(function (jqXhr, textStatus, errorText) {
//     			alert("오류 : " + errorText);
    		});
    		return false;
    	}
    });
    
	//작성 또는 수정 완료시 노트리스트로 복귀
	function main_open() {
    	document.getElementById("noteEditor").style.display = "none";
    	document.getElementById("profileModal").style.display = "";
    	document.getElementById("noteView").style.display = "";
    	document.getElementById("noteView").style.width = (screen.innerWidth - 420) +"px";
		document.getElementById("noteView").style.height = screen.innerHeight +"px";
		getMainCategory();
		mainNoteList();
		makeDragList();
		$("#noteTitle").val("");
		CKEDITOR.instances.ckeditor.setData("");
	}
    </script>
</body>
</html>