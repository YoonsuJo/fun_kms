<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<p class="th_stitle2 mB10">공문 정보</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
    <caption>공지사항 보기</caption>
    <colgroup><col class="col120" /><col width="px" /></colgroup>
    <tbody>
    	<tr>
     	<td class="title">발신구분</td>
     	<td class="pL10">
     		<form:radiobuttons items="${companyList}" path="companyId" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;"/>
     		<input type="radio" name="companyId" value="another" <c:if test="${specificVO.companyId}=='another'"> checked</c:if>> 기타 
    	</tr>
    	<tr>
     	<td class="title">공문번호</td>
     	<td class="pL10">
     		  공문번호는 결재완료 후 채번됩니다. 결재완료문서에서 공문번호 확인 후 번호를 넣어서 발송하시기 바랍니다.
  			(단, 발신구분이 “기타”인 경우는 시스템에서 번호 관리를 하지 않으니 별도 확인하시기 바랍니다.)
     	</td>
    	</tr>
    	<tr>
     	<td class="title">수신처</td>
     	<td class="pL10"> <input type="text" name="destn" class="span_15"  value="${specificVO.destn}" /> </td>
    	</tr>		                    	
    </tbody>
    </table>
</div>
