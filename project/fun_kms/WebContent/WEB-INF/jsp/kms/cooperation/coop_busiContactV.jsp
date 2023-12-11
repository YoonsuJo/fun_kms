<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<c:import url="${rootPath}/cooperation/selectBusinessContactCommentList.do">
	<c:param name="type" value="head" />
</c:import>
<script>
$(document).ready(function() {
	var linkCmmtCn = '${linkCmmtCn}';
	var linkCmmtUserNm = '${linkCmmtUserNm}';
	if (linkCmmtCn.trim() != '' || linkCmmtUserNm.trim() != '') {
		// 덧글내용이나 덧글작성자를 검색하여 조회했을 때, 모든 덧글 조회
		showComments('all');

		// 덧글 내용 포커스
		if (linkCmmtCn.trim() != '') {
			var arrLinkCmmtCn = linkCmmtCn.split(' ');  
			var txts = $('#tableReplyL').find('td.txt');
			for(var i=0; i<txts.length; i++) {
				for(var j=0; j<arrLinkCmmtCn.length; j++) {
					if ($(txts[i]).html().indexOf(arrLinkCmmtCn[j]) > -1) {
						$(txts[i]).css('background-color', '#fffddb');
					}
				}
			}
		}
		
		// 덧글 작성자 포커스
		if (linkCmmtUserNm.trim() != '') {
			var arrLinkCmmtUserNm = linkCmmtUserNm.split(' ');  
			var writers = $('#tableReplyL').find('td.writer');
			for(var i=0; i<writers.length; i++) {
				for(var j=0; j<arrLinkCmmtUserNm.length; j++) {
					if ($(writers[i]).html().indexOf(arrLinkCmmtUserNm[j]) > -1) {
						$(writers[i]).css('background-color', '#fffddb');
					}
				}
			}
		}
	}
});

function delBC() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.useAt.value = "N";
		document.frm.action = "${rootPath}/cooperation/deleteBusinessContact.do";
		document.frm.submit();
	}
}
function list() {
	document.frm.action = "${rootPath}/cooperation/selectBusinessContactList.do";
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
function layerHide(id) {
	$('#'+id).hide();
}
function changeRecieve() {
	document.frm.action = "${rootPath}/cooperation/changeBusinessContactRecieve.do";
	document.frm.submit();
}
function interest() {
	/*
	if ("${result.interestYn}" == "Y") {
		document.frm.interestYn.value = "N";
	} else {
		document.frm.interestYn.value = "Y";
	}
	document.frm.action = "${rootPath}/cooperation/updateBusinessContactInterest.do";
	document.frm.submit();
	*/
	
	var bool;
	if (document.frm.interestYn.value == 'Y') bool = 'N';
	else bool = 'Y';
	
	$.ajax({
		url: "/cooperation/updateBusinessContactInterestAjax.do",
		data: {
			bcId: document.frm.bcId.value,
			interestYn: bool
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			if (data.indexOf("success") > -1) {
				//alert("저장에 성공했습니다");
				if (bool=='Y') {
					$('#imgInterest').attr('src', '${imagePath}/btn/btn_clear02.gif');
					$('#icoInterest').attr('src', '${imagePath}/btn/btn_light_on.gif');
				} else {
					$('#imgInterest').attr('src', '${imagePath}/btn/btn_regist04.gif');
					$('#icoInterest').attr('src', '${imagePath}/btn/btn_light_off.gif');
				}
				document.frm.interestYn.value = bool;
			}
			else 
				alert("저장에 실패했습니다. 형식을 확인해주세요.");
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("저장에 실패했습니다. 형식을 확인해주세요.");
			return false;
		}
	});
}

function connect() {
	
	document.connectFrm.title.value = encodeURIComponent('${result.bcSj}');
	
	var POP_NAME = "_POP_TASK_CONTENT_";
	document.connectFrm.target = POP_NAME;
	document.connectFrm.action = "${rootPath}/cooperation/insertTaskContentView.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=754px,height=784px,scrollbars=yes,resizable=yes");
	document.connectFrm.submit();
	popup.focus();
}
function print() {
	var POP_NAME = "_POP_BC_PRINT_";
	document.frm.target = POP_NAME;
	document.frm.action = "${rootPath}/cooperation/selectBusinessContact.do";
	document.frm.viewType.value = "print";
	
	var popup = window.open("about:blank",POP_NAME,"width=700px,height=500px;");
	document.frm.submit();
	popup.focus();
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
	var isIE = ( (sUserAgent.indexOf("compatible") > -1 && sUserAgent.indexOf("MSIE")) || sUserAgent.indexOf("Trident") ) > -1 && !isOpera;
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

		function copyLayerClickEvent(event){
			if (!$(event.target).closest(layer).length && event.target !== $(obj).get(0)) {
				$('body').unbind('click.copyLayer');
				layer.remove();
			};
		}
		$('body').bind('click.copyLayer', copyLayerClickEvent );
	}
}

