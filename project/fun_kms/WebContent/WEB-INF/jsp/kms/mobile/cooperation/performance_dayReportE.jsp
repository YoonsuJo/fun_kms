<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="dayReportRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function submit() {
	document.frm.submit();					
}

function goBack(){
	history.back();
}
</script>
<div id="showhidden"></div>
<!-- S:Section Area -->
	<ul class="sectionttl bgTop">
		<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
		<li>실적등록</li>
		<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
	</ul>

<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->
	<table cellspacing="0" border="1" summary="" class="office_f">
<caption></caption>
	<colgroup>
	<col width="80px">
	<col width="*">
	<col width="80px">
	<col width="*">
	</colgroup>
	<tbody>
	<tr>
		<th scope="col">프로젝트명</th>
		<td scope="col" colspan="3">[${result.prjCd}]${result.prjNm}</td>
	</tr>
	<tr>
		<th scope="col">작업명</th>
		<td scope="col" colspan="3">${result.taskSjPrint}</td>
	</tr>
	<tr>
		<th scope="col">담당자</th>
		<td scope="col"><span class="addrdatea"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></span></td>
		<th scope="col">완료예정일</th>
		<td scope="col"><span class="addrdatea">${result.taskDuedatePrint}</span></td>
	</tr>
	<tr>
		<th scope="col">등록자</th>
		<td scope="col"><span class="addrdatea"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></span></td>
		<th scope="col">진행상태</th>
		<td scope="col"><span class="addrdatea">${result.taskStatePrint}</span></td>
	</tr>
	</tbody>
	</table>
	<form:form name="frm" id="frm" commandName="dayReportRegist" method="POST" action="${rootPath}/mobile/cooperation/updateDayReport.do">
	<input type="hidden" name="no" value="${dayReport.no}"/>
	<input type="hidden" name="prjId" value="${result.prjId}"/>
	<input type="hidden" name="taskId" value="${result.taskId}"/>
	<input type="hidden" name="userNo" value="${result.userNo}"/>
	<input type="hidden" name="cnt" value="1"/>
	<table cellspacing="0" border="1" summary="" class="office_f">
	<caption></caption>
	<colgroup>
	<col width="80px">
	<col width="*">
	<col width="40px">
	</colgroup>
	<tbody>
	<tr>
		<th scope="col">내용</th>
		<td scope="col" colspan="3">${result.taskCnPrint}</td>
	</tr>

	<tr>
		<th scope="col">날짜</th>
		<td scope="col" colspan="3">
			<input type="text" class="inputttl" style="width:58%" name="dayReportDt" value="${dayReport.dayReportDt}"/>
			&nbsp;
			<select name="dayReportTm" style="width:30%">
				<option value="0" <c:if test="${dayReport.dayReportTm == '0' }">selected</c:if>>1시간</option>
				<option value="1" <c:if test="${dayReport.dayReportTm == '1' }">selected</c:if>>1시간</option>
				<option value="2" <c:if test="${dayReport.dayReportTm == '2' }">selected</c:if>>2시간</option>
				<option value="3" <c:if test="${dayReport.dayReportTm == '3' }">selected</c:if>>3시간</option>
				<option value="4" <c:if test="${dayReport.dayReportTm == '4' }">selected</c:if>>4시간</option>
				<option value="5" <c:if test="${dayReport.dayReportTm == '5' }">selected</c:if>>5시간</option>
				<option value="6" <c:if test="${dayReport.dayReportTm == '6' }">selected</c:if>>6시간</option>
				<option value="7" <c:if test="${dayReport.dayReportTm == '7' }">selected</c:if>>7시간</option>
				<option value="8" <c:if test="${dayReport.dayReportTm == '8' }">selected</c:if>>8시간</option>
				<option value="9" <c:if test="${dayReport.dayReportTm == '9' }">selected</c:if>>9시간</option>
				<option value="10" <c:if test="${dayReport.dayReportTm == '10' }">selected</c:if>>10시간</option>
				<option value="11" <c:if test="${dayReport.dayReportTm == '11' }">selected</c:if>>11시간</option>
				<option value="12" <c:if test="${dayReport.dayReportTm == '12' }">selected</c:if>>12시간</option>
				<option value="13" <c:if test="${dayReport.dayReportTm == '13' }">selected</c:if>>13시간</option>
				<option value="14" <c:if test="${dayReport.dayReportTm == '14' }">selected</c:if>>14시간</option>
				<option value="15" <c:if test="${dayReport.dayReportTm == '15' }">selected</c:if>>15시간</option>
				<option value="16" <c:if test="${dayReport.dayReportTm == '16' }">selected</c:if>>16시간</option>
				<option value="17" <c:if test="${dayReport.dayReportTm == '17' }">selected</c:if>>17시간</option>
				<option value="18" <c:if test="${dayReport.dayReportTm == '18' }">selected</c:if>>18시간</option>
				<option value="19" <c:if test="${dayReport.dayReportTm == '19' }">selected</c:if>>19시간</option>
				<option value="20" <c:if test="${dayReport.dayReportTm == '20' }">selected</c:if>>20시간</option>
				<option value="21" <c:if test="${dayReport.dayReportTm == '21' }">selected</c:if>>21시간</option>
				<option value="22" <c:if test="${dayReport.dayReportTm == '22' }">selected</c:if>>22시간</option>
				<option value="23" <c:if test="${dayReport.dayReportTm == '23' }">selected</c:if>>23시간</option>
				<option value="24" <c:if test="${dayReport.dayReportTm == '24' }">selected</c:if>>24시간</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td scope="col" colspan="3"><textarea name="dayReportCn" placeholder="내용을 입력해주세요."><c:out value="${dayReport.dayReportCn}" escapeXml="false"/></textarea></td>
	</tr>
	</tbody>
	</table>
	</form:form>
	<p style="margin:10px 0px 50px 0px">
	<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	<a href="javascript:submit();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">수정</button></a>
	</p>

<!-- E:콘텐츠 들어가는곳 -->

</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>