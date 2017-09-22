<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Memory Lane</title>
    
    <!-- jQuery -->
    <script src="/memory/resources/js/jquery-3.2.1.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/memory/resources/js/bootstrap.min.js"></script>

    <!-- Custom Theme JavaScript -->
    
    
    <!-- Favicon -->
	<link rel="shortcut icon" href="/memory/resources/img/memory.ico">
	<link rel="icon" href="/memory/resources/img/memory.ico">

    <!-- Bootstrap Core CSS -->
    <link href="/memory/resources/css/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/memory/resources/css/stylish-portfolio.css" rel="stylesheet">
	<link href="/memory/resources/css/memory-sheet.css" rel="stylesheet" type="text/css">

    <!-- Custom Fonts -->
    <link href="/memory/resources/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <!-- Navigation  -->
    <a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i class="fa fa-bars"></i></a>
    <nav id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <a id="menu-close" href="#" class="btn btn-light btn-lg pull-right toggle"><i class="fa fa-times"></i></a>
            <li class="sidebar-brand">
                <a href="#top" onclick=$("#menu-close").click();>Memory Book</a>
            </li>
            <li>
                <a href="#top" onclick=$("#menu-close").click();>Home</a>
            </li>
            <li>
                <a href="#services" onclick=$("#menu-close").click();>Services</a>
            </li>
            <li>
                <a href="#portfolio" onclick=$("#menu-close").click();>Portfolio</a>
            </li>
            <li>
                <a href="#contact" onclick=$("#menu-close").click();>Contact</a>
            </li>
            <li>
                <a href="#register"  onclick=$("#menu-close").click();>Register</a>
            </li>
            <li>
                <a data-toggle="modal" data-target="#myModal" onclick=$("#menu-close").click();>Login</a>
            </li>
        </ul>
    </nav>

    <!-- Header -->
    <header id="top" class="header">
	        <div class="text-vertical-center">
	            <h1 class="title100">Memory Lane</h1>
	            <p class="title101">더듬어 걷는 기억</p>
	            <a data-toggle="modal" data-target="#myModal" class="btn btn-default btn-lg">Login / Register</a>
	        </div>
    </header>

    <!-- About -->
    <section id="about" class="about">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="about-text">당신이 걸었던 길의 기억 한조각, 한조각을 남겨보세요</h2>
                    <h3 class="about-text2">여행  책  영화  맛집  패션  뉴스  소셜  친구  쇼핑  공부 언어 </h3>
<!--                     <p class="lead">This theme features some wonderful photography courtesy of <a target="_blank" href="http://join.deathtothestockphoto.com/">Death to the Stock Photo</a>.</p> -->
                </div>
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>

    <!-- Services -->
    <!-- The circle icons use Font Awesome's stacked icon classes. For more information, visit http://fontawesome.io/examples/ -->
    <section id="services" class="services bg-primary">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-10 col-lg-offset-1">
                    <h2 class="service-text">메모리 레인은?</h2>
                    <hr class="small">
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item"><br><br><br>
                            	<img src="/memory/resources/img/mainIcon/drag1.png"><br><br>
                                <h2 class="service-content">
                                    <strong>드래그 저장 기능</strong>
                                </h2>
                                <p class="service-content2">정보 검색하던 사이트에서 내가 원하는 부분만 드래그하면 저장이 가능합니다.</p>
<!--                                 <a href="#" class="btn btn-light">Learn More</a> -->
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item"><br><br><br>
                                <img src="/memory/resources/img/mainIcon/note1.png"><br><br>
                                <h2 class="service-content">
                                    <strong>노트 기능</strong>
                                </h2>
                                <p class="service-content2">내가 드래그한 내용을 나만의 방식으로 수정해 보세요.</p>
<!--                                 <a href="#" class="btn btn-light">Learn More</a> -->
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item"><br><br><br>
                                <img src="/memory/resources/img/mainIcon/friend1.png"><br><br>
                                <h2 class="service-content">
                                    <strong>친구 기능</strong>
                                </h2>
                                <p class="service-content2">친구들과 함께 노트를 공유해 보세요.</p>
