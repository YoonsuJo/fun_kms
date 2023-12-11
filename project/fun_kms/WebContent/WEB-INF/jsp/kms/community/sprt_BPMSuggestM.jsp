<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(function(){
	$('#btn_modify').click(function(){
		if($('#content').val() == ""){
			alert("내용은 필수값입니다.");
			$('#content').focus();
			return false;
		}
		$('#frm').attr('action', '${rootPath}/support/bpManualSMP.do');
		$('#frm').submit();
	});
	$('#btn_close').click(function(){
		self.close();	
	});
});

</script>
</head>

<body>
<div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">
				<c:if test="${bpmVO.suggestStatus == 'Y'}">업무절차 건의 수정</c:if>
				<c:if test="${bpmVO.suggestStatus == 'N'}">업무절차 답변 수정</c:if>
			</li>
		</ul>
 	</div>
 	<form id="frm" name="frm" method="post">
 	<input type="hidden" name="suggestNo" value="${bpmVO.suggestNo}"/>
 	
 	<div class="pop_con08">
       	<p class="th_stitle">
       		<c:if test="${bpmVO.suggestStatus == 'Y'}">건의 수정</c:if>
       		<c:if test="${bpmVO.suggestStatus == 'N'}">답변 수정</c:if>
       	</p>
		<div class="boardWrite">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>업무연락 작성하기</caption>
            <colgroup>
	            <col class="col100" />
				<col width="px" />
			</colgroup>
			<thead>
				<tr>
    				<th class="write_info">내용</th>
    				<th class="write_info2">
    					<textarea rows="9" cols="100" name="content" id="content">${element.content}</textarea>
    				</th>
   				</tr>	                        
			</thead>
            <tbody>
			</tbody>
			</table>
		</div>
	</div>
	</form>
	<div class="pop_btn_area04">
		<img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" id="btn_modify"/>
		<img src="${imagePath}/btn/btn_close.gif" class="cursorPointer" id="btn_close"/>
	</div>
</div>
</body>
</html>