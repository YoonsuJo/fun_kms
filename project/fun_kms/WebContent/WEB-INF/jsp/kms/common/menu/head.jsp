<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/ajax_inc.jsp"%>

<%
String message = (request.getParameter("message") == null ? "" : request.getParameter("message"));
%>
<!-- TENY_170319 Google Analytics  -->
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-93894295-1', 'auto');
	ga('send', 'pageview');
//	ga('set', 'userId', {{USER_ID}}); // 로그인한 User-ID를 사용하여 User-ID를 설정합니다.
	ga('set', '&uid', '${user.userId}');
</script>

<script>
// 맨위에 있는 사원, 정보 검색창의 검색기능
function headSearch() {
	document.headSearchFrm.submit();
}

function adminPage(){	
	if("${user.admin}"=="true"){	
		document.headSearchFrm.action = "${rootPath}/admin/member/selectMemberList.do";
		document.headSearchFrm.submit();
	} else {
		alert("관리자만 권한이 있는 관리자페이지입니다.");
	}
}
function muvcViewCall() {
	var popup = window.open('${rootPath}/app.do','_DOSA_CONFERENCE_WINDOW','width=380px, height=520px');
	popup.focus();
}

function gameCall() {
	var game = window.open('http://222.112.235.135/game/startV.jsp?id=${user.userId}&no=${user.no}','_DOSA_GAME_WINDOW','width=810px, height=595px, scrollbars=no');
	game.focus();
}

containHeadPage = true;


/* 2013.07.24 김대현 웹메일 주소 */
onLoad();
function onLoad(){
	var message = "<%=message%>";
	if(message == "emailLinkWriteOk"){
		alert("회사 웹메일 로그인화면 주소를 등록 하였습니다.");
		emailLinkCall();
	}
}
function emailLinkCall(){
	var emailLink = "${user.emailLink}";
	if(emailLink.length > 0){	
		if(emailLink.indexOf("http://") != 0){
			emailLink = "http://"+emailLink;
		}
		window.open(emailLink,'_blank');
	}else{
		//alert("개인정보 수정 > 이메일 > 웹메일 주소에 웹메일 주소를 입력해주세요.");
		//document.headSearchFrm.action = "<c:url value='${rootPath}/member/updtMemberView.do' />";
		//document.headSearchFrm.submit();
		var scrolled = $(window).scrollTop();
		var position = $('#emailLinkImg').offset();
		var left = position.left + 0;
		var top = position.top + 10 - scrolled ;
		$('#emailLinkWrite').css("left",($('#emailLinkImg').offset().left+46)+"px");
		$('#emailLinkWrite').css("top",($('#emailLinkImg').offset().top+28)+"px");	
		$('#emailLinkWrite').show();
	}
}
function emailLinkWrite(){
	    if(nullChk() == true){
			var curPage = document.location.href;                
			document.headSearchFrm.curPage.value = curPage;
			document.headSearchFrm.action = "<c:url value='${rootPath}/member/updtMemberEmailLink.do' />";
			document.headSearchFrm.submit();
	    } 
}
function nullChk(){
var bol = true;
if (document.headSearchFrm.emailLink.value == ""){
alert('회사 웹메일 로그인 화면 주소를 입력하십시오.');
document.userInsertForm.oemail.focus();
bol = false;
}
return bol; 
}

function hideLayerName(openedLayerName) {
	$('#'+openedLayerName).hide();
}


function showLayer_head(layerName, obj) {	

	var scrolled = $(window).scrollTop();
	var position = $('#'+obj).offset();	
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;	

	$('#adminPageTxt').hide();
	$('#emailLinkTxt').hide();
	$('#muvcViewCallTxt').hide();
	$('#gameCallTxt').hide();	
	$('#bookCallTxt').hide();
		
	$('#'+layerName).css("left",($('#'+obj).offset().left+46)+"px");
	$('#'+layerName).css("top",($('#'+obj).offset().top+28)+"px");	
	$('#'+layerName).show();
	
}


function hideLayer_head()
{	
	$('#adminPageTxt').hide();
	$('#emailLinkTxt').hide();
	$('#muvcViewCallTxt').hide();
	$('#gameCallTxt').hide();	
	$('#bookCallTxt').hide();	
		
}

