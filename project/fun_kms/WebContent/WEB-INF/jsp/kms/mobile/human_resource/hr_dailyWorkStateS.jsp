<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>

function goInsertView(){
	location.href = "${rootPath}/mobile/member/insertAbsenceView.do?wsTyp=O";
}
</script>
<!-- S:Section Area -->
<div id="showhidden"></div>
<!-- S:Section Area -->
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>근태현황</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px; margin-left:5px;"><font class="fontShadow"><a href="javascript:goInsertView();" alt="" class="">등록</a></font></div>
</ul>
<!-- S:콘텐츠 들어가는곳 -->
<h1 class="officettl">근태현황</h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office">
<caption></caption>
<colgroup>
<col width="100px">
<col width="*">
<col width="100px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">지각</th>
	<td scope="col">${result.state.l}명</td>
	<th scope="col">야근</th>
	<td scope="col">${result.state.n}명</td>
</tr>
</tbody>
</table>
<br/>
<h1 class="officettl">부재현황</h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office">
<caption></caption>
<colgroup>
<col width="80px">
<col width="*">
<col width="100px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">휴가</th>
	<td scope="col">${result.state.v}명</td>
	<th scope="col">외근</th>
	<td scope="col">${result.state.o}명</td>
</tr>
<tr>
	<th scope="col">출장</th>
	<td scope="col">${result.state.t}명</td>
	<th scope="col">파견</th>
	<td scope="col">${result.state.s}명</td>
</tr>
<tr>
	<th scope="col">합계</th>
	<td scope="col" colspan="3">${result.state.sum}명</td>
</tr>
</tbody>
</table>

<h1 class="officettl"><a name="hu">부재등록정보</a></h1>

<h1 class="officettl"><a name="dhl">지각</a></h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="*">
<col width="100px">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">소속부서</th>
	<th scope="col">연락처</th>
</tr>
<c:forEach items="${result.lateList}" var="late">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${late.userId}">${late.userNm}</a></td>
	<td scope="col">${late.orgnztNm}</td>
	<td scope="col" style="text-align:left; padding-left:3px;">${late.userMoblphonNo}</td>
</tr>
</c:forEach>
<c:if test="${empty result.lateList}">
<tr>
	<td scope="col" colspan="3">지각현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>

<h1 class="officettl"><a name="dhl">야근</a></h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="*">
<col width="100px">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">시간</th>
	<th scope="col">연락처</th>
</tr>
<c:forEach items="${result.nightList}" var="night">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${night.userId}">${night.userNm}</a></td>
	<td scope="col">${night.orgnztNm}</td>
	<td scope="col" style="text-align:left; padding-left:3px;">${night.userMoblphonNo}</td>
</tr>
</c:forEach>
<c:if test="${empty result.nightList}">
<tr>
	<td scope="col" colspan="3">야근현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>


<h1 class="officettl"><a name="dhl">휴가</a></h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="100px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">기간</th>
	<th scope="col">사유</th>
</tr>
<c:forEach items="${result.vacList}" var="vac">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${vac.userId}">${vac.userNm}</a></td>
	<td scope="col">&nbsp;${vac.wsBgnDe}<br/>~${vac.wsEndDe}</td>
	<td scope="col" style="text-align:left; padding-left:3px;"><print:textarea text="${vac.wsPurpose}"/></td>
</tr>
</c:forEach>
<c:if test="${empty result.vacList}">
<tr>
	<td scope="col" colspan="3">휴가현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>


<h1 class="officettl"><a name="dhl">외근</a></h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="100px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">시간</th>
	<th scope="col">장소</th>
</tr>
<c:forEach items="${result.outList}" var="out">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${out.userId}">${out.userNm}</a></td>
	<td scope="col">${out.wsBgnTm}~${out.wsEndTm}</td>
	<td scope="col" style="text-align:left; padding-left:3px;">${out.wsPlace}</td>
</tr>
</c:forEach>
<c:if test="${empty result.outList}">
<tr>
	<td scope="col" colspan="3">외근현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>

<h1 class="officettl"><a name="pa">출장</a></h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="140px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">시간</th>
	<th scope="col">장소</th>
</tr>
<c:forEach items="${result.tripList}" var="trip">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${trip.userId}">${trip.userNm}</a></td>
	<td scope="col">${trip.wsBgnDe}<br/>~${trip.wsEndDe}</td>
	<td scope="col" style="text-align:left; padding-left:3px;">${trip.wsPlace}</td>
</tr>
</c:forEach>
<c:if test="${empty result.tripList}">
<tr>
	<td scope="col" colspan="3">출장현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>

<h1 class="officettl">파견</h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="80px">
<col width="150px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<th scope="col">시간</th>
	<th scope="col">장소</th>
</tr>
<c:forEach items="${result.sendList}" var="send">
<tr>
	<td scope="col"><a href="${rootPath}/mobile/member/selectMember.do?userId=${send.userId}">${send.userNm}</a></td>
	<td scope="col">${send.wsBgnDe}<br/>~${send.wsEndDe}</td>
	<td scope="col" style="text-align:left; padding-left:3px;">${send.wsPlace}</td>
</tr>
</c:forEach>
<c:if test="${empty result.sendList}">
<tr>
	<td scope="col" colspan="3">파견현황이 없습니다.</td>
</tr>
</c:if>
</tbody>
</table>
<div id="btn_ext">
	<div class="bgBtn shadowBtn btnTop btn_ext" style="width:50px; float:left;"><a href="" class="btn_ext">위로<span class="bl_select"><img src="${commonMobilePath}/image/bl_select.png" alt="선택"/></span></a></div>
</div>
<!-- E:콘텐츠 들어가는곳 -->
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>