<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	document.frm.submit();
}

function view(userId) {
	document.frm.userId.value = userId;
	document.frm.action = "<c:url value='${rootPath}/mobile/member/selectMember.do'/>";
	document.frm.submit();
}

function pushMsgSendView(sabun){
	document.frm.userId.value = sabun;
	document.frm.action = "<c:url value='${rootPath}/mobile/pushMsgSendView.do'/>";
	document.frm.submit();
}
</script>
<div id="showhidden"></div>
<!-- S:Section Area -->
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>사원조회</li>
	<!-- <div class="bgTopBtn shadowBtn bgTopBtnBor" id="searchbtn" style="width:34px;ime-mode:active"><font class="fontShadow"><a href="bbs.html" alt="">검색</a></font></div> -->
</ul>

<div id="searchBoard">
<form name="frm" method="POST" action="${rootPath}/mobile/member/selectMemberList.do" onsubmit="search(); return false;">
<input type="hidden" name="no" value="0"/>
<input type="hidden" name="userId" value=""/>
<input type="hidden" name="user_no" value="0"/>
<input type="hidden" name="sabun" value="0"/>
<input type="hidden" name="workSt" value="W,L,R"/>
<table cellspacing="0" border="1" summary="" class="scheTable">
<caption></caption>
<colgroup>
<col width="*">
<col width="63px">
</colgroup>
<tbody>
<tr>
	<th scope="col"><input type="text" name="searchNm" id="searchKeyword"  maxlength="255" onfocus="ac_checkText();" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="이름 또는 부서명을 입력하세요."/></th>
	<td scope="col" style="position:relative">
	<div class="bgBtn btnsearch" style="width:35px; height:21px; position:absolute; right:5px; top:5px; "><span><img src="${commonMobilePath}/image/bl_search.png" alt="search"  onclick="search();"/></span></div>
	</td>
</tr>
</tbody>
</table>
</form>
</div>


<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->
<ul class="mem_vclip">
	<c:forEach items="${resultList}" var="result">
	<c:if test="${result.sabun != null && result.workSt != 'R'}">	
	<li class="listG">
		<span class="vspac"></span>	
		<span class="cont">
			<a href="javascript:view('<c:out value="${result.userId}"/>');">
			<span class="tit_txt">${result.userNm}</span>&nbsp;
			<span class="tit_txts">${result.userId}</span>&nbsp;
			<span class="tit_txtss">
				<c:if test="${result.workSt == 'W'}">
				<c:choose>
				<c:when test="${result.wsTyp == 'T'}">출장</c:when>
				<c:when test="${result.wsTyp == 'S'}">파견</c:when>
				<c:when test="${result.wsTyp == 'V'}">휴가</c:when>
				<c:otherwise>내근</c:otherwise>
				</c:choose>
				</c:if>
			</span>
			</a>	
			<span class="txt_sub">${result.orgnztNm}<span class="txt_date">${result.moblphonNo} <c:if test="${result.offmTelnoInner != ''}">(내선 ${result.offmTelnoInner})</c:if></span></span>
		</span>
	<div class="txt_user bgBtn shadowBtn btnmem" style="position:absolute; right:72px; top:19px; width:60px;"><a href="${rootPath}/mobile/pushMsgSendView.do?sabun=${result.no}"><span class=bl_icon><img src="${commonMobilePath}/image/btn_message.png" alt="선택"/></span>메세지</a></div>
	<div class="txt_user bgBtn shadowBtn btnmem" style="position:absolute; right:8px; top:19px; width:52px;"><a href="tel:${fn:replace(result.moblphonNo,'-','')}"><span class=bl_icon2><img src="${commonMobilePath}/image/btn_phone.png" alt="선택"/></span>전화</a></div>
	</li>
	</c:if>
	</c:forEach>
</ul>
<br />
<!-- E:콘텐츠 들어가는곳 -->
</div>

<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>