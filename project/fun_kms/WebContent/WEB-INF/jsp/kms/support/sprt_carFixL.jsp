<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="../include/ajax_inc.jsp"%>

<p class="th_stitle">정비 이력</p>
<div class="boardList02 mB20">
<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>정비이력 보기</caption>
	<colgroup>
		<col class="col80" />
		<col class="col60" />
		<col class="col60" />
		<col class="col120" />
		<col width="px" />
		<col class="col120" />
		<col class="col40" />
	</colgroup>
	<thead>
		<tr>
			<th>일자</th>
			<th>정비자</th>
			<th>운행거리(km)</th>
			<th>정비항목</th>
			<th>정비 상세내역</th>
			<th>비고</th>
			<th class="td_last">&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result">
			<tr>
				<td class="txt_center">${result.fixDate}</td>
				<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
				<td class="txt_center">${result.runLengthPrint}</td>
				<td class="txt_center">${result.fixItem}</td>
				<td class="txt_center">${result.fixItemDetailPrint}</td>
				<td class="txt_center">${result.fixNotePrint}</td>
				<td class="td_last pL10">
					<a href="${rootPath}/support/updateCarFixInfoView.do?no=${result.no}"><img src="${imagePath}/btn/btn_plus02.gif" /></a>
					<a href="${rootPath}/support/deleteCarFixInfo.do?no=${result.no}&carId=${result.carId}"><img src="${imagePath}/btn/btn_minus02.gif" /></a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<!--// 처리내역 끝  -->

<!-- 버튼 시작 -->
<div class="btn_area">
	<a href="javascript:insertCarFix();"><img src="${imagePath}/btn/btn_repairRegist.gif" /></a>
</div>
<!-- 버튼 끝 -->
