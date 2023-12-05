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
	window.resizeTo(600, 700);
});
function resendNote() {
	document.note.action = "<c:out value='${rootPath}/community/sendNoteView.do'/>";
	document.note.submit();
}

function deleteNote() {
	document.note.action = "<c:out value='${rootPath}/community/deleteSendNote.do'/>";
	document.note.submit();
}
</script>
</head>

<body style="overflow-X:hidden;overflow-Y:hidden"><div id="pop_message" style="height:565px !important;">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">보낸쪽지</li>
		</ul>
 	</div>
 	
 	<div id="pop_con02">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col90" /><col /></colgroup>
 			<thead>
 				 <tr>
					<th class="title" scope="col">받는사람</th>
					<th class="title2" scope="col"><print:user userNo="${result.recieverNo}" userNm="${result.recieverNm}" userId="${result.recieverId}" printId="true"/></th>
				</tr>
				<tr>
					<th class="title" scope="col">보낸시간</th>
					<th class="title2" scope="col"><c:out value="${result.sendDt}" /></th>
				</tr> 
 			</thead>
 			<tbody>
 				<tr>
 					<td colspan="2" >
 						<div class="popNote_scroll" style="height:400px !important;">
 							<print:textarea text="${result.noteCn}"/>
 						</div>
 					</td>
 				</tr>
 			</tbody>
 		</table>
 		
 		<p></p>
      
		<div class="pop_btn_area">
			<a href="javascript:window.close();"><img src="${imagePath}/btn/btn_ok.gif"/></a>
			<a href="javascript:resendNote();"><img src="${imagePath}/btn/btn_redispatch.gif"/></a>
            <a href="javascript:deleteNote();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
        </div>
 		
 		<form method="POST" name="note">
 			<input type="hidden" name="noteId" value="<c:out value='${result.noteId}'/>" />
 			<input type="hidden" name="noteCn" value="<c:out value='${result.noteCn}'/>" />
 			<input type="hidden" name="recieverId" value="<c:out value='${result.recieverId}'/>" />
 			<input type="hidden" name="recieverNm" value="<c:out value='${result.recieverNm}'/>" />
 			<input type="hidden" name="recieverNo" value="<c:out value='${result.recieverNo}'/>" />
 			<input type="hidden" name="sendOriMsgYn" value="Y" />
 		</form>
 		
 	</div>
</div>

</body>
</html>