function bookCall() {
window.open('http://guide.dosanet.co.kr','_blank','width=1270, height=747, scrollbars=no, resizable=no, toolbars=no, menubar=no');
}


var mobile = "";
if(navigator.userAgent.match(/iPhone/) != null || navigator.userAgent.match(/iPad/) != null) { 
	mobile = "IOS";
}else if(navigator.userAgent.match(/Android/) != null) { 
	mobile = "Android";
}

function logout() {
	try {
		if(mobile == "Android") {
			mobilekms.setLogout(true);
		}
	} catch(e) {}
	document.headSearchFrm.action = "${rootPath}/logout.do";
	document.headSearchFrm.submit();
}

// [2014.6.25/김동우]검색 조건에 따라, 초성검색 지원여부 조절
function clickSearchConditionHead() {
	var condition = $('.search input[name=searchCondition]:checked').val();
	var searchKeyword = $('.search input[name=searchKeyword]');
	if (condition == 0)
		searchKeyword.addClass('userNameAutoHead');
	else {
		searchKeyword.removeClass('userNameAutoHead');
		removeAutoComplete(searchKeyword);
	}
}

$(document).ready(function() {
	if( !(("본사" == "${user.isInnerNetworkPrint}") &&!("${user.outerNetLoginLogList[0] }")) ) {
			$('#outerNetLoginLog').show("6");
	}
	
	$('#outerNetLoginLog').click(function() {
		if("본사" != "${user.isInnerNetworkPrint}") {return false;}	// 외부 접속이면 닫기 기능 무효화
		
		$.ajax({
			url: "/ajax/confirmOuterNetLoginLog.do"
			,type: "post"
			,async: false
			,success: function(data) {
				$('#outerNetLoginLog').hide("fast");
			}
			,error: function(xhr, testStatus, errorThrown) {
				alert("외부 접속 확인 창 닫기 실패");
				return false;
			}
		});
	});
	
	// [2014/10/20, dwkim] Top navigation 추가
	
	// 메인페이지를 제외하고는 Top Button 보이도록
	var currentPage = document.location.href; 
	if (currentPage.indexOf('main.do') == -1) {
		var targetContent = $('#center_bg').children().first();
		var center_bg_right = targetContent.offset().left + parseInt(targetContent.css('width'));
		var mainnav_left = center_bg_right + 1;
		$('#mainnav').css('left', mainnav_left + 'px');
		$('#mainnav').show();
	}
	
	$('#mainnav').hover(function() {
		$(this).animate({"opacity": 1}, "slow");
	}, function() {
		$(this).animate({"opacity": 0.4}, "slow");
	});

	$('#nav_top').click(function() {
		$(window).scrollTo({top:'0%', left:'+=0px'}, 1000);
	});

	$('#nav_center').click(function() {
		$(window).scrollTo({top:'50%', left:'+=0px'}, 1000);
	});

	$('#nav_bottom').click(function() {
		$(window).scrollTo({top:'100%', left:'+=0px'}, 1000);
	});
});



</script>




	<!-- S: header -->
	<div id="header">
		<fmt:parseDate value="${ user.outerNetLoginLogList[0].tm }" pattern="yyyy-MM-dd HH:mm:ss" var="conTime" />
		<fmt:formatDate value="${ conTime }" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" var="conTime" />
		<div id="outerNetLoginLog" style="display:none;">
			<img src="${imagePath}/inc/ico_alert.png" alt="[경고]" />
			<c:if test="${'본사' == user.isInnerNetworkPrint}">
				<span>[${ conTime }] 외부 IP(${ user.outerNetLoginLogList[0].ip })로 접속한 기록이 있습니다.</span>
				<span style="font-size:2em; vertical-align:-12px; margin-left:4px;">×</span>
			</c:if>
			<c:if test="${'본사' != user.isInnerNetworkPrint}">
				<span>외부 IP 접속입니다. 모든 사용 내역이 저장됩니다.</span>
			</c:if>
		</div> 
		<div id="logo_util">