<!--                                 <a href="#" class="btn btn-light">Learn More</a> -->
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="service-item"><br><br><br>
                                <img src="/memory/resources/img/mainIcon/mindmap1.png"><br><br>
                                <h2 class="service-content">
                                    <strong>마인드 맵 기능</strong>
                                </h2>
                                <p class="service-content2">친구들과 마인드맵으로 회의, 계획을 짜보세요</p>
<!--                                 <a href="#" class="btn btn-light">Learn More</a> -->
                            </div>
                        </div>
                    </div>
                    <!-- /.row (nested) -->
                </div>
                <!-- /.col-lg-10 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>

    <!-- Portfolio -->
    <section id="portfolio" class="portfolio">
        <div class="portfolio_con">
                    <h1 class="text001" align="right"><strong>크롬 확장 프로그램</strong></h1><br>
                    <h2 class="text002" align="right"><strong>메모리 레인은 구글 확장 프로그램을 사용합니다.</strong></h2>
                    <h2 class="text002" align="right"><strong>메모리 레인을 사용하기 위해 구글 확장프로그램을 설치해 주세요.</strong></h2>
                    <a class="btn btn-default btn-lg" onclick="downloadUrl" id="downBtn">Download it now</a>
                    
        </div>
        <!-- /.container -->
    </section>

		  <!-- Modal -->
		  <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content memberLogin">
		        <div class="modal-header">
		          <button type="button" class="close" id="modalClose" data-dismiss="modal">&times;</button>
		          <br>
		          <br>
		          <h4 class="modal-title loginTitle" id="dragNoteTitle">Memory Lane LogIn</h4>
		          <br>
		        </div>
		        <br>
		        	<div class="modal-body joinModal" id="joinModal">
		          	<form name="joinfrm" id="joinfrm">       
			    	<div id="joinInfo">
			    			<div class="form-group">
			    			 <label for="name">name:</label>
			    			 <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" required="" autofocus="" />
			    			</div>
			    			<div class="form-group">
			    			 <label for="email">Email:</label>
			    			 <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required="" autofocus="" />
			    			 <span id="emailck"></span>
			    			</div>
			    			<div class="form-group">
			    			 <label for="password">password:</label>
			    			 <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required="" autofocus="" />
			    			</div>
			    			<div class="form-group">
			    			 <label for="passwordConf">password check:</label>
			    			 <input type="password" class="form-control" id="passwordConf" name="passwordConf" placeholder="비밀번호를 확인하세요" required="" autofocus="" />
			    			 <span id="checkPwd"></span>
			    			</div>
			    		</div>
			    		<table>
			    		<tr>
			    			<td colspan="2">&nbsp;&nbsp;</td>
			    		</tr>
						</table>
						<table class="btns_align">
			    			<td id="btns btn_space">
							    <button id="joinBtn" class="btn btn-default join_ok join_btns">회원가입</button>   
							    <button id="cancelBtn" class="btn btn-default join_no join_btns">취소</button>  
			    			</td>
			    		</tr>
		    		</table>
			    </form>
		        	</div>
		        	
		        <div class="modal-body" id="loginModal" >
		          	
		          	
		          	<form name="loginfrm" id="loginfrm">       
			    	<table id="loginInfo">
			    		<tr>
			    			<div class="form-group">
			    			 <label for="loginEmail">Email:</label>
			    			 <input type="text" class="form-control" id="loginEmail" name="loginEmail" placeholder="Email Address" required="" autofocus="" />
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
							    <label for="loginPassword">Password:</label>
							    <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="Password" required=""/>
			    			</div>
			    		</tr>
			    	</table>
			    	<table class="btns_align">
					    <tr>
					    	<td id="btns btn_etc btn_space">
							    <button id="loginBtn" class="btn btn-default login_ok">로그인</button>   
							    <div id="joinFormBtn" class="btn btn-default login_no">회원가입</div>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		<!--           <div id="googleLoginDiv" align="center" class="g-signin2 googleLogin" data-onsuccess="onSignIn"></div> -->
		          
		        </div>
		      </div>
		    </div>
		  </div>

    <!-- Footer -->
    <section id="contact" class="contact">
    <footer id="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 text-center">
                    <h4><strong>MemoryLane</strong>
                    </h4>
                    <p>서울 강남구 삼성동 COEX 4F ICT교육센터</p>
                    <ul class="list-unstyled">
                        <li><i class="fa fa-phone fa-fw"></i> (010) 1234-5678</li>
                        <li><i class="fa fa-envelope-o fa-fw"></i> <a href="mailto:name@example.com">name@example.com</a>
                        </li>
                    </ul>
                    <p class="text-muted">Copyright &copy; 잊지못해NotNull</p>
                </div>
            </div>
        </div>
        <a id="to-top" href="#top" class="btn btn-dark btn-lg"><i class="fa fa-chevron-up fa-fw fa-1x"></i></a>
    </footer>
    </section>

    <script>
    //모달 회원가입창버튼 
    $("#joinFormBtn").click(function (){
    	$("#dragNoteTitle").html("Welcome to Memory Lane")
    	$('#loginModal').css('display', 'none');
    	$('#joinModal').css('display', 'block');
    	return false;
    })
    //모달 취소버튼
    $("#cancelBtn").click(function (){
    	$("#dragNoteTitle").html("Welcome to Memory Lane")
    	$('#loginModal').css('display', 'block');
    	$('#joinModal').css('display', 'none');
    	return false;
    })
    //비밀번호 확인
    $("#passwordConf").on("keyup",function(){
		var f1 = document.joinfrm;
		var pw1 = f1.password.value;
		var pw2 = f1.passwordConf.value;
		if(pw1!=pw2) {
		$('#checkPwd').css('color', 'red');
		document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요."; 
		}else{
		$('#checkPwd').css('color', 'green');
		document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다."; 
		}
    })
    
    //이메일 중복 확인
    $("#email").on("keyup",function(){
    	var validate = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    	var f1 = document.joinfrm;
		var email = f1.email.value;
		console.log("test: "+email)
		if(email == "") document.getElementById('emailck').innerHTML = "";
		var emailok = validate.test(email);
		$.ajax ({
    		url: "/memory/member/emailCheck",
    		type: "POST",
    		data: {"email" : email},
    		success : function(result) {
    					var check = result.email;
	    	    		if(!result && email != ""){
	    	    			$('#emailck').css('color', 'red');
	    	    			document.getElementById('emailck').innerHTML = "이미 사용중인 이메일 입니다."; 
	    	    		}
	    	    		if(result && email != "") {
	    	    			$('#emailck').css('color', 'green');
	    	    			document.getElementById('emailck').innerHTML = "사용가능한 이메일 입니다.";
	    	    		}
	    	    		if(!emailok && email != "") {
	    	    			$('#emailck').css('color', 'red');
	    	    			document.getElementById('emailck').innerHTML = "Email주소를 올바른 형식으로 입력하세요"; 
	    	    		}
    	    		}
		});
    })
    
