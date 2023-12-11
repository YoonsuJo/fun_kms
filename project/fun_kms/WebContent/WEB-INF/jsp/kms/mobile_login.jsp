<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBliC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>


<title>FUNNET KMS 시스템</title>
<%@ include file="include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/mobile.css" type="text/css" />
<script>
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

var cookieId = "KMS_LOGIN_ID";
var cookiePass = "KMS_LOGIN_PASS";
$(document).ready(function(){
	var cid = cookieGet(cookieId);
	if(cid){
		document.loginFrm.saveIdChk.checked = true;
		document.loginFrm.userId.value = cid;
	}
	var cpass = cookieGet(cookiePass);
	if(cpass){
		document.loginFrm.savePassChk.checked = true;
		document.loginFrm.password.value = cpass;
	}
	document.loginFrm.userId.focus();
});

function login(){
	if(document.loginFrm.userId.value.length < 1){
		alert("아이디를 확인해주세요.");
		document.loginFrm.userId.focus();
		return false;
	}
	if(document.loginFrm.password.value.length < 1){
		alert("비밀번호를 확인해주세요.");
		document.loginFrm.password.focus();
		return false;
	}

	var ckObj = {};
	ckObj[cookieId] = document.loginFrm.userId.value;

	if( document.loginFrm.saveIdChk.checked ){
		cookieSet(ckObj, 1, null, null); 
	}else{
		cookieSet(ckObj, -1, null, null); 
	}

	ckObj = {};
	ckObj[cookiePass] = document.loginFrm.password.value;
	if( document.loginFrm.savePassChk.checked ){
		cookieSet(ckObj, 1, null, null); 
	}else{
		cookieSet(ckObj, -1, null, null); 
	}
	document.loginFrm.action="${rootPath}/actionLogin.do";
	document.loginFrm.submit();
}

<c:if test="${param.loginFail == 'true'}">
	document.loginFrm.userId.value = "${param.userId}";
	alert("로그인에 실패하였습니다.\r\n아이디와 비밀번호를 확인 후 다시 시도해주세요.");
</c:if>

$('document').ready(function(){
	/*
	var prntWidth=  $('.info').parent().width();
	$('.info').css('width' ,(prntWidth - 150) + "px");
	*/
});
</script>

</head>
<body onload="document.loginFrm.userId.focus();">
	<div id="content">
		<div class="toolbar">
			(주)FUNNET
		</div>
		<div id="member_info">
			<div class="pic">
				<c:choose>
						<c:when test="${not empty memInfo.picFileId && memInfo.picFileId != ''}">
							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${memInfo.picFileId}" />
								<c:param name="param_width" value="100" />
								<c:param name="param_height" value="125" />
							</c:import>
						</c:when>
						<c:when test="${not empty memInfo.picFileId2 && memInfo.picFileId2 != ''}">
							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${memInfo.picFileId2}" />
								<c:param name="param_width" value="100" />
								<c:param name="param_height" value="125" />
							</c:import>
						</c:when>
						<c:otherwise>
							<img class="noImage" src="${imagePath}/login/sample.gif"/>
						</c:otherwise>
				</c:choose>
			</div>
			<div class="info">
				<ul>	
					<li class="name">${memInfo.userNm} ${memInfo.rankNm} : ${memInfo.orgnztNm}</li>
					<li class="introduce">
						<print:strShort length="150" str="${memInfo.abutMe}"/>
					</li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		
		<div class="mb_login_box">
			<form action="${rootPath}/actionLogin.do" method="post" name="loginFrm">
				<ul class="rounded">
					<li>
						<dl>
							<dt>아이디</dt>
							<dd>
								<input type="text" class="span_10" name="userId" <c:if test="${param.loginFail == 'true'}">value="${param.userId}"</c:if>/>
							</dd>
							<dd class="clear"></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt>패스워드</dt>
							<dd>
								<input type="password" class="span_10" name="password"/>
							</dd>
							<dd class="clear"></dd>
						</dl>
					</li> 
					<li class="check">
						<dl>
							<dd class="mR20">
								아이디저장 <input type="checkbox" name="saveIdChk"/>
							</dd>
							<dd>
								패스워드 저장 <input type="checkbox" name="savePassChk"/>
							</dd>
						</dl>
					</li>
					<li class="forward" onclick="login();">로그인</li>
				</ul>
			</form>
		</div>
	</div>
<div id="copyright">
	Knowledge Management System Mobile ver 0.05
</div>
</body>
</html>