<!--			<h1><a href="${rootPath}/statusBoard.do"><img src="${imagePath}/inc/top_logo.gif" alt="KMS 지식관리시스템"/></a></h1> -->
			<h1><a href="${rootPath}/main.do"><img src="${imagePath}/inc/top_logo.gif" alt="KMS 지식관리시스템"/></a></h1>

			<form name="headSearchFrm" method="POST" action="${rootPath}/headSearch.do" onsubmit="headSearch(); return false;">
			
			<!-- 2013.07.24 김대현 퇴사자는 관리자만 검색되도록 -->
			<input type="hidden" name="isAdmin" value=${user.admin}>
			<!-- 2013.07.24 김대현 웹메일 주소 -->
			<input type="hidden" name="no" value=${user.no}>
			<input type="hidden" name="curPage" value="">
			
			<input type="hidden" name="bbsPageIndex" value="1"/>
			<input type="hidden" name="bcPageIndex" value="1"/>
			<div class="search">
				<ul>
					<li class="option_txt">
						<label>사원<span class="pL7"></span><input type="radio" name="searchCondition" value="0" onclick="javascript:clickSearchConditionHead();" <c:if test="${empty headSearchVO || 

headSearchVO.searchCondition == 0}">checked="checked"</c:if>></label><span class="pL7"></span>
						<label>정보<span class="pL7"></span><input type="radio" name="searchCondition" value="1" onclick="javascript:clickSearchConditionHead();" <c:if 

test="${headSearchVO.searchCondition == 1}">checked="checked"</c:if>></label>
					</li>
					<li class="search_box"><input type="text" class="search_txt userNameAutoHead" name="searchKeyword" value="${headSearchVO.searchKeyword}"/></li>
					<li><input type="image" src="${imagePath}/btn/btn_search.gif" alt="검색"/></li>
				</ul>
			</div>
						
			<div class="simpleMsg_layer" id="emailLinkWrite" >				
				<table width="380" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td style="padding:40px">
				    <!-- content -->
				    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				          <tr>
				            <td style="padding-bottom:20px;"><img src="${imagePath}/main/txt.gif" alt="웹메일 로그인 화면 주소 등록"/></td>
				          </tr>
				          <tr>
				            <td height="2" style="background-color:#4b4b4b;"></td>
				          </tr>
				          <tr>
				            <td height="20"></td>
				          </tr>
				          <tr>
				            <td bgcolor="#f6f6f6" style="padding:20px; border:1px solid #dbdbdb;">
				            	<!-- mail -->
				                <table width="100%" border="0" cellspacing="0" cellpadding="0">
				                  <tr>
				                    <td height="30" valign="top"><b>펀네트</b></td>
				                    <td valign="top" style="color:#1285de;">mail.fun-net.co.kr</td>
				                  </tr>
				                  <tr>
				                    <td height="30" valign="top"><b>새하컴즈</b></td>
				                    <td valign="top" style="color:#1285de;">mail.saeha.com</td>
				                  </tr>
				                  <tr>
				                    <td height="30" valign="top"><b>프로비츠</b></td>
				                    <td valign="top" style="color:#1285de;">mail.probits.co.kr</td>
				                  </tr>
				                  <tr>
				                    <td valign="top"><b>쏘몬</b></td>
				                    <td valign="top" style="color:#1285de;">mail.ssomon.com</td>
				                  </tr>				                  
				                </table>
				            	<!-- mail -->
				            </td>
				          </tr>
				          <tr>
				            <td style="font-size:14px; font-weight:bold; padding-top:30px;">회사 웹메일 로그인 화면 주소</td>
				          </tr>
				          <tr>
				             <td><input type="text" name="emailLink" id="emailLink" style="margin-top:10px; border:1px solid #bebebe; width:300px; height:28px; padding-left:2px;"/></td>
				          </tr>
				          <tr>
				            <td style="padding-top:30px;">
				            	<!-- btn -->
				                <table width="100%" border="0" cellspacing="0" cellpadding="0">
				                  <tr>
				                    <td width="235" style="text-align:right;"><a href="javascript:emailLinkWrite()" onfocus="this.blur()"><img src="${imagePath}/btn/btn_r.gif" alt="등록"/></a></td>
				                    <td width="65" style="text-align:right;"><a href="javascript:hideLayerName('emailLinkWrite');" onfocus="this.blur()"><img src="${imagePath}/btn/btn_c.gif" alt="취소"/></a></td>
				                  </tr>
				                </table>
				                <!-- btn -->
				            </td>
				          </tr>
				        </table>
				    <!-- content -->
				    </td>
				  </tr>
				</table>
				</div>							
			</form>
			
			<div class="utility">
				<ul>
					<!-- 2014.04.18. 김동우 한마음 화상회의(통합멀티뷰)-->
					<li>
						<a href="http://hanmam.svc.saeha.com/sso/ssologin.do?userid=${user.userId}" target="_blink">
						<img src="${imagePath}/mvuc_images/icon_multiview.png" style="width:23px;margin-top:3px;"  title="한마음 화상회의"/></a> &nbsp; &nbsp;
					</li>
					<!-- 관리자 버튼을 관리자만 보이게 수정 -->
					<c:if test="${user.admin == 'true'}">
					<li><a href="javascript:adminPage();"><img id="adminPageImg" src="${imagePath}/inc/util_admin.gif" alt="관리자페이지" 
							onmouseover="showLayer_head('adminPageTxt','adminPageImg')" onmouseout="hideLayer_head()"/></a></li>
					</c:if>
					<li><a href="javascript:emailLinkCall(this);"><img id="emailLinkImg" src="${imagePath}/inc/mail.gif" alt="웹메일" 
							onmouseover="showLayer_head('emailLinkTxt','emailLinkImg')" onmouseout="hideLayer_head()"/></a></li>
				</ul>
				
				<div class="simpleMsg_layer" id="adminPageTxt">관리자 기능 </div>
				<div class="simpleMsg_layer" id="emailLinkTxt">회사 웹메일(링크)
				<c:if test="${user.emailLink != ''}">
				<br>${user.emailLink}<br>인사정보에서 수정 가능
				</c:if>
				</div>
				<div class="simpleMsg_layer" id="muvcViewCallTxt">application 다운로드</div>
				
			</div>
		</div>
		<div id="gnb_menu">
			<!-- S: LOGIN_INFO -->
			<c:set var="loginInfoUrl" value="${rootPath}/member/selectAbsenceState.do"/>
			<c:set var="loginInfoUrlTitle" value="부재현황 조회"/>
			<c:set var="loginInfoUrl" value="${rootPath}/member/dailyWorkStateStatistic.do"/>
			<c:set var="loginInfoUrlTitle" value="일일근태기록 조회"/>
			<ul class="login_info">
				<li class="mem_txt cursorPointer" onclick="location.href='${loginInfoUrl }'" onmouseover="javascript:showHelp('${loginInfoUrlTitle }', showHelpToMem);" onmouseout="javascript:hideHelp();">
				${user.userNm}</li>
				<li class="mem_location cursorPointer" onclick="location.href='${loginInfoUrl }'" onmouseover="javascript:showHelp('${loginInfoUrlTitle }', showHelpToMem);" onmouseout="javascript:hideHelp();">		

				[${user.isInnerNetworkPrint}${user.attendCdPrintSlash}]
