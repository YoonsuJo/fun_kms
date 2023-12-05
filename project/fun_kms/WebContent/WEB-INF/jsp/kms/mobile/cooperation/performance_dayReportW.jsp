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
	
	<form:form name="frm" id="frm" commandName="dayReportRegist" method="POST" action="${rootPath}/mobile/cooperation/insertDayReport.do">
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
				<input type="text" class="inputttl" style="width:58%" name="dayReportDt" value="${searchVO.searchDate}"/>
				&nbsp;
				<select name="dayReportTm" style="width:30%">
					<option value="0">0시간</option>
					<option value="1">1시간</option>
					<option value="2">2시간</option>
					<option value="3">3시간</option>
					<option value="4">4시간</option>
					<option value="5">5시간</option>
					<option value="6">6시간</option>
					<option value="7">7시간</option>
					<option value="8">8시간</option>
					<option value="9">9시간</option>
					<option value="10">10시간</option>
					<option value="11">11시간</option>
					<option value="12">12시간</option>
					<option value="13">13시간</option>
					<option value="14">14시간</option>
					<option value="15">15시간</option>
					<option value="16">16시간</option>
					<option value="17">17시간</option>
					<option value="18">18시간</option>
					<option value="19">19시간</option>
					<option value="20">20시간</option>
					<option value="21">21시간</option>
					<option value="22">22시간</option>
					<option value="23">23시간</option>
					<option value="24">24시간</option>
				</select>
			</td>
		</tr>
		
		<tr>
			<td scope="col" colspan="3"><textarea name="dayReportCn" placeholder="내용을 입력해주세요."></textarea></td>
		</tr>
	</tbody>
	</table>
	</form:form>
	<p style="margin:10px 0px 50px 0px">
	<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	<a href="javascript:submit();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">등록</button></a>
	</p>

<!-- E:콘텐츠 들어가는곳 -->

</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>