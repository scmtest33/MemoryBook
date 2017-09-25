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

<title>회원 목록</title>
</head>

<body>
	<div class="container">
	<div class="row">

		<section class="content">
			<h1 class="pageTitle">회원 목록</h1>
			<div class="col-md-8 col-md-offset-2">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="pull-right">
							<div class="btn-group">
								<button type="button" class="btn btn-success btn-default btn-filter" data-target="open">일반회원보기</button>
								<button type="button" class="btn btn-danger btn-default btn-filter" data-target="lock">정지회원보기</button>
								<button type="button" class="btn btn-primary btn-default btn-filter" data-target="all">모두보기</button>
<!-- 								<button type="button" class="btn btn-default btn-filter" id="ban">회원정지</button> -->
<!-- 								<button type="button" class="btn btn-default btn-filter" id="cancelBan">정지해제</button> -->
							</div>
						</div>
						<div class="table-container">
							<table id="table2" class="table table-filter">
									
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
		
	</div>
</div>
</body>


<script>
	
// 	$("#ban").click(function(){
// 		var check = document.getElementByName("checkbox");
		
// 		for(var i = 0; i < check.length; i++) {
// 			alert(check);

// 	    }
		
// 		var check = confirm("정말로 정지시키시겠습니까?");
// 			if(check){
// 			$.ajax({
// 				url: "/memory/member/click",
// 				dataType: "json",
// 				type: "post",
// 				data: {"name": item.name,"approvalNum" :item.approvalNum},
// 				success: function(result){
// 					if(result){
// 						$(".list").empty();
// 						getList();
// 					}
					
// 				}
// 			});
// 		}
// 	}); 

	$(function(){
		getList();
	});

	function getList(){
		$.ajax({
			url: "/memory/member/getList",
			dataType: "json",
			success: function(result){   		
						$(result).each(function(index, item) {
								var addRow = '<tbody>';
								if(item.approvalNum == 0){
										addRow += '<tr data-status="open">';
									}else{
										addRow += '<tr data-status="lock">';	
									}
// 								addRow += '<td><div class="ckbox"><input type="checkbox" name="checkbox" id="checkbox'+index+'"><label for="checkbox'+index+'"></label></div></td>';
								addRow += '<td><div class="media">';
								addRow += '<td><a href="#" class="media-photo"><img src="/memory/data/mem_image/'+item.mem_image+'" class="media-photo img-circle"></a></td>';
								addRow += '<td><div class="media-body"><h4 id="userName">'+ item.name + '</h4> <p id="userEmail">'+ item.email +'</p></div></td>';
								if(item.approvalNum == 0){
					                   addRow +='<td class = "practice">' + '<img id = "normal'+index+'" src = "/memory/resources/img/open-lock.png">' + '</td>';
					                }else{
					                   addRow +='<td class = "practice">' + '<img id = "stop'+index+'" src = "/memory/resources/img/lock.png">' + '</td>';
					                }
								addRow += '</div></td>';
								addRow += '</tr></tbody>';
								$("#table2").append(addRow);
								//정지해제function
								$("#stop"+index).click(function(){
									var check = confirm("정말로 해제시키시겠습니까?");
									if(check){
										$.ajax({
											url: "/memory/member/click",
											dataType: "json",
											type: "post",
											data: {"name": item.name, "approvalNum" :item.approvalNum},
											success: function(result){
												if(result){
													$("#table2").empty();
													getList();
												}
											}
										});
									}
								});
								//정지function
								 $("#normal"+index).click(function(){
									var check = confirm("정말로 정지시키시겠습니까?");
										if(check){
										$.ajax({
											url: "/memory/member/click",
											dataType: "json",
											type: "post",
											data: {"name": item.name,"approvalNum" :item.approvalNum},
											success: function(result){
												if(result){
													$("#table2").empty();
													getList();
												}
												
											}
										});
									}
								});
						});
					}
		});
	}


$(document).ready(function () {

	$('.star').on('click', function () {
      $(this).toggleClass('star-checked');
    });

    $('.ckbox label').on('click', function () {
      $(this).parents('tr').toggleClass('selected');
    });

    $('.btn-filter').on('click', function () {
      var $target = $(this).data('target');
      if ($target != 'all') {
        $('.table tr').css('display', 'none');
        $('.table tr[data-status="' + $target + '"]').fadeIn('slow');
      } else {
        $('.table tr').css('display', 'none').fadeIn('slow');
      }
    });

 });
</script>
</html>