<!--				${user.attendCdPrint}${user.attendCdPrintSimple}-->
				</li>
				<li class="cursorPointer" onclick="location.href='${loginInfoUrl }'" onmouseover="javascript:showHelp('${loginInfoUrlTitle }', showHelpToMem);" onmouseout="javascript:hideHelp();">
					<div id="showHelpToMem"></div>
				</li>				
				<li class="login_time cursorPointer" onclick="location.href='${loginInfoUrl }'" onmouseover="javascript:showHelp('${loginInfoUrlTitle }', showHelpToMem);" onmouseout="javascript:hideHelp();">
				${user.attendTmShort}
				<!--				${user.attendTm}-->
				</li>
				<li class="cursorPointer" onclick="location.href='${rootPath}/member/insertAbsenceView.do?wsTyp=O'" onmouseover="javascript:showHelp('부재등록', this);" onmouseout="javascript:hideHelp();"><img 

class="pL10" src="${imagePath}/btn/btn_write01.gif" alt="외근등록"/>
				</li>
			</ul>
			<!-- E: LOGIN_INFO -->	
			<!-- S: GNB -->
			<ul id="gnbmenu">
				<li class="gnb_first">
				</li>
				<li><a href="${rootPath}/daily/DailyByWeekL.do" id="top1m1"><img src="${imagePath}/inc/gnb/gnb01.gif" alt="공통업무" /></a>
					<div id="snbmenu_m1">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu01m1"><a href="${rootPath}/daily/DailyByWeekL.do">나의업무</a></li>
									<li id="snbmenu01m2"><a href="${rootPath}/project/listMyProject.do">나의 프로젝트</a></li>
									<li id="snbmenu01m3"><a href="${rootPath}/approval/main.do">전자결재</a></li>
									<li id="snbmenu01m4"><a href="${rootPath}/cooperation/selectMeetingRoomList.do">펀네트회의실</a></li>
									<li id="snbmenu01m5"><a href="javascript:myTask('today');">나의업무[기존]</a></li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>
				</li>
				<li><a href="${rootPath}/cooperation/selectDayReport.do" id="top1m2"><img src="${imagePath}/inc/gnb/gnb02.gif" alt="부서업무" /></a>
					<div id="snbmenu_m2">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">

 <!-- 
