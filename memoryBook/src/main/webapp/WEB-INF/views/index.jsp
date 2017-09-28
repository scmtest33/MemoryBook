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
    <link href="/memory/resources/css/memory-sheet.css" rel="stylesheet">

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
                    <a class="noteImg" data-toggle="modal" data-target="#profileModal">
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
      		        	<img src="/memory/resources/img/indexImg/mindmap_hover.png" class="indexImg9">
      		        	<img src="/memory/resources/img/indexImg/mindmap1.png" class="indexImg10">
					    My Mindmap
					</a>
                </li>
                 <li>
                	<a id="myFriend" class="noteImg">
                		<img src="/memory/resources/img/indexImg/friend_hover.png" class="indexImg11">
      		        	<img src="/memory/resources/img/indexImg/friend1.png" class="indexImg12">
					    My Friend
					</a>
                </li>
                <li>
               		<a class="noteImg" data-toggle="modal" data-target="#userSearchModal">
                	<!-- <a id="searchFriend" class="noteImg"> -->
                	<img src="/memory/resources/img/indexImg/search_hover.png" class="indexImg13">
      		        <img src="/memory/resources/img/indexImg/search1.png" class="indexImg14">
					    Friend Search
					</a>
                </li>
                <li>
                    <a onclick="logout()" class="noteImg" id="logout">
                	<img src="/memory/resources/img/indexImg/logout_hover.png" class="indexImg15">
      		        <img src="/memory/resources/img/indexImg/logout1.png" class="indexImg16">
                    	Logout
                    </a>
                </li>
                <c:if test="${email eq 'admin'}">
                <li>
                	<a id="user" class="noteImg">
                	<img src="/memory/resources/img/indexImg/admin_hover.png" class="indexImg17">
      		        <img src="/memory/resources/img/indexImg/admin1.png" class="indexImg18">
						UserList
					</a>
                </li>
                </c:if>
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
			  		<%-- <%@ include file="menu/search.jsp" %> --%>
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
    
    
    
    
    
    
    <!-- Profile Modal-->
	<div class="modal fade" id="profileModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-user-o modal_title"></i> Profile
					</h2>
				</div>
				<div class="align-center">
					<h1>테스트</h1>
						<div>
							<img class='profile1 img-circle' width='150px' height='150px' alt='avatar' src='/memory/data/mem_image/${mem_image}'>
							<ul id="myInfoList" class="list-group">
							</ul>
						</div>
						<div>
							<button type="button" class="btn" id="myProfile" data-dismiss="modal">회원정보 수정</button>
							<button type="button" class="btn" data-dismiss="modal">닫기</button>
							<input class="btn btn-danger pull-right" data-dismiss="modal" data-toggle="modal" data-target="#myModal_Unregister" value="탈퇴" type="button">
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	
	<!-- 탈퇴 Modal -->
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
					    	<td id="btns" colspan="2">
					    		<input type="submit" value="회원탈퇴" class="btn btn-default memberOut_btns out_ok">
					    	</td>
					    	<td>
					    	&nbsp;&nbsp;
					    	</td>
						    	<td id="btns" colspan="2">
							    <button class="btn btn-default memberModify_btns Modify_no" id="cancelBtn2" data-dismiss="modal">취소</button>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		        </div>
		      </div>
		    </div>
		  </div>
    
	<!-- userSearch Modal-->
	<div class="modal fade" id="userSearchModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content"> <!-- 여기가 모달 사이즈 -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-user-o modal_title"></i> User Search
					</h2>
				</div>
				<div class="align-center">
					<div class="searchInput col-md-offset">
						<div class="search-form">
							<label for="search" class="sr-only">Search</label> <input type="text"
								class="form-control" name="findId" id="findId"
								placeholder="이름 또는 Email을 입력하세요"
								onkeydown="javascript:if(event.keyCode == 13) searchList();">
						</div>
					</div>
					<div class="btn-default noteSearch_btn" id="findBtn"
						onclick="findMember();">
						<img src="/memory/resources/img/search_icon.jpg">
					</div>
					<br>
					<br>
					<div id="panel"></div>
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
    var editor_chk = false; //드래그 입력시 에디터 on/off여부 체크
    var chk_tf; //메뉴 이동시 에디터 체크
    var note_Chk; //에디터 모드 구분 (노트/드래그)

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
		authInit();//노트 권한설정창
		//노트 리스트 화면
		$('#noteView').css('display', '');
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		$('#noteEditor').css('display', 'none');
		$("#noteTitle").val("");
		CKEDITOR.instances.ckeditor.setData("");
		
		//노트 에디터
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
		
	}

	// 브라우저 창 크기 변화 시 위치 지정 (통합)
	$(window).resize(function(){
		//드래그 리스트
		$('#myDragList').css('width', '(screen.innerWidth - 420) +"px"');
		$('#myDragList').css('height', 'screen.innerHeight +"px"');		
		//노트 리스트
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		//노트 에디터
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
		//에디터 드래그 리스트
		$('#editorDraglist').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorDraglist').css('height', 'screen.innerHeight +"px"');
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
    
    // 메인으로 가기
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
    
    //프로필로 가기
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
    
    //드래그리스트로 가기
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
    
    //노트리스트 보기
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
    
    //관계도 보기
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
    
    //친구목록 보기
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
    
    //친구찾기
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
			console.log("editor: "+editor_chk);
			console.log("chk: "+chk_tf);
		} else {
			search_menu();
		}
	    console.log("editor2: "+editor_chk);
		console.log("chk2: "+chk_tf);
	});
    
    //회원목록(운영자용) 보기
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
    
    //드래그 테스트 (운영자용)
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
	 		authInit(); 
	 		$('#noteEditor').css('display', 'none'); 
	 		$('#categoryToAdd').css('display', 'none'); 
	 		$('#Category1').css('display', 'none'); 
	 		$('#Category2').css('display', 'none'); 
	 		$('#noteView').css('display', ''); 
	 		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"'); 
	 		$('#noteView').css('height', 'screen.innerHeight +"px"'); 
	 		chk_tf = true; 
 		} else { 
 			chk_tf = false; 
 		} 
 	}

    
    
/*  	function editorCancelChk() {
		swal({
			  title: '정말로 취소하시겠습니까?',
			  text: '취소시 글 내용은 저장되지 않습니다.',
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
			editor_chk = false;
			console.log(editor_chk);
	 		$("#noteTitle").val(''); 
	 		CKEDITOR.instances.ckeditor.setData(""); 
	 		authInit(); 
	 		$('#noteEditor').css('display', 'none'); 
	 		$('#categoryToAdd').css('display', 'none'); 
	 		$('#Category1').css('display', 'none'); 
	 		$('#Category2').css('display', 'none'); 
	 		$('#noteView').css('display', ''); 
	 		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"'); 
	 		$('#noteView').css('height', 'screen.innerHeight +"px"'); 
	 		chk_tf = true;
	 		console.log(chk_tf);
			}, function (dismiss) {
				chk_tf = false;
			   });
	} */
    
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
	
	
	//회원찾기 로직
	function findMember() {
		$.ajax ({
			url: "/memory/member/findMember",
			type: "POST",
			data: {
				"findId" : $("input[name=findId]").val()
				},
			success : function(result) {
						$("#panel").empty()
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
											$("#panel").empty()
											$("#searched").empty();
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