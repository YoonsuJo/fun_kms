	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../../include/ajax_inc.jsp"%>

<!-- 상위계정 추가  -->
<form:form commandName="accountVO" name="accountVO" method="post" >
<form:hidden path="accLv"/>
<form:hidden path="accId"/>
<form:hidden path="prntAccId"/>
<p class="th_stitle">${title}</p>
<div class="boardWrite02">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>상위계정 추가</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
			<tr>
		    <td class="title">계정명</td>
			<td class="pL10" ><form:input path="accNm" cssClass="span_11" /></td>
			</tr>
			<tr>
		    <td class="title">계정분류</td>
			<td class="pL10" ><form:radiobuttons path="prntTyp" items="${prntTypList}" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;"/></td>
			</tr>
			<tr>
		    <td class="title">사용여부</td>
			<td class="pL10" >
				예 <input type="radio" name="useAt" value="Y" <c:if test="${accountVO.useAt=='Y' }">checked</c:if>/>
				<c:if test="${invalidUseAt!=1}">
				아니오 <input type="radio" name="useAt" value="Y" <c:if test="${accountVO.useAt=='N' }">checked</c:if>/>
				</c:if>
				
			</td>
			</tr>                      	
                </tbody>
                </table>
</div>
<div class="btn_area">
 	<img src="${imagePath}/admin/btn/btn_ok.gif" id="prntAccInsB" class="cursorPointer"/>
 	<img src="${imagePath}/admin/btn/btn_cancel.gif" class="cursorPointer" id="prntAccAddCancleB"/>
</div>
</form:form>