"ORGAN_TOP_ORGAN_CODE"	"회사"
-->
<!--
 ORGAN_00000000000004 : 경영기획실 
 -->
<!-- 
ORGAN_00000000000311 : VC사업부
ORGAN_00000000000032 : 서비스사업팀
ORGAN_00000000000031"	"솔루션사업팀
ORGAN_00000000000015 : 국방SI사업부
ORGAN_00000000000331 : 신사업부
 -->
 <!-- 
"ORGAN_00000000000211"	"서비스본부"
"ORGAN_00000000000033"	"서비스운영팀"
"ORGAN_00000000000241"	"서비스기술팀"
"ORGAN_00000000000191"	"솔루션기획팀"
 -->
 <!-- 
"ORGAN_00000000000035"	"PC기술팀"
"ORGAN_00000000000036"	"기반기술팀"
"ORGAN_00000000000171"	"모바일기술팀"
"ORGAN_00000000000361"	"웹기술팀"

 -->
 
<c:choose>
	<c:when test="${user.orgnztId == 'ORGAN_TOP_ORGAN_CODE'}">  <!--		회사 -->
									<li id="snbmenu02m1"><a href="/fund/chckOrgSalesList.do">채권관리</a></li>
									<li id="snbmenu02m2"><a href="/fund/invoiceList.do?searchMode=1">계산서발행요청</a></li>
									<li id="snbmenu02m3"><a href="/fund/invoiceList.do?searchMode=3">수금등록</a></li>
									<li id="snbmenu02m4"><a href="/management/selectExpenseStatistic.do">경비지출내역</a></li>
									<li id="snbmenu02m5"><a href="/management/fundWeekly.do">주간자금보고</a></li>
									<li id="snbmenu02m6"><a href="/management/fundMonthly.do">월간자금보고</a></li>
									<li id="snbmenu02m7"><a href="/support/stockL.do">재고 현황</a></li>
									<li id="snbmenu02m8"><a href="/product/selectProductInfoList.do">제품관리</a></li>
									<li id="snbmenu02m9"><a href="/product/selectProductRequestMain.do?requestType=E">기능오류관리</a></li>
									<li id="snbmenu02m10"><a href="/request/RequestList.do">요구사항관리</a></li>
									<li id="snbmenu02m11"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:when>
	<c:when test="${user.orgnztId == 'ORGAN_00000000000004' }"> <!-- 경영기획실 -->
									<li id="snbmenu02m1"><a href="/fund/chckOrgSalesList.do">채권관리</a></li>
									<li id="snbmenu02m2"><a href="/fund/invoiceList.do?searchMode=2">계산서발행</a></li>
									<li id="snbmenu02m3"><a href="/fund/invoiceList.do?searchMode=3">수금등록</a></li>
									<li id="snbmenu02m4"><a href="/management/selectExpenseStatistic.do">경비지출내역</a></li>
									<li id="snbmenu02m5"><a href="/management/fundWeekly.do">주간자금보고</a></li>
									<li id="snbmenu02m6"><a href="/management/fundMonthly.do">월간자금보고</a></li>
									<li id="snbmenu02m7"><a href="/support/stockL.do">재고 현황</a></li>
									<li id="snbmenu02m8"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:when>
	<c:when test="${ (user.orgnztId == 'ORGAN_00000000000015') || (user.orgnztId == 'ORGAN_00000000000331') }"> <!--		국방SI사업부, 신사업부 -->
									<li id="snbmenu02m1"><a href="/fund/invoiceList.do?searchMode=1">계산서발행요청</a></li>
									<li id="snbmenu02m2"><a href="/fund/chckOrgSalesList.do">채권관리</a></li>
									<li id="snbmenu02m3"><a href="/fund/chckProjectBondCheckList.do">미수금현황</a></li>
									<li id="snbmenu02m4"><a href="/fund/bizCollectList.do">수금현황조회</a></li>
									<li id="snbmenu02m5"><a href="/management/contractL.do?searchTyp=W">수주계약</a></li>
									<li id="snbmenu02m6"><a href="/management/contractL.do?searchTyp=O">발주계약</a></li>
									<li id="snbmenu02m7"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:when>
	<c:when test="${ (user.orgnztId == 'ORGAN_00000000000311') || (user.orgnztId == 'ORGAN_00000000000031') || (user.orgnztId == 'ORGAN_00000000000032') }"> <!--		VC사업부, 솔루션사업팀, 서비스사업팀 -->
									<li id="snbmenu02m1"><a href="/fund/invoiceList.do?searchMode=1">계산서발행요청</a></li>
									<li id="snbmenu02m2"><a href="/fund/chckOrgSalesList.do">채권관리</a></li>
									<li id="snbmenu02m3"><a href="/fund/chckProjectBondCheckList.do">미수금현황</a></li>
									<li id="snbmenu02m4"><a href="/fund/bizCollectList.do">수금현황조회</a></li>
									<li id="snbmenu02m5"><a href="/cooperation/selectConsultManageListMine.do">상담관리</a></li> 
									<li id="snbmenu02m6"><a href="/management/contractL.do?searchTyp=W">수주계약</a></li>
									<li id="snbmenu02m7"><a href="/management/contractL.do?searchTyp=O">발주계약</a></li>
									<li id="snbmenu02m8"><a href="/cooperation/selectClientList.do">고객사관리</a></li>
									<li id="snbmenu02m9"><a href="/request/RequestList.do">요구사항관리</a></li>
									<li id="snbmenu02m10"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:when>
	<c:when test="${(user.orgnztId == 'ORGAN_00000000000211') || (user.orgnztId == 'ORGAN_00000000000033') || (user.orgnztId == 'ORGAN_00000000000191') || 
			(user.orgnztId == 'ORGAN_00000000000241') }" >  <!-- 	서비스본부 -->
									<li id="snbmenu02m1"><a href="/cooperation/selectConsultManageListMine.do">상담관리</a></li> 
									<li id="snbmenu02m2"><a href="/cooperation/writeConsultManage.do">상담접수</a></li>
									<li id="snbmenu02m3"><a href="/cooperation/selectConsultManageListMine.do">상담처리</a></li>
									<li id="snbmenu02m4"><a href="/cooperation/selectConsultManageList.do">상담결과</a></li>
									<li id="snbmenu02m5"><a href="/cooperation/consultStatusList2.do">상담통계</a></li>
									<li id="snbmenu02m6"><a href="/cooperation/selectClientList.do">고객사관리</a></li>
									<li id="snbmenu02m7"><a href="/request/RequestList.do">요구사항관리</a></li>
									<li id="snbmenu02m8"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:when>  
	<c:when test="${(user.orgnztId == 'ORGAN_00000000000012') || (user.orgnztId == 'ORGAN_00000000000035') || (user.orgnztId == 'ORGAN_00000000000036') || 
			(user.orgnztId == 'ORGAN_00000000000171') || (user.orgnztId == 'ORGAN_00000000000361')}"> <!-- 	솔루션개발연구소 -->
									<li id="snbmenu02m1"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
									<li id="snbmenu02m2"><a href="/request/RequestList.do">요구사항관리</a></li>
									<li id="snbmenu02m3"><a href="/product/listProduct.do">제품관리</a></li>
									<li id="snbmenu02m4"><a href="/product/listPart.do">구성품관리</a></li>
	</c:when>
	<c:otherwise>
									<li id="snbmenu02m1"><a href="/cooperation/selectPrjBoardMain.do">프로젝트 게시판</a></li>
									<li id="snbmenu02m2"><a href="/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">솔루션게시판</a></li>
	</c:otherwise>
