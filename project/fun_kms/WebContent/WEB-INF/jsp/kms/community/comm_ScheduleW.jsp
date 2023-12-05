<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="commSche" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
$(document).ready(function(){
	$('#searchOrgNm, #searchOrgTreeB').click(function(){
		orgGen('searchOrgNm','searchOrgId',2);
	});
});

function register() {
	document.commSchedule.scheCn.value = myeditor.outputBodyHTML();
	if (!validateCommSche(document.commSchedule)) {
		return;
	}
	if (document.commSchedule.date.value.length != 8) {
		alert("날짜를 정확하게 입력해주세요");
		document.commSchedule.date.focus();
		return;
	}
	if (document.getElementById("from").disabled == false) {
		if (document.getElementById("from").value == "") {
			alert("시작시간을 입력해주세요");
			return;
		}
		else if (document.getElementById("from").value.indexOf(":") != 2 || document.getElementById("from").value.length != 5) {
			alert("XX:OO 형식으로 입력해주세요.");
			return;
		}
		else if (new Number(document.getElementById("from").value.split(":")[0]) >= 24 || new Number(document.getElementById("from").value.split(":")[1]) >= 60) {
			alert("유효하지 않은 시간입니다.");
			return;
		}
	}
	if (document.getElementById("to").disabled == false) {
		if (document.getElementById("to").value != "") {
			if (document.getElementById("to").value.indexOf(":") != 2 || document.getElementById("to").value.length != 5) {
				alert("XX:OO 형식으로 입력해주세요.");
				return;
			}
			else if (new Number(document.getElementById("to").value.split(":")[0]) >= 24 || new Number(document.getElementById("to").value.split(":")[1]) >= 60) {
				alert("유효하지 않은 시간입니다.");
				return;
			}
		}
	}
	
	document.commSchedule.action = "<c:url value='${rootPath}/community/addSchedule.do'/>";
	document.commSchedule.submit();					
}
function cancel() {
	history.back();
}
function tmAbleSet() {
	if (document.commSchedule.scheTmTyp[0].checked == true) {
		document.getElementById("from").disabled = true;
		document.getElementById("to").disabled = true;
	} else {
		document.getElementById("from").disabled = false;
		document.getElementById("to").disabled = false;
	}
}
function chkScheTyp(obj) {
	if (obj.value == "T") {
		document.commSchedule.scheOrgnztNm.value = "${user.orgnztNm}";
		document.commSchedule.scheOrgnztId.value = "${user.orgnztId}";
		document.commSchedule.scheOrgnztNm.style.display = "";
		document.getElementById("orgTree").style.display = "";
		document.getElementById("sharedTr").style.display = "";
	}
	else {
		document.commSchedule.scheOrgnztNm.value = "";
		document.commSchedule.scheOrgnztId.value = "";
		document.commSchedule.scheOrgnztNm.style.display = "none";
		document.getElementById("orgTree").style.display = "none";
		document.getElementById("sharedTr").style.display = "none";
	}
}
</script>
</head>

<body onload="tmAbleSet();">

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center" style="padding-bottom:80px">
					<div class="path_navi">
						<ul>
							<li class="stitle">일정 등록</li>
							<li class="navi">홈 > 커뮤니티 > 일정공유 > 주요일정</li>
						</ul>
					</div>
					
					<span class="stxt">새로운 일정을 등록합니다.</span>
	
					<!-- S: section -->
					<div class="section01">
						<!-- 게시판 시작  -->
						<form:form commandName="commSche" name="commSchedule" method="POST" enctype="multipart/form-data" action="${rootPath}/community/addSchedule.do">
						<input type="hidden" name="scheOrgnztId" id="orgId" />
						<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="새로운 일정을 등록합니다.">
							<caption>일정등록</caption>
							<colgroup>
								<col class="col80" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="txt_center write_info">제목</th>
									<th class="write_info2"><input type="text" class="write_input" name="scheSj" /></th>
								</tr>
								<tr>
									<th class="write_info">구분</th>
									<th class="write_info2">
										<label><input type="radio" name="scheTyp" value="P" onclick="chkScheTyp(this);" checked="checked" />개인일정</label><span class="pL7"></span>
										<label><input type="radio" name="scheTyp" value="T" onclick="chkScheTyp(this);" />부서일정</label><span class="pL7"></span>
										<label><input type="radio" name="scheTyp" value="C" onclick="chkScheTyp(this);" />회사일정</label><span class="pL7"></span>
										<input type="text" name="scheOrgnztNm" id="orgNm" onclick="orgGen('orgNm','orgId',1);" style="display:none"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',1);" style="display:none"/>
									</th>
								</tr>
								<tr id="sharedTr" style="display:none;">
									<th class="write_info">공유부서</th>
									<th class="write_info2">
										<input type="text" name="scheSharedOrgnztNm" id="sharedOrgNm" class=span_12 onclick="orgGen('sharedOrgNm','sharedOrgId',2);" />
										<input type="hidden" name="scheSharedOrgnztId" id="sharedOrgId" />
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('sharedOrgNm','sharedOrgId',2);" />
									</th>
								</tr>
								<tr>
									<th class="write_info">날짜</th>
									<th class="write_info2"><input type="text" name="date" class="calGen" maxlength="8" value="<c:out value='${searchVO.date}' />"/></th>		                        </tr>
								<tr>
									<th class="write_info">시간</th>
									<th class="write_info2">
									<input type="radio" name="scheTmTyp" value="0" onclick="tmAbleSet();" checked="checked" />하루종일<span class="pL7"></span>
									<input type="radio" name="scheTmTyp" value="1" onclick="tmAbleSet();" />시간지정<span class="pL7"></span>
									<input type="text" name="scheTmFrom" maxlength="5" class="write_input04" id="from" />~<input type="text" name="scheTmTo" maxlength="5" class="write_input04" id="to" />
									(e.g. 15:30)
									</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td colspan="2">
										<textarea rows="9" cols="100" name="scheCn" id="scheCn"></textarea>
										<script type="text/javascript" language="javascript">
												var myeditor = new cheditor();
												myeditor.config.editorHeight = '400px';
												myeditor.config.editorWidth = '100%';
												myeditor.inputForm = 'scheCn';
												myeditor.run();
											</script>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
						</form:form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
							<a href="javascript:history.back();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
