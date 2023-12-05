<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>한마음 시스템</title>
<%@ include file="include/login_inc.jsp"%>

<script>
////////// 개발환경인 경우, 자동 로그인 되도록 수정
$(document).ready(function() {
	if (document.location.href.indexOf('localhost:8080') >= 0) {
		$('#userId').val('admin');
		$('#password').val('1');
		//$('#btnLogin').click();
	}
});
////////// 개발환경인 경우, 자동 로그인 되도록 수정. 끝
var currentPage = document.location.href; 
if(currentPage.indexOf('funnet.co.kr') == -1 && currentPage.indexOf('hanmam') == -1 && currentPage.indexOf('localhost') == -1&& currentPage.indexOf('172') == -1 && currentPage.indexOf('172.16.2.55') == -1 && currentPage.indexOf('172.16.30.135') == -1 && currentPage.indexOf('hm12') == -1 && currentPage.indexOf('hm13') == -1 && currentPage.indexOf('hm14') == -1 && currentPage.indexOf('222.112.235.160') == -1){
	location.href='../hanmam/hanmam.html';
}

function cookieSet(valueObj, expires, domain, path){
	var date = new Date();
	date.setDate( date.getDate() + expires );
	for(var key in valueObj){
		var t = [];
		t.push( key + '=' + escape(valueObj[key]) + '; expires='+date.toGMTString() + ';' );
		if(domain) t.push( 'domain='+domain+';' );
		if(path) t.push( 'path='+path+';' );
		document.cookie = t.join('');
	}
}
function cookieGet(key){
	var cookies = document.cookie.split(';');
	for(var i=0, cnt=cookies.length; i<cnt; ++i){
		var t = cookies[i].split('=');
		if(t[0].replace(" ","") != key) continue;
		return unescape(t[1]);
	}
}

var CK = "KMS_LOGIN_COOKIE";
function onLoad(){
	var cid = cookieGet(CK);
	document.loginFrm.userId.focus();
	if(cid){
		document.loginFrm.saveIdChk.checked = true;
		document.loginFrm.userId.value = cid;
		document.loginFrm.password.focus();
	}
	document.loginFrm.saveIdChk.checked = true;
	//alert("현재 한마음 시스템 하드웨어 문제로 인해\n" + "임시서버를 운영중입니다.\n" + "현 시스템 속도나 파일 시스템에 관한 공지를 확인해주세요.");
}

var onLogin = false;
var onLoginError = false;
function login(){
	//2013-05-16 Form Submit 으로해서 엔터치면 입력되게 함. login() 함수가 두번씩 호출되는 오류가 있어서 제어 변수로 해결함	
	if(document.loginFrm.userId.value.length < 1){
		if(onLoginError == false){
			onLoginError = true;
			alert("아이디를 확인해주세요.");
			document.loginFrm.userId.focus();
			return false;
		}
		onLoginError = false;
		document.loginFrm.userId.focus();
		return false;
	}
	if(document.loginFrm.password.value.length < 1){
		if(onLoginError == false){
			onLoginError = true;
			alert("비밀번호를 확인해주세요.");
			document.loginFrm.password.focus();
			return false;
		}
		onLoginError = false;
		document.loginFrm.password.focus();
		return false;
	}
	
	if(onLogin==true)
		return false;	
	onLogin = true;
	
	var ckObj = {};
	ckObj[CK] = document.loginFrm.userId.value;

	if( document.loginFrm.saveIdChk.checked ) {
		cookieSet(ckObj, 1, null, null); 
	} else {
		cookieSet(ckObj, -1, null, null); 
	}
	document.loginFrm.action="${rootPath}/actionLogin.do";
	document.loginFrm.submit();
}
<c:if test="${loginFail}">
	alert("로그인에 실패하였습니다.\r\n아이디와 비밀번호를 확인 후 다시 시도해주세요.");
</c:if>
</script>


</head>
<body onload="onLoad();">
	<div id="login" >
		<div class="login_box">
			<div class="login_img">
				<c:choose>
					<c:when test="${not empty memInfo.picFileId && memInfo.picFileId != ''}">
						<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${memInfo.picFileId}" />
							<c:param name="param_width" value="200" />
							<c:param name="param_height" value="250" />
						</c:import>
					</c:when>
					<c:when test="${not empty memInfo.picFileId2 && memInfo.picFileId2 != ''}">
						<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${memInfo.picFileId2}" />
							<c:param name="param_width" value="200" />
							<c:param name="param_height" value="250" />
						</c:import>
					</c:when>
					<c:otherwise>
						사진 없음
					</c:otherwise>
				</c:choose>
			</div>
			<div class="number">
				사번NO.${memInfo.sabun}
			</div>
			
			<div class="login_id">
				<form name="loginFrm" method="post" onSubmit="return login();">
<!--				<form name="loginFrm" method="post" onsubmit="login(); return false;">-->
				<ul>
					<li><input type="text" class="span_11" id="userId" name="userId" style="ime-mode:disabled;" value="${userId}"/></li>
					<li><input type="password" class="span_11" id="password" name="password"/></li>
				</ul>
				<ul>
					<li class="check"><input type="checkbox" name="saveIdChk" id="saveIdChk" value="1" /> 아이디저장</li>
					<li class="login_btn">
						<input type="image" id="btnLogin" src="${imagePath}/login/btn_login.gif" onclick="login();"/>
					</li>
				</ul>
				</form>
			</div>
			
			<div class="login_txt">
				<ul>
					<li class="name">${memInfo.userNm} ${memInfo.rankNm} : ${memInfo.orgnztNm}</li>
					<li class="name">
						<ul class="name_s">
							<li>좌우명 : </li>
							<li>${memInfo.abutMePrint}</li>
						</ul>
					</li>
					<!--  
					<li class="introduce">
						<c:out value="${memInfo.abutMePrint}" escapeXml="false"/>
					</li>
					-->
				</ul>
			</div>			
			<div class="login_copy">Copyright 2012-2013 DOSANET&SAEHA. All Rights Reserved.<br>
<!--			Connected : ${userAgent}-->
			</div>						
		</div>
	</div>
</body>
</html>


