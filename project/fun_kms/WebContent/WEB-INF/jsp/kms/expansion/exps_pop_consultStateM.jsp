<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function stateUpdate() {
	
	document.frm.action = "<c:url value='${rootPath}/cooperation/updateConsultState.do'/>";
	document.frm.submit();
}
function changeCheck(obj) {
	obj = $(obj);
	if (obj.attr('checked') == 'checked') {
		$('input[name=complete_date]').val('${todayF}');
		var date = new Date();
		var hours = date.getHours();
		$('select[name=complete_tm]').find('option').attr('selected', '');
		$('select[name=complete_tm]').find('option[value=' + hours + ']').attr('selected', 'selected');
	}
}
</script>
</head>

<body><div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">처리상태</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		
 		<div class="pop_board mB20">
 		<form:form commandName="frm" name="frm" method="post">
 		<input type="hidden" name="consult_no" value="${result.consult_no }"/>
 		<input type="hidden" name="writer_no" value="${result.writer_no }"/>
 		 
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col100" /><col width="px"/></colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >상담번호 </td> 
 					<td class="pL10">${result.cno} </td>
 				</tr>
 				<tr>
 					<td class="title" >처리상태</td>
 					<td class="pL10">
 						<select name="state" class="select01">		
             				<option value="" label="처리상태 선택"/>
				      		<c:forEach items="${stateList}" var="state" varStatus="c">
				      			<option value="${state.code}" label="${state.codeNm}"<c:if test="${result.state==state.code }"> selected="selected"</c:if>/>	
				      		</c:forEach>
				      	</select>
 					</td>
 				</tr>
 				<tr>
 					<td class="title" >처리일시</td>
 					<td class="pL10">
 						<input type="text" name="complete_date" class="input01 span_5 calGen" value="<c:choose><c:when test="${result.complete_date==null }">${todayF }</c:when><c:otherwise>${result.complete_date}</c:otherwise></c:choose>"/>
 						<select name="complete_tm" class="span_3">
 							<c:forEach begin="01" end="23" step="1" varStatus="c">
				      			<option value="${c.count}" label="${c.count}시" <c:if test="${result.complete_tm==c.count }"> selected="selected"</c:if>/>	
				      		</c:forEach>
 						</select>
 						현재일시로
 						<input type="checkbox" name="todayChk" class="input01" onchange="javascript:changeCheck(this);" value="Y"/>
 					</td>					
 				</tr>
 				<tr>
 					<td class="title" >상담만족도</td>
 					<td class="pL10">
 						<select name="satisfaction" class="select01">		
             				<option value="" label="상담만족도 선택"/>
				      		<c:forEach items="${satisList}" var="satis" varStatus="c">
				      			<option value="${satis.code}" label="${satis.codeNm}"<c:if test="${result.satisfaction==satis.code}"> selected="selected"</c:if>/>	
				      		</c:forEach>
				      	</select>
 					</td>				
 				</tr>	
 			</tbody>
 		</table>
 		</form:form>
 		</div>
 		
 		<div class="pop_btn_area">
            <a href="javascript:stateUpdate()"><img src="${imagePath}/btn/btn_regist.gif"/></a>
            <img src="${imagePath}/btn/btn_close.gif" alt="창닫기" class="cursorPointer" onclick="window.close();">
        </div>
 		
 	</div>
</div>

</body>
</html>
