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
$(document).ready(function() {
	$.ajax({
		url: "/common/getCheckListAjax.do",
		type: "POST",
		dataType: "text",
		success: function(data) {
			/* $("#chkListId").val(data); */
			var result = $.parseJSON(data).checkList;
			$(".connUser").text("접속 : "+result.connUser);
			
			
			//요구사항
			if(result.request > 0){
				$(".requestProcess").empty();
				var requestHtml = '';
						
				requestHtml +='<a href="${rootPath}/request/RequestList.do?mode=18">'
				requestHtml +='<span class="txt_blue" onmouseover="showLayerCheckList(\'reqweek\',this)" onmouseout="hideLayerCheckList()">'
				requestHtml +='['+result.reqweek+', </span></a>'
				requestHtml +='<a href="${rootPath}/request/RequestList.do?mode=19">'
				requestHtml +='<span class="txt_blue" onmouseover="showLayerCheckList(\'reqmonth\',this)" onmouseout="hideLayerCheckList()">'
				requestHtml +=''+result.reqmonth+']</span></a>';
				$(".requestProcess").append(requestHtml);
			}
			
			if(result.cardSpend > 0){
				$(".approval2").empty();
				var approvalHtml2 = '';
				approvalHtml2 += '<ul class="chk_menu2" >';
				approvalHtml2 += '<li style="position:relative; left:-12px; padding-top:2px;">';
				approvalHtml2 += '- <a href="${rootPath}/approval/selectCardSpendList.do"> 법인카드 미상신 내역</a> ';
				approvalHtml2 += '<a href="${rootPath}/approval/selectCardSpendList.do"><span class="txt_blue">['+result.cardSpend+']</span></a>';
				approvalHtml2 += '</li>';
				approvalHtml2 += '</ul>';
				$(".approval2").append(approvalHtml2);
			}
			
			//업무연락
			if(result.busiCntct > 0){
				$(".busiCntAppend").empty();
				var busiCntHtml = '';
				busiCntHtml += '<a href="${rootPath}/cooperation/selectBusinessContactList.do"><span class="txt_blue" id="busiCntctCnt">['+result.busiCntct+']</span></a>';
				$(".busiCntAppend").append(busiCntHtml);
			}
			
			//펀네트 회의실
			if(result.meetUnread > 0){
				$(".meetUnreadAppend").empty();
				var meetUnreadHtml = '';
				meetUnreadHtml += '<a href="${rootPath}/cooperation/selectMeetingRoomList.do"><span class="txt_blue" id="meetUnread">['+result.meetUnread+']</span></a>';
				$(".meetUnreadAppend").append(meetUnreadHtml);
			}
			
			//쪽지
			if(result.note > 0){
				$(".noteAppend").empty();
				var noteHtml = '';
				noteHtml += '<a href="${rootPath}/community/selectRecieveNoteList.do">';
				noteHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'recieveNote\',this)" onmouseout="hideLayerCheckList()">	['+result.note+']</span></a>';
				$(".noteAppend").append(noteHtml);
			}
			
			//게시물
			if((result.notice + result.commFree + result.solBbs) > 0){
				$(".noticeAppend").empty();
				var noticeHtml = '';
				noticeHtml += '<a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">';
				noticeHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'notice\',this)" onmouseout="hideLayerCheckList()">';
				noticeHtml += '['+result.notice+', </span></a>';
				noticeHtml += '<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">';
				noticeHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'commFree\',this)" onmouseout="hideLayerCheckList()">';
				noticeHtml += ''+result.commFree+', </span></a>';
				noticeHtml += '<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">';
				noticeHtml += '<span class="txt_blue" >';
				noticeHtml += ''+result.solBbs+']</span></a>';
				
				$(".noticeAppend").append(noticeHtml);
			}
			
			//메일
			if(result.mail > 0){
				$(".mailAppend").empty();
				var mailHtml = '';
				mailHtml += '<a href="${rootPath}/community/selectRecieveMailList.do">';
				mailHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'recieveMail\',this)" onmouseout="hideLayerCheckList()">';
				mailHtml += '['+result.mail+']</span></a>';
				$(".mailAppend").append(mailHtml);
			}
			
		},
		error: function(xhr, testStatus, errorThrown) {
			return false;
		 	}
	});
	
	$.ajax({
		url: "/common/getCheckReferenceListAjax.do",
		type: "POST",
		dataType: "text",
		success: function(data) {
			var result = $.parseJSON(data).checkListReference;
			
			//전자결재
			if((result.accept + result.reference + result.todo + result.reject) > 0){
				$(".approval1").empty();
				var approvalHtml = '';
				approvalHtml += '<a href="${rootPath}/approval/approvalL.do?mode=2">';
				approvalHtml +=	'<span class="txt_blue" onmouseover="showLayerCheckList(\'accept\',this)" onmouseout="hideLayerCheckList()">';
				approvalHtml +=	'['+result.accept+', </span></a>';
				approvalHtml += '<a href="${rootPath}/approval/approvalL.do?mode=12">';
				approvalHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'reference\',this)" onmouseout="hideLayerCheckList()">';
				approvalHtml += ''+result.reference+', </span></a>';
				approvalHtml += '<a href="${rootPath}/approval/approvalL.do?mode=13">';
				approvalHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'todo\',this)" onmouseout="hideLayerCheckList()">';
				approvalHtml += ''+result.todo+', </span></a>';
				approvalHtml += '<a href="${rootPath}/approval/approvalL.do?mode=5">';
				approvalHtml += '<span class="txt_blue" onmouseover="showLayerCheckList(\'reject\',this)" onmouseout="hideLayerCheckList()">';
				approvalHtml += ''+result.reject+']</span></a>';
				$(".approval1").append(approvalHtml);
			}
			
		},
		error: function(xhr, testStatus, errorThrown) {
			return false;
		 	}
	});
});


