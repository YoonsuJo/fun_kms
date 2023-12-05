<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
<meta name="apple-mobile-web-app-capable" content="no">
<meta name="apple-touch-fullscreen" content="no" />
<title>도전하는사람들 화상회의시스템</title>
<style>

*{margin:0;padding:0}
/* reset 셋팅 */
html,body {margin:0; padding:0; font-family:'na',Malgun Gothic,,NanumGothic,arial,sans-serif; font-size:12pt;color:#959595; height: 100%;}
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td {margin:0; padding:0;}
input,textarea,select {font-size: 12px;}
table { border-spacing: 0; border-collapse: collapse;}
address,caption,cite,code,dfn,em,th,var { font-style:normal; font-weight:normal; }
ol,ul ,li { list-style: none; }
h1,h2,h3,h4,h5,h6 { font-size: 100%; font-weight: normal; }
abbr,acronym { border:0; }
hr{clear:both;display:none;}
legend, caption{position:absolute;visibility:hidden;overflow:hidden;line-height: 0;width:0;height:0;margin:0;padding:0;font:0/0 Arial;}
img, fieldset{border:0 none;}
label{cursor:pointer;}
a{color:#222;text-decoration:none;}
a:link, 
a:visited{color:#686868;text-decoration:none;}
a:hover{text-decoration:underline;}
a:active{text-decoration:none;}

.clearfix:after    {content: "."; display: block; height: 0px; clear: both; visibility: hidden}
.clearfix    {display: inline-block}
.clearfix    {display: block}
* html .clearfix    {height: 1%} /* Hides from IE-mac */
.clearfix    {zoom:1} /*for IE 5.5-7*/

/* font - nanum gothic */
@font-face{font-family:'na';src:url('/common/fonts/nanum.gothic.eot');src:local('☺'), url('/common/fonts/nanum.gothic.woff') format('woff'), url('/common/fonts/nanum.gothic.ttf') format('truetype');font-style:normal;font-weight:normal;}
@font-face{font-family:'naBold';src:url('/common/fonts/nanum.gothic.bold.eot');src:local('☺'), url('/common/fonts/nanum.gothic.bold.woff') format('woff'), url('/common/fonts/nanum.gothic.bold.ttf') format('truetype');font-style:normal;font-weight:normal;}
@font-face{font-family:'naBoldE';src:url('/common/fonts/nanum.gothic-ExtraBold.eot');src:local('☺'), url('/common/fonts/nanum.gothic-ExtraBold.woff') format('woff'), url('/common/fonts/nanum.gothic-ExtraBold.ttf') format('truetype');font-style:normal;font-weight:normal;}
/* ================= common ================= */
.png24 { tmp:expression(setPng24(this)); }

.fl { float:left;}
.fr { float:right;}
.hidden {overflow: hidden;}
.fc_blue {color:#1285de;}

.clear {clear:both;}
a:hover {text-decoration:none;}
.font_bold{font-family:'naBold', sans-serif !important ;}
.font_boldE{font-family:'naBoldE', sans-serif !important ;}

#warp {
	position: relative;
	clear: both;
	width: 100%;
	height: 100%;
	min-height:100% !important; 
}
.header{
	width:100%;
	height:43px;
	background-color:#1978d9;
	position:relative;
	border-bottom: 1px solid #0e5298;
}
.header h1{
	float:left;
	font-size:15pt;
	color:#fff;
	position:relative;
	top:13px;
	font-family:'naBold';
	padding-left:20px;
}
.header span{
	float:right;
	font-size:10pt;
	color:#8af8ff;
	position:relative;
	top:20px;
	font-family:'naBold';
	padding-right:20px;
}

.contents{
	clear:both;
	background: #fff;
	padding-bottom:6px;
}

.con_tl {
	background: #1c2e40;
	border-top:1px solid #0e1720;
	border-bottom:1px solid #0d1d2d;
	padding: 7px 0 7px 20px;
}
.con_tl h2 {
	font-size:11pt;
	color:#fff;
	font-family:'naBold';
	background: url('/images/mvuc_images/bu_plus.png') left center no-repeat;
	background-size: auto 50% ;
	padding-left: 14px;
}
.dowm_box {
	position: relative;
	overflow: hidden;
	margin-top:10px;
	margin-bottom:12px;
}
.down_tl {
	margin-left: 20px;
	position:relative;
	top:2px;
	float: left;
	width: 20%;
}
.down_tl img {
	width:15px; 
	height:15px;
	position: relative;
	top:2px; 
}

.down_tl .tl_tt {
	font-family: 'naBold';
	font-size:11pt;  
	color:#2c333a; 
}

.btn_area {
	position: relative;
	float: right;
	width: 70%;
}
.btn_area .btns {
	margin-right:14px;
	overflow: hidden;
}
.btn_area .btns li {
	display:inline-block; 
	float:left; 
	text-align:center; 
	font-family: 'naBold';
	width: 33%;
}
.btn_area .btns li a {
	display:block; 
	margin-right: 3px;
	font-size:10pt;
	color:#95a3b1; 
	border:1px solid #7e8ba7; 
	-webkit-border-radius: 4px; 
	-moz-border-radius: 4px;
	border-radius: 4px;
	cursor: pointer;
	display: block;
	outline: none;
	vertical-align:middle; 
	background:url('/images/mvuc_images/bg_gr.png') repeat-x;
	background-size:contain;
	padding: 10px 0 6px 0;
}
.btn_area .btns li a:hover{
	border:1px solid #0079f6;
	-webkit-border-radius: 4px; 
	-moz-border-radius: 4px;
	border-radius: 4px;
	color:#0079f6;
}

.btn_s .btn_logo {
	display:block; 
	margin-bottom:5px;
}
.btn_s .btn_logo img {
	width:25px;
}
</style>
</head>
<body>
	<div id="warp">
		<!-- header -->
		<div class="header">
			<h1>한마음 App</h1>
			<span>설치 후 자동업데이트</span>
		</div>
		<!-- //header -->
		<!-- contents -->
		<div class="contents">
		<!-- 정식 버전  -->
			<div class="con_tl">    
				<h2>정식버전</h2>
			</div>
			<!-- 한마음 -->
			<div class="dowm_box" >
				<div class="down_tl">
					<img src="${imagePath}/mvuc_images/icon_hanmaum.png">
					<span class="tl_tt">한마음</span>
				</div>

				<div class="btn_area">                
					<ul class="btns">
						<li>
						 <a href="itms-services://?action=download-manifest&url=https://mupdate.saeha.com/update/com.saeha.MobileKMS/3/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_ios.png"/></span>
								<span>iOS</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="https://mupdate.saeha.com/update/com.saeha.MobileKMS/2/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_android.png"/></span>
								<span>Android</span>
							</div>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!--// 한마음 -->
			<!-- 멀티뷰 -->
			<div class="dowm_box" >
				<div class="down_tl">
					<img src="${imagePath}/mvuc_images/icon_multiview.png">
					<span class="tl_tt">멀티뷰</span>
				</div>

				<div class="btn_area">                
					<ul class="btns">
						<li>
						 <a href="itms-services://?action=download-manifest&url=https://mupdate.saeha.com/update/com.saeha.MultiviewMobile.Svc61/3/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_ios.png"/></span>
								<span>iOS</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="https://mupdate.saeha.com/update/com.saeha.MultiviewMobile.Svc61/2/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_android.png"/></span>
								<span>Android</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="http://hanmam.svc.saeha.com" target="_blank">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_windows.png"/></span>
								<span>Windows</span>
							</div>
							</a>
						</li>
					</ul>
				</div>
			</div>                
			<!--// 멀티뷰 -->
			<!-- 코러스 -->
			<div class="dowm_box" >
				<div class="down_tl">
					<img src="${imagePath}/mvuc_images/icon_chorus.png">
					<span class="tl_tt">코러스</span>
				</div>

				<div class="btn_area">                
					<ul class="btns">
						<li>
						 <a href="itms-services://?action=download-manifest&url=https://mupdate.saeha.com/update/com.saeha.ChorusVC/3/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_ios.png"/></span>
								<span>iOS</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="http://222.112.235.247/chorusvc/ChorusVC.apk">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_android.png"/></span>
								<span>Android</span>
							</div>
							</a>
						</li>
						<!--
						<li>
						 <a href="http://222.112.235.250:6010/chorusvc/app/chorusvc/PC/download.xml">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_windows.png"/></span>
								<span>Windows</span>
							</div>
							</a>
						</li>
						-->
					</ul>
				</div>
			</div>                
			<!--// 코러스 -->
		<!--// 정식 버전  -->
		<!-- 베타 버전  -->
			<div class="con_tl">    
				<h2>베타버전</h2>
			</div>
			<!-- 멀티뷰 -->
<!-- 
			<div class="dowm_box" >
				<div class="down_tl">
					<img src="${imagePath}/mvuc_images/icon_multiview.png">
					<span class="tl_tt">멀티뷰</span>
				</div>

				<div class="btn_area">                
					<ul class="btns">
						<li>
						 <a href="itms-services://?action=download-manifest&url=https://mupdate.saeha.com/update/com.saeha.MultiviewMobile.Svc60/3/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_ios.png"/></span>
								<span>iOS</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="https://mupdate.saeha.com/update/com.saeha.MultiviewMobile.Svc60/2/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_android.png"/></span>
								<span>Android</span>
							</div>
							</a>
						</li>
 -->
						<!--
						<li>
						 <a href="http://hanmam.svc.saeha.com" target="_blank">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_windows.png"/></span>
								<span>Windows</span>
							</div>
							</a>
						</li>
						-->
<!-- 
					</ul>
				</div>
			</div>
 -->                
			<!--// 멀티뷰 -->
			<!-- 알림톡 -->
			<div class="dowm_box" >
				<div class="down_tl">
					<img src="${imagePath}/mvuc_images/icon_allimtalk.png">
					<span class="tl_tt">알림톡</span>
				</div>

				<div class="btn_area">                
					<ul class="btns">
						<li>
						 <a href="itms-services://?action=download-manifest&url=https://mupdate.saeha.com/update/com.allimtalk.hanmaum/3/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_ios.png"/></span>
								<span>iOS</span>
							</div>
							</a>
						</li>
						<li>
						 <a href="https://mupdate.saeha.com/update/com.android.allimtalk.hanmaum/2/downloadNewestVersion.do">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_android.png"/></span>
								<span>Android</span>
							</div>
							</a>
						</li>
						<!--
						<li>
						 <a href="">
							<div class="btn_s">
								<span class="btn_logo"><img src="${imagePath}/mvuc_images/logo_windows.png"/></span>
								<span>Windows</span>
							</div>
							</a>
						</li>
						-->
					</ul>
				</div>
			</div>                
			<!--// 알림톡 -->
		<!--// 베타 버전  -->
		</div>
		<!-- //contents -->
	</div>
</body>
</html>