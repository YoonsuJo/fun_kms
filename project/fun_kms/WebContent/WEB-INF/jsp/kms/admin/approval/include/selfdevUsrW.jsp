	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../../include/ajax_inc.jsp"%>
	<!-- 게시판 시작  -->
<form:form commandName="selfdevUsrVO" id="selfdevUsrVO" name="selfdevUsrVO" method="post" enctype="multipart/form-data" >
<form:hidden path="selfdevUsrNo" />
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>자기개발비 개인별 조정비율 설정</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
			<tr>
		    <td class="title">이름</td>
			<td class="pL10" >
				<form:input path="userMix" cssClass="span_11 userNameAuto userValidateCheck" />
				<img src="${imagePath}/admin/btn/btn_tree.gif" class="cursorPointer" id="userTreeGenB" onclick="usrGen('userMix', 1);"/>
			</td>
			</tr>  
			<tr>
			    <td class="title">적용년도</td>
				<td class="pL10" >
					<form:input path="year" cssClass="span_11" id="year" />
					<input type="button" value="-1" onclick="addYear(-1);" />
					<input type="button" value="+1" onclick="addYear(1);" />
				</td>
			</tr> 
			<tr>
			    <td class="title">조정비율</td>
				<td class="pL10" >
					<form:input path="percent" cssClass="span_11" id="percent"/> %
					<input type="button" value="-10" onclick="addPercent(-10);" />
					<input type="button" value="-1" onclick="addPercent(-1);" />
					<input type="button" value="+1" onclick="addPercent(1);" />
					<input type="button" value="+10" onclick="addPercent(10);" />
				</td>
			</tr> 
			<tr>
			    <td class="title">할증금액</td>
				<td class="pL10" >
				<form:input path="extraCharge" cssClass="span_11" id="extraCharge" />(단위 : 천원)
				</td>
			</tr>
			<tr>
			    <td class="title">사유</td>
				<td class="pL10" >
					<form:input path="description" cssClass="span_11" id="description"/> 
					<input type="button" value="기본값" onclick="setDescription(1);" />
					<input type="button" value="비우기" onclick="setDescription(0);" />
				</td>
			</tr>
     </tbody>
     </table>
</div>
<!-- 게시판 끝  -->

<!-- 버튼 시작 -->
<div class="btn_area">
	<img src="${imagePath}/admin/btn/btn_save.gif" class="cursorPointer" id="selfdevUsrSaveB"/>
	<img src="${imagePath}/admin/btn/btn_cancel.gif" class="cursorPointer" id="selfdevUsrCancleB"/>
</div>
<!-- 버튼 끝 -->		
</form:form>