function addMyMenuPop(){
	
	var POP_NAME = "_ADD_MYMENU_POP_";
	var target = document.myTaskFrm.target;
	document.myTaskFrm.target = POP_NAME;
	document.myTaskFrm.action = "<c:url value='/menu/writeMenuPop.do' />";

	//var popup = window.showModalDialog('${rootPath}/management/collectL.do',POP_NAME,'dialogWidth:560px;dialogHeight:570px');
	var popup = window.open("about:blank", POP_NAME, "width=900px,height=200px;");
	document.myTaskFrm.method="POST"
	document.myTaskFrm.submit();
	popup.focus();
	document.myTaskFrm.target = target;
}

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

function writeDailyPlan2(writerNo, writeDate) {
	var popup = window.open("${rootPath}/daily/DailyPlanWUPop.do?no=0&writerNo=" + writerNo + "&writeDate=" + '<%=today%>', "_DAY_REPORT_POP_","width=700px, height=650px,scrollbars=yes");
	popup.focus();
}
function writeRequest2() {
	var popup = window.open("${rootPath}/request/RequestWritePop.do", "_REQUEST_WRITE_REQUEST_POP_","width=700px, height=700px, scrollbars=yes");
	popup.focus();
}
</script>
<h2>
	체크리스트 
	<div class="replay">
		<span class="txt_blue4 pR5 cursorPointer connUser" onclick="javascript:curUserShow(this);"></span>
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
	<li class="line"><a href="/project/listMyProject.do">나의프로젝트</a>
	</li>
	<li class="line"><a href="/daily/DailyByWeekL.do">나의업무</a>
		<a href="javascript:writeDailyPlan2(${user.no}, ${calendarInfo.date});"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line"><a href="/request/RequestList.do">요구사항</a>
		<span class="requestProcess">
			<%-- <a href="${rootPath}/request/RequestList.do?mode=1">
			<span class="txt_blue" onmouseover="showLayerCheckList('request',this)" onmouseout="hideLayerCheckList()">
				[${chkList.request}, </span></a> --%>
			<%-- <a href="${rootPath}/request/RequestList.do?mode=3">
			<span class="txt_blue" onmouseover="showLayerCheckList('reqweek',this)" onmouseout="hideLayerCheckList()">
				[0,</span></a>
			<a href="${rootPath}/request/RequestList.do?mode=5">
			<span class="txt_blue" onmouseover="showLayerCheckList('reqmonth',this)" onmouseout="hideLayerCheckList()">
				0]</span></a> --%>
		</span>
		<a href="javascript:writeRequest2();"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line"><a href="${rootPath}/approval/main.do">전자결재</a>
		<span class="approval1">
			<a href="${rootPath}/approval/approvalL.do?mode=2">
			<span class="txt_blue" onmouseover="showLayerCheckList('accept',this)" onmouseout="hideLayerCheckList()">
				[0,</span></a>
			<a href="${rootPath}/approval/approvalL.do?mode=12">
			<span class="txt_blue" onmouseover="showLayerCheckList('reference',this)" onmouseout="hideLayerCheckList()">
				0,</span></a>
			<a href="${rootPath}/approval/approvalL.do?mode=13">
			<span class="txt_blue" onmouseover="showLayerCheckList('todo',this)" onmouseout="hideLayerCheckList()">
				0,</span></a>
			<a href="${rootPath}/approval/approvalL.do?mode=5">
			<span class="txt_blue" onmouseover="showLayerCheckList('reject',this)" onmouseout="hideLayerCheckList()">
				0]</span></a>
		</span>
		<a href="${rootPath}/approval/appr_NewDraft.do"> <img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
		
		<span class="approval2"></span>
	</li>
	<li class="line">
		<a href="${rootPath}/cooperation/selectBusinessContactList.do">업무연락</a>
		<span class="busiCntAppend">
			<a href="${rootPath}/cooperation/selectBusinessContactList.do"><span class="txt_blue" id="busiCntctCnt">[0]</span></a>
		</span>
		<a href="${rootPath}/cooperation/insertBusinessContactView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/cooperation/selectMeetingRoomList.do">펀네트 회의실</a>
		<span class="meetUnreadAppend">			
			<%-- <a href="${rootPath}/cooperation/selectMeetingRoomList.do"><span class="txt_blue" id="meetUnread">[0]</span></a> --%>
		</span>
		<a href="${rootPath}/cooperation/insertMeetingRoomView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectRecieveNoteList.do">쪽지</a>		
		<span class="noteAppend">
				<%-- <a href="${rootPath}/community/selectRecieveNoteList.do">
				<span class="txt_blue" onmouseover="showLayerCheckList('recieveNote',this)" onmouseout="hideLayerCheckList()">	[0]</span></a>
			<a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')"> --%>
		</span>
		<a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')">
		<img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectUnreadBoardList.do">게시물</a>
		<span class="noticeAppend">
			<a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031">
			<span class="txt_blue" onmouseover="showLayerCheckList('notice',this)" onmouseout="hideLayerCheckList()">
				[0,</span></a>
			<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001">
			<span class="txt_blue" onmouseover="showLayerCheckList('commFree',this)" onmouseout="hideLayerCheckList()">
				0,</span></a>
			<a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000085">
			<span class="txt_blue" onmouseover="showLayerCheckList('solution',this)" onmouseout="hideLayerCheckList()">
				0]</span></a>
		</span>
		<a href="${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000001"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>
	<li class="line">
		<a href="${rootPath}/community/selectRecieveMailList.do">사내메일</a>
		<span class="mailAppend">
			<%-- <a href="${rootPath}/community/selectRecieveMailList.do">
			<span class="txt_blue" onmouseover="showLayerCheckList('recieveMail',this)" onmouseout="hideLayerCheckList()">
				[0]</span></a> --%>
		</span>
		<a href="${rootPath}/community/sendMailView.do"><img src="${imagePath}/btn/btn_write01.gif" alt="글쓰기"/></a>
	</li>

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
		<a href="${rootPath}/menu/myMenuL.do">나의메뉴</a>
		<span style="position:relative; top:4px;"><a href="javascript:addMyMenuPop();"><img src="${imagePath}/btn/btn_plus.gif"/></a>
		</span>		
		<ul class="chk_menu2" >
		<!-- 5개만 출력하는 2가지 방법예제 -->
			<c:forEach items="${myMenuList}" var="menu" varStatus="s" begin="0" end="19" step="1">		
				<c:if test="${s.count < 21}"> 
					<li style="position:relative; left:-12px; padding-top:2px;">
					<c:choose>
						<c:when test="${menu.menuSj == 'space'}">
							<c:out value="---------------" />
						</c:when>
						<c:otherwise>
							- <a href="${menu.linkUrl}"><c:out value="${menu.menuSj}" /></a>  
						</c:otherwise>
					</c:choose>
					</li>
				</c:if>
			</c:forEach>
			<div id="targetMyMenu" style="display:none;">
				<c:forEach items="${myMenuList}" var="menu" varStatus="s" begin="5">		
					<li style="position:relative; left:-12px; padding-top:2px;">
						- <a href="${menu.linkUrl}"><c:out value="${menu.menuSj}" /></a>  
					</li>				
				</c:forEach>
			</div>
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

<div class="simpleMsg_layer" id="request"> 미처리 요구 </div>
<div class="simpleMsg_layer" id="reqweek"> 14일이내 잔여 </div>
<div class="simpleMsg_layer" id="reqmonth"> 30일이내 잔여 </div>

<div class="simpleMsg_layer" id="accept">승인할문서</div>
<div class="simpleMsg_layer"  id="reference">참조할문서</div>
<div class="simpleMsg_layer"  id="todo">처리할문서</div>
<div class="simpleMsg_layer"  id="reject">반려된문서</div>
<div class="simpleMsg_layer"  id="notice">공지사항</div>
<div class="simpleMsg_layer"  id="commFree">자유게시판</div>
<div class="simpleMsg_layer"  id="solution">솔루션 게시판</div>

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

