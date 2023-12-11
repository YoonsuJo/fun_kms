<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function() {
	$('input[name=taskCntSj]').val(decodeURIComponent('${link.title}') + '(${link.userNm})');
});

function selRadio(bool) {
	if (bool == "Y") {
		document.getElementById("newTask_N").style.display = "none";
		document.getElementById("newTask_Y").style.display = "";
	}
	else if (bool == "N") {
		document.getElementById("newTask_N").style.display = "";
		document.getElementById("newTask_Y").style.display = "none";
	}
}

function register() {
	
	document.frm.taskCntSj.value = encodeURIComponent(document.frm.taskCntSj.value);
	
	document.frm.action = "${rootPath}/cooperation/insertTaskContent.do";
	document.frm.submit();
}

</script>
</head>

<body><div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">작업 관련자료 등록하기</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		<form name="frm" method="POST">
 		<input type="hidden" name="linkUrl" value="${link.linkUrl}"/>
 		<input type="hidden" name="taskCntTyp" value="${link.taskContentTyp}"/>
 		<div class="pop_board mB20">
	 		<p class="th_stitle">관련자료로 등록할 컨텐츠</p>
	 		<table cellpadding="0" cellspacing="0">
	 			<colgroup><col class="col90" /><col class="col170" /><col class="col90" /><col width="px"/></colgroup>
	 			<tbody>
	 				<tr>
	 					<td class="title">종류</td>
	 					<td class="pL10" colspan="3">
	 						<c:choose>
	 							<c:when test="${link.taskContentTyp == 'AP'}">전자결재</c:when>
	 							<c:when test="${link.taskContentTyp == 'CO'}">업무연락</c:when>
	 							<c:when test="${link.taskContentTyp == 'SB'}">자료공유</c:when>
	 							<c:when test="${link.taskContentTyp == 'TA'}">관련작업</c:when>
	 							<c:otherwise></c:otherwise>
	 						</c:choose>
	 					</td>
	 				</tr>
	 				<tr>
	 					<td class="title" >제목</td>
	 					<td class="pL10" colspan="3">
	 						<input type="text" name="taskCntSj" value="" style="width:320px;"/>
	 					</td>
	 				</tr>
	 			</tbody>
	 		</table>
 		</div>
 		
 		<div class="pop_board">
	 		<p class="th_stitle">컨텐츠와 연관된 작업</p>
	 		<p>
	 			<label><input type="radio" name="newTask" value="N" onclick="selRadio('N');" checked="checked"/> <span class="T11">기존 작업에 관련자료로 등록</span></label><span class="pL7"></span>
	 			<label><input type="radio" name="newTask" value="Y" onclick="selRadio('Y');"/> <span class="T11">신규 작업을 생성하고 관련자료로 등록</span></label>
	 		</p>
 		</div>
 		
 		<div class="pop_board mB20" id="newTask_N">
	 		<table cellpadding="0" cellspacing="0">
	 			<colgroup><col class="col40" /><col class="col200" /><col width="px"/><col class="col90" /></colgroup>
	 			<thead>
	 				<tr>
	 					<th class="title">선택</th>
	 					<th class="title">프로젝트</th>
	 					<th class="title">작업명</th>
	 					<th>완료예정일</th>
	 				</tr>
	 			</thead>
	 			<tbody>
	 				<c:forEach items="${taskList}" var="task">
		 				<tr>
		 					<td class="Lright txt_center"><input type="radio" name="taskId" value="${task.taskId}" /></td>
		 					<td class="Lright pL10"><span class="txtB_grey">[${task.prjCd}]</span> ${task.prjNm}</td>
		 					<td class="Lright pL10">${task.taskSjPrint}</td>
		 					<td class="txt_center td_last">${task.taskDuedatePrint}</td>
		 				</tr>
	 				</c:forEach>
	 			</tbody>
	 		</table>
 		</div>
 		
 		<div class="pop_board mB20" id="newTask_Y" style="display:none;">
	 		<table cellpadding="0" cellspacing="0">
	 			<colgroup><col class="col90" /><col class="col170" /><col class="col90" /><col width="px"/></colgroup>
	 			<tbody>
	 				<tr>
	 					<td class="title" >프로젝트</td>
	 					<td class="pL10" colspan="3">
	 						<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onfocus="prjGen('prjNm','prjId',1)"/>
	 						<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1)" />
	 						<input type="hidden" name="prjId" id="prjId" />
	 					</td>
	 				</tr>
	 				<tr>
	 					<td class="title" >작업명</td>
	 					<td class="pL10" colspan="3" ><input type="text" class="span_12" name="taskSj" /></td>
	 				</tr>
	 				<tr>
	 					<td class="title" >시작일</td>
	 					<td class="pL10">
	 						<input type="text" class="span_4 calGen" name="taskStartdate" value="${date}" />
	 						<input type="text" class="span_1" name="taskStarttime" id="taskStarttime" onfocus="numGen('taskStarttime',9,18,5);"/> 시
	 					</td>
	 					<td class="title" >완료예정일</td>
	 					<td class="pL10">
	 						<input type="text" class="span_4 calGen" name="taskDuedate" />
	 						<input type="text" class="span_1" name="taskDuetime" id="taskDuetime" onfocus="numGen('taskDuetime',9,18,5);"/> 시
	 					</td>
	 				</tr>
	 				<tr>
	 					<td class="title" >내용</td>	
	 					<td class="pL10 pT5 pB5" colspan="3">
	 						<textarea name="taskCn" class="span_12 height_35"></textarea>
	 					</td>
					</tr>
	 			</tbody>
	 		</table>
 		</div>
 		</form>
 		
 	    <div class="pop_btn_area">
            <a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
            <a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
        </div>
 		
 	</div>
</div>

</body>
</html>
