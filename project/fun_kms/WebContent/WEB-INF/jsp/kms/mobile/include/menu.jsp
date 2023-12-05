<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
var mobile = "";
if(navigator.userAgent.match(/iPhone/) != null || navigator.userAgent.match(/iPad/) != null) { 
	mobile = "IOS";
}else if(navigator.userAgent.match(/Android/) != null) { 
	mobile = "Android";
}


function pcVersionLogin(){
	if(mobile == "IOS") { 
		location.href = "http://hm.hanmam.kr/mobile/pcVersion.do";
	}else if(mobile == "Android") { 
		mobilekms.runPcVersion("http://hm.hanmam.kr/mobile/pcVersion.do");
	}
}

function pageMove(page){
	if(mobile == "IOS") { 
		//mobilekms.stopProgress();
	}else if(mobile == "Android") {
		try {
			if (page == '/mobile/logout.do') {
				mobilekms.setLogout(true);
			}
		} catch(e) {}
		mobilekms.startProgress();
	}
	if (page=="pcVersion") {
		pcVersionLogin();
	}
	else {
		location.href = "${rootPath}"+page;
	}
}

function reLogin() {
	document.reLoginFrm.userId.value = '${user.userId}';
	document.reLoginFrm.reLoginYn.value = 'Y';
	document.reLoginFrm.action = "/mobile/actionLogin.do";
	document.reLoginFrm.submit();
}

</script>
<div class="userttl bgTop_list">
	<p class="f_fffb fontShadow">${user.userNm}${user.attendCdPrint}&nbsp;${user.attendTm}</p>
	<p class="logout_02"><a href="javascript:reLogin();">출근등록</a></p>
</div>
<ul class="mslst">
	<hr class="hr_000000" />
	
	<li class="mslstttl f_74777d">업무처리 </li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon01">
		<a href="javascript:pageMove('/mobile/cooperation/selectBusinessContactList.do');" alt="업무연락" style="padding-top:14px;">
		<span class="menuBlock">업무연락</span></a>
		<span class="counts bgTop">${chkList.busiCntct}</span>
	</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon02">
		<a href="javascript:pageMove('/mobile/cooperation/selectDayReport.do');" alt="나의업무보고" style="padding-top:14px;">
		<span class="menuBlock">나의업무보고</span></a>
	</li>
	
	<hr class="hr_000000" />
	
	<li class="mslstttl f_74777d">커뮤니티</li>
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon04">
		<a href="javascript:pageMove('/mobile/support/selectBoardList.do?bbsId=BBSMSTR_000000000031');" alt="공지사항" style="padding-top:14px;">
		<span class="menuBlock">공지사항</span></a>
		<span class="counts bgTop">${chkList.notice}</span>
	</li>
	
	<hr class="hr_000000" />
	
	<li class="mslstttl f_74777d">사원정보 및 현황</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon05">
		<a href="javascript:pageMove('/mobile/member/selectAbsenceState.do');" alt="근태현황" style="padding-top:14px;">
		<span class="menuBlock">근태현황</span></a>
	</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon08">
		<a href="javascript:pageMove('/mobile/member/insertAbsenceView.do?wsTyp=O');" style="padding-top:14px;">
		<span class="menuBlock">근태입력</span></a>
	</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon06">
		<a href="javascript:pageMove('/mobile/member/selectMemberList.do?workSt=W,L,R');" alt="사원정보" style="padding-top:14px;">
		<span class="menuBlock">사원정보</span></a>
	</li>
	
	<hr class="hr_000000" />
	<li class="mslstttl f_74777d">로그아웃</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon07">
		<a href="javascript:pageMove('/mobile/logout.do');" alt="로그아웃" style="padding-top:14px;">
		<span class="menuBlock">로그아웃</span></a>
	</li>
	
	<hr class="hr_000000" />
	<li class="mslstttl f_74777d">PC버전</li>
	
	<hr class="hr_000000" />
	<hr class="hr_4a4a4d" />
	
	<li class="mslstmenu sIcon05">
		<a href="javascript:pageMove('pcVersion');" alt="PC버전" style="padding-top:14px;">
		<span class="menuBlock">PC버전으로 보기</span></a>
	</li>
<ul>

<form method="POST" name="reLoginFrm">
<input type="hidden" name="userId" value=""/>
<input type="hidden" name="reLoginYn" value=""/>
</form>