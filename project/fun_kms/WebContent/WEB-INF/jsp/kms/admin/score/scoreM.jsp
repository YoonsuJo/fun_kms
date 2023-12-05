<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){
 	$('#bbsPointSumitB').click(function(){
 	 	var inputList = $("#scoreBbsVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scoreBbsVO").attr("action", "/admin/score/scoreBatchU.do?category=BBS");
	 	$("#scoreBbsVO").submit();
 		});

 	$('#schedulePointSumitB').click(function(){
 		var inputList = $("#scoreScheduleVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scoreScheduleVO").attr("action", "/admin/score/scoreBatchU.do?category=SCH");
	 	$("#scoreScheduleVO").submit();
 		});

 	$('#mailPointSumitB').click(function(){
 		var inputList = $("#scoreMailVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scoreMailVO").attr("action", "/admin/score/scoreBatchU.do?category=MAL");
	 	$("#scoreMailVO").submit();
 		});

 	$('#notePointSumitB').click(function(){
 		var inputList = $("#scoreNoteVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scoreNoteVO").attr("action", "/admin/score/scoreBatchU.do?category=NOT");
	 	$("#scoreNoteVO").submit();
 		});
		
 	$('#etcPointSumitB').click(function(){
 		var inputList = $("#scoreEtcVO input[type=text]");
 	 	for(var i =0; i<inputList.length; i++)
 	 	{
 	 		var val = inputList[i];
 	 		if(val.value==null || val.value=="" || isNaN(val.value))
 	 		{
 	 	 		alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
 	 	 		val.focus();
 	 	 		return;
 	 		}
 	 	} 
	 	$("#scoreEtcVO").attr("action", "/admin/score/scoreBatchU.do?category=ETC");
	 	$("#scoreEtcVO").submit();
 		});
});
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
							<li class="stitle">점수관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">		
						<!-- 게시판 시작 -->
		                
		                <p class="th_stitle">나의업무보고 점수</p>
		                
						<p class="th_stitle mT20">근태 점수</p>

						<p class="th_stitle mT20">커뮤니티 점수</p>
						<p class="th_stitle2 mT10">게시판 점수</p>
						<form:form commandName="scoreBbsVO" name="scoreBbsVO" id="scoreBbsVO" method="post" enctype="multipart/form-data" >
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col70" /><col class="col90" /><col class="col90" /><col width="px" /><col class="col120" /><col class="col120" /></colgroup>
							<thead>
								<tr>
								<th scope="col">게시판코드</th>
								<th scope="col">게시판명</th>
								<th scope="col">게시물작성<br/>점수</th>
								<th scope="col">덧글작성 점수<br/><span class="T11">(등록 1주일 이내 게시물에 대한 덧글)</span></th>
								<th scope="col">게시물 열람점수<br/><span class="T11">(24시간 이내)</span></th>
								<th scope="col" class="td_last" >게시물 열람점수<br/><span class="T11">(24시간 이후)</span></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${scoreBbsList}" var="scoreElem">
								<input type ="hidden"" name="bbsCode" value="${scoreElem.code }"/>
									<tr class="center">
										<td>&nbsp;</td>
										<td>${scoreElem.nm }</td>
										<td><input type="text" name="point1List" class="span_2 txt_center" value="${scoreElem.articleInsert}"/></td>
										<td><input type="text" name="point2List" class="span_2 txt_center"  value="${scoreElem.commentInsert}"/></td>
										<td><input type="text" name="point3List" class="span_2 txt_center" value="${scoreElem.viewEarly}"/></td>
										<td class="td_last txt_center"><input type="text" name="point4List" class="span_2 txt_center" value="${scoreElem.viewLate}"/></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<div class="btn_area03">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="bbsPointSumitB"/>
		                </div>
						<!--// 게시판 끝  -->
						</form:form>
						<!-- 일정공유 점수 시작 -->
						<p class="th_stitle2 mT10">일정공유 점수</p>
						<form:form commandName="scoreScheduleVO" name="scoreScheduleVO" id="scoreScheduleVO" method="post" enctype="multipart/form-data" >
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col250" /><col width="px" /></colgroup>
							<thead>
								<tr>
								<th scope="col">종류</th>
								<th class="td_last" scope="col">등록점수 <span class="T11">(오늘 이후의 일정)</span></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${scoreScheduleList}" var="scoreElem">
								<input type ="hidden"" name="bbsCode" value="${scoreElem.code }"/>
								<tr class="center">
									<td>
										${scoreElem.nm}
									</td>
									<td class="td_last txt_center"><input type="text" class="span_2 txt_center" name="point1List" value="${scoreElem.point }"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form:form>
						<div class="btn_area03">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="schedulePointSumitB"/>
		                </div>
						<!--// 일정공유 점수 끝  -->
						
						<!-- 사내메일 점수 시작 -->
						<p class="th_stitle2 mT10">사내메일 점수</p>
						<form:form commandName="scoreMailVO" name="scoreMailVO" id="scoreMailVO" method="post" enctype="multipart/form-data" >
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col250" /><col width="px" /></colgroup>
							<thead>
								<tr>
								<th scope="col">항목</th>
								<th class="td_last" scope="col">점수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${scoreMailList}" var="scoreElem">
								<input type ="hidden"" name="bbsCode" value="${scoreElem.code }"/>
								<tr class="center">
									<td>
										${scoreElem.nm}
									</td>
									<td class="td_last txt_center"><input type="text" class="span_2 txt_center" name="point1List" value="${scoreElem.point }"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form:form>
						<div class="btn_area03">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="mailPointSumitB"/>
		                </div>
						<!--// 사내메일 점수 끝  -->
						
						<!-- 쪽지점수 시작 -->
						<p class="th_stitle2 mT10">쪽지 점수</p>
						<form:form commandName="scoreNoteVO" name="scoreNoteVO" id="scoreNoteVO" method="post" enctype="multipart/form-data" >
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col250" /><col width="px" /></colgroup>
							<thead>
								<tr>
								<th scope="col">항목</th>
								<th class="td_last" scope="col">점수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${scoreNoteList}" var="scoreElem">
								<input type ="hidden"" name="bbsCode" value="${scoreElem.code }"/>
								<tr class="center">
									<td>
										${scoreElem.nm}
									</td>
									<td class="td_last txt_center"><input type="text" class="span_2 txt_center" name="point1List" value="${scoreElem.point }"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form:form>
						<div class="btn_area03">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="notePointSumitB"/>
		                </div>
						<!--// 쪽지점수 끝  -->
						
						<!-- 기타점수 시작 -->
						<p class="th_stitle mT20">기타 점수 (** 미적용)</p>
						<form:form commandName="scoreEtcVO" name="scoreEtcVO" id="scoreEtcVO" method="post" enctype="multipart/form-data" >
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup><col class="col250" /><col width="px" /></colgroup>
							<thead>
								<tr>
								<th scope="col">항목</th>
								<th class="td_last" scope="col">점수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${scoreEtcList}" var="scoreElem">
								<input type ="hidden"" name="bbsCode" value="${scoreElem.code }"/>
								<tr class="center">
									<td>
										${scoreElem.nm}
									</td>
									<td class="td_last txt_center"><input type="text" class="span_2 txt_center" name="point1List" value="${scoreElem.point }"/></td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						</form:form>
						<div class="btn_area03">
		                	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="etcPointSumitB"/>
		                </div>
						<!--// 기타점수 끝  -->
		                
						
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
