<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<%@ include file="../include/common_inc.jsp"%>

<script>
var rankYear = ${year}; 
var rankMonth = ${month};
var userYear = ${year}; 
var userMonth = ${month};
$(document).ready(function(){	
});

function rankSalaryMove(pos) {
	var preMonth = rankMonth;
	var preYear = rankYear;
	rankMonth = rankMonth + pos;
	if(rankMonth< 1) {
		rankYear--;
		rankMonth = rankMonth + 12;
	} else if(rankMonth> 12) {
		rankYear++;
		rankMonth = rankMonth - 12;
	}
	
	$.post("/ajax/admin/salary/rankSalaryAjax.do?year=" + rankYear +"&month=" + rankMonth ,function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			rankYear = preYear;
			rankMonth = preMonth;
		} else {
			$('#rankSalaryD').html(data);
			$('#rankSalaryYearS').html(rankYear+"년 " + rankMonth + "월");
		}
	});
}

function userSalaryMove(pos) {
	var preMonth = userMonth;
	var preYear = userYear;
	userMonth = userMonth + pos;
	if(userMonth< 1) {
		userYear--;
		userMonth = userMonth + 12;
	} else if(userMonth> 12) {
		userYear++;
		userMonth = userMonth - 12;
	}
	
	$.post("/ajax/admin/salary/userSalaryAjax.do?year=" + userYear +"&month=" + userMonth ,function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			userYear = preYear;
			userMonth = preMonth;
		} else {
			$('#userSalaryD').html(data);
			$('#userSalaryYearS').html(userYear+"년 " + userMonth + "월");
		}
	});
}

