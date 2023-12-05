<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<form id ="userSalaryForm">
<div id="pop_expense02">
 	 	
	${memberVO.orgnztNm } <print:user userNo="${memberVO.userNo}" userNm="${memberVO.userNm}"/> ${memberVO.rankNm } 
							
 	<!-- 게시판 시작  -->
	<div class="boardList02 mB5" >
		<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>프로젝트 현황</caption>
		<colgroup>
			<col class="col70" />
			<col class="col120" />
			<col width="px"/>
			<col class="col70" />
			<col class="col70" />
		</colgroup>
		<thead>
			<tr>
				<th>이름</th>
				<th>부서</th>
				<th>프로젝트</th>
				<th>시간</th>
				<th class="td_last">투입율</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultList}" var="result">
				<c:set var="irpSize" value="${fn:length(result.inputResultPersonList)}" />
				<tr>
					<td class="txt_center" rowspan="${irpSize + 1}"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
					<td class="txt_center" rowspan="${irpSize + 1}"><print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/> </td>
					
					<c:forEach items="${result.inputResultPersonList}" var="irp" varStatus="c">
						<td class="pL10"><print:project prjCd="${irp.prjCd}" prjId="${irp.prjId}" prjNm="${irp.prjNm}"/></td>
						<td class="txt_center">${irp.tm}</td>
						<td class="td_last txt_center">${irp.tmPercent}%</td>
				<c:out value="</tr>" escapeXml="false"/>
				<c:out value="<tr>" escapeXml="false"/>
					</c:forEach>
					<td class="td_last txt_center bG" colspan="3">투입시간 : ${result.totalTm}시간</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	</div>
	<!--// 게시판  끝  -->
	
		
</div>
</form>