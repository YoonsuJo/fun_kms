<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="print" uri="print" %>
<%@ page import = "kms.com.common.utils.CalendarUtil" %>
<%
String today =  CalendarUtil.getToday();
String searchDateInit = CalendarUtil.getFirstDateOfThisWeek2(CalendarUtil.getToday()); //기존 일요일 구하는 함수 변형한 월요일 구하는 함수로 변경
String searchLastDateOfThisWeek =  CalendarUtil.getLastDateOfThisWeek(CalendarUtil.getToday());
%>
<script>
function curUserShow(obj) {
	delayCommonTimer(1);
	$('#CurUser_layer').css("left",($(obj).offset().left+20)+"px");
	$('#CurUser_layer').css("top",($(obj).offset().top+15)+"px");	
	$('#CurUser_layer').show();

	function curUserLayerClickEvent(event){
		if (!$(event.target).closest($('#CurUser_layer')).length 
				&& event.target !== $(obj).get(0)) {
			curUserHide();
			$('body').unbind('click.curUserLayer');
	    };
	}
	$('body').bind('click.curUserLayer', curUserLayerClickEvent );
}
function curUserHide() {
	$('#CurUser_layer').hide();
}
function myMenuToggle() {
	$('#targetMyMenu').toggle();
}
var openedLayerNameCheckList;
var openLayerBoolCheckList = "Y";
function hideLayerCheckList() {
	//$('#'+openedLayerName).dialog( "close" );
	$('#'+openedLayerNameCheckList).hide();
}
function showLayerCheckList(layerName, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;	

	hideLayerCheckList();	
	openedLayerNameCheckList = layerName;

	if(openLayerBoolCheckList=="N"){
		return;
	}
	$('#'+layerName).css("left",($(obj).offset().left+23)+"px");
	$('#'+layerName).css("top",($(obj).offset().top+20)+"px");	
	$('#'+layerName).show();
}
function writeTaskMy() {
	var popup = window.open("${rootPath}/cooperation/insertTaskView.do?no=${user.no}&date=${calendarInfo.date}&param_returnUrl=${rootPath}/cooperation/selectDayReportMyList.do","_TASK_POP_","width=570px,height=450px,scrollbars=yes,resizable=yes");
	popup.focus();
}


function myTask(searchType) {

	document.myTaskFrm.searchType.value = searchType;



	
	if(searchType == 'seven'){
		document.myTaskFrm.searchDateFrom.value = '<%=searchDateInit%>'; 
		document.myTaskFrm.searchDateTo.value = '<%=searchLastDateOfThisWeek%>'; 
	}else if(searchType == 'thirty'){
		var df = document.myTaskFrm.searchDateFrom.value; 
		var dt = document.myTaskFrm.searchDateTo.value;
		document.myTaskFrm.searchDateFrom.value = getFirstDayOfMonth(df);
		document.myTaskFrm.searchDateTo.value = getLastDayOfMonth(df);
	}else if(searchType == 'next'){
		var df = document.myTaskFrm.searchDateFrom.value; 
		var dt = document.myTaskFrm.searchDateTo.value;
		document.myTaskFrm.searchDateFrom.value = getFirstDayOfMonth(df);
		document.myTaskFrm.searchDateTo.value = getLastDayOfMonth(df);
	}
	document.myTaskFrm.action = "${rootPath}/cooperation/selectDayReportMyList.do";	
	document.myTaskFrm.submit();
}

</script>
<h2>
	체크리스트 
	<div class="replay">
		<span class="txt_blue4 pR5 cursorPointer" onclick="javascript:curUserShow(this);">접속 : ${chkList.connUser}명</span>
<!--		<span class="txt_blue4 pR5 cursorPointer" onclick="javascript:showLayerCheckList('accept',this);" onmouseout="hideLayer()">접속 : ${chkList.connUser}명</span>-->
		<img src="${imagePath}/btn/btn_replay.gif" alt="새로고침" onclick="refreshChkList()" style="cursor:pointer;" />
	</div>
</h2>