function editRankSalary(rankCode, elem) {
	var position = $(elem).position();
	$.post("/ajax/admin/salary/rankSalaryP.do?year=" + rankYear +"&rankCode=" + rankCode ,function(data){
		$("#tab1").html(data);
		$("#tab1").show();
		$("#tab1").dialog(
				{ 
		 		    height: 344
		 		   ,width: 599
		 		   ,closeOnEscape: true 
		 		   ,resizable: true 
		 		   ,draggable: true
		 		   //,modal: true   	
		 		   ,autoOpen: true 		
		 		   ,position : [position.left-500,position.top+20]   
		 			 });
		$("#tab1 input").keyup(function(){jsMakeCurrency(this)});
				
		$('#saveB').click(function(){
			//익스플로러에서 클론으로 변경된 값이 안 넘어오는 버그때문에 수정
			//var formClone = $('#rankSalaryForm').clone(); 
			var formClone = $('#rankSalaryForm');
			var inputList =  formClone.find("input[type=text]");
			
	 	 	for(var i =0; i<inputList.length; i++) {
	 	 		var val = inputList[i];	 	 		
	 	 		val.value = jsDeleteComma(val.value);
	 	 		if(val.value==null ||val.value=="" || isNaN(val.value))	{
	 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 	 	 		val.focus();
	 	 	 		delete formClone;
	 	 	 		return;
	 	 		}
	 	 	} 
			$.post("/ajax/admin/salary/rankSalaryU.do?year=" + rankYear +"&rankCode=" + rankCode, formClone.serialize(),
					function(data){
					if(data.indexOf("success"))
					{
						//elem 의 salary 값 변경 해주기.
						$(elem).parent().siblings(".rankSalary").html(
								jsAddComma( $('#rankSalaryForm input[type=text]')[rankMonth-1].value) );
						
						$("#tab1").dialog( "destroy" );
						$("#tab1").html("");
						$("#tab1").hide();
					}
			});
		});

		$('#copyB').click(function(){
			var inputList = $("#rankSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++)
	 	 	{
		 	 	if(i==0)
	 	 			var val = inputList[i].value;
		 	 	else
			 	 	inputList[i].value = val;
	 	 	} 
			
		});

		$('#cancleB').click(function(){
			$("#tab1").dialog( "destroy" );
		});
	});
}


function editUserSalary(userNo,elem)
{
	var position = $(elem).position();
	$.post("/ajax/admin/salary/userSalaryP.do?year=" + userYear +"&userNo=" + userNo ,function(data){
		$("#tab1").html(data);
		$("#tab1").show();
		$("#tab1").dialog(
				{ 
		 		    height: 544
		 		   ,width: 599
		 		   ,closeOnEscape: true 
		 		   ,resizable: true 
		 		   ,draggable: true
		 		   //,modal: true   	
		 		   ,autoOpen: true 		
		 		   ,position : [position.left-500,position.top+20]   
		 			 });
		$("#tab1 input").keyup(function(){jsMakeCurrency(this)});
		$('#saveB').click(function(){
			//익스플로러에서 클론으로 변경된 값이 안 넘어오는 버그때문에 수정
			//var formClone = $('#userSalaryForm').clone();
			var formClone = $('#userSalaryForm');
			var inputList = formClone.find("input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++) {
	 	 		var val = inputList[i];
	 	 		val.value = jsDeleteComma(val.value);
	 	 		if(val.value==null || val.value=="" || isNaN(val.value)) {
	 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 	 	 		delete formClone;
	 	 	 		val.focus();
	 	 	 		return;
	 	 		}
	 	 	} 
			$.post("/ajax/admin/salary/userSalaryU.do?year=" + userYear +"&userNo=" + userNo, formClone.serialize(),
					function(data){
					if(data.indexOf("success"))	{						
						//elem 의 salary 값 변경 해주기.
						$(elem).parent().siblings(".userSalary1").html(
								jsAddComma( $('#userSalaryForm input[type=text]')[(userMonth-1)*3].value) );
						$(elem).parent().siblings(".userSalary2").html(
								jsAddComma( $('#userSalaryForm input[type=text]')[(userMonth-1)*3+1].value) );
						$(elem).parent().siblings(".userSalary3").html(
								jsAddComma( $('#userSalaryForm input[type=text]')[(userMonth-1)*3+2].value) );
						$(elem).parent().siblings(".isRegistered").html('등록');
						$("#tab1").dialog( "destroy" );
						$("#tab1").html("");
						$("#tab1").hide();
					}
			});
		});

		$('#copyB').click(function(){
			var inputList = $("#userSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i=i+3) {
		 	 	if(i==0) {
	 	 			var val1 = inputList[i].value;
	 	 			var val2 = inputList[i+1].value;
	 	 			var val3 = inputList[i+2].value;
		 	 	} else {
			 	 	inputList[i].value = val1;
			 	 	inputList[i+1].value = val2;
			 	 	inputList[i+2].value = val3;
		 	 	}
	 	 	} 			
		});

		$('#cancleB').click(function(){
			$("#tab1").dialog( "destroy" );
		});
	});
}

</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">인건비 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle mB10">직급별 기준인건비</p>
						
						<!-- 날짜 선택창 시작 -->
                 	    <div class="scheduleDate mB10">
	                		<img id="rankSalaryYearBackB" class="cursorPointer" onclick="javascript:rankSalaryMove(-12);" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<img id="rankSalaryMonthBackB" class="pR10 cursorPointer" onclick="javascript:rankSalaryMove(-1);" src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span class="option_txt" id="rankSalaryYearS">${year}년 ${month}월</span>
							<img id="rankSalaryYearForwardB" class="pL10 cursorPointer" onclick="javascript:rankSalaryMove(+1);"  src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
	                		<img id="rankSalaryYearForwardB" class="cursorPointer" onclick="javascript:rankSalaryMove(+12);" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지">
						</div>	
	        		    <!-- 날짜 선택창 끝 -->
	        		    
						<div id="rankSalaryD" class="boardList mB20">
							<jsp:include page="${jspPath}/admin/salary/include/rankSalary.jsp"></jsp:include>
						</div>
						
						<p class="th_stitle mB10">개인별 인건비</p>
						
						<!-- 날짜 선택창 시작 -->
                 	    <div class="scheduleDate mB10">
	                		<img id="userSalaryYearBackB" class="cursorPointer" onclick="javascript:userSalaryMove(-12);" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<img id="userSalaryMonthBackB" class="cursorPointer pR10" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span id="userSalaryYearS" class="option_txt">${year }년 ${month }월</span>
							<img id="userSalaryMonthForwardB" class="cursorPointer pL10" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
	                		<img id="userSalaryYearForwardB" class="cursorPointer" onclick="javascript:userSalaryMove(12);" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지">
						</div>
	        		    <!-- 날짜 선택창 끝 -->
	        		    
						<div id="userSalaryD" class="boardList">
							<jsp:include page="${jspPath}/admin/salary/include/userSalary.jsp"></jsp:include>
						</div>
							
						<!-- 게시판 끝  -->
							
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>

<!-- for hidden dialog -->
<div id="tab1">
</div>
</body>
</html>
