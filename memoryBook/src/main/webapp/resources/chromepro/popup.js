var value = "";
var e ="";
var p = "";
$("#join").on('click',(function(){
	 window.open("http://localhost:8888/memory/");

}));

$("#login").click(function () {
	var text =$("#email").val();  
	var pwd = $("#pw").val();
	$.ajax ({
		url: "http://localhost:8888/memory/member/login_ex",
		type: "POST",
		data: {
			"email" : text,
			"mem_pwd" : pwd
			},
		dataType: 'JSON',
		success : function(result) {
		  		if(result != null){
		             value = result.name;
		             e = result.email;
		             p = result.mem_pwd;
		             photo = result.mem_image;
		             localStorage.setItem("name", value);
		           localStorage.setItem("email",e);
		           localStorage.setItem("photo", photo);
		           localStorage.setItem("password",p);
		           
		           var addRow = '<img id="userPhoto" style="border: 4px solid #FFF; margin: 3px;" width="140px" height="140px" src="http://localhost:8888/memory/data/mem_image/'+photo+'" class="media-photo img-circle">';
		           $("#popupDiv").append(addRow);
		           $('<h3></h3>').html(value).appendTo('h3');
		           $('<span></span>').html(e).appendTo('span');
		            document.querySelector("#afterLogin").style.display = "block";
		            document.querySelector("#loginForm").style.display = "none";
		  		} else {
    	    			alert("ID/PWD를 확인해 주세요")
    	    		}
	    		},
			error : function(result){
				alert(result+"에러에러");
			}
	}); 
});

document.querySelector("#logoutBtn").onclick = function () {
	localStorage.clear();
    $('h3').empty();
    $('span').empty();
    $("#popupDiv").empty();
    document.querySelector("#afterLogin").style.display = "none";
    document.querySelector("#loginForm").style.display = "block";
    stopDrag();
}

window.onload = function () {
    if(localStorage.getItem("email") != null) {
    	var value = localStorage.getItem("name");
    	var e = localStorage.getItem("email");
    	var photo = localStorage.getItem("photo");
    
    var addRow = '<img id="userPhoto" style="border: 4px solid #FFF; margin: 3px;" width="140px" height="140px" src="http://localhost:8888/memory/data/mem_image/'+photo+'" class="media-photo img-circle">';
    
    $("#popupDiv").append(addRow);
    $('<h3></h3>').html(value).appendTo('h3');
    $('<span></span>').html(e).appendTo('span');
    
    document.querySelector("#afterLogin").style.display = "block";
    document.querySelector("#loginForm").style.display = "none";
    $('<h4></h4>').html(localStorage.getItem("name")+"님 어서오세요!").appendTo('h4');
    }
}

$("#drag").click(function(){
	allowDrag();
});

$("#homeOpenBtn").click(function () {
	   	$.ajax ({
	    		url: "http://localhost:8888/memory/member/login",
	    		type: "POST",
	    		data: {
	    			"email" : localStorage.getItem("email"),
	    			"mem_pwd" : localStorage.getItem("password")
	    			},
	    		success : function(result) {
		    	    		if(result.approvalNum == 0){
		    	    			alert("로그인 완료.")
		    	    			window.open('http://localhost:8888/memory/index');
		    	    		}
		    	    		else if(result.approvalNum == 1){
		    	    			alert("계정이 정지되었습니다. 관지라에게 문의해주세요.")
		    	    		}
		    	    		else {
		    	    			alert("ID/PWD를 확인해 주세요.")
		    	    		}
	    	    		}
	    	});
	    	return false;
		
 });

function allowDrag(){
   chrome.tabs.executeScript({
      code:  'var prevText;  $("body").mouseup(function(){'
          +  'var range = window.getSelection().getRangeAt(0),'
          +  '     content = range.extractContents(),'
          +  '        span = document.createElement("SPAN");'
          +  '   console.log(content);'
          +  '      span.appendChild(content);'
          +  '      var htmlContent = span.innerHTML;'
          +  '     range.insertNode(span);'
          +  '     var text = htmlContent;' 
          +  '     console.log(text);'
          +  '      var dragUrlTitle = document.getElementsByTagName("title")[0].innerHTML.replace(/&/g, "&amp;");'
          +  '      if (text !="" && text.length > 1 && $.trim(text).length != 0 && prevText != text) {'
          +  '$.ajax({'
          +  '    url: "http://localhost:8888/memory/drag/registDrag",'
          +  '   type: "POST",'   
          +  '    data: {"dragContent": text,'
          +  '            "dragUrlTitle": dragUrlTitle'
          +  '}, '   
          +  '   success: function (result) {'
          +  '      alert("등록성공");'
          +  '      prevText = text;'
          +  '     window.getSelection().removeAllRanges();'
          +  '    },'
          +  '   error: function (jqXhr, textStatus, errorText) {'
          +  '      alert("에러발생 : " + errorText); '
          +  '   }'
          +  ' });'
          +  '}' 
          +  ' });' 
      },function (result) {
            console.log("good:)");
      });
   
};

function stopDrag() {
	chrome.tabs.executeScript({
		code: ' location.reload()'
		}, function (result) {
	     console.log("good:)");
	   });
}