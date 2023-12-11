<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="bondCollect" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>
<script>
$(document).ready(function() {
	$('#bondVO').find(".currency").keyup(function(){
		jsMakeCurrency(this);
	});
});
function updateCollection(){

	if (!validateBondCollect(document.bondFrm)) {
		return;
	}
	
	$('[name$=expense]').val(parseInt(jsDeleteComma($('[name$=expense]').val())));
	
	document.bondFrm.target = "_POP_COLLECTION_LIST_";
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectU.do" />';
	document.bondFrm.submit();
	this.close();
}
function popClose(){
	this.close();
}
</script>
<body><div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="../images/inc/pop_bullet.gif" /></li>
			<li class="popTitle">수금수정</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		
 		<form name="bondFrm" id="bondFrm" method="POST" action="">
			<input type="hidden" name="bondPrjNo" value="${result.bondPrjNo}" />
			<input type="hidden" name="bondColNo" value="${result.bondColNo}" />
			<input type="hidden" name="prjId" value="${result.prjId}" />
 		
 		<div class="pop_board mB20" id="bondVO">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col100" /><col width="px"/></colgroup>
 			<tbody>
 				<tr>
 					<td class="title" >수금일</td>
 					<td class="pL10"><input type="text" name="collectionDate" class="input01 span_6 calGen" value="${result.collectionDate}" /></td>
 				</tr>
 				<tr>
 					<td class="title" >금액(원)</td>
 					<td class="pL10"><input type="text" name="expense" class="input01 span_6 currency" value="<print:currency cost='${result.expense}'/>"/></td>					
 				</tr>
 				<tr>
 					<td class="title" >비고</td>
 					<td class="pL10"><input type="text" name="note" class="input01 span_12" value="${result.note}" /></td>				
 				</tr>	
 			</tbody>
 		</table>
 		</div>
 		
 		</form>
 		
 		<div class="pop_btn_area">
            <img src="../../images/btn/btn_regist.gif" onclick="updateCollection();" class="cursorPointer"/>
            <img src="../../images/btn/btn_cancel.gif" onclick="javascript:popClose();" class="cursorPointer"/>
        </div>
        
<!-- 		수금등록에서 가져옴 mgmt_pop_collectW.jsp-->
<!-- 		<div class="pop_board mT20" id="bondVO">-->
<!-- 		<label><input type="checkbox" name="fundAutoInsertCheck" id="fundAutoInsertCheck" checked="checked" value="Y" onchange="javascript:fundCheck();"/> 자금보고 건 자동등록</label>-->
<!-- 		<table cellpadding="0" cellspacing="0">-->
<!-- 			<colgroup><col class="col100" /><col width="px"/></colgroup>-->
<!-- 			<tbody>-->
<!-- 				<tr>-->
<!-- 					<td class="title" >회사구분</td>-->
<!-- 					<td class="pL10">-->
<!-- 						<select name="companyCd" class="fundAutoInsert" onchange="javascript:changeBankBook(this);">-->
<!--							<c:forEach items="${companyList}" var="company">-->
<!--								<option-->
<!--									value="${company.code}"-->
<!--								>-->
<!--									${company.codeNm}-->
<!--								</option>-->
<!--							</c:forEach>-->
<!--						</select>-->
<!-- 					</td>-->
<!-- 				</tr>-->
<!-- 				<tr>-->
<!-- 					<td class="title" >통장</td>-->
<!-- 					<td class="pL10">-->
<!-- 						<select name="bankBookSample" class="select01" style="display:none">-->
<!--							<c:forEach items="${bankBookList}" var="bankBook">-->
<!--								<option-->
<!--									value="${bankBook.code}"-->
<!--									tag="${bankBook.codeDc}"-->
<!--								>-->
<!--									${bankBook.codeNm}-->
<!--								</option>-->
<!--							</c:forEach>-->
<!--						</select>-->
<!-- 						<select  name="bankBook" class="select01 fundAutoInsert">-->
<!--							<c:forEach items="${bankBookList}" var="bankBook">-->
<!--								<option-->
<!--									value="${bankBook.code}" tag="${bankBook.codeDc}"-->
<!--									<c:if test="${bankBook.codeDc != companyCd}">style="display:none;"</c:if>-->
<!--								>-->
<!--									${bankBook.codeNm}-->
<!--								</option>-->
<!--							</c:forEach>-->
<!--						</select>-->
<!-- 					</td>-->
<!-- 				</tr>-->
<!-- 				<tr>-->
<!-- 					<td class="title" >구분</td>-->
<!-- 					<td class="pL10">-->
<!-- 						<select name="type" class="fundAutoInsert">-->
<!--							<c:forEach items="${typeList}" var="type">-->
<!--								<option-->
<!--									value="${type.code}"-->
<!--									<c:if test="${type.code == 'D'}">selected="selected"</c:if>-->
<!--								>-->
<!--									${type.codeNm}-->
<!--								</option>-->
<!--							</c:forEach>-->
<!--						</select>-->
<!-- 					</td>-->
<!-- 				</tr>-->
<!-- 				<tr>-->
<!-- 					<td class="title" >현금흐름</td>-->
<!-- 					<td class="pL10">-->
<!-- 						<select  name="account" class="select01 fundAutoInsert" >-->
<!--							<c:forEach items="${accountList}" var="account">-->
<!--								<option-->
<!--									value="${account.code}"-->
<!--								>-->
<!--									${account.codeNm}-->
<!--								</option>-->
<!--							</c:forEach>-->
<!--						</select>-->
<!-- 					</td>-->
<!-- 				</tr>-->
<!-- 			</tbody>-->
<!-- 		</table>-->
<!-- 		</div>-->
<!-- 		-->
 		
 	</div>
</div>

</body>
</html>
