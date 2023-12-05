	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

$(document).ready(function() {
	
	var form1 = $('#selfdevCmmVO');

	
	
	function moveSelfdevCmmYear(event){
		var offset =0;
		if(typeof event=="object")
			offset = event.data.key1;
		else
			offset = 0;
		var year = parseInt($('#selfdevCmmYearS').html()) + parseInt(offset);		
		//var formClone = form1.clone();
		var formClone = form1;
		formClone.attr("action", "/admin/approval/selectSelfdevList.do?year=" + year);
 	 	formClone.submit();
	}
	
	form1.find("input[type=text]").keyup(function(){
		jsMakeCurrency(this);
	});

	$('#selfdevCmmYearBackB').bind("click", {key1 : -1}, moveSelfdevCmmYear);
	$('#selfdevCmmYearForwardB').bind("click", {key1 : 1}, moveSelfdevCmmYear);
	
	
	
	//기본한도 저장
	$('#selfdevCmmSaveB').click(function(){
		//validate
		//jQuery clone function has IE bug 
		//var formClone = form1.clone();
		var formClone = form1;
		var inputList = formClone.find("input[type=text]");
 	 	for(var i =0; i<inputList.length; i++) {
 	 		inputList[i].value = jsDeleteComma(inputList[i].value) ;
 	 		if(inputList[i].value==null || inputList[i].value=="" || isNaN(inputList[i].value)) {
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 		inputList[i].value= inputList[i].value* 1000;
 	 	} 
 	 	
 	 	var year = ${year};
 	 	formClone.attr("action", "/admin/approval/updateSelfdevCmm.do?year=" + year);
 	 	formClone.submit();
	});
	
	
	
	

	
	
	
	
	
	function moveSelfdevUsrYearOld(event){
		var offset =0;
		if(typeof event=="object")
			offset = event.data.key1;
		else
			offset = 0;
		var year = parseInt($('#selfdevUsrYearS').html()) + parseInt(offset);
		$.post("/ajax/selectSelfdevUsrList.do?year=" + year, function(data){
			$('#selfdevUsrYearS').html(year + "년");
			$('#selfdevUsrListD').html(data);
		});
	}
	
	function moveSelfdevUsrYear(event){
		var offset =0;
		if(typeof event=="object")
			offset = event.data.key1;
		else
			offset = 0;
		var year = parseInt($('#selfdevUsrYearS').html()) + parseInt(offset);		
		//var formClone = form1.clone();
		var formClone = form1;
		formClone.attr("action", "/admin/approval/selectSelfdevList.do?year=" + year);
 	 	formClone.submit();
	}
	
	form1.find("input[type=text]").keyup(function(){
		jsMakeCurrency(this);
	});

	$('#selfdevUsrYearBackB').bind("click", {key1 : -1}, moveSelfdevUsrYear);
	$('#selfdevUsrYearForwardB').bind("click", {key1 : 1}, moveSelfdevUsrYear);
	
	//개인별 수정
	$('.selfdevUsrModifyB').live("click",function(){
		var selfdevUsrNo = $(this).closest('tr').find("input[name=selfdevUsrNo]").val();
		$.post("/ajax/admin/approval/modifySelfdevUsr.do?selfdevUsrNo="+selfdevUsrNo,function(data){

			var layer = $('<div id="projectInputL">'+ data + '</div>');
			layer.appendTo('body');
			layer.dialog({
	 		    height: 300
				,width:500 
				,closeOnEscape: true 
				,resizable: true 
				,draggable: true
				//,modal :true
				,autoOpen: true 		
				,position : [300,200]   
 				,close: function(event,ui){
					layer.remove();
					moveSelfdevUsrYear();
		 		}
			});
		 	
		 	layer.find('#userTreeGenB').click(function(){
		 		usrGen("userMix",1);
			 	});
		 			
			layer.find('#selfdevUsrSaveB').click(function(){
				
				$.post("/ajax/admin/approval/updateSelfdevUsr.do",$('#selfdevUsrVO').serialize(),function(data){
					//alert("저장되었습니다.");
					layer.dialog("destroy");
					//reload 
					moveSelfdevUsrYear();
				});
			});
			
			layer.find('#selfdevUsrCancleB').click(function(){
				layer.dialog("destroy");
				moveSelfdevUsrYear();				
			});			
		});
	});

	//등록
	$('#selfdevUsrWriteB').live("click",function(){
		$.post("/ajax/admin/approval/writeSelfdevUsr.do",function(data){
			var layer = $('<div id="projectInputL">'+ data + '</div>');
			layer.appendTo('body');
			layer.dialog({
	 		    height: 300
				,width:500 
	 		   	,closeOnEscape: true 
				,resizable: true 
				,draggable: true
				//,modal :true
				,autoOpen: true 		
				,position : [300,200] 
				,close: function(event,ui){
					layer.remove();
					moveSelfdevUsrYear();
	 		}
		 	});

			var year = ${year};
			var month = ${thisMonth};
			//if(month>9) //ajax에서 submit 방식으로 변경해서 필요없어짐, 변경 이유는 레이어 다이얼로그가 두번째 열때 생기는 오류 때문. 등록 두번 열어보면 쉽게 알 수 있다.
				//year++;

			document.selfdevUsrVO.year.value = year;
			document.selfdevUsrVO.percent.value = 120;
			document.selfdevUsrVO.description.value = '장기근속 할증';				
			
			var userArray =null;
		    $.post("/ajax/selectUserListJson.do",function(data){
			    userArray = eval(data);
			});
		    
		    function split( val ) {
				return val.split( /,\s*/ );
			}
			function extractLast( term ) {
				return split( term ).pop();
			}		    
		    
			layer.find('#selfdevUsrSaveB').click(function(){
				$.post("/ajax/admin/approval/insertSelfdevUsr.do", $('#selfdevUsrVO').serialize(),function(data){
						//alert("등록되었습니다.");
						layer.dialog("destroy");
						moveSelfdevUsrYear();
				});
			});

			layer.find('#selfdevUsrCancleB').click(function(){
				layer.dialog("destroy");
				moveSelfdevUsrYear();				
			});			
		});		
	});

	//개인별 삭제
	$('.selfdevUsrDeleteB').live("click",function(){
		if(confirm("정말 삭제하시겠습니까?")){
			var selfdevUsrNo = $(this).closest('tr').find("input[name=selfdevUsrNo]").val();
			
			$.post("/ajax/admin/approval/deleteSelfdevUsr.do?selfdevUsrNo="+selfdevUsrNo,function(data){
				//alert(data);
				moveSelfdevUsrYear();
			});
		}

	});
});

function addYear(offset){
	var year = document.selfdevUsrVO.year.value;
	year = (year*1) + (offset*1);
	document.selfdevUsrVO.year.value = year;	
}
function addPercent(offset){
	var percent = document.selfdevUsrVO.percent.value;
	percent = (percent*1) + (offset*1);
	document.selfdevUsrVO.percent.value = percent;
}
function setDescription(mode){
	if(mode == 0)
		document.selfdevUsrVO.description.value = '';
	if(mode == 1)
		document.selfdevUsrVO.description.value = '장기근속 할증';
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
							<li class="stitle">자기개발비 한도 관리</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">	
						<form name="selfdevCmmVO" id="selfdevCmmVO" enctype="multipart/form-data" method="post">

						<!-- 게시판 시작  -->
						<p class="th_stitle">기본한도 - (단위 : 천원) </p>

						<div class="scheduleDate mB10">
	                		<img id="selfdevCmmYearBackB" class="cursorPointer" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<span class="option_txt" id="selfdevCmmYearS">${year}년</span>
	                		<img id="selfdevCmmYearForwardB" class="cursorPointer" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지" />
						</div>
						

						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col70" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">입사월</th>
								<th scope="col">1월</th>
								<th scope="col">2월</th>
								<th scope="col">3월</th>
								<th scope="col">4월</th>
								<th scope="col">5월</th>
								<th scope="col">6월</th>
								<th scope="col">7월</th>
								<th scope="col">8월</th>
								<th scope="col">9월</th>
								<th scope="col">10월</th>
								<th scope="col">11월</th>
								<th class="td_last" scope="col">12월</th>
								</tr>
							</thead>
							<tbody>
								<tr class="center">
									<td>전액한도</td>
									
									<c:forEach items="${resultList}" var="result" varStatus="status">
										<td <c:if test="${status.index==11 }">class="td_last txt_center" </c:if>>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="${result.fullPrint}"/>
										</td>										
									</c:forEach>
									<c:if test="${empty resultList}">
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td class="td_last txt_center">
											<input name="selfdevFullList" type="text" class="span_2 txt_center" value="0"/>
										</td>											
									</c:if>
									
								</tr>
								<tr class="center">
									<td>반액한도</td>
										<c:forEach items="${resultList}" var="result" varStatus="status">
										<td <c:if test="${status.index==11 }">class="td_last txt_center" </c:if>>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="${result.halfPrint}"/>
										</td>										
									</c:forEach>
									<c:if test="${empty resultList}">
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td>
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>	
										<td class="td_last txt_center">
											<input name="selfdevHalfList" type="text" class="span_2 txt_center" value="0"/>
										</td>											
									</c:if>									
								</tr>
							</tbody>
							</table>
						</div>
		                   
	                    <div class="btn_area03">
	                		<img src="${imagePath}/admin/btn/btn_changeapply.gif" id="selfdevCmmSaveB" class="cursorPointer"/>
	               		</div>
	              		 </form>
						<p class="th_stitle mB10"">개인별 조정 비율</p>
						
						<div class="scheduleDate mB10">
	                		<img id="selfdevUsrYearBackB" class="cursorPointer" src="${imagePath}/admin/btn/btn_first.gif" alt="처음페이지" />
	                		<span class="option_txt" id="selfdevUsrYearS">${year}년</span>
	                		<img id="selfdevUsrYearForwardB" class="cursorPointer" src="${imagePath}/admin/btn/btn_end.gif" alt="마지막 페이지" />
						</div>	
						
						<div class="boardList" id="selfdevUsrListD">
							<%@ include file="./include/selfdevUsrL.jsp"%>
						</div>						
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<img src="${imagePath}/admin/btn/btn_regist.gif" id="selfdevUsrWriteB" class="cursorPointer"/>
		                </div>
		                <!-- 버튼 끝 -->	
		                
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
</body>
</html>
