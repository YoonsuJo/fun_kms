<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<title>한마음 시스템</title>
<%@ include file="../include/ajax_inc.jsp"%>

<dl>
	<dt>${result.carTyp}(${result.carId})<br/>사용자 : ${result.userNm } / 예약자 : ${result.writerNm}</dt>
	<dd>
	 	<ul class="layer_left">
	 		<li>사용기간</li>
	 		<li>사용목적</li>
	 		<li>행선지</li>
	 		<li>운행예정거리</li>
	 		<li>비고</li>
	 	</ul>
	 	<ul class="layer_right">
	 		<li>${result.stDtPrint} ${result.stTm}시 ~ ${result.edDtPrint} ${result.edTm}시</li>
	 		<li>${result.purposePrint}</li>
	 		<li>${result.destination}</li>
	 		<li>${result.runLength}km</li>
	 		<li>${result.rsvNotePrint}</li>
	 	</ul>
	</dd>
</dl>
