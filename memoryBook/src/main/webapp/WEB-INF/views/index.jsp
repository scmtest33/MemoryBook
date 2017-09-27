<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Simple Sidebar - Start Bootstrap Template</title>
    
    <!-- Favicon -->
	<link rel="shortcut icon" href="/memory/resources/img/memory.ico">
	<link rel="icon" href="/memory/resources/img/memory.ico">

	<!-- StyleSheets -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css">
	<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/nanummyeongjo.css">
	<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/notosanskr.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="/memory/resources/css/memory-sheet.css">

    <!-- Bootstrap core CSS -->
    <link href="/memory/resources/css/bootstrap.css" rel="stylesheet">

	<!-- sweet_alert2 -->
    <script src="/memory/resources/js/sweetalert2.js"></script>
	<link rel="stylesheet" href="/memory/resources/css/sweetalert2.css">

	<!-- tableStyle CSS -->
    <link href="/memory/resources/css/tableStyle.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/memory/resources/css/simple-sidebar.css" rel="stylesheet">

	<!-- 공용 스크립트 -->
	<script src="/memory/resources/js/jquery-3.2.1.min.js"></script>
	<script src='/memory/resources/js/fullcalendar-3.2.0/lib/moment.min.js'></script>
	<script src='/memory/resources/js/fullcalendar-3.2.0/fullcalendar.js'></script>
</head>

<body>

    <div id="wrapper" class="toggled">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a id="indexTitle">
                        Memory Lane
                    </a>
                </li>
                <li>
                    <a id="Main" class="noteImg">
                    	<img src="/memory/resources/img/indexImg/home_hover.png" class="indexImg1">
      		        	<img src="/memory/resources/img/indexImg/home1.png" class="indexImg2">
	                    Main
                    </a>
                </li>
                <li>
                    <a id="myProfile" class="noteImg">
                    	<img src="/memory/resources/img/indexImg/profile_hover.png" class="indexImg3">
      		        	<img src="/memory/resources/img/indexImg/profile1.png" class="indexImg4">
	                    Profile
                    </a>
                </li>
                <li>
                    <a id="drag" class="noteImg">
                    	<img src="/memory/resources/img/indexImg/drag_hover.png" class="indexImg5">
      		        	<img src="/memory/resources/img/indexImg/drag1.png" class="indexImg6">
					    My Drag
					</a>
                </li>
                <li>
      		        <a id="note" class="noteImg" >
      		        	<img src="/memory/resources/img/indexImg/note_hover.png" class="indexImg7">
      		        	<img src="/memory/resources/img/indexImg/note1.png" class="indexImg8">
					    My Note
					</a>
                </li>
                <li>
      		        <a id="mindmap" class="noteImg" >
      		        	<img src="/memory/resources/img/indexImg/note_hover.png" class="indexImg7">
      		        	<img src="/memory/resources/img/indexImg/note1.png" class="indexImg8">
					    My Mindmap
					</a>
                </li>
                 <li>
                	<a id="myFriend" class="noteImg">
                		<img src="/memory/resources/img/indexImg/friend_hover.png" class="indexImg9">
      		        	<img src="/memory/resources/img/indexImg/friend1.png" class="indexImg10">
					    My Friend
					</a>
                </li>
                <li>
                	<a id="searchFriend" class="noteImg">
                	<img src="/memory/resources/img/indexImg/search_hover.png" class="indexImg11">
      		        <img src="/memory/resources/img/indexImg/search1.png" class="indexImg12">
					    Friend Search
					</a>
                </li>
                <c:if test="${email eq 'admin'}">
                <li>
                	<a id="user" class="noteImg">
                	<img src="/memory/resources/img/indexImg/admin_hover.png" class="indexImg15">
      		        <img src="/memory/resources/img/indexImg/admin1.png" class="indexImg16">
						UserList
					</a>
                </li>
                </c:if>
                <li>
                    <a onclick="logout()" class="noteImg" id="logout">
                	<img src="/memory/resources/img/indexImg/logout_hover.png" class="indexImg13">
      		        <img src="/memory/resources/img/indexImg/logout1.png" class="indexImg14">
                    	Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Page Content -->
        <div id="page-content-wrapper" class="page-content-wrapper">
