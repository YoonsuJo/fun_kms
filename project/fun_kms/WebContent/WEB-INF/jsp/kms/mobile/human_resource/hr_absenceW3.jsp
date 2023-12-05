<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function register() {
	if (document.frm.wsBgnDe.value > document.frm.wsEndDe.value) {
		alert("기간이 잘못되었습니다. 다시 확인해주세요.");
		return;
	}
	document.frm.action = '<c:url value="${rootPath}/mobile/member/insertAbsence.do" />';
	document.frm.submit();
}

function setUserInfo() {
	var act = new yAjax("${rootPath}/member/changeUserinfo.do", "POST");
	act.send = "no=" + document.frm.userNo.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		document.frm.userTelno.value = xml.getValue("homeTelno", 0);
		document.frm.userMoblphonNo.value = xml.getValue("moblphonNo", 0);
	};
	act.action();
}

function setDefault() {
	var wsBgnDe = document.getElementById("wsBgnDe");
	var year = (new Date().getFullYear()).toString();
	var month = (new Date().getMonth() + 1).toString();
	if (month.length == 1) month = "0" + month;
	var date =  (new Date().getDate()).toString();
	if (date.length == 1) date = "0" + date;
	wsBgnDe.value = year + month + date;
	var sHours = (new Date().getHours()).toString();
	if (sHours.length == 1) sHours = "0" + sHours;
	var eHours = (new Date().getHours() + 2).toString();
	if (eHours.length == 1) eHours = "0" + eHours;
	var wsBgnTm = document.getElementById("wsBgnTm");
	var wsEndTm = document.getElementById("wsEndTm");

	for (var i = 0; i < wsBgnTm.options.length; i++) {
	   if (wsBgnTm.options[i].text == sHours) {
		   wsBgnTm.selectedIndex = i;
		   break;
	   }
	}
	for (var i = 0; i < wsEndTm.options.length; i++) {
	   if (wsEndTm.options[i].text == eHours) {
		   wsEndTm.selectedIndex = i;
		   break;
	   }
	}

	var wsPlace = document.getElementById("wsPlace");
	wsPlace.focus();
}

function goBack(){
	history.back();
}

function goInsertView(wsTyp){
	document.frm.wsTyp.value = wsTyp;
	document.frm.action = "${rootPath}/mobile/member/selectAbsenceState.do";
	document.frm.submit();
}


function goCancel(){
	document.frm.action = "${rootPath}/mobile/member/dailyWorkStateStatistic.do";
	document.frm.submit();
}
</script>
<!-- S:Section Area -->
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA"/></li>
	<li>근태등록</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px; margin-left:5px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
</ul>

<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->
<style>
.tab2 {width:100%; background:red; border-top:1px solid #dfdfdf; font-size:14px; }
.tab2 ul li {height:35px; width:25%; float:left; text-align:center; line-height:38px;}
.tab2_des	{font-weight:bold; text-align:center; line-height:43px; background:url(${commonMobilePath}/image/tab_bar.png) right repeat-y #fff;}
.tab2_de	{ background:url(${commonMobilePath}/image/tab_bar.png) right repeat-y #f6f9fb; border-bottom:1px solid #cdd4dc;}
</style>
<!-- UI Object -->
<div class="tab2">
	<ul>
		<li class="tab2_de"><a href="javascript:goInsertView('O');">외근</a></li>
		<li class="tab2_de"><a href="javascript:goInsertView('T');">출장</a></li>
		<li class="tab2_des"><a href="javascript:goInsertView('S');">파견</a></li>
		<li class="tab2_de"><a href="javascript:goInsertView('N');">야근</a></li>
	</ul>
</div>
<br /><br /><br />
<span class="office_text">다른 임직원의 부재현황 및 연장근무를 대신 등록할 수 있습니다</span>
<p>
<hr class="hr_e1e1e1" />
<form:form commandName="KmsAbsence" name="frm" method="POST">
<input type="hidden" name="wsTyp" value="S"/>
<input type="hidden" name="wsHrCnt" value="0"/>
<table cellspacing="0" border="1" summary="" class="office_w">
<caption></caption>
<colgroup>
<col width="80px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">이름</th>
	<td scope="col">
		<select name="userNo" onchange="setUserInfo();">
			<c:forEach items="${memList}" var="mem">
			<option value="${mem.no}" <c:if test="${mem.no == user.no}">selected="selected"</c:if>>${mem.userNm}</option>
			</c:forEach>
		</select>
	</td>
</tr>

<tr>
	<th scope="col">기간</th>
	<td scope="col">
		<input type="text" name="wsBgnDe" style="width:40%" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="">
		<span>~</span>
		<input type="text" name="wsEndDe" style="width:40%" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="">		
	</td>
</tr>
<tr>
	<th scope="col">유선전화</th>
	<td scope="col"><input type="text" name="userTelno" value="${user.homeTelno}" class="inputtype" title="" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""></td>
</tr>
<tr>
	<th scope="col">무선전화</th>
	<td scope="col"><input type="text" name="userMoblphonNo" value="${user.moblphonNo}" class="inputtype" title="" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""></td>
</tr>
<tr>
	<th scope="col">장소</th>
	<td scope="col"><input type="text" name="wsPlace" class="inputtype" title="" maxlength="255" 
		autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="예) 삼성화재 (구월동)"></td>
</tr>
<tr>
	<td scope="col" colspan="2"><textarea name="wsPurpose" placeholder="예) uniLDAP 테스트 환경 설치 지원"></textarea></td>
</tr>
</tbody>
</table>
</form:form>
</p>

<p style="margin:10px 0px 50px 0px">
	<a href="javascript:goCancel();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
	<a href="javascript:register();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">등록</button></a>
</p>

<!-- E:콘텐츠 들어가는곳 -->
</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<script>setDefault();</script>
<jsp:include page="../include/footer.jsp"></jsp:include>