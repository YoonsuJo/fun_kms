<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/ajax_inc.jsp"%>
<script>
$(document).ready(function(){
	$('#orgnztNm, #orgnztTreeB').click(function(){
		orgGen('orgnztNm','orgnztId',1);
	});

	
});
</script>
<p class="th_stitle2 mB10">채용 정보</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col100" /><col width="px" /><col class="col80" /><col class="col170"/><col class="col40"/></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">채용부서</td>
                 	<td class="pL10">
                 		<input type="text" name="orgnztNm" id="orgnztNm" class="span_8" value="${specificVO.orgnztNm}" readonly/>
                 		<input type="hidden" name="orgnztId" id="orgnztId" value="${specificVO.orgnztId}"/>
                 		<img src="${imagePath}/btn/btn_tree.gif" id="orgnztTreeB" class="cursorPointer">
                 	</td>
                 	<td class="title">담당업무</td>
                 	<td class="pL10" colspan="2">
                 		<input type="text" name="mngTsk" class="span_8" value="${specificVO.mngTsk}" />
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">경력</td>
                 	<td class="pL10">
                 		
                 		<input type="radio" name="carCd" value="1"   <c:if test="${specificVO.carCd==1 }"> checked</c:if> > 무관
                 		 <input type="radio" name="carCd" value="2"  <c:if test="${specificVO.carCd==2 }"> checked</c:if>> 신입 
                 		 <input type="radio" name="carCd" value="3"  <c:if test="${specificVO.carCd==3 }"> checked</c:if>>경력 
                 		 <input type="text" name="carMinYear" class="span_1" value="${specificVO.carMinYear}"/>년 ~ 
                 		 <input type="text" name="carMaxYear" class="span_1" value="${specificVO.carMaxYear}"/>년
                 	</td>
                 	<td class="title">기준임금</td>
                 	<td class="pL10" colspan="2">
                 		<input type="text" name="monPayMin" class="span_3" value="${specificVO.monPayMin}"/> 만원 ~ 
                 		<input type="text" name="monPayMax" class="span_3" value="${specificVO.monPayMax}"/> 만원
                 	</td>
                	</tr>
              		<tr>
                 	<td class="title">학력</td>
                 	<td class="pL10">
                 	 	<form:checkboxes items="${educationList}" path="educationList" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;&nbsp;"  />
                 	</td>
                 	<td class="title">연령</td>
                 	<td class="pL10" colspan="2">
                 		<input type="text" name="ageMin" class="span_3" value="${specificVO.ageMin}"/> ~ 
                 		<input type="text" name="ageMax" class="span_3" value="${specificVO.ageMax}"/>
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">직급</td>
                 	<td class="pL10">
                 		<form:checkboxes items="${rankList}" path="rankIdList" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;"/>
                 	</td>
                 	<td class="title">성별</td>
                 	<td class="pL10" colspan="2"> 
                 		<form:radiobuttons items="${gendList}" itemValue="code" path="gendCd" itemLabel="codeNm" delimiter="&nbsp;"/>
                 	</td>
                	</tr>
                	<tr>
                 	<td class="title">출근희망일</td>
                 	<td class="pL10">
                 		<input type="text" name="dsdFrWk" class="span_8 calGen" value="${specificVO.dsdFrWk}" />
                 	</td>
                 	<td class="title"></td>
                 	<td class="pL10" colspan="2"></td>
                	</tr>
                	<tr>
                 	<td class="title">키워드</td>
                 	<td class="pL10" colspan="4"><input type="text" name="keywd" class="span_15" value="${specificVO.keywd}" /></td>
                	</tr>
                	<tr>
                 	<td class="title">기타조건</td>
                 	<td class="pL10 pT10 pB10" colspan="3">
                 		<textarea name="otrCon" class="span_15 height_35">${specificVO.otrCon}</textarea>
               		</td>
                 	<td>
                 		<ul class="arrow">
                 			<li><img src="${imagePath}/btn/btn_arrow_top.gif" /></li>
                 			<li class="dotline"></li>
                 			<li><img src="${imagePath}/btn/btn_arrow_down.gif" /></li>
                 		</ul>
                 	</td>
                	</tr>		                    			                    	
                </tbody>
                </table>
</div>
