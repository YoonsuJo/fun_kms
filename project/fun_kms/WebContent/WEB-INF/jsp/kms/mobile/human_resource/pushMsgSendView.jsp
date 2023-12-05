<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function writeComment() {
	if(document.pushFrm.msg.value == ""){
		alert('내용을 입력하세요.');
		return;
	}

	document.pushFrm.action = "${rootPath}/mobile/pushMsgSend.do";
	document.pushFrm.submit();
}
</script>

<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>Push메세지</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:history.back();" alt="">뒤로</a></font></div>
</ul>
<!-- S:콘텐츠 들어가는곳 -->

<hr class="hr_e1e1e1" />
<div class="reply_commd" style="margin-bottom:8px;">
<form name="pushFrm" method="POST">
<input type="hidden" name="password" value="${user.password}"/>
<input type="hidden" name="macAddr" value="${result.macAddr}"/>
<input type="hidden" name="deviceType" value="${result.deviceType}"/>
<input type="hidden" name="tokenInfo" value="${result.tokenInfo}"/>
<input type="hidden" name="id" value="${result.userId}"/>
<input type="hidden" name="userNo" value="${result.userNo}"/>
<textarea name="msg" placeholder="내용을 입력해 주세요." rows="6" cols="85" ></textarea>
</form>
</div>

<p>
<a href="javascript:history.back();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
<a href="javascript:writeComment();"><button class="bgBtn shadowBtn btnreply" style="float:right; margin-right:10px; width:50px">전송</button></a>
<br/>
</p>
<!-- E:콘텐츠 들어가는곳 -->
<jsp:include page="../include/footer.jsp"></jsp:include>