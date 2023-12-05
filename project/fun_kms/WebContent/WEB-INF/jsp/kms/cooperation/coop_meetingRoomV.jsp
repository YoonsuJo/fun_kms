<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<c:import url="${rootPath}/cooperation/selectMeetingRoomCommentList.do">
	<c:param name="type" value="head" />
</c:import>
<script>
function delMT() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.useAt.value = "N";
		document.frm.action = "${rootPath}/cooperation/deleteMeetingRoom.do";
		document.frm.submit();
	}
}
function list() {
	document.frm.action = "${rootPath}/cooperation/selectMeetingRoomList.do";
	document.frm.submit();
}
function recieveLayerShow() {
	var position = $("#btn_chng").position();
	var height = $("#btn_chng").height();
	
	$('#RecieverLayer').show();
	document.getElementById("RecieverLayer").style.top = position.top - 140 + "px";
	document.getElementById("RecieverLayer").style.left = position.left - 100 + "px";
	document.getElementById("RecieverLayer").style.zIndex = "1";
}
function changeRecieve() {
	document.frm.action = "${rootPath}/cooperation/changeMeetingRoomRecieve.do";
	document.frm.submit();
}
function interest() {
	if ("${result.interestYn}" == "Y") {
		document.frm.interestYn.value = "N";
	} else {
		document.frm.interestYn.value = "Y";
	}
	document.frm.action = "${rootPath}/cooperation/updateMeetingRoomInterest.do";
	document.frm.submit();
}
function connect() {
	var POP_NAME = "_POP_TASK_CONTENT_";
	document.connectFrm.target = POP_NAME;
	document.connectFrm.action = "${rootPath}/cooperation/insertTaskContentView.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=754px,height=784px,scrollbars=yes,resizable=yes");
	document.connectFrm.submit();
	popup.focus();
}
function print() {
	var POP_NAME = "_POP_MT_PRINT_";
	document.frm.target = POP_NAME;
	document.frm.action = "${rootPath}/cooperation/selectMeetingRoom.do";
	document.frm.viewType.value = "print";
	
	var popup = window.open("about:blank",POP_NAME,"width=700px,height=500px;");
	document.frm.submit();
	popup.focus();
}
function copyList(typ, obj) {
	var rec = "<c:forEach items='${result.recieveList}' var='rec' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${rec.userNm}(${rec.userId})</c:forEach>";
	var ref = "<c:forEach items='${result.referenceList}' var='ref' varStatus='c'><c:if test='${c.count != 1}'>,</c:if> ${ref.userNm}(${ref.userId})</c:forEach>";
	var data = '';
	
	if(typ == 'rec')
		data = rec;
	else if(typ == 'ref')
		data = ref;

	var sUserAgent = navigator.userAgent;
	var isOpera = sUserAgent.indexOf("Opera") > -1;
	var isIE = sUserAgent.indexOf("compatible") > -1 && sUserAgent.indexOf("MSIE") > -1 && !isOpera;
	if(isIE) {
		window.clipboardData.setData('Text',data);
		var tmp = '수신자';
		if(typ == 'ref') tmp = '참조자';
		window.alert(tmp + "가 복사되었습니다.");
	} else {
		if($('.copy_recieveList').length>0) {
			$('body').unbind('click.copyLayer');
			$('.copy_recieveList').remove();
		}
		
		var layer = $('<div class="copy_recieveList">' + data + '<br/><p align="right">※ 드래그하여 복사해주세요.</p></div>');
		
		layer.css("left",($(obj).offset().left+20)+"px");
		layer.css("top",($(obj).offset().top+15)+"px");

		layer.css("width", 300);
		
		layer.appendTo('body');

		function copyLayerClickEvent(event) {
			if (!$(event.target).closest(layer).length && event.target !== $(obj).get(0)) {
				$('body').unbind('click.copyLayer');
				layer.remove();
			};
		}
		$('body').bind('click.copyLayer', copyLayerClickEvent );
	}
}
function resultReg(flag){

	var POP_NAME = "_POP_MEET_RESULT_";
	document.frm.inputType.value = flag;
	document.frm.target = POP_NAME;
	document.frm.action = "${rootPath}/cooperation/updateMeetingResultView.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=700px,height=600px,scrollbars=no");
	document.frm.submit();
	popup.focus();	
}