</c:choose>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>
				</li>
				<li><a href="${rootPath}/management/monthResultStatistic.do" id="top1m3"><img src="${imagePath}/inc/gnb/gnb03.gif" alt="경영정보" /></a>
					<div id="snbmenu_m3">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu03m1"><a href="${rootPath}/management/monthResultStatistic.do">사업실적</a></li>
<c:if test="${(user.rankId == '01') || (user.rankId == '12') || (user.rankId == '11') || (user.rankId == '03') }" >
									<li id="snbmenu03m9"><a href="${rootPath}/management/stepResultStatistic.do">다단계성과분석</a></li>
</c:if>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li><a href="/support/selectBoardList.do?bbsId=BBSMSTR_000000000053" id="top1m4"><img src="${imagePath}/inc/gnb/gnb04.gif" alt="업무지원" /></a>
					<div id="snbmenu_m4">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu04m1"><a href="/support/selectBoardList.do?bbsId=BBSMSTR_000000000053">업무처리절차</a></li>
									<li id="snbmenu04m2"><a href="/support/ruleL.do">제반규정</a></li>
									<li id="snbmenu04m3"><a href="http://localhost:9080/support/selectBoardList.do?bbsId=BBSMSTR_000000000052">각종문서양식</a></li>
									<li id="snbmenu04m4"><a href="/support/selectBoardList.do?bbsId=BBSMSTR_000000000050">회사자료</a></li>
									<li id="snbmenu04m5"><a href="/support/selectCarRsvCalendar.do">차량예약</a></li>
									<li id="snbmenu04m6"><a href="/support/selectBoardList.do?bbsId=BBSMSTR_000000000061">한마음 개선요청</a></li>
									<li id="snbmenu04m7"><a href="/support/selectIpList.do">사내 IP 관리</a></li>
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li ><a href="${rootPath}/member/selectMemberMain.do" id="top1m5"><img src="${imagePath}/inc/gnb/gnb05.gif" alt="인사정보" /></a>
					<div id="snbmenu_m5">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
									<li id="snbmenu05m1"><a href="${rootPath}/member/selectMemberList.do">사원정보</a></li>
									<li id="snbmenu05m2"><a href="${rootPath}/member/dailyWorkStateStatistic.do">일일근태기록</a></li>
