<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${rootPath}/html/egovframework/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsMember" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function insert() {
	if (chkId == false) {
		alert("사용중인 아이디입니다.");
		return;
	}
	if (!validateKmsMember(document.frm)) {
		return;
	}
	document.frm.action="<c:url value='${rootPath}/admin/member/insertMember.do'/>";
	document.frm.submit();
}
function list() {
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectMemberList.do'/>";
	document.frm.submit();
}

var chkId = false;
function chkUserId() {
	var act = new yAjax("${rootPath}/admin/member/chkUserId.do", "POST");
	act.send = "userId=" + document.frm.userId.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var result = xml.getValue("result", 0);
		if (result == "success") {
			chkId = true;
		}
	};
	act.action();
}

function msnInsert() {
	var br = document.createElement("br");
	var input1 = document.createElement("div");
	var input2 = document.createElement("div");
	var btn = document.createElement("div");

	input1.className = "msn_data_input1";
	input2.className = "msn_data_input2";
	btn.className = "msn_data_btn";

	input1.innerHTML = "<input type=\"text\" class=\"span_6\" name=\"msnTyp\"/>";
	input2.innerHTML = "<input type=\"text\" class=\"span_11\" name=\"msnAdres\"/>";
	btn.innerHTML = "<a href=\"javascript:msnInsert();\"><img src=\"${imagePath}/admin/btn/btn_add03.gif\"/></a>";

	
	document.getElementById("MSN_ROW").appendChild(br);
	document.getElementById("MSN_ROW").appendChild(input1);
	document.getElementById("MSN_ROW").appendChild(input2);
	document.getElementById("MSN_ROW").appendChild(btn);
}

function pop_photo(typ) {
	if (typ == 1) {
		var popup = window.open('${rootPath}/admin/member/popPhoto.do?picTyp=picFileId&picFileId=${info.picFileId}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}else if (typ == 2) {
		var popup = window.open('${rootPath}/admin/member/popPhoto.do?picTyp=picFileId2&picFileId=${info.picFileId2}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}
	popup.focus();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">사원정보 수정</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<form:form commandName="KmsMember" name="frm" method="POST">
						<input type="hidden" name="command" value=""/>
						<input type="hidden" name="ihidNumFront" value=""/>
						<input type="hidden" name="ihidNumBack" value=""/>
						<input type="hidden" name="promotionYear" value=""/>
						<input type="hidden" name="careerMonthYear" value=""/>
						<input type="hidden" name="careerMonthMonth" value=""/>
						<input type="hidden" name="brth" value=""/>
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
						* 검색 기능에 사용할 이름초성을 입력해주세요
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>사원정보 등록</caption>
		                    <colgroup><col class="col120" /><col class="*" /><col class="col120" /><col class="*" /></colgroup>
		                    <tbody>
		                    	<tr>
								    <td class="title">이름</td>
								    <td class="pL10"><input type="text" name="userNm" class="span_5" /></td>
								    <td class="title">이름초성</td>
								    <td class="pL10"><input type="text" name="initial" class="span_5" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">ID</td>
								    <td class="pL10"><input type="text" name="userId" class="span_5" onchange="chkUserId();" /></td>
								    <td class="title">비밀번호</td>
							        <td class="pL10"><input type="password" name="password" /></td>
							        
		                    	</tr>
		                    </tbody>
		                    </table> 	
						</div>
						</form:form>
						<!-- 게시판 끝  -->
		                
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:insert();"><img src="${imagePath}/admin/btn/btn_add.gif"/></a>
		                	<a href="javascript:list();"><img src="${imagePath}/admin/btn/btn_cancel.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->
						
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
