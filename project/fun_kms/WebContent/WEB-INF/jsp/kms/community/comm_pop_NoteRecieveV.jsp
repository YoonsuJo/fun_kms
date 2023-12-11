<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/notepop_inc.jsp"%>
<script>
$(document).ready(function() {
	window.resizeTo(600, 700);
});
function replyNote() {
	document.note.action = "<c:out value='${rootPath}/community/replyNote.do'/>";
	document.note.submit();
}

function forwardNote() {
	document.note.action = "<c:out value='${rootPath}/community/forwardNote.do'/>";
	document.note.submit();
}

function deleteNote() {
	document.note.action = "<c:out value='${rootPath}/community/deleteRecieveNote.do'/>";
	document.note.submit();
}

function readNote(noteId, readDt){	
	if (readDt == null || readDt == '') {
		$.post(rootPath + "/community/setNoteReadDt.do?noteId=" + noteId, function(data) {
			;
		});
	}
	window.close();
}
//http 자동 링크 생성 작업 하다가 말았음
function replaceTextWithHTMLLinks(text) {
	  var exp = /(apple)/ig;
	    return text.replace(exp,"<a class='link' href='http://www.$1.com' target='_blank' >$1</a>"); 
}
function autolink(s) {   
   var hlink = /(\s|^)(ht|f)tp:\/\/([^ \,\;\:\!\)\(\"\'\<\>\f\n\r\t\v])+/g;
   return (s.replace (hlink, function ($0,$1,$2) { s = $0.substring(1,$0.length); 
                                                   // remove trailing dots, if any
                                                   while (s.length>0 && s.charAt(s.length-1)=='.') 
                                                      s=s.substring(0,s.length-1);
                                                   // add hlink
                                                   return " " + s.link(s); 
                                                 }
                     ) 
           );
}
function jAutoHyperlinkURLs(sInput) {
	//php 코드
	sTarget = "_blank", $sClassName = "";
	return sInput.replace("/\\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|]/i", "<a href=\"\\0\" target=\"$sTarget\" class=\"$sClassName\">\\0</a>");
}

function doautolink() {
   var bodycontent = document.forms["message"].elements["body"].value;
   bodycontent = autolink(bodycontent);
   document.forms["message"].elements["body"].value = bodycontent;
   //document.forms["message"].elements["body"].value = "<print:textarea text=" + bodycontent + "/>";
}
</script>
</head>

<body onunload="opener.processUnloadNoteV(self, '${result.noteId}', '${result.readDt}');" style="overflow-X:hidden;overflow-Y:hidden"><div id="pop_message" style="height:565px !important;">
<!--<body style="overflow-X:hidden;overflow-Y:hidden"><div id="pop_message"> onunload가 모바일에서 연결이 안되는 증상이 있어서 function readNote 만들면서 테스트 -->
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">받은쪽지</li>
		</ul>
 	</div>
 	
 	
<!--<form name="message" method="post" -->
<!--      action="NewArticle.php?qs_submit=1" -->
<!--      enctype="multipart/form-data">-->
<!--  <textarea name="body" rows="8" cols="60"></textarea>-->
<!--  <input type="button" value="Autolink" onclick="doautolink()">-->
<!--</form>-->

 	<div id="pop_con02">
 		<table cellpadding="0" cellspacing="0">
 			<colgroup><col class="col90" /><col /></colgroup>
 			<thead>
 				 <tr>
					<th class="title" scope="col">보낸사람</th>
					<th class="title2" scope="col"><print:user userNo="${result.senderNo}" userNm="${result.senderNm}" userId="${result.senderId}" printId="true"/></th>
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
            <a href="javascript:readNote('${result.noteId}', '${result.readDt}');"><img src="${imagePath}/btn/btn_read.gif"/></a>
            <a href="javascript:forwardNote();"><img src="${imagePath}/btn/btn_delivery.gif"/></a>
            <a href="javascript:replyNote();"><img src="${imagePath}/btn/btn_answer02.gif"/></a>
            <a href="javascript:deleteNote();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
        </div>
 		
 		<form method="POST" name="note">
 			<input type="hidden" name="noteId" value="<c:out value='${result.noteId}'/>" />
 			<input type="hidden" name="noteCn" value="<c:out value='${result.noteCn}'/>" />
 			<input type="hidden" name="sendDt" value="<c:out value='${result.sendDt}'/>" />			
 			<input type="hidden" name="senderId" value="<c:out value='${result.senderId}'/>" />
 			<input type="hidden" name="senderNm" value="<c:out value='${result.senderNm}'/>" />
 			<input type="hidden" name="senderNo" value="<c:out value='${result.senderNo}'/>" /> 			
 			<input type="hidden" name="readChk" value="Y" />
 		</form>
 	</div>
</div>

</body>
</html>
