<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var rankYear =${year}; 
var rankMonth = ${month};
var userYear =${year}; 
var userMonth = ${month};
var positionYear=${year}; 
var positionMonth= ${month};
$(document).ready(function(){
	
});

function rankSalaryMove(pos)
{
	var preMonth = rankMonth;
	var preYear = rankYear;
	rankMonth = rankMonth + pos;
	if(rankMonth< 1)
	{
		rankYear--;
		rankMonth = rankMonth + 12;
	}

	else if(rankMonth> 12)
	{
		rankYear++;
		rankMonth = rankMonth - 12;
	}
	
	$.post("/ajax/admin/salary/rankSalaryHolAjax.do?year=" + rankYear +"&month=" + rankMonth ,function(data){
		
		$('#rankSalaryD').html(data);
		$('#rankSalaryYearS').html(rankYear+"년 " + rankMonth + "월");
	});
}



function userSalaryMove(pos)
{
	var preMonth = userMonth;
	var preYear = userYear;
	userMonth = userMonth + pos;
	if(userMonth< 1)
	{
		userYear--;
		userMonth = userMonth + 12;
	}

	else if(userMonth> 12)
	{
		userYear++;
		userMonth = userMonth - 12;
	}
	
	$.post("/ajax/admin/salary/userSalaryHolAjax.do?year=" + userYear +"&month=" + userMonth ,function(data){
		$('#userSalaryD').html(data);
		$('#userSalaryYearS').html(userYear+"년 " + userMonth + "월");
	});
}

function positionSalaryMove(pos)
{
	var preMonth = positionMonth;
	var preYear = positionYear;
	positionMonth = positionMonth + pos;
	if(positionMonth< 1)
	{
		positionYear--;
		positionMonth = positionMonth + 12;
	}

	else if(positionMonth> 12)
	{
		positionYear++;
		positionMonth = positionMonth - 12;
	}
	
	$.post("/ajax/admin/salary/posSalaryHolAjax.do?year=" + positionYear +"&month=" + positionMonth ,function(data){
		$('#positionSalaryD').html(data);
		$('#positionSalaryYearS').html(positionYear+"년 " + positionMonth + "월");
	});
}