/*     function validateEmail(email) {
    	return re.test(email);
    }   */
    
    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    
    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    
    // Scrolls to the selected menu item on the page
/*     $(function() {
        $('a[href*=#]:not([href=#],[data-toggle],[data-target],[data-slide])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    }); */
    
    //#to-top button appears after scrolling
    var fixed = false;
    $(document).scroll(function() {
        if ($(this).scrollTop() > 250) {
            if (!fixed) {
                fixed = true;
                // $('#to-top').css({position:'fixed', display:'block'});
                $('#to-top').show("slow", function() {
                    $('#to-top').css({
                        position: 'fixed',
                        display: 'block'
                    });
                });
            }
        } else {
            if (fixed) {
                fixed = false;
                $('#to-top').hide("slow", function() {
                    $('#to-top').css({
                        display: 'none'
                    });
                });
            }
        }
    });
    
    // Disable Google Maps scrolling
    // See http://stackoverflow.com/a/25904582/1607849
    // Disable scroll zooming and bind back the click event
    var onMapMouseleaveHandler = function(event) {
        var that = $(this);
        that.on('click', onMapClickHandler);
        that.off('mouseleave', onMapMouseleaveHandler);
        that.find('iframe').css("pointer-events", "none");
    }
    
    var onMapClickHandler = function(event) {
            var that = $(this);
            // Disable the click handler until the user leaves the map area
            that.off('click', onMapClickHandler);
            // Enable scrolling zoom
            that.find('iframe').css("pointer-events", "auto");
            // Handle the mouse leave event
            that.on('mouseleave', onMapMouseleaveHandler);
        }
        // Enable map zooming with mouse scroll when the user clicks the map
    $('.map').on('click', onMapClickHandler);
        
    $("#loginBtn").click(function () {
    	$.ajax ({
    		url: "/memory/member/login",
    		type: "POST",
    		data: {
					"email" : $("input[name=loginEmail]").val(),
					"mem_pwd" : $("input[name=loginPassword]").val()
					},
    		success : function(result) {
    					var i = result.approvalNum;
    					var a = result.email;
	    	    		if(a != null && i != 1){
	    	    			localStorage.setItem("memberNo", result.mem_no);
	    	    			location.href='/memory/index';
	    	    		}
	    	    		
	    	    		else if(a != null && i == 1){
	    	    			alert("계정이 정지되었습니다. 관리자에게 문의해주세요.\n※관리자Email: admin@memory.lane")
	    	    		}
	    	    		else {
	    	    			alert("ID/PWD를 확인해 주세요.")
	    	    		}
    	    		}
		});
    	return false;
	});
        
	$("#joinBtn").click(function () {
	   	var frm = document.joinfrm;
	   	if (frm.name.value == "") {
	   		frm.name.focus();
	   		alert("이름을 입력하세요");
	   		return false;
	   	}
	   	if (frm.email.value == "") {
	   		frm.email.focus();
	   		alert("E-mail을 입력하세요");
	   		return false;
	   	}
	   	if (frm.password.value == "") {
	   		frm.password.focus();
	   		alert("비밀번호를 입력하세요");
	   		return false;
	   	}
	   	if (frm.passwordConf.value == "") {
	   		frm.passwordConf.focus();
	   		alert("비밀번호 확인란에도 입력하세요");
	   		return false;
	   	}
	   	if(frm.password.value != frm.passwordConf.value){
	   		frm.passwordConf.focus();
	   		alert("비밀번호가 다릅니다");
	   		return false;	  
	   	}
	   	$.ajax ({
			url: "/memory/member/join",
	    	type: "POST",
	    	data: {
	 			"name" : $("input[name=name]").val(),    			
	    		"email" : $("input[name=email]").val(),
	    		"mem_pwd" : $("input[name=password]").val()
	    		},
	    	success: function(result) {
	    			if(result) {
						alert("회원가입완료");
	 	    	    	frm.name.value = "";
	 	    	    	frm.email.value = "";
	 	    	    	frm.password.value = "";
	 	    	    	frm.passwordConf.value = "";
	 	    	    	$('#loginModal').css('display', 'block');
	 	    	    	$('#joinModal').css('display', 'none');
	    				$("#myModal").modal('hide');
	     			} else alert("회원가입 실패");
	     	    },
	     	error: alert("이메일이 중복되었거나, 올바르게 입력되지 않았습니다.")
	     	});
	     	return false;
	    });

		//다운로드 링크주기
// 	    function downloadUrl(){
// 	    	window.open("https://chrome.google.com/webstore/detail/drag-note/hljfaipfmfnppbpkkdmdchehfpoehflh?utm_source=gmail", "_blank")
// 	    };
    </script>
</body>
</html>