<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<p class="th_stitle2 mB10">휴가신청 정보</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
      <caption>공지사항 보기</caption>
      <colgroup><col class="col120" /><col width="px" /></colgroup>
      <tbody>
      	<tr>
	  		<td class="title">구분</td>
	       	<td class="pL10">
	       		<c:choose>
	       			<c:when test="${specificVO.vacTyp ==1}">
	       				연차
	       			</c:when>
	       			<c:when test="${specificVO.vacTyp ==2}">
	       				경조휴가 
	       			</c:when>
	       			<c:when test="${specificVO.vacTyp ==3}">
	       				특별휴가 
	       			</c:when>
	       			<c:when test="${specificVO.vacTyp ==4}">
	       				기타
	       			</c:when>
	       			<%-- <c:when test="${specificVO.vacTyp ==5}">
	       				하계휴가
	       			</c:when> --%>
	       		</c:choose>
	       	</td>		
      	</tr>
      	<tr>
        	<td class="title">기간</td>
        	<td class="pL10">
        		${specificVO.vacDayInform}
        		<span class="span_5">${specificVO.sumDate }일간	</span>
        	</td>
      	</tr>
      </tbody>
      </table>
</div>
