<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<p class="th_stitle2 mB10">채용 정보</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col100" /><col width="px" /><col class="col80" /><col class="col170"/><col class="col40"/></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">채용부서</td>
                 	<td class="pL10">
                 		<span class="span_8"><print:org orgnztNm="${specificVO.orgnztNm}" orgnztId="${specificVO.orgnztId}"/></span>
                 	</td>
                 	<td class="title">담당업무</td>
                 	<td class="pL10" colspan="2">
                 		<span class="span_8"> ${specificVO.mngTsk} </span>
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">경력</td>
                 	<td class="pL10">
                 	
                 		 <input type="radio" disabled="disabled" name="carCd" value="1"  <c:if test="${specificVO.carCd==1 }"> checked</c:if>> 무관
                 		 <input type="radio" disabled="disabled" name="carCd" value="2"  <c:if test="${specificVO.carCd==2 }"> checked</c:if>> 신입 
                 		 <input type="radio" disabled="disabled" name="carCd" value="3"  <c:if test="${specificVO.carCd==3 }"> checked</c:if>> 경력 
                 		 <span class="span_1">${specificVO.carMinYear}</span>년 ~ 
                 		 <span class="span_1">${specificVO.carMaxYear}</span> 년
                 	</td>
                 	<td class="title">출근희망일</td>
                 	<td class="pL10" colspan="2">
                 		<span class="span_8"> ${specificVO.dsdFrWk} </span>
                 	</td>
                	</tr>
              		<tr>
                 	<td class="title">학력</td>
                 	<td class="pL10">
                 		<form:checkboxes disabled="true" items="${educationList}" path="educationList" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;" />
                 	</td>
                 	<td class="title">연령</td>
                 	<td class="pL10" colspan="2">
                 		<span  class="span_3" >${specificVO.ageMin}</span> ~ 
                 		<span  class="span_3" >${specificVO.ageMax}</span>
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">직급</td>
                 	<td class="pL10">
						<form:checkboxes disabled="true" items="${rankList}" path="rankIdList" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;" />
                 		
                 	</td>
                 	<td class="title">성별</td>
                 	<td class="pL10" colspan="2"> 
                 		<form:radiobuttons disabled="true" items="${gendList}" path="gendCd" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;"/>
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">기준임금</td>
                 	<td class="pL10" colspan="4">
                 		<span class="span_3"> ${specificVO.monPayMin}</span> 만원 ~ 
                 		<span class="span_3"> ${specificVO.monPayMax} </span> 만원
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">키워드</td>
                 	<td class="pL10" colspan="4"><span class="span_15"> ${specificVO.keywd} </span></td>
                	</tr>
                	<tr>
                 	<td class="title">기타조건</td>
                 	<td class="pL10 pT10 pB10" colspan="4">
                 		<print:textarea text="${specificVO.otrCon}"/>
                 	</td>
                	</tr>		                    			                    	
                </tbody>
                </table>
</div>