function editRankSalary(rankCode,elem)
{
	var position = $(elem).position();
	$.post("/ajax/admin/salary/rankSalaryHolP.do?year=" + rankYear +"&rankCode=" + rankCode ,function(data){
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
		$("#rankSalaryForm").find("input[type=text]").keyup(function(){
			jsMakeCurrency(this);
		});
		$('#saveB').click(function(){
			var inputList = $("#rankSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++)
	 	 	{
	 	 		var val = inputList[i];
	 	 		if(val.value==null || val.value=="" || isNaN(jsDeleteComma(val.value)))
	 	 		{
	 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 	 	 		return;
	 	 		}
	 	 	}
	 	 	var cloneForm = $("#rankSalaryForm").clone();
	 	 	cloneForm.find("input[type=text]").each(function()
	 		 	 	{$(this).val(jsDeleteComma($(this).val()))
 		 	 });
			$.post("/ajax/admin/salary/rankSalaryHolU.do?year=" + rankYear +"&rankCode=" + rankCode,cloneForm.serialize(),
					function(data){
					if(data.indexOf("success"))
					{
						//elem 의 salary 값 변경 해주기.
						$(elem).parent().siblings(".rankSalary").html($('#rankSalaryForm input[type=text]')[rankMonth-1].value);
						
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

function editPositionSalary(positionCode,elem)
{
	var position = $(elem).position();
	$.post("/ajax/admin/salary/posSalaryHolP.do?year=" + positionYear +"&positionCode=" + positionCode ,function(data){
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
		$("#positionSalaryForm input[type=text]").keyup(function(){
			jsMakeCurrency(this);
		});
		$('#saveB').click(function(){
			var inputList =  $("#positionSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++)
	 	 	{
	 	 		var val = inputList[i];
	 	 		if(val.value==null || val.value=="" || isNaN(jsDeleteComma(val.value)))
	 	 		{
	 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 	 	 		return;
	 	 		}
	 	 	}
	 	 	var cloneForm = $("#positionSalaryForm").clone();
	 	 	cloneForm.find("input[type=text]").each(function()
	 		 	 	{$(this).val(jsDeleteComma($(this).val()))
 		 	 });
			$.post("/ajax/admin/salary/posSalaryHolU.do?year=" + positionYear +"&positionCode=" + positionCode,cloneForm.serialize(),
					function(data){
					if(data.indexOf("success"))
					{
						//elem 의 salary 값 변경 해주기.
						$(elem).parent().siblings(".positionSalary").html($('#positionSalaryForm input[type=text]')[positionMonth-1].value);
						
						$("#tab1").dialog( "destroy" );
						$("#tab1").html("");
						$("#tab1").hide();
					}
			});
		});

		$('#copyB').click(function(){
			var inputList = $("#positionSalaryForm input[type=text]");
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
	$.post("/ajax/admin/salary/userSalaryHolP.do?year=" + userYear +"&userNo=" + userNo ,function(data){
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
		$("#userSalaryForm input[type=text]").keyup(function(){
			jsMakeCurrency(this);
		});
		$('#saveB').click(function(){
			var inputList = $("#userSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++)
	 	 	{
	 	 		var val = inputList[i];
	 	 		if(val.value==null || val.value=="" || isNaN(jsDeleteComma(val.value)))
	 	 		{
	 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 	 	 		return;
	 	 		}
	 	 	}
	 	 	var cloneForm = $("#userSalaryForm").clone();
	 	 	cloneForm.find("input[type=text]").each(function()
	 		 	 	{$(this).val(jsDeleteComma($(this).val()))
 		 	 });
			$.post("/ajax/admin/salary/userSalaryHolU.do?year=" + userYear +"&userNo=" + userNo,cloneForm.serialize(),
					function(data){
					if(data.indexOf("success"))
					{
						//elem 의 salary 값 변경 해주기.
						$(elem).parent().siblings(".userSalary").html($('#userSalaryForm input[type=text]')[(userMonth-1)].value);
						
						$("#tab1").dialog( "destroy" );
						$("#tab1").html("");
						$("#tab1").hide();
					}
			});
		});

		$('#copyB').click(function(){
			var inputList = $("#userSalaryForm input[type=text]");
	 	 	for(var i =0; i<inputList.length; i++)
	 	 	{
		 	 	if(i==0)
		 	 	{
	 	 			var val1 = inputList[i].value;
		 	 	}
		 	 	else
		 	 	{
			 	 	inputList[i].value = val1;
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
							<li class="stitle">휴일근무수당 지급기준 관리</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">						
						<p class="th_stitle mB10">직급별 휴일근무수당 기준 금액</p>
						<!-- 상단 검색창 시작 -->
							<!-- 날짜 선택창 시작 -->
                 	    <div class="scheduleDate mB10">
	                		<img id="rankSalaryYearBackB" class="cursorPointer" onclick="javascript:rankSalaryMove(-12);" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<img id="rankSalaryMonthBackB" class="pR10 cursorPointer" onclick="javascript:rankSalaryMove(-1);" src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span class="option_txt" id="rankSalaryYearS">${year}년 ${month}월</span>
							<img id="rankSalaryYearForwardB" class="pL10 cursorPointer" onclick="javascript:rankSalaryMove(+1);"  src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
	                		<img id="rankSalaryYearForwardB" class="cursorPointer" onclick="javascript:rankSalaryMove(+12);" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지">
						</div>	
	        		    <!-- 날짜 선택창 끝 -->
		                
						<!-- 게시판 시작 -->
						<div id="rankSalaryD" class="boardList mB20">
							<jsp:include page="${jspPath}/admin/salary/include/rankSalaryHol.jsp"></jsp:include>
						</div>
						
						
						
						<p class="th_stitle mB10">보직별 휴일근무수당 기준금액</p>
						<div class="scheduleDate mB10">
	                		<img id="positionSalaryYearBackB" class="cursorPointer" onclick="javascript:positionSalaryMove(-12);" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<img id="positionSalaryMonthBackB" class="pR10 cursorPointer" onclick="javascript:positionSalaryMove(-1);" src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span class="option_txt" id="positionSalaryYearS">${year}년 ${month}월</span>
							<img id="positionSalaryYearForwardB" class="pL10 cursorPointer" onclick="javascript:positionSalaryMove(+1);"  src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
	                		<img id="positionSalaryYearForwardB" class="cursorPointer" onclick="javascript:positionSalaryMove(+12);" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지">
						</div>	
		                
						<!-- 게시판 시작 -->
							<div id="positionSalaryD" class="boardList mB20">
							<jsp:include page="${jspPath}/admin/salary/include/positionSalaryHol.jsp"></jsp:include>
						</div>
						
						<!-- 게시판 끝  -->
	                 	
						<p class="th_stitle mB10">개인별 휴일근무수당 기준금액</p>
						<!-- 상단 검색창 시작 -->
						<div class="scheduleDate mB10">
	                		<img id="userSalaryYearBackB" class="cursorPointer" onclick="javascript:userSalaryMove(-12);" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<img id="userSalaryMonthBackB" class="cursorPointer pR10" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span id="userSalaryYearS" class="option_txt">${year }년 ${month }월</span>
							<img id="userSalaryMonthForwardB" class="cursorPointer pR10" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
	                		<img id="userSalaryYearForwardB" class="cursorPointer" onclick="javascript:userSalaryMove(12);" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지">
						</div>	
		                <!-- 상단 검색창 끝 -->
		                
						<!-- 게시판 시작 -->
						<div id="userSalaryD" class="boardList">
							<jsp:include page="${jspPath}/admin/salary/include/userSalaryHol.jsp"></jsp:include>
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
<!-- foor hidden dialog -->
<div id="tab1">
</div>
</body>
</html>
