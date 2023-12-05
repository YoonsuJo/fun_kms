<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
<caption>공지사항 보기</caption>
<colgroup><col class="col10" /><col class="col10" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col40" /><col class="col10" /></colgroup>
<thead>
	<tr>
		<th rowspan="2">이름</th>
		<th rowspan="2">소속부서</th>
		<th colspan="12">${searchVO.searchYear}년도 월별 연장근무일수 (시간)</th>
		<th rowspan="2" class="td_last">합계</th>
	</tr>
	<tr>
		<th>1월</th>
		<th>2월</th>
		<th>3월</th>
		<th>4월</th>
		<th>5월</th>
		<th>6월</th>
		<th>7월</th>
		<th>8월</th>
		<th>9월</th>
		<th>10월</th>
		<th>11월</th>
		<th>12월</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
		<td class="txt_center">${result.orgnztNm}</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','01','${searchVO.searchYear}');">${result.cnt1}일<br/>(${result.sum1})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','02','${searchVO.searchYear}');">${result.cnt2}일<br/>(${result.sum2})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','03','${searchVO.searchYear}');">${result.cnt3}일<br/>(${result.sum3})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','04','${searchVO.searchYear}');">${result.cnt4}일<br/>(${result.sum4})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','05','${searchVO.searchYear}');">${result.cnt5}일<br/>(${result.sum5})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','06','${searchVO.searchYear}');">${result.cnt6}일<br/>(${result.sum6})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','07','${searchVO.searchYear}');">${result.cnt7}일<br/>(${result.sum7})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','08','${searchVO.searchYear}');">${result.cnt8}일<br/>(${result.sum8})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','09','${searchVO.searchYear}');">${result.cnt9}일<br/>(${result.sum9})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','10','${searchVO.searchYear}');">${result.cnt10}일<br/>(${result.sum10})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','11','${searchVO.searchYear}');">${result.cnt11}일<br/>(${result.sum11})</td>
		<td class="txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','12','${searchVO.searchYear}');">${result.cnt12}일<br/>(${result.sum12})</td>
		<td class="td_last txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail('${result.userNo}','','${searchVO.searchYear}');">${result.cnt}일<br/>(${result.sum})</td>
<!--		<td class="td_last txt_center" ><a href="/member/selectOvertimeView.do?userNo=${result.userNo}&searchYear=${searchVO.searchYear}" target="_black">${result.cnt}일<br/>(${result.sum})</a></td>-->
<!--		<td class="td_last txt_center" style="cursor:pointer;" onclick="loadOvertimeDetail2('${result.userNo}','','${searchVO.searchYear}');">${result.cnt}일<br/>(${result.sum})</td>-->		
	</tr>
</tbody>
</table>
