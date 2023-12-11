<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
function writeCollection(){
	
	var POP_NAME = "_POP_COLLECTION_";
	document.bondFrm.target = POP_NAME;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectW.do" />';
	
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.bondFrm.submit();
	popup.focus();
}
function modifyCollection(bondColNo){
	document.bondFrm.bondColNo.value = bondColNo;
	
	var POP_NAME = "_POP_COLLECTION_";
	document.bondFrm.target = POP_NAME;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectM.do" />';
	
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.bondFrm.submit();
	popup.focus();
}
function deleteCollection(bondColNo){
	document.bondFrm.bondColNo.value = bondColNo;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectD.do" />';
	document.bondFrm.submit();
}
function popClose(){
	opener.thisRefresh();
	this.close();
}
</script>
<body><div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">수금 내역</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 	
 		<form name="bondFrm" id="bondFrm" method="POST" action="">
			<input type="hidden" name="bondPrjNo" value="${resultSum.bondPrjNo}" />
			<input type="hidden" name="bondColNo" value="0" />
			<input type="hidden" name="prjId" value="${resultSum.prjId}" />
		</form>
 		
 		<div class="pop_board mB20">
 		<p class="th_stitle">세금계산서 정보</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col80" /><col class="col100" /><col class="col60" /><col class="col100" /><col class="col60" /><col width="px"/></colgroup>
 			<tbody>
 				<tr>
 					<td class="title">프로젝트</td>
 					<td class="pL10" colspan="5"><a href="${rootPath}/cooperation/selectProjectV.do?prjId=${resultSum.prjId}" target="_blank">
 					[${resultSum.prjCd}] ${resultSum.prjNm}</a></td>
 				</tr>
 				<tr>
 					<td class="title">발행일</td>
 					<td class="pL10"><print:date date="${resultSum.publishDate}"/></td>
					<td class="title">업체명</td>
 					<td class="pL10">${resultSum.custNm} </td>
 					<td class="title">발행금액</td>
 					<td class="pL10"><print:currency cost="${resultSum.sumExpense}"/> (원)</td> 					
 				</tr>
 				<tr>
 					<td class="title">수금대상금액</td>
 					<td class="pL10"><print:currency cost="${resultSum.sumWillCollect}"/> (원)</td>
					<td class="title">수금액</td>
 					<td class="pL10"><print:currency cost="${resultSum.sumCollection}"/> (원)</td>
 					<td class="title">미수금액</td>
 					<td class="pL10"><print:currency cost="${resultSum.noCollection}"/> (원)</td> 					
 				</tr>	
 			</tbody>
 		</table>
 		</div>
 		
 		<div class="pop_board mB20">
 		<p class="th_stitle">수금 상세내역</p>
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col80" /><col class="col100" /><col width="px"/><col class="col90" /></colgroup>
 			<thead>
 				<tr>
 					<th class="title">수금일</th>
 					<th class="title">금액(원)</th>
 					<th class="title">비고</th>
 					<th>수정/삭제</th>
 				</tr>
 			</thead>
 			<tbody>
 				<c:forEach items="${resultList}" var="result" varStatus="c">
               	<tr>
                	<td class="Lright height24 txt_center"><print:date date="${result.collectionDate}"/></td>
                	<td class="Lright height24 txt_center"><print:currency cost="${result.expense}"/></td>
                	<td class="Lright height24 txt_center">${result.note} </td>
                	<td class="td_last height24 txt_center pT5">
                		<c:if test="${user.taxAdmin || user.admin}">
	                		<img src="../../images/btn/btn_plus02.gif" onclick="modifyCollection(${result.bondColNo});" class="cursorPointer"/>
	                		&nbsp;<img src="../../images/btn/btn_minus02.gif" onclick="deleteCollection(${result.bondColNo});" class="cursorPointer"/>
                		</c:if>&nbsp;
                	</td>
               	</tr>
               	</c:forEach>
 			</tbody>
 		</table>
 		</div>
 				
 		<div class="pop_btn_area">
 			<c:if test="${user.taxAdmin || user.admin}">
            <img src="../../images/btn/btn_collectRegist.gif" onclick="writeCollection();" class="cursorPointer"/>
 			</c:if>
            <img src="../../images/btn/btn_close.gif" onclick="popClose();" class="cursorPointer"/>
        </div>
 		
 	</div>
</div>

</body>
</html>