<ul class="chk_menu">
  	<form name="myTaskFrm" id="myTaskFrm" method="get">
			    	<input type="hidden" name="dateMove" value="0"/>
			    	<input type="hidden" name="searchDate" value="<%=today%>"/>	
			    	<input type="hidden" name="searchType" value=""/>			    	
			    	<input type="hidden" name="searchDateFrom" value="<%=today%>"/>		    	
			    	<input type="hidden" name="searchDateTo" value="<%=today%>"/>		    	
	</form>
 	<li class="line"><a href="javascript:myTask('today');">나의업무</a>
		<a href="javascript:myTask('today');">
		<span class="txt_blue" onmouseover="showLayerCheckList('today',this)" onmouseout="hideLayerCheckList()">
			[${chkList.todayPCnt},</span></a>
		<a href="javascript:myTask('seven');">
		<span class="txt_blue" onmouseover="showLayerCheckList('seven',this)" onmouseout="hideLayerCheckList()">
			${chkList.sevenPCnt},</span></a>
		<a href="javascript:myTask('thirty');">
		<span class="txt_blue" onmouseover="showLayerCheckList('thirty',this)" onmouseout="hideLayerCheckList()">
			${chkList.thirtyPCnt},</span></a>
		<a href="javascript:myTask('next');">
		<span class="txt_blue" onmouseover="showLayerCheckList('next',this)" onmouseout="hideLayerCheckList()">
			${chkList.nextPCnt}]</span></a>
		<a href="javascript:writeTaskMy();">
			<img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"
				onmouseover="showLayerCheckList('newMission',this)" onmouseout="hideLayerCheckList()"/>
		</a>
		<a href="${rootPath}/cooperation/selectDayReportMyDList.do" target="_blank">
			<img src="${imagePath}/btn/btn_team.gif" alt="우리 팀 실적 조회"
				onmouseover="showLayerCheckList('teamTask',this)" onmouseout="hideLayerCheckList()" />
		</a>
	</li>
	
	<li class="line"><a href="${rootPath}/approval/main.do">전자결재</a>
		<a href="${rootPath}/approval/approvalL.do?mode=2">
		<span class="txt_blue" onmouseover="showLayerCheckList('accept',this)" onmouseout="hideLayerCheckList()">
			[${chkList.accept},</span></a>
		<a href="${rootPath}/approval/approvalL.do?mode=12">
		<span class="txt_blue" onmouseover="showLayerCheckList('reference',this)" onmouseout="hideLayerCheckList()">
			${chkList.reference},</span></a>
		<a href="${rootPath}/approval/approvalL.do?mode=13">
		<span class="txt_blue" onmouseover="showLayerCheckList('todo',this)" onmouseout="hideLayerCheckList()">
			${chkList.todo},</span></a>
		<a href="${rootPath}/approval/approvalL.do?mode=5">
		<span class="txt_blue" onmouseover="showLayerCheckList('reject',this)" onmouseout="hideLayerCheckList()">
			${chkList.reject}]</span></a>
<!--		<span class="txt_blue">[1, 12, 13, 47]</span>-->
		<a href="${rootPath}/approval/appr_NewDraft.do"> <img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/cooperation/selectBusinessContactList.do">업무연락</a>
		<a href="${rootPath}/cooperation/selectBusinessContactList.do">
		<span class="txt_blue" id="busiCntctCnt">[${chkList.busiCntct}]</span></a>
		<a href="${rootPath}/cooperation/insertBusinessContactView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectRecieveNoteList.do">쪽지</a>		
			<a href="${rootPath}/community/selectRecieveNoteList.do">
			<span class="txt_blue" onmouseover="showLayerCheckList('recieveNote',this)" onmouseout="hideLayerCheckList()">
				[${chkList.note}]</span></a>
			<!-- 
			<a href="${rootPath}/community/selectSendNoteList.do">
			<span class="txt_blue" onmouseover="showLayerCheckList('sendNote',this)" onmouseout="hideLayerCheckList()">
				${chkList.noreadnote}]</span></a>
			 -->
			<a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')">
			<img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectUnreadBoardList.do">게시물</a>		
			<!--[${chkList.comm}]-->
<!--			<a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031"-->
<!--			><span class="txt_blue">[${chkList.notice}]</span></a><a -->
<!--			href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001"-->
<!--			><span class="txt_blue">[${chkList.commFree}]</span></a>-->
			<a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">
			<span class="txt_blue" onmouseover="showLayerCheckList('notice',this)" onmouseout="hideLayerCheckList()">
				[${chkList.notice},</span></a>
			<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">
			<span class="txt_blue" onmouseover="showLayerCheckList('commFree',this)" onmouseout="hideLayerCheckList()">
				${chkList.commFree}]</span></a>
			<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000001"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectRecieveMailList.do">사내메일</a>		
			<a href="${rootPath}/community/selectRecieveMailList.do">
			<span class="txt_blue" onmouseover="showLayerCheckList('recieveMail',this)" onmouseout="hideLayerCheckList()">
				[${chkList.mail}]</span></a>
			<!-- 
			<a href="${rootPath}/community/selectSendMailList.do">
			<span class="txt_blue" onmouseover="showLayerCheckList('sendMail',this)" onmouseout="hideLayerCheckList()">
				${chkList.noreadmail}]</span></a>
			-->
			<a href="${rootPath}/community/sendMailView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