//작성자 변경기능
function writerLayerShow(){
	var position = $("#btn_chng2").position();
	var height = $("#btn_chng2").height();
	
	$('#writerLayer').show();
	document.getElementById("writerLayer").style.top = position.top - 110 + "px";
	document.getElementById("writerLayer").style.left = position.left - 100 + "px";
	document.getElementById("writerLayer").style.zIndex = "1";
}
function layerHide(id) {
	$('#'+id).hide();
}
function updateWriterNo(){
	//document.frm.action = "${rootPath}/cooperation/changeMeetingRoomRecieve.do";
	document.frm.action="${rootPath}/cooperation/changeMeetingRoomWriter.do";
	document.frm.submit();
}
// 인쇄 옵션 레이어 Show
function printLayerShow(){
	var position = $("#btn_chng3").position();
	var height = $("#btn_chng3").height();
	
	$('#printLayer').show();
	document.getElementById("printLayer").style.top = position.top - 110 + "px";
	document.getElementById("printLayer").style.left = position.left - 100 + "px";
	document.getElementById("printLayer").style.zIndex = "1";
}

function viewProject(prjId){
	var popup = window.open("/project/viewProjectPop.do?prjId="+prjId,
			"_POP_PROJECT_VIEW",
			"width=970px,height=800px,scrollbars=yes,resizable=yes");
	popup.focus();
}

</script>
</head>

