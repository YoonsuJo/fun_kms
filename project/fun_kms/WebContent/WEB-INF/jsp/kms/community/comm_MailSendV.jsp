<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function() {
	$('[name=mailCn]').val($('#mailCn').html());
});
function mailReply() {
	document.frm.recieverList.value = "${result.senderNm}(${result.senderId})";
	document.frm.action = "<c:url value='${rootPath}/community/replyMail.do'/>";
	document.frm.submit();
}

function mailAllReply() {
	document.frm.recieverList.value = "${result.senderNm}(${result.senderId}),${result.recieverList}";
	document.frm.action = "<c:url value='${rootPath}/community/replyMail.do'/>";
	document.frm.submit();
}

function mailDelivery() {
	document.frm.atchFileId.value = "${result.atchFileId}";
	document.frm.action = "<c:url value='${rootPath}/community/forwardMail.do'/>";
	document.frm.submit();
}

function mailResend() {
	document.frm.action = "<c:url value='${rootPath}/community/resendMail.do'/>";
	document.frm.submit();
}

function mailDelete() {
	if (confirm('<spring:message code="common.delete.msg" />')) {
		document.frm.action = "<c:url value='${rootPath}/community/deleteSendMailList.do'/>";
		document.frm.submit();
	}
}

function mailPrint() {
	var POP_NAME = "_POP_MAIL_PRINT_";
	document.frm.target = POP_NAME;
	document.frm.action = "${rootPath}/community/printMail.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=700px,height=500px;");
	document.frm.submit();
	popup.focus();
}

function mailList() {
	document.frm.action = "<c:url value='${rootPath}/community/selectSendMailList.do'/>";
	document.frm.submit();
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
				<div id="center" style="padding-bottom:80px">
					<div class="path_navi">
						<ul>
							<li class="stitle">보낸편지</li>
							<li class="navi">홈 > 커뮤니티 > 사내메일 > 보낸편지</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작  -->
						<form name="frm" method="post">
						<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
						<input type="hidden" name="mailId" value="<c:out value='${result.mailId}' />">
						<input type="hidden" name="mailCn" >
						<input type="hidden" name="recieverList" >
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
			                    <col class="col100"  />
			                    <col width="px" />
		                    </colgroup>
		                     <thead>
		                     	<tr>
			                    	<th class="write_info">제목</th>
			                    	<th class="write_info2"><c:out value="${result.mailSj}"/></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">보낸사람</th>
			                    	<th class="write_info2"><print:user userNo="${result.senderNo}" userNm="${result.senderNm}" userId="${result.senderId}" printId="true"/></th>
			                    </tr>
		                        <tr>
			                    	<th class="write_info">받는사람</th>
			                    	<th class="write_info2">
			                    		<c:forEach items="${resultList}" var="r" varStatus="c">
			                    			<c:if test="${c.count != 1}"> / </c:if>
			                    			<print:user userNo="${r.recieverNo}" userNm="${r.recieverNm}" />
			                    			<c:choose>
			                    				<c:when test="${empty r.readDt || r.readDt == ''}">(미열람)</c:when>
			                    				<c:otherwise>(<c:out value="${r.readDt}" /> <c:out value="열람" />)</c:otherwise>
			                    			</c:choose>
			                    		</c:forEach>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">송신일시</th>
			                    	<th class="write_info2"><c:out value="${result.sendDt}"/></th>
		                        </tr>
		                        <!--	                        
		                        <tr>			                    	
			                    	<th class="write_info">SMS 전송</th>
			                    	<th class="write_info2">
			                    		<input type="checkbox" name="smsSend" id="smsSend" <c:if test="${result.smsSend == 'Y'}">checked="checked"</c:if> disabled="disabled"/>
			                    		문자메시지로 메일 도착을 알려줍니다.
			                    		<c:if test="${result.smsSend == 'F'}"><span class="txt_red">문자전송 실패</span></c:if>
			                    	</th>
		                        </tr>
		                        -->
		                        <tr>			                    	
			                    	<th class="write_info">PUSH 전송</th>
			                    	<th class="write_info2">
			                    		<input type="checkbox" name="pushSend" id="pushSend" <c:if test="${result.pushSend == 'Y'}">checked="checked"</c:if> disabled="disabled"/>
			                    		PUSH로 메일 도착을 알려줍니다.
			                    	</th>
		                        </tr>
		                        		                        
		                    </thead>
		                    
							<tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
		                    <tbody>
		                    	<tr>
			                    	<td colspan="2" id="mailCn"><c:out value="${result.mailCn}" escapeXml="false"/></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:mailReply();"><img src="${imagePath}/btn/btn_reply.gif"/></a>
		                	<a href="javascript:mailAllReply();"><img src="${imagePath}/btn/btn_allreply.gif"/></a>
		                	<a href="javascript:mailDelivery();"><img src="${imagePath}/btn/btn_delivery.gif"/></a>
		                	<a href="javascript:mailResend();"><img src="${imagePath}/btn/btn_redispatch.gif"/></a>
		                	<a href="javascript:mailDelete();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                	<a href="javascript:mailPrint();"><img src="${imagePath}/btn/btn_print.gif"/></a>
		                	<a href="javascript:mailList();"><img src="${imagePath}/btn/btn_list.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->
	
	
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
