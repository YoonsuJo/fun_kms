<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="taskRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	if (!validateTaskRegist(document.frm)) {
		return;
	}
	if (document.frm.taskDuedate.value != '' && document.frm.taskStartdate.value > document.frm.taskDuedate.value) {
		alert("시작일과 완료예정일을 확인해주세요.");
		return;
	}
	document.frm.submit();					
}

function goBack(){
	history.back();
}
</script>
<div id="showhidden"></div>
	<div id="section"></div>
<!-- S:Section Area -->
	<ul class="sectionttl bgTop">
		<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
		<li>계획등록</li>
		<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
	</ul>

<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->

	<hr class="hr_e1e1e1" />
	<form:form name="frm" commandName="taskRegist" method="POST" action="${rootPath}/mobile/cooperation/updateTask.do">
	<input type="hidden" name="taskId" value="${result.taskId}"/>
	<input type="hidden" name="writerNo" value="${user.no}"/>
	<input type="hidden" name="taskState" value="${result.taskState}" />
	<table cellspacing="0" border="1" summary="" class="office_f">
	<caption></caption>
	<colgroup>
	<col width="80px">
	<col width="*">
	<col width="40px">
	</colgroup>
	<tbody>
	<tr>
		<th scope="col">프로젝트</th>
		<td scope="col">
			<input type="text" name="prjNm" id="prjNm" readonly="readonly" style="width:98%" onclick="prjGen('prjNm','prjId',1);" onfocus="prjGen('prjNm','prjId',1);" value="${result.prjNm}"/>
			<input type="hidden" name="prjId" id="prjId" value="${result.prjId}"/>
		</td>
	</tr>
	<tr>
		<th scope="col">작업명</th>
		<td scope="col" colspan="2">
			<input type="text" class="inputttl" name="taskSj" maxlength="255" value="${result.taskSjPrint}" />
		</td>
	</tr>
	<tr>
		<th scope="col">등록자</th>
		<td scope="col" colspan="2">
			<input type="text" class="inputttl" name="userNm" id="userNm" value="${member.userNm}(${member.userId})" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<th scope="col">기간</th>
		<td scope="col" colspan="2">
			<input type="text" name="taskStartdate" style="width:30%" value="${result.taskStartdate}" /> ~ 
			<input type="text" name="taskDuedate" style="width:30%" value="${result.taskDuedate}"/>
			&nbsp;
			<select name="taskDuetime">
				<option value=""></option>
				<option value="09" <c:if test="${result.taskDuetime == '09' }">selected</c:if>>09시</option>
				<option value="10" <c:if test="${result.taskDuetime == '10' }">selected</c:if>>10시</option>
				<option value="11" <c:if test="${result.taskDuetime == '11' }">selected</c:if>>11시</option>
				<option value="12" <c:if test="${result.taskDuetime == '12' }">selected</c:if>>12시</option>
				<option value="13" <c:if test="${result.taskDuetime == '13' }">selected</c:if>>13시</option>
				<option value="14" <c:if test="${result.taskDuetime == '14' }">selected</c:if>>14시</option>
				<option value="15" <c:if test="${result.taskDuetime == '15' }">selected</c:if>>15시</option>
				<option value="16" <c:if test="${result.taskDuetime == '16' }">selected</c:if>>16시</option>
				<option value="17" <c:if test="${result.taskDuetime == '17' }">selected</c:if>>17시</option>
				<option value="18" <c:if test="${result.taskDuetime == '18' }">selected</c:if>>18시</option>
			</select>
		</td>
	</tr>
	<tr>
		<th scope="col">진행상태</th>
		<td scope="col" colspan="2">${result.taskStatePrint}</td>
	</tr>
	<tr>
		<td scope="col" colspan="3"><textarea name="taskCn" placeholder="내용을 입력해주세요.">${result.taskCn}</textarea></td>
	</tr>
	</tbody>
	</table>
	</form:form>
	
	<p style="margin:10px 0px 50px 0px">
	<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	<a href="javascript:update();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">수정</button></a>
	</p>


<!-- E:콘텐츠 들어가는곳 -->

</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>