<body>

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
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">회의실 읽기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 한마음 회의실</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 게시판 시작  -->
						<form name="frm" method="POST">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
						<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="mtId" value="${result.mtId}"/>
						<input type="hidden" name="interestYn" />
						<input type="hidden" name="useAt" />
						<input type="hidden" name="viewType" />
						<input type="hidden" name="inputType" />
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>회의실 보기</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info">회의명</th>
									<th class="write_info2" colspan="3" >${result.mtSj}</th>
								</tr>
								<tr>
									<th class="write_info">작성자</th>
									<th class="write_info2" colspan="3"><print:user userNo="${result.userNo}" userNm="${result.userNm}" userId="${result.userId}" printId="true"/></th>
								</tr>
								<tr>
									<th class="write_info">작성일시</th>
									<th class="write_info2">${result.regDt}</th>
									<th class="write_info">변경일시</th>
									<th class="write_info2">${result.modDt}</th>
								</tr>
								<tr>
									<th class="write_info">참석자</th>
									<th class="write_info2" colspan="3">
										<c:forEach items="${result.recieveList}" var="rec" varStatus="c">
											<c:if test="${c.count != 1}">,</c:if>
											<print:user userNo="${rec.userNo}" userNm="${rec.userNm}"/>(
												<c:choose>
													<c:when test="${empty rec.readtime}"><span class="txt_red">미열람</span></c:when>
													<c:otherwise>${rec.readtime } <span class="txt_blue">열람</span></c:otherwise>
												</c:choose>
											)
										</c:forEach>
										<c:if test="${!empty result.recieveList}">
											<img class="cursorPointer" onclick="javascript:copyList('rec',this);" src="${imagePath}/btn/btn_receiveCopy.gif" />
										</c:if>
									</th>
								</tr>
								<tr>
									<th class="write_info">참조자</th>
									<th class="write_info2" colspan="3">
										<c:forEach items="${result.referenceList}" var="ref" varStatus="c">
											<c:if test="${c.count != 1}">,</c:if>
											<print:user userNo="${ref.userNo}" userNm="${ref.userNm}"/>(
												<c:choose>
													<c:when test="${empty ref.readtime}"><span class="txt_red">미열람</span></c:when>
													<c:otherwise>${ref.readtime } <span class="txt_blue">열람</span></c:otherwise>
												</c:choose>
											)
										</c:forEach>
										<c:if test="${!empty result.referenceList}">
											<img class="cursorPointer" onclick="javascript:copyList('ref',this);" src="${imagePath}/btn/btn_referCopy.gif" />
										</c:if>
									</th>
								</tr>
								<tr>
									<th class="write_info">프로젝트</th>
									<th class="write_info2" colspan="3"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}" length="35"/></th>
								</tr>
								<tr>
									<th class="write_info">회의일시</th>
									<th class="write_info2" colspan="3">${fn:substring(result.mtDate,0,4)}-${fn:substring(result.mtDate,4,6)}-${fn:substring(result.mtDate,6,8)}&nbsp;${result.mtFrTm}시~${result.mtToTm}시</th>
								</tr>
								<tr>
									<th class="write_info">회의장소</th>
									<th class="write_info2">${result.mtPlace}</th>
									<th class="write_info">회의장소 구분</th>
									<th class="write_info2">
										<c:forEach items="${mtPlaceTypList}" var="typ">
											<c:if test="${result.mtPlaceTyp==typ.code}">${typ.codeNm}</c:if>
										</c:forEach>
									</th>
								</tr>
								<tr>
									<th class="write_info">회의알림</th>
									<th class="write_info2" colspan="3">
										<input type="checkbox" disabled="disabled" <c:if test="${result.pushYn1 == 'Y'}">checked="checked"</c:if> />
										회의참석자, 참조자에게 회의실이 개설 되었음을  Push메세지 및 쪽지로 알립니다.
									</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td class="write_info">회의자료</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.attachFileId}" />
										</c:import>
									</td>
								</tr>
								<c:if test="${!empty result.mtResult}">
									<tr>
										<td colspan="4" style="background:#fff;"></td>
									</tr>
									<tr>
										<td colspan="4" class="write_info">회의 결과</td>
									</tr>
									<tr>
										<td class="write_info">결과 작성자</td>
										<td class="write_info2"><print:user userNo="${result.mtResultWrNo}" userNm="${result.mtResultWrNm}" userId="${result.mtResultWrId}" printId="true"/></td>
										<td class="write_info">결과 작성일시</td>
										<td class="write_info2">${result.mtResultDt}</td>
									</tr>
									<tr>
										<td class="write_info">내용</td>
										<td colspan="3" class="write_info2"><c:out value="${result.mtResult}" escapeXml="false" /></td>
									</tr>
								</c:if>
							</tfoot>
							<tbody>
								<tr>
									<td colspan="4" class="H300"><c:out value="${result.mtCn}" escapeXml="false" /></td>
								</tr>
							</tbody>
							</table>
						</div>
						
						<!-- 수신자 변경 레이어  -->
						<input type="hidden" name="userNo" value="${result.userNo}"/>
						<div id="RecieverLayer" class="Receiver_layer" style="display:none;">
							<dl>
								<dt>회의실 수신자 변경</dt>
								<dd>
									<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>회의실 보기</caption>
									<colgroup><col class="col120" /><col width="px" /></colgroup>
									<tbody>
										<tr>
											<td class="title">수신자</td>
											<td class="pL10">
												<input type="text" class="span_13 userNamesAuto userValidateCheck" name="recUserMixes" id="recUserMixes"
													value="<c:forEach items='${result.recieveList}' var='rec'>${rec.userNm}(${rec.userId}), </c:forEach>" />
												<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('recUserMixes',0)"/>
											</td>
										</tr>
										<tr>
											<td class="title">참조자</td>
											<td class="pL10">
												<input type="text" class="span_13 userNamesAuto userValidateCheck" name="refUserMixes" id="refUserMixes"
													value="<c:forEach items='${result.referenceList}' var='ref'>${ref.userNm}(${ref.userId}), </c:forEach>" />
												<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('refUserMixes',0)" />
											</td>
										</tr>
									</tbody>
									</table>
									</div>
									<div class="btn_area">
										<a href="javascript:changeRecieve();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
										<a href="javascript:layerHide('RecieverLayer');"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
									</div>
								</dd>
							</dl>
						</div>
						<!--// 수신자 변경 레이어 끝  -->
						
						<!-- 작성자 변경 레이어  -->			        	
						<div id="writerLayer" class="Receiver_layer" style="display:none;">
							<dl>
								<dt>회의실 작성자 변경</dt>
								<dd>
									<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>공지사항 보기</caption>
									<colgroup>
										<col class="col120" />
										<col width="px" />
									</colgroup>
									<tbody>
										<tr>
											<td class="title">작성자</td>
											<td class="pL10">
												<input type="text" class="span_27 userNameAuto userValidateCheck" name="wrtUser" id="wrtUser" />
												<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('deciderMix',1);"/> (1명)
											</td>
										</tr>
									</tbody>
									</table>
									</div>
									<div class="btn_area">
										<a href="javascript:updateWriterNo();"><img src="${imagePath}/btn/btn_apply.gif"/></a>
										<a href="javascript:layerHide('writerLayer');"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
									</div>
								</dd>
							</dl>
						</div>
						<!--// 작성자 변경 레이어 끝  -->
						
						<!-- 인쇄 옵션 레이어  -->
						<div id="printLayer" class="Receiver_layer" style="display:none;">
							<dl>
								<dt>인쇄 옵션 변경</dt>
								<dd>
									<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="인쇄 옵션을 설정합니다.">
									<caption>인쇄 옵션 변경</caption>
									<colgroup>
										<col class="col120" />
										<col width="px" />
									</colgroup>
									<tbody>
										<tr>
											<td class="title">인쇄 옵션</td>
											<td class="pL10">
												<c:if test="${!empty result.mtResult}">
													<label class="pR10">
													<input type="checkbox" name="printIncResult" checked="true"/>
													회의 결과 포함
													</label>
												</c:if>
												<label>
												<input type="checkbox" name="printIncComment"/>
												덧글 포함
												</label>
											</td>
										</tr>
									</tbody>
									</table>
									</div>
									<div class="btn_area">
										<a href="javascript:print();"><img src="${imagePath}/btn/btn_print.gif"/></a>
										<a href="javascript:layerHide('printLayer');"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
									</div>
								</dd>
							</dl>
						</div>
						<!--// 인쇄 옵션 레이어 끝  -->

						</form>
						
						<!-- 20130827 수정 -->
						<!-- 버튼 시작 -->
						<div class="btn_area02" style="padding-bottom:10px;">
							<ul>
							<!--  
								<li class="left">
									<a href="javascript:interest();">
										<c:choose>
											<c:when test="${result.interestYn == 'Y'}">
												<img src="${imagePath}/btn/btn_clear02.gif"/>
											</c:when>
											<c:otherwise>
												<img src="${imagePath}/btn/btn_regist04.gif"/>
											</c:otherwise>
										</c:choose>
									</a>
									<a href="javascript:scrapArticle('MEET', '${result.mtId}')"><img src="${imagePath}/btn/btn_scrap.gif"/></a>
									<a href="javascript:connect();"><img src="${imagePath}/btn/btn_connect.gif"/></a>
								</li>
							-->
								<li class="right">
									<c:if test="${user.no == result.userNo || user.isHmdev=='Y'}">
										<!-- 기안자변경 -->
										<a href ="javascript:writerLayerShow();">
											<img id="btn_chng2" src="${imagePath}/btn/btn_change5.gif"/>
										</a>
									</c:if>
									<c:choose>
										<c:when test="${empty result.mtResult}">
											<a href="javascript:resultReg('Reg');"><img src="${imagePath}/btn/btn_meetResultReg.gif"/></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:resultReg('Mod');"><img src="${imagePath}/btn/btn_meetResultMod.gif"/></a>
										</c:otherwise>
									</c:choose>
									<c:if test="${user.no == result.userNo || user.isHmdev=='Y'}">
										<a href="${rootPath}/cooperation/updateMeetingRoomView.do?mtId=${result.mtId}"><img src="${imagePath}/btn/btn_modify.gif"/></a>
										<a href="javascript:delMT();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
									</c:if>
									<a href="javascript:recieveLayerShow();"><img id="btn_chng" src="${imagePath}/btn/btn_change.gif"/></a>
									<a href="javascript:printLayerShow();"><img id="btn_chng3" src="${imagePath}/btn/btn_print.gif"/></a>
									<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>
								</li>
							</ul>
						</div>
						<!--// 버튼 끝 -->
						
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/selectMeetingRoomCommentList.do">
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${comment.no}" />
								<c:param name="printIncComment" value="${printIncComment}" />
							</c:import>
						</div>
						<!--// 게시판 끝  -->
						
						<form name="connectFrm" method="POST">
							<input type="hidden" name="taskContentTyp" value="ME"/>
							<input type="hidden" name="title" value="${result.mtSj}"/>
							<input type="hidden" name="userNm" value="${result.userNm}"/>
							<input type="hidden" name="regDt" value="${result.regDt}"/>
							<input type="hidden" name="linkUrl" value="${rootPath}/cooperation/selectMeetingRoom.do?mtId=${result.mtId}"/>
							<input type="hidden" name="taskId" value=""/>
						</form>
						
						
						
						<!-- 미열람 회의실 시작 -->
						<br/>
						<p class="th_stitle" style="clear:both;">미열람 회의실</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,회의명,작성자,등록일,첨부,조회를 볼수 있고 회의명 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col class="col90" />
								<col class="col40" />
								<col width="px" />
								<col class="col50" />
								<col class="col70" />
								<col class="col110" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">프로젝트코드</th>
								<th scope="col">장소</th>
								<th scope="col">회의명</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">변경일시</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center"><c:out value="${c.index + 1}"/></td>
										<td class="txt_center"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}"/></td>
										<td class="txt_center">
											<c:forEach items="${mtPlaceTypList}" var="typ">
												<c:if test="${result.mtPlaceTyp==typ.code}">
													<span title="${result.mtPlace}">${typ.codeNm}</span>
												</c:if>
											</c:forEach>
										</td>
										<td class="pL10">
											<a href="${rootPath}/cooperation/selectMeetingRoom.do?mtId=${result.mtId}">
												<c:choose>
													<c:when test="${result.readYn == 'N'}"><span class="txt_red">${result.mtSj}</span></c:when>
													<c:otherwise>${result.mtSj}</c:otherwise>
												</c:choose>
												<span class="txt_reply">[${result.commentCnt}]</span>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${fn:substring(result.regDt,0,10)}</td>
										<td class="txt_center">${result.modDt}</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 미열람 회의실 끝 -->
						
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
