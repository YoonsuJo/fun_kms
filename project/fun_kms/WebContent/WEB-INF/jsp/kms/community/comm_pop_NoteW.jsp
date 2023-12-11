<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="commNote" staticJavascript="false" xhtml="true" cdata="false"/>
<script>

$(document).ready(function() {
	window.resizeTo(600, 700);
	
	var noteCn = $('#noteCn').text();

	if ('${replyType}' == 'goodmo') {
		noteCn += '[한마음 아침인사 답장]\n\n';
		$('#noteCn').text(noteCn);
		$('#noteCn').focus();
	}

	if ('${reply}' == 'Y' || '${forward}' == 'Y') {
		noteCn += '\n\n========== 원본 메시지 ==========\n'
		noteCn += '보낸사람: ${noteVO.recieverNm}(${noteVO.recieverId})\n'
		noteCn += '받는사람: ${noteVO.senderNm}(${noteVO.senderId})\n'
		noteCn += '송신일시: ${noteVO.sendDt}\n\n'
		noteCn += decodeURIComponent('${noteVO.noteCn}');
		$('#noteCn').text(noteCn);
		$('#noteCn').focus();
	}

	if ('${sendOriMsgYn}' == 'Y') {
		$('#noteCn').text(decodeURIComponent('${noteVO.noteCn}'));
		$('#noteCn').focus();
	}
});

_editor_area = "noteCn";

var send = 0;

function sendNote() {	
	if (!validateCommNote(document.note)) {
		return;
	}
	if(send==0){
		//document.getElementById('sendButton').style.visibility = 'hidden';
		send = 1;
		document.note.action = "<c:url value='${rootPath}/community/sendNote.do'/>";
		document.note.submit();
	}					
}
var expanded = 0;
function expandWindow() {	
	//self.resizeTo(500, 565);
	if(expanded == 0){
		self.resizeBy(0,250);
		expanded = 1;
	}			
}

window.onload=function() {
	document.getElementById('recieverList').focus();
	<c:if test="${replyType == 'goodmo'}">
	var noteCn = document.getElementById('noteCn');
	noteCn.focus();
	noteCn.value = noteCn.value + " ";
	</c:if>
};


</script>
</head>
<body style="overflow-X:hidden;overflow-Y:hidden"><div id="pop_message" style="height:615px !important;">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">쪽지</li>
		</ul>
 	</div>
 	<div id="pop_con">
	 	<form:form commandName="commNote" name="note" method="post" onsubmit="return false;">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup>
 				<col class="col90" />
 				<col width="px" />
 				<col class="col170" />
			</colgroup>
 			<thead>
 				 <tr>
					<th scope="col">수신자</th>
					<th scope="col">
						<input type="text" name="recieverList" id="recieverList" class="input_left write_input09 userNamesAuto userValidateCheck" 
							<c:if test="${not empty noteVO.recieverNm}"> value="${noteVO.recieverNm}(${noteVO.recieverId})"</c:if>
						/> <img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="expandWindow();usrGen('recieverList',0);">
					</th>
					<th class="pR10">
						<label><span class="T11">현재 접속자에게만 전송</span>
						<input type="checkbox" name="currentUserOnly" class="cursorPointer check" value="Y"
						<c:if test="${currentUserOnly == 'Y'}"> checked="true"</c:if>/></label>
					</th>
				</tr> 
 			</thead>
 			<tbody>
 				<tr>
 <!-- 					전달인 경우원본 메세지 포함. textarea에 보이는 그대로 출력되므로 이렇게 붙임-->
 					<td colspan="3" class="txt_center"> 
						<textarea name="noteCn" id="noteCn" style="height:450px !important;"></textarea>
 					</td> 					
 				</tr>
 			</tbody>
 		</table>
 		 		
 		<p></p>
 		
 	    <div class="pop_btn_area">
 	    	<label><span class="T11">모바일 전송 안함</span>
				<input type="checkbox" name="mobilePush" class="cursorPointer check" value="N"
				<c:if test="${mobilePush == 'N'}"> checked="true"</c:if>/></label> 	
            <a href="javascript:sendNote();"><img id="sendButton" src="${imagePath}/btn/btn_send_pop.gif"/></a>
            <a href="javascript:window.close();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
        </div>
        </form:form>
 	</div>
</div>

</body>
</html>
