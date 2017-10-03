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

    <title>Memory Lane</title>
    
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

	<!-- Common Script -->
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
                    <a id="myProfile" onclick="profileUpdate()" class="noteImg" data-toggle="modal" data-target="#profileModal">
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
               		<a id="searchFriend" class="noteImg" data-toggle="modal" data-target="#userSearchModal">
                	<img src="/memory/resources/img/indexImg/search_hover.png" class="indexImg13">
      		        <img src="/memory/resources/img/indexImg/search1.png" class="indexImg14">
					    User Search
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
<%--                 <p>${name}様 This is main screen.</p> --%>
<!--                 <a class="btn btn-secondary" id="menu-toggle">Toggle Menu</a> -->
<!--             </div> -->
            
            <div id='indexMain'>
				<div class="container-fluid" id="indexMainContent">
				<%@ include file="menu/indexMain.jsp" %>
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
	        
		  	<div id='userList'>
		  		<div class="container-fluid">
			  		<%@ include file="manager/userList.jsp" %>
			  	</div>
		  	</div>
		</div>	
    </div>
    
    
    <!-- Profile Modal-->
	<div class="modal fade" id="profileModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content profile-size">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-user-o modal_title"></i> Profile
					</h2>
				</div>
				<br>
				<div class="align-center" id="profileView">
				</div>
				<div class="profile-btns align-left">
					<button type="button" class="btn btn-default" onclick="pwEdit()">パスワード更新</button>
					<button type="button" class="btn btn-default" id="myProfile" data-dismiss="modal" data-toggle="modal" data-target="#myModal_Unregister">退会</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-default" data-dismiss="modal">閉める</button>
				</div>
			</div>
		</div>

	</div>
	
	<!-- 退会Modal -->
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
		        			        	
		        <div class="modal-body" id="unregisterBody">
		          	
		        <form name="unregisterfrm" id="unregisterfrm" action="/memory/member/unregister" method="post">       
			    	<table>
			    		<tr>
			    			<td class="form-group">
				    			退会したいなら、パスワードを入力してください。
				    			<br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td class="form-group">
				    			※退会すれば全ての情報とデーターが削除されます。
				    			<br>
			    			</td>
			    		</tr>
			    		<tr>
			    			<td class="form-group">
								<label for="loginPassword">Password:</label>
								<input type="password" class="form-control" id="mem_pwd" name="mem_pwd" placeholder="パスワードを入力してください。" required="required"/>
			    				<br>
			    			</td>
			    		</tr>
					    <tr>
					    	<td id="btns">
					    		<input type="submit" value="退会する" class="btn btn-default memberOut_btns out_ok">
							    <button class="btn btn-default memberModify_btns Modify_no" id="cancelBtn2" data-dismiss="modal">キャンセル</button>
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
			<div class="modal-content memSearch-size"> <!-- ここがモーダルサイズ -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h2 class="modal-title">
						<i class="fa fa-user-o modal_title"></i> User Search
					</h2>
				</div>
				<div>
					<div class="col-md-offset">
						<div class="memSearch">
							<table>
								<tr>
									<td class="memSearch-input">
										<input type="text" class="form-control searchInput" name="findId" id="findId"
										 placeholder="名前又はメールアドレスを入力してください。" onkeydown="javascript:if(event.keyCode == 13) findMember();">
								 	</td>
									<td>
										<button class="btn-default noteSearch_btn memSearch-btn" id="findBtn" onclick="findMember();">
										<img src="/memory/resources/img/search_icon.jpg"></button>
									</td>
									<td>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<button type="button" class="btn btn-default" data-dismiss="modal">閉める</button>
									</td>
								</tr>
							</table>
						</div>
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
    var editor_chk = false; //ドラッグ入力するとき、エディターon/offチェック
    var chk_tf; //メニュー移動するとき、エディターチェック
    var note_Chk; //エディターモード区分 (ノート/ドラッグ)

    //index初期画面
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
    
	// ローディング位置指定
	window.onload = function () {
		mainNoteList(); //ノートリスト
		mainNoteList2(); //ノートリスト(関係図用)
		mainDragList(); //ドラッグ リスト
		makeDragList(); //エディター内のドラッグリスト
		getMainCategory(); //カテゴリーリスト
		getMainCategory2(); //カテゴリーリスト(関係図用)
		mainFriendNoteList() //友達のノート リスト
		getMainFriendCategory();//友達のカテゴリーリスト
		authInit();//ノート権限設定
		//ノートリスト画面
		$('#noteView').css('display', '');
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		$('#noteEditor').css('display', 'none');
		$("#noteTitle").val("");
		CKEDITOR.instances.ckeditor.setData("");
		
		//ノート 에디터
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
		
	}

	// ブラウザ画面サイズが変化する時の位置指定
	$(window).resize(function(){
		//ドラッグリスト
		$('#myDragList').css('width', '(screen.innerWidth - 420) +"px"');
		$('#myDragList').css('height', 'screen.innerHeight +"px"');		
		//ノートリスト
		$('#noteView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#noteView').css('height', 'screen.innerHeight +"px"');
		//ノートエディター
		$('#editorView').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorView').css('height', 'screen.innerHeight +"px"');
		//エディター内のドラッグリスト
		$('#editorDraglist').css('width', '(screen.innerWidth - 420) +"px"');
		$('#editorDraglist').css('height', 'screen.innerHeight +"px"');
	});
	
	//ログアウト
    function logout(){
    	swal({
    		  title: '本当にログアウトしますか。',
    		  type: 'question',
    		  showCancelButton: true,
    		  confirmButtonColor: '#3085d6',
    		  cancelButtonColor: '#d33',
    		  confirmButtonText: 'はい',
    		  cancelButtonText: 'いいえ',
    		  confirmButtonClass: 'btn btn-success',
    		  cancelButtonClass: 'btn btn-danger',
    		  buttonsStyling: false
    		}).then(function () {
    			localStorage.clear();
        		location.href='/memory/member/logout';
    		})
    }
    
  //Modalキャンセルボタン
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
    
	//Profile更新
	function profileUpdate(){
		$.ajax ({
			url: "/memory/member/myList",
			type: "post",
			success : function(result){
				$("#profileView").empty();
				var addRow = '<a id="getImage" onclick="photoEdit()">'
					addRow += '<img class="profile1 profile-photo" width="130px" height="130px" alt="avatar" src="/memory/data/mem_image/'+result.mem_image+'"></a>';
					addRow += '<br>';
					addRow += '<span class="profile-name">'+result.name+'</span>';
					addRow += '<span class="profile-editBtn">&nbsp;<i onclick="nameEdit()" class="fa fa-pencil-square" aria-hidden="true"></i></span>';
					addRow += '<ul id="myInfoList" class="list-group">';
					addRow += '<li class="list-group-item profile"><span class="profile-items"><i class="fa fa-envelope"></i>&nbsp;${email}</span></li>';
					if(result.infoNumber == 0) {					
						addRow += '<li class="list-group-item profile"><span class="profile-items">'
						addRow += '<i class="fa fa-lock fa-lg"></i>&nbsp;会員検索許容'
						addRow += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
						addRow += '<a onclick="infoToggle()"><img src="/memory/resources/img/on.png"></a></span></li>';
						localStorage.setItem("infoStatus","0");
					}
					if(result.infoNumber == 1) {
						addRow += '<li class="list-group-item profile"><span class="profile-items">'
						addRow += '<i class="fa fa-lock fa-lg"></i>&nbsp;会員検索許容'
						addRow += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
						addRow += '<a onclick="infoToggle()"><img src="/memory/resources/img/off.png"></a></span>';
						localStorage.setItem("infoStatus","1");
					}
					addRow += '</ul>';
					$("#profileView").append(addRow);
				}
		})
	}
    
    //メインページへ
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
    
    //ドラッグリストページへ
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
    
    //ノートリストページへ
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
    
    //関係図ページへ
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
    
    //友達ページへ
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
    
    //会員管理ページへ(only admin)
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
    
    //ドラッグtest(only admin)
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
    
    //index menu image hover
    $(function(){
    	$(".noteImg").hover(function(){
    	     $("img",this).eq(1).stop().fadeToggle(500);
    	},function(){
    	     $("img",this).eq(1).stop().fadeToggle(500);
    	});
    });
    
    //エディター作動中キャンセルチェック
     function editorCancelChk() { 
 		var chk; 
 		chk = confirm("本当にキャンセルしますか。"); 
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
			  title: '本当にキャンセルしますか。',
			  text: 'キャンセルするなら、作成した内容はセーブしせん。',
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'はい',
			  cancelButtonText: 'いいえ',
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
    
	// ドロップ許容
	function allowDrop(ev) {
		ev.preventDefault(); 
		}

	// ドラッグイベント
	function drag(ev) { 
		ev.dataTransfer.setData("text", ev.target.id); 
		} 

	// ノートやドラッグ削除ドロップイベント
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

		
	
	//会員検索
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
						if(result.length <= 0){
							swal({
								  title: '検索結果がありません。',
								  type: 'info',
								  confirmButtonText: 'OK'
								})
						} else {
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
												  title: '友達申請完了',
												  text: '友達が申請を受諾すれば、登録が完了されます。',
												  type: 'success',
												  confirmButtonText: 'OK'
												})
											$("#panel").empty()
											$("#searched").empty();
											$("#friendList").empty();
											friendList();
										}else {
											swal({
												  title: 'Error!',
												  text: 'すでに登録されている友達です。',
												  type: 'error',
												  confirmButtonText: 'OK'
												})
										}
									}
								});
							});
						});
		    		}
			}
		});
    };
    
    //プロフィールイメージ訂正
    function photoEdit(){
    	swal({
    		  title: 'イメージファイル選択',
      		  html:
      		    '<input type="file" id="imageFile" class="swal2-input">',
      		  showCancelButton: true,
      		  focusConfirm: false
    		}).then(function (file) {
    			var data = new FormData();
    			var files = $("#imageFile").get(0).files;
    			if (files.length > 0) {
    				data.append("imageFile", files[0]);
    				}
    			$.ajax({
    				type: "POST",
    				url : "/memory/member/upload",
    				data: data,
    				processData: false,
    				contentType: false,
    				success: function (result) {
    					if(result == "error") {
    						swal({
    							  title: 'Warning!',
    							  text: 'イメージファイルのみアップロードができます。',
    							  type: 'warning',
    							  confirmButtonText: 'OK'
    							})
    					} else if (result == "IOException") {
    						swal({
    							  title: 'Error!',
    							  text: 'イメージアップロードを失敗しました。',
    							  type: 'error',
    							  confirmButtonText: 'OK'
    							})
    					} else {
    					$("#getImage").html("<img class='profile1 profile-photo' width='130px' height='130px' alt='avatar' src='/memory/data/mem_image/"+result+"'>");
    					swal({
							  title: 'Profileイメージ更新完了',
							  type: 'success',
							  confirmButtonText: 'OK'
							})
    					}
    				},
    				error: function(jqXhr, textStatus, errorText){
    					swal({
    						  title: 'Error!',
    						  text: 'Profileイメージ更新を失敗しました。',
    						  type: 'error',
    						  confirmButtonText: 'OK'
    						})
    				}
    			})
    		/* var reader = new FileReader
    		  reader.onload = function (e) {
    		    swal({
    		      title: 'Your uploaded picture'
    		      imageUrl: e.target.result,
    		      imageAlt: 'The uploaded picture'
    		    })
    		  }
    		  reader.readAsDataURL(file) */
    		})
    	}
    
    //パスワード更新
    function pwEdit(){
    	swal({
    		  title: 'パスワード更新',
    		  html:
    		    '新しいパスワード入力 <input type="password" id="swal-input1" class="swal2-input">' +
    		    'パスワード確認 <input type="password" id="swal-input2" class="swal2-input">',
    		  showCancelButton: true,
    		  focusConfirm: false
    		}).then(function () {
    			var pw1 = $('#swal-input1').val();
		        var pw2 = $('#swal-input2').val();
    			if (pw1 != pw2 || pw1 == "") {
    				swal({
    					title : 'Error!',
    					text : 'パスワードを確認してください。',
    					type : 'error',
    					confirmButtonText : 'OK'
    				})
    				return;
    			} else {
    				$.ajax({
    					url : "/memory/member/infoUpdate",
    					type : "POST",
    					data : {"mem_pwd" : $("#swal-input1").val()}
    				})
    				.done(function (result) {
    					swal({
  						  title: 'パスワードが更新されました。',
  						  type: 'success',
  						  confirmButtonText: 'OK'
  						})
    				})
    				.fail(function(jqXhr, textStatus, errorText){
    					swal({
    					  title: 'Error!',
    					  text: 'パスワード更新を失敗しました。',
    					  type: 'error',
    					  confirmButtonText: 'OK'
    					})
    				});
    			}
    		}).catch(swal.noop)
    }
    
	//名前更新
	function nameEdit(){
		swal({
  		  title: '名前更新',
  		  html:
  		    '新しい名前を入力してください。 <input id="swal-input3" class="swal2-input">',
  		  showCancelButton: true,
  		  focusConfirm: false
  		}).then(function () {
  			var name_chk = $('#swal-input3').val();
  			if (name_chk == "") {
  				swal({
  					title : 'Error!',
  					text : '名前が入力されませんでした。',
  					type : 'error',
  					confirmButtonText : 'OK'
  				})
  				return;
  			} else {
  				$.ajax({
  					url : "/memory/member/infoUpdate",
  					type : "POST",
  					data : {"name" : $("#swal-input3").val()}
  				})
  				.done(function (result) {
  					swal({
						  title: '名前が更新されました。',
						  type: 'success',
						  confirmButtonText: 'OK'
						})
					profileUpdate();
  				})
  				.fail(function(jqXhr, textStatus, errorText){
  					swal({
  					  title: 'Error!',
  					  text: '名前更新を失敗しました。',
  					  type: 'error',
  					  confirmButtonText: 'OK'
  					})
  				});
  			}
  		}).catch(swal.noop)
	}
	
	//会員検索公開許容設定
	function infoToggle(){
		var infoNum = localStorage.getItem("infoStatus");
  		$.ajax({
  			url: "/memory/member/infoUpdate",
  			type: "POST",
  			data: {"infoNumber" : infoNum}
  		})
  		.done(function (result) {
			profileUpdate();
  		})
  		.fail(function(jqXhr, textStatus, errorText){
  			swal({
  			  title: 'Error!',
  			  text: '公開許容設定変更を失敗しました。',
  			  type: 'error',
  			  confirmButtonText: 'OK'
  			})
  		});
	}
    </script>
</body>
</html>