function alarmYn() {
	if ("${result.alarmYn}" == "Y") {
		document.frm.alarmYn.value = "N";
	} else {
		document.frm.alarmYn.value = "Y";
	}
	document.frm.action = "${rootPath}/cooperation/updateBusinessContactAlarm.do";
	document.frm.submit();
}

//업무연락
var offset = 20;
var limit = 10;
var curCommentsCnt = 0;
function showComments(type) {
	//$("#loading").fadeIn(300);
	
	if (type=="all") limit = 9999;
	
	$.ajax({
		url: "/cooperation/ajax/selectBusinessContactCommentList.do",
		data: {
			bcId : '${result.bcId}',
			offset: offset,
			limit: limit
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			//$("#loading").fadeOut(300);
			
			// tr 닫는 태그가 하나라도 있으면, 데이터가 가져온 것으로 간주.
			$('#tableReplyL').append(data);
			
			// 데이터 갯수 만큼 현재 덧글갯수 추가
			$('#tableReplyL').find('tr.busiComm').each(function() {
				curCommentsCnt += 1;
			});
			
			// 더보기 Div 숨기기.
			if (curCommentsCnt >= parseInt('${commentsCnt}')) $('.comment_div').hide();
			
			// COUNT 표시
			$('.comment_cnt').html('※ 댓글 수 : <b>' + curCommentsCnt + '</b>/${commentsCnt}');
			
			//$('#tableReplyL').find('tr.hidden').fadeIn(2000).removeClass('hidden');
			$('#tableReplyL').find('tr.busiComm').removeClass('busiComm');
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("failed");
			return false;
  	 	}
	});
	
	offset += 10;
	
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
							<li class="stitle">업무연락 읽기</li>
							<li class="navi">홈 > 업무공유 > 협업 > 업무연락</li>
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
						<input type="hidden" name="bcId" value="${result.bcId}"/>
						<input type="hidden" name="interestYn" value="${result.interestYn}"/>
						
						<input type="hidden" name="alarmYn" />
												
						<input type="hidden" name="useAt" />
						<input type="hidden" name="viewType" />
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
								<col class="col100" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
									<th class="write_info">제목</th>
									<th class="write_info2" colspan="3" >${result.bcSj}
										<c:choose>
											<c:when test="${result.interestYn == 'Y'}">
												<img src="${imagePath}/btn/btn_light_on.gif" id="icoInterest" class="cursorPointer" onclick="interest();" title="관심 업무연락"/>
											</c:when>
											<c:otherwise>
												<img src="${imagePath}/btn/btn_light_off.gif" id="icoInterest" class="cursorPointer" onclick="interest();" title="관심 업무연락"/>
											</c:otherwise>
										</c:choose>	
									</th>
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
									<th class="write_info">수신자</th>
									<th class="write_info2" colspan="3">
										<c:forEach items="${result.recieveList}" var="rec" varStatus="c">
											<c:if test="${c.count != 1}">,</c:if>
											<print:user userNo="${rec.userNo}" userNm="${rec.userNm}"/>(
												<c:choose>
													<c:when test="${empty rec.readtime}"><span class="txt_red">
													미열람 <c:if test="${rec.alarmYn == 'N'}">off</c:if>					                			
													</span></c:when>
													<c:otherwise>${rec.readtime } <span class="txt_blue">
													열람 <c:if test="${rec.alarmYn == 'N'}">off</c:if>
													</span></c:otherwise>
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
													<c:when test="${empty ref.readtime}"><span class="txt_red">
													미열람 <c:if test="${ref.alarmYn == 'N'}">off</c:if>
													</span></c:when>
													<c:otherwise>${ref.readtime } <span class="txt_blue">
													열람 <c:if test="${ref.alarmYn == 'N'}">off</c:if>
													</span></c:otherwise>
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
									<!-- 수신자, 참조자에게 업무연락이 수신되었음을  SMS로 알립니다.-->
									<!--<th class="write_info">SMS 연동</th>
									<th class="write_info2" >
										<input type="checkbox" disabled="disabled" <c:if test="${result.smsYn == 'Y'}">checked="checked"</c:if> />

										관계자에게 업무연락을  SMS로 알립니다.
									</th>-->
									<th class="write_info">댓글 허용</th>
									<th class="write_info2" colspan="3">
										<input type="checkbox" disabled="disabled" <c:if test="${result.commentYn == 'Y'}">checked="checked"</c:if> />
										댓글작성을 허용합니다.
									</th>
								</tr>		  
								<!-- //2013.08.20 김대현 PUSH 적용 -->
								<tr>
									<th class="write_info">PUSH 연동</th>
									<th class="write_info2" colspan="3">
										<input type="checkbox" disabled="disabled" <c:if test="${result.pushYn == 'Y'}">checked="checked"</c:if> />
										관계자에게 업무연락을  PUSH로 알립니다.
									</th>
								</tr>
													 
							</thead>
							
							<tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2" colspan="3">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.attachFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<td colspan="4" class="H300"><c:out value="${result.bcCn}" escapeXml="false" /></td>
								</tr>
							</tbody>
							</table>
						</div>
						
						<!-- 수신자 변경 레이어  -->
						<input type="hidden" name="userNo" value="${result.userNo}"/>
						<div id="RecieverLayer" class="Receiver_layer" style="display:none;">
							<dl>
								<dt>업무연락 수신자 변경</dt>
								<dd>
									<div class="boardWrite02 mB10">
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>공지사항 보기</caption>
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
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<ul>
								<li class="left">
									<a href="javascript:interest();">
										<c:choose>
											<c:when test="${result.interestYn == 'Y'}">
												<img id="imgInterest" src="${imagePath}/btn/btn_clear02.gif"/>
											</c:when>
											<c:otherwise>
												<img id="imgInterest" src="${imagePath}/btn/btn_regist04.gif"/>
											</c:otherwise>
										</c:choose>
									</a>
									<a href="javascript:scrapArticle('BUSI', '${result.bcId}')"><img src="${imagePath}/btn/btn_scrap.gif"/></a>
								
									<a href="javascript:connect();"><img src="${imagePath}/btn/btn_connect.gif"/></a>
								
									<!-- 2013.08.13 업무연락 알람 ON/OFF  -->
									<a href="javascript:alarmYn();">
											<c:choose>
												<c:when test="${result.alarmYn == 'Y'}">
													<img src="${imagePath}/btn/btn_alarm_on.gif"/>
												</c:when>
												<c:otherwise>
													<img src="${imagePath}/btn/btn_alarm_off.gif"/>
												</c:otherwise>
											</c:choose>
										</a>
								
								
								</li>
								<li class="right">
									<c:if test="${user.no == result.userNo || user.admin  }">
										<a href="${rootPath}/cooperation/updateBusinessContactView.do?bcId=${result.bcId}"><img src="${imagePath}/btn/btn_modify.gif"/></a>
									</c:if>
									<c:if test="${user.no == result.userNo || user.isHmdev }">
										<a href="javascript:delBC();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
									</c:if>
									<a href="javascript:recieveLayerShow();"><img id="btn_chng" src="${imagePath}/btn/btn_change7.gif"/></a>
									<a href="javascript:printLayerShow();"><img id="btn_chng3" src="${imagePath}/btn/btn_print.gif"/></a>
									<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>
								</li>
							</ul>
						</div>
						<!--// 버튼 끝 -->
												
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/selectBusinessContactCommentList.do">
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${comment.no}" />
								<c:param name="limit" value="20" />
								<c:param name="offset" value="0" />
							</c:import>
						</div>
						<!--// 게시판 끝  -->
						
						<form name="connectFrm" method="POST">
							<input type="hidden" name="taskContentTyp" value="CO"/>
							<input type="hidden" name="title" value="${result.bcSj}"/>
							<input type="hidden" name="userNm" value="${result.userNm}"/>
							<input type="hidden" name="regDt" value="${result.regDt}"/>
							<input type="hidden" name="linkUrl" value="${rootPath}/cooperation/selectBusinessContact.do?bcId=${result.bcId}"/>
							<input type="hidden" name="taskId" value=""/>
						</form>
						
						
						<!-- 미열람 업무연락 시작 -->
						<br/>
						<p class="th_stitle" style="clear:both;">미열람 업무연락</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col class="col90" />
								<col width="px" />
								<col class="col50" />
								<col class="col70" />
								<col class="col110" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">프로젝트코드</th>
								<th scope="col">제목</th>
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
										<td class="pL10">
											<a href="${rootPath}/cooperation/selectBusinessContact.do?bcId=${result.bcId}">
												<c:choose>
													<c:when test="${result.readYn == 'N'}"><span <c:if test="${result.alarmYn != 'N'}">class="txt_red"</c:if> >${result.bcSj}</span></c:when>
													<c:when test="${result.interestYn == 'Y'}"><span class="txt_blue">${result.bcSj}</span></c:when>
													<c:otherwise>${result.bcSj}</c:otherwise>
												</c:choose>
												<span class="txt_reply">[${result.commentCnt}]</span>
											</a>
										</td>
										<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
										<td class="txt_center">${result.regDtShort}</td>
										<td class="txt_center">${result.modDt}</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<!--// 미열람 업무연락 끝  -->
						
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
