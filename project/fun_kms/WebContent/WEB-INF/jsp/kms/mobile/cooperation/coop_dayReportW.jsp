<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="taskRegist" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateTaskRegist(document.frm)) {
		return;
	}
	if (document.frm.taskStartdate.value != "" && document.frm.taskDuedate.value != "" && document.frm.taskStartdate.value > document.frm.taskDuedate.value) {
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
	<!-- S:Section Area -->
	<ul class="sectionttl bgTop">
		<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
		<li>계획등록</li>
		<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
	</ul>

<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->

	<hr class="hr_e1e1e1" />
	<form:form name="frm" commandName="taskRegist" method="POST" action="${rootPath}/mobile/cooperation/insertTask.do">
	<input type="hidden" name="writerNo" value="${user.no}"/>
	<input type="hidden" name="taskState" value="P" />
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
			<input type="text" name="prjNm" id="prjNm" readonly="readonly" style="width:98%" onclick="prjGen('prjNm','prjId',1);" onfocus="prjGen('prjNm','prjId',1);" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""/>
			<input type="hidden" name="prjId" id="prjId" />
		</td>
	</tr>
	<tr>
		<th scope="col">작업명</th>
		<td scope="col" colspan="2">
			<input type="text" class="inputttl" name="taskSj" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""/>
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
			<input type="text" name="taskStartdate" value="${date}" style="width:30%"/> ~ <input type="text" name="taskDuedate" value="${date}" style="width:30%"/>
			&nbsp;
			<select name="taskDuetime">
				<option value="">시간</option>
				<option value="09">09시</option>
				<option value="10">10시</option>
				<option value="11">11시</option>
				<option value="12">12시</option>
				<option value="13">13시</option>
				<option value="14">14시</option>
				<option value="15">15시</option>
				<option value="16">16시</option>
				<option value="17">17시</option>
				<option value="18">18시</option>
			</select>
		</td>
	</tr>
	<tr>
		<td scope="col" colspan="3"><textarea name="taskCn" placeholder="내용을 입력해주세요."></textarea></td>
	</tr>
	</tbody>
	</table>
	</form:form>
	
	<p style="margin:10px 0px 50px 0px">
	<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	<a href="javascript:register();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">등록</button></a>
	</p>


<!-- E:콘텐츠 들어가는곳 -->

</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>