<!-- 
									<li id="snbmenu05m3"><a href="${rootPath}/member/selectMemberCareerList.do">이력관리</a></li>
									<li id="snbmenu05m4"><a href="${rootPath}/member/selectOvertimeView.do">연장근무내역</a></li>
									<li id="snbmenu05m5"><a href="${rootPath}/member/selectVacationSummaryView.do">휴가사용내역</a></li>
									<li id="snbmenu05m6"><a href="${rootPath}/member/selectHolidayWorkStatisticView.do">휴일근무내역</a></li>
 -->
 								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li >
					<div id="snbmenu_m6">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li >
					<div id="snbmenu_m7">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
				<li class="gnb_last">
					<div id="snbmenu_m8">
						<ul>
							<li class="snb_topBg"></li>
							<li class="snb_cenBg">
								<ul class="snbmenu_txt">
								</ul>
							</li>
							<li class="snb_botBg"></li>
						</ul>
					</div>				
				</li>
			</ul>

			<!-- E: GNB -->
			
			<!-- S: LOGIN_ETC -->
			<ul class="login_etc">
<!-- mypage/listMenuAll.do
<li class="etc_over"><a href="${rootPath}/main.do" id="top1m0" >HOME</a></li>
 -->
				<li class="etc_over"><a href="${rootPath}/mypage/listMenuAll.do" >MENU</a></li>
				<li class="etc_over"><a href="${rootPath}/member/selectMember.do">MY PAGE</a></li>
				<li class="etc_over"><a href="javascript:logout();">LOGOUT</a></li>
			</ul>
			<!-- E: LOGIN_ETC -->
			
			<!-- S: Top&Bottom navigation -->
			<ul id="mainnav">
				<li id="nav_top" title="최상단으로"><img src="${imagePath}/inc/new_fnc.png" style="margin:-22px 0 0 1px;" title="업무연락, 전자결재 등 스크롤이 긴 메뉴에서 이용하면 편리한 기능입니다."/></li>
				<li id="nav_center" title="중간으로"></li>
				<li id="nav_bottom" title="최하단으로"></li>
			</ul>
			<!-- E: Top&Bottom navigation -->
		</div>
	</div>
	<!-- E: header -->
	
