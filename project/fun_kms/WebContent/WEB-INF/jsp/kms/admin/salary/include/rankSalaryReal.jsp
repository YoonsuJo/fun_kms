<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>


<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
<caption>직급별 기준연봉</caption>
<colgroup>
	<col class="col5" />
	<col class="col90" />
	<col class="col90" />
	<col class="col90" />
	<col width="px" />
	<col width="col90" />
	<col width="col90" />
	<col width="col70" />
	<col class="col5" />
</colgroup>
<thead>
	<tr>
	<th class="th_left"></th>
	<th scope="col">직급코드</th>
	<th scope="col">직급명</th>
	<th scope="col">상태</th>
	<th scope="col">A등급 기준연봉</th>
	<th scope="col">년차별 공차</th>
	<th scope="col">등급별 공차</th>
	<th scope="col">수정</th>
	<th class="th_right"></th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${resultList1}"  var="elem" varStatus="status">
	<tr>
<!--		직급코드-->
		<td class="txt_center rankCode" colspan="2">${elem.rankCode }</td>
<!--		직급명-->
		<td class="txt_center">${elem.rankNm }
		<input type="hidden" name="rankName${elem.rankCode }" id="rankName${elem.rankCode }" value="${elem.rankNm}" />
		</td>
<!--		상태-->
		<td class="txt_center">${elem.useAt }</td>
<!--		A등급 기준연봉-->
		<td class="txt_center rankSalary">
		<input type="text" name="salary${elem.rankCode }" id="salary${elem.rankCode }" class="write_input04" maxlength="14"
		onkeyup="javascript:inputjsMakeCurrency('salary${elem.rankCode }');" value="<print:currency cost='${elem.salary }' />" />
		</td>
<!--		년차별 공차-->
		<td class="txt_center rankSalary">
		<input type="text" name="yearDiff${elem.rankCode }" id="yearDiff${elem.rankCode }" class="write_input04" maxlength="12"
		onkeyup="javascript:inputjsMakeCurrency('yearDiff${elem.rankCode }');" value="<print:currency cost='${elem.yearDiff }'/>"/>		
		</td>
<!--		등급별 공차-->
		<td class="txt_center rankSalary">
		<input type="text" name="gradeDiff${elem.rankCode }" id="gradeDiff${elem.rankCode }" class="write_input04" maxlength="14" 
		onkeyup="javascript:inputjsMakeCurrency('gradeDiff${elem.rankCode }')" value="<print:currency cost='${elem.gradeDiff }' />" />
		</td>
<!--		연봉인상률-->
<!--		<td class="txt_center rankSalary">-->
<!--		<input type="text" name="raiseRate${elem.rankCode }" id="raiseRate${elem.rankCode }" class="write_input04" maxlength="14" -->
<!--		onkeyup="javascript:inputjsMakeCurrency('raiseRate${elem.rankCode }')" value="<print:currency cost='${elem.raiseRate }' />" />-->
<!--		</td>-->
<!--		수정	-->
		<td class="txt_center" colspan="2">
		<img class="cursorPointer" onclick="javascript:editRankSalary('${elem.rankCode}', this);" 
		src="${imagePath}/admin/btn/btn_modify02.gif"/></td>	
	</tr>	
	</c:forEach>	
</tbody>
</table>