<!--	<li class="sub_chk_menu">-->
<!--		<ul class="chk_menu2" >			-->
<!--			<li class="chk_menuli1">-->
<!--			- <a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">-->
<!--					공지사항</a> <span class="txt_blue">[${chkList.notice}]</span>	-->
<!--			</li>-->
<!--			<li>-->
<!--			- <a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">-->
<!--			       자유게시판</a> <span class="txt_blue"> [${chkList.commFree}]</span>-->
<!--			</li>-->
<!--		</ul>-->
<!--	</li>-->
<!-- 	
	<li class="sub_chk_menu">
		<ul class="chk_menu2" >
			<li>
			- <a href="${rootPath}/approval/selectCardSpendList.do"> 법인카드 미상신 내역</a> 
			<a href="${rootPath}/approval/selectCardSpendList.do"><span class="txt_blue">[${chkList.cardSpend}]</span></a>
			</li>
		</ul>
	</li>
 -->
	<c:if test="${user.taxAdmin}">
	<li class="line">
			<a href="${rootPath}/fund/invoiceList.do?searchMode=1">세금계산서</a>
			<c:forEach items="${taxChkList}" var="result" varStatus="c">
				<c:if test="${result.compCd == 'tax_all'}"><span class="txt_blue"> [${result.cnt}]</span></c:if>
			</c:forEach>
			<c:if test="${fn:length(taxChkList) != 1 && fn:length(taxChkList) != 0}">
				<ul class="chk_menu2" >
					<c:forEach items="${taxChkList}" var="result" varStatus="c">
						<c:if test="${result.compCd != 'tax_all'}">
					<li style="position:relative; left:-12px; padding-top:2px;">
							- <a href="${rootPath}/fund/invoiceList.do?searchMode=1">
									${result.compNm}</a> <span class="txt_blue">[${result.cnt}]</span>	
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
	</li>
	</c:if>
	<!--나의메뉴-->
	<li class="line">
		<a href="javascript:myMenuToggle();">나의메뉴</a>
		<span style="position:relative; top:4px;">
			<a href="${rootPath}/mypage/MymenuList.do"><img src="${imagePath}/btn/btn_plus.gif"/></a>
		</span>		
		<ul class="chk_menu2" >
		<!-- 5개만 출력하는 2가지 방법예제 -->
			<c:forEach items="${myMenuList}" var="menu" varStatus="s" begin="0" end="20" step="1">		
				<c:if test="${s.count < 21}"> 
					<li style="position:relative; left:-12px; padding-top:2px;">
						- <a href="${menu.linkUrl}" target="_blank"><c:out value="${menu.menuSj}" /></a>  
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</li>
</ul>



<!-- 현재접속자 레이어  -->
<c:set var="memCnt" value="${fn:length(currentUserList)}" />
<c:set var="layerHeight" value="${(memCnt - (memCnt%3) + 3)*10 + 50}" />
<div class="CurUser_layer" id="CurUser_layer" style="display:none;<c:if test="${memCnt <= 45}"> height:${layerHeight}px;</c:if>">
	<table cellpadding="0" cellspacing="0" summary="">
	<caption>현재접속자</caption>
	<colgroup>
		<col width="33%">
		<col width="33%">
		<col width="33%">
	</colgroup>
	<tbody>
		<c:forEach items="${currentUserList}" var="cur" varStatus="c">
			<c:if test="${c.count % 3 == 1}">
			<c:out value="<tr>" escapeXml="false" />
			</c:if>
			<td><print:user userNo="${cur.userNo}" userNm="${cur.userNm}" userId="${cur.userId}" printId="true"/></td>
			<c:if test="${c.count % 3 == 0}">
			<c:out value="<tr>" escapeXml="false" />
			</c:if>
		</c:forEach>
	</tbody>
	</table>
</div>
<!-- //미투입인력 레이어 -->

<div class="simpleMsg_layer" id="accept">승인할문서</div>
<div class="simpleMsg_layer"  id="reference">참조할문서</div>
<div class="simpleMsg_layer"  id="todo">처리할문서</div>
<div class="simpleMsg_layer"  id="reject">반려된문서</div>
<div class="simpleMsg_layer"  id="notice">공지사항</div>
<div class="simpleMsg_layer"  id="commFree">자유게시판</div>

<div class="simpleMsg_layer"  id="todayMission">오늘</div>
<div class="simpleMsg_layer"  id="sevenMission">이번주</div>
<div class="simpleMsg_layer"  id="thirtyMission">이번달</div>
<div class="simpleMsg_layer"  id="nextMission">향후</div>

<div class="simpleMsg_layer"  id="today">오늘</div>
<div class="simpleMsg_layer"  id="seven">이번주</div>
<div class="simpleMsg_layer"  id="thirty">이번달</div>
<div class="simpleMsg_layer"  id="next">향후</div>
<div class="simpleMsg_layer"  id="newMission">새 작업 작성하기</div>
<div class="simpleMsg_layer"  id="teamTask">우리팀 실적조회</div>


<div class="simpleMsg_layer"  id="recieveMail">받은편지</div>
<div class="simpleMsg_layer"  id="sendMail">보낸편지</div>

<div class="simpleMsg_layer"  id="recieveNote">받은쪽지</div>
<div class="simpleMsg_layer"  id="sendNote">보낸쪽지</div>
