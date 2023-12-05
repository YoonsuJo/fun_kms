<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<title>도사에 오신걸 환영합니다.</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>

<link rel="stylesheet" href="${commonMobilePath}/style/css/login.css" type="text/css" media="all" />

<script type="text/javascript" src="${commonMobilePath}/library/jquery-1.7.2.min.js"></script>
<jsp:include page="${commonPath}/jsp/settingGlobalJs.jsp"></jsp:include>

<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="apple-touch-icon" href="${commonMobilePath}/image/Icon.png" />
<link rel="apple-touch-icon" sizes="${commonMobilePath}/image/Icon.png" />

<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;">

<script>
$(document).ready(function() {
	var scheight = screen.height;
	$('.bd2').css('height', scheight+16);
});
window.addEventListener('load', function() { setTimeout(scrollTo, 0, 0, 1); }, false);

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
var cookieAuthLogin = "KMS_LOGIN_AUTH";

$(document).ready(function(){
	
	$('#saveIdChk').click(function() {
		if ($(this).attr('checked')!='checked')
			$('#saveAuthChk').attr('checked', false);
	});
	$('#saveAuthChk').click(function() {
		if ($(this).attr('checked')=='checked')
			$('#saveIdChk').attr('checked', true);
	});
	
	document.loginFrm.userId.focus();
	var cid = cookieGet(cookieId);
	var cpass = cookieGet(cookiePass);
	var cauth = cookieGet(cookieAuthLogin);
	if(cid){
		document.loginFrm.userId.value = cid;
		document.loginFrm.password.value = cpass;
		document.loginFrm.password.focus();
	}
	if(cauth=='Y'){
		document.loginFrm.password.value = cpass;
		document.loginFrm.action="${rootPath}/mobile/actionLogin.do";
		document.loginFrm.submit();
	}
	document.loginFrm.saveIdChk.checked = true;
	document.loginFrm.saveAuthChk.checked = true;
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
		cookieSet(ckObj, 7, null, null); 
	}else{
		cookieSet(ckObj, -1, null, null); 
	}

	ckObj = {};
	var ckObjPass = {};
	ckObj[cookieAuthLogin] = 'Y';
	ckObjPass[cookiePass] = document.loginFrm.password.value;
	if( document.loginFrm.saveAuthChk.checked ){
		cookieSet(ckObj, 7, null, null);
		cookieSet(ckObjPass, 7, null, null);
	}else{
		cookieSet(ckObj, -1, null, null);
		cookieSet(ckObjPass, -1, null, null);
	}

	document.loginFrm.action="${rootPath}/mobile/actionLogin.do";
	document.loginFrm.submit();
}

function pcVersionLogin(){
	if(navigator.userAgent.match(/iPhone/) != null || navigator.userAgent.match(/iPad/) != null){  
		document.loginFrm.action="${rootPath}/mobile/pcVersion.do";
		document.loginFrm.submit();
	}else if(navigator.userAgent.match(/Android/) != null) { 
		mobilekms.runPcVersion("${rootPath}/mobile/pcVersion.do");
	}	
}


function muvcViewCallmobile() {
	var popup = window.open('${rootPath}/app.do','_DOSA_CONFERENCE_WINDOW','width=380px, height=566px');
	popup.focus();
}


function init(){
	if("${param.loginFail}" == "true") {
		document.loginFrm.userId.value = "${param.userId}";
	}
	
	//2014-03-21 버전확인. apk 1.5.3.1
	//2015-02-23 버전확인. ipa 1.0.0.27
	if(navigator.userAgent.match(/iPhone/) != null || navigator.userAgent.match(/iPad/) != null){
		//document.location.href = "mobilekms:updateInfo:1.0.0.27";
	}else if(navigator.userAgent.match(/Android/) != null) { 
		//모바일KMS 버전 체크
		//mobilekms.checkCurrentVersion("1.5.3.1");
	}
}
</script>

</head>


<body onload="init();">
	<div class="bd2">
		<div class="top_bg">
			<h1><img src="${commonMobilePath}/image/logo.png" alt="" style="width:104px;padding:62px 0 35px 0" /></h1>
			<p><img src="${commonMobilePath}/image/han_p.png" alt="" style="width:243px"/></p>
		</div>
		<form method="post" name="loginFrm">
			<div id ="login_area2">
				<p class="uid"> 
				<label for="username" class="uname" data-icon="u" ></label>
				<input id="username" name="userId" class="ids" required="required" type="text" style="color:#000;" placeholder="아이디" tabindex="1"/> 
				</p>
				<p class="upw"> 
				<label for="password"></label>
				<input id="password" name="password" class="pws" required="required" style="color:#000;" type="password" placeholder="패스워드" tabindex="2"/>
				</p>
				<p class="ubtn">
					<a href="javascript:login();" class="loginBtn" tabindex="3"><span>로그인</span></a>
				</p>
				<p>
					<ul style="width:90%; margin-top:16px">
						<li style="float:left;">
							<label style="font-size:13px; color:#738dbe" class="textShadow">
								<input type="checkbox" id="saveIdChk" name="saveIdChk"/> 아이디 저장
							</label>
						<li style="margin-left:43%">
							<label style="font-size:13px; color:#738dbe" class="textShadow">
								<input type="checkbox" id="saveAuthChk" name="saveAuthChk"/> 자동 로그인
							</label>
						</li>
					</ul>	
				</p>
			</div>
			<div id="notice_area">
				<div class="btn00">
	
					<a href="javascript:pcVersionLogin();" class="join_simple">
						<span><span>PC버전</span></span>
					</a>
					<a href="javascript:muvcViewCallmobile();" class="join_simple" style="margin-left:3%">
						<span><span>App다운로드</span></span>
					</a>
				</div>
				<!--<p class="Sbtn">
					<a href="javascript:pcVersionLogin();" class="join_simple">
						<span><span>PC버전</span></span>
					</a>
				</p>
				
				<p class="Sbtn">
					<a href="javascript:muvcViewCallmobile();" class="join_simple">
						<span><span>App다운로드</span></span>
					</a>
				</p>-->
				
				<span class="unotice">HANMAUM Mobile Ver 0.01<br>
				USER-AGENT: ${userAgent}</span>
			</div>
			<style>
								.btn00 {width: 100%;text-align: center}
				.btn00 a {display: inline-block;
height: 36px;
margin: 10px 0;
padding: 0 20px;
-webkit-border-radius: 5px;
border-radius: 5px;
text-align: center;
line-height: 36px;
font-size: 13px;
cursor: pointer;
-webkit-border-radius: 5px;
border-radius: 5px;
border:1px solid #041632; 
background-color: #041632;
text-decoration: none;
overflow: hidden;
/* Legacy browsers */
    -o-background-size: 100% 100%;
    -moz-background-size: 100% 100%;
    -webkit-background-size: 100% 100%;
    background-size: 100% 100%;
    /* Recent browsers */
    background: -webkit-gradient(
        linear,
        left top, left bottom,
        from(#142d54),
        to(#0c2449)
    );
    background: -webkit-linear-gradient(
        top,
        #142d54,
        #0c2449
    );
    background: -moz-linear-gradient(
        top,
        #142d54,
        #0c2449
    );
    background: -o-linear-gradient(
        top,
        #142d54,
        #0c2449
    );
    background: linear-gradient(
        top,
        #142d54,
        #0c2449
    );
			</style>
		</form>
	</div>
</body>
</html>


