<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
<caption>공지사항 보기</caption>
<colgroup>
	<col width="px" />
	<col width="px" />
	<col width="px" />
	<!-- <col width="px" />
	<col width="px" /> -->
	<col width="px" />
	<col width="px" />
	<col width="px" />
	<col width="px" />
	<col width="px" />
	<col width="px" />
</colgroup>
<thead>
	<tr>
		<th rowspan="2">이름</th>
		<th rowspan="2">소속부서</th>
		<th rowspan="2">근속기간</th>
		<th colspan="1">연차지급일수<br/>(${fn:substring(todayDate,0,4)}년 기준)</th>
		<th colspan="5" class="td_last">${searchVO.searchYear}년 휴가사용일수</th>
	</tr>
	<tr>
		<th>연차</th>
		<!-- <th>하계</th> -->
		<th>연차</th>
		<!-- <th>하계</th> -->
		<th>경조</th>
		<th>특별</th>
		<th>기타</th>
		<th class="td_last">계</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
		<td class="txt_center">${result.orgnztNm}</td>
		<td class="txt_center">${result.workMonthPrint}</td>
		<td class="txt_center">${result.vacCnt}</td>
		<%-- <td class="txt_center">${result.sumVacCnt}</td> --%>
		<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','1','${searchVO.searchYear}')">${result.cntNm}</td>
		<%-- <td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','5','${searchVO.searchYear}')">${result.cntSv}</td> --%>
		<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','2','${searchVO.searchYear}')">${result.cntHs}</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','3','${searchVO.searchYear}')">${result.cntSpcl}</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','4','${searchVO.searchYear}')">${result.cntEtc}</td>
		<td class="td_last txt_center" style="cursor:pointer;" onclick="loadVacationDetail('${result.userNo}','','${searchVO.searchYear}')">${result.cntAll}</td>
	</tr>
</tbody>
</table>