<!--             <div class="container-fluid"> -->
<!--                 <h1>Memory Lane</h1> -->
<%--                 <p>${name}님 This is main screen.</p> --%>
<!--                 <a class="btn btn-secondary" id="menu-toggle">Toggle Menu</a> -->
<!--             </div> -->
            
            <div id='indexMain'>
				<div class="container-fluid" id="indexMainContent">
				<%@ include file="menu/indexMain.jsp" %>
				</div>
	        </div>
            
			<div id="profile">
				<div class="container-fluid">
				<%@ include file="menu/profile.jsp" %>
				</div>
	        </div>
	        
	        <div id='myDragList'>
	        	<div class="container-fluid">
	 		  		<%@ include file="menu/drag.jsp" %>
	 		  	</div>
		  	</div>
	        
	        <div id='myNote'>
	        	<div class="container-fluid">
	            	<%@ include file="menu/note.jsp" %>
	            </div>
	        </div>
	        
		  	<div id='mindMap'>
		  		<div class="container-fluid">
			  		<%@ include file="menu/mindmap.jsp" %>
			  	</div>
		  	</div> 
	        
			<div id='friend'>
				<div class="container-fluid">
			  		<%@ include file="menu/friend.jsp" %> 
			  	</div>
		  	</div>
	        
			<div id='search'>
				<div class="container-fluid">
			  		<%@ include file="menu/search.jsp" %>
			  	</div>
		  	</div>
		  	
		  	<div id='userList'>
		  		<div class="container-fluid">
			  		<%@ include file="manager/userList.jsp" %>
			  	</div>
		  	</div>
		  	
			<div id='myDragtest'>
				<div class="container-fluid">
			  		<%@ include file="menu/drag_test.jsp" %>
			  	</div>
		  	</div>
		</div>	
    </div>
   
    <!-- Bootstrap core JavaScript -->
    <script src="/memory/resources/js/jquery-3.2.1.js"></script>
    <script src="/memory/resources/js/popper.min.js"></script>
    <script src="/memory/resources/js/bootstrap.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    //index들어왔을때 초기화면
    $(function(){
    	$('#myDragList').css('display', 'none');
    	$('#myNote').css('display', 'none');
    	$('#mindMap').css('display', 'none');
    	$('#userList').css('display', 'none');
    	$('#friend').css('display', 'none');
    	$('#myDragtest').css('display', 'none');
    	$('#search').css('display', 'none');
    	$('#profile').css('display', 'none');
    	$('#editorDraglist').css('display', 'none');
    	$('#indexMain').css('display', '');
	});
    
    
	//로그아웃
    function logout(){
    	swal({
    		  title: '정말로 로그아웃 하시겠습니까?',
    		  type: 'question',
    		  showCancelButton: true,
    		  confirmButtonColor: '#3085d6',
    		  cancelButtonColor: '#d33',
    		  confirmButtonText: '네',
    		  cancelButtonText: '아니오',
    		  confirmButtonClass: 'btn btn-success',
    		  cancelButtonClass: 'btn btn-danger',
    		  buttonsStyling: false
    		}).then(function () {
    			localStorage.clear();
        		location.href='/memory/member/logout';
    		})
    }
    
  //모달 취소버튼
     $("#cancleBtn").click(function (){
    	location.href='/memory/index';
    }); 
     $("#cancleBtn1").click(function (){
    	location.href='/memory/index';
    }); 
     $("#cancleBtn2").click(function (){
    	location.href='/memory/index';
    }); 
    
    $("#menu-toggle").click(function(e){
    	e.preventDefault();
    	$("#wrapper").toggleClass("toggled");
    });
    
	// 로딩 위치 지정
	window.onload = function () {
		mainNoteList(); //노트 리스트
		mainNoteList2(); //노트 리스트(마인드맵용)
		mainDragList(); //드래그 리스트
		makeDragList(); //글 작성창 드래그 리스트
		getMainCategory(); //카테고리 리스트
		getMainCategory2(); //카테고리 리스트(마인드맵용)
		mainFriendNoteList() //친구 노트 리스트
		getMainFriendCategory();//친구 카테고리 리스트
		//노트 리스트 화면
		$('#profileModal').css('display', '');
		$('#noteView').css('display', '');
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		$('#noteEditor').css('display', 'none');
		$("#noteTitle").val("");
		CKEDITOR.instances.ckeditor.setData("");
		
		//노트 에디터
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
		
		//메뉴 이동시 에디터 체크
		var chk_tf;
	}

	// 브라우저 창 크기 변화 시 위치 지정 (통합)
	$(window).resize(function(){
		//드래그 리스트
		$('#editorDraglist').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorDraglist').css('height', 'screen.innerHeight +"px"');
		//노트 리스트
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		//노트 에디터
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
	});
    
    // 내비바 아이콘으로 열고 닫기
    $("#indexTitle").click(function(e) {
     	function profile_menu(){
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#indexMain').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			profile_menu();
    		}
    	} else {
    		profile_menu();
    	}
    });
    
    $("#Main").click(function(e) {
     	function profile_menu(){
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#indexMain').css('display', '');
	    	
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			profile_menu();
    		}
    	} else {
    		profile_menu();
    	}
    });
    
    $("#myProfile").click(function(e) {
     	function profile_menu(){
     		$('#indexMain').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#profile').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			profile_menu();
    		}
    	} else {
    		profile_menu();
    	}
    });
    
    $("#drag").click(function(e) {
    	function drag_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#myDragList').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			drag_menu();
    		}
    	} else {
    		drag_menu();
    	}
    });
    
    $("#dragtest").click(function(e) {
    	function dragTest_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			dragTest_menu();
    		}
    	} else {
    		dragTest_menu();
    	}
    });
    
    $("#note").click(function(e) {
    	function note_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#myNote').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			note_menu();
    		}
    	} else {
    		note_menu();
    	}
    });
    
    $("#mindmap").click(function(e) {
    	function mind_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#mindMap').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			mind_menu();
    		}
    	} else {
    		mind_menu();
    	}
    });
    
    $("#myFriend").click(function(e) {
    	function friend_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#friend').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			friend_menu();
    		}
    	} else {
    		friend_menu();
    	}
    });
    
    $("#searchFriend").click(function(e) {
    	function search_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#userList').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#search').css('display', '');
    	}
	    if(editor_chk){
			editorCancelChk();
			if(chk_tf) {
				search_menu();
			}
		} else {
			search_menu();
		}
	});
    
    $("#user").click(function(e) {
    	function user_menu(){
    		$('#indexMain').css('display', 'none');
     		$('#profile').css('display', 'none');
     		$('#myDragList').css('display', 'none');
     		$('#myNote').css('display', 'none');
     		$('#mindMap').css('display', 'none');
     		$('#friend').css('display', 'none');
     		$('#search').css('display', 'none');
     		$('#myDragtest').css('display', 'none');
     		$('#userList').css('display', '');
    	}
    	if(editor_chk){
    		editorCancelChk();
    		if(chk_tf) {
    			user_menu();
    		}
    	} else {
    		user_menu();
    	}
    });
    
    //인덱스 메뉴 이미지 호버
    $(function(){
    	$(".noteImg").hover(function(){
    	     $("img",this).eq(1).stop().fadeToggle(500);
    	},function(){
    	     $("img",this).eq(1).stop().fadeToggle(500);
    	});
    });
    
    //에티터 작동중 취소여부 확인 (noteWrite.jsp에도 연동되어 같이 적용됨)
	function editorCancelChk() {
		var chk;
		chk = confirm("정말로 취소하시겠습니까?");
		if(chk) {
		editor_chk = false;
		$("#noteTitle").val('');
		CKEDITOR.instances.ckeditor.setData("");
		$('#noteEditor').css('display', 'none');
		$('#categoryToAdd').css('display', 'none');
		$('#Category1').css('display', 'none');
		$('#Category2').css('display', 'none');
		$('#profileModal').css('display', '');
		$('#noteView').css('display', '');
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		chk_tf = true;
		} else {
		chk_tf = false;
		}
	}
    
	// 드롭 허용
	function allowDrop(ev) {
		ev.preventDefault(); 
		}

	// 드래그 이벤트
	function drag(ev) { 
		ev.dataTransfer.setData("text", ev.target.id); 
		} 

	// 노트 및 드래그 삭제 드랍 이벤트
	function drop(ev) {
		ev.preventDefault();
		var deleteId = ev.dataTransfer.getData("text"); 
		var deleteNum = deleteId.substring(4);
		if (deleteId.startsWith("d")){
		 	deleteDrag(deleteNum);
		} else if (deleteId.startsWith("c")){
			deleteNum = deleteId.substring(8);
			deleteCategory(deleteNum);
		} else{
		 	deleteNote(deleteNum);
		} 
	}
    </script>

</body>
</html>
