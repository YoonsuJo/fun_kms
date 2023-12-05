<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function list(){
	document.frm.action = "${rootPath}/mobile/cooperation/selectBusinessContactList.do";
	document.frm.submit();
}

function goCommentWritePage(){
	document.frm.action = "${rootPath}/mobile/cooperation/goCommentWritePage.do";
	document.frm.submit();
}
function commentUpdateView(no) {
	document.frm.no.value = no;
	document.frm.action = "${rootPath}/mobile/cooperation/updateBusinessContactCommentView.do?type=body";
	document.frm.submit();
}
function commentDelete(no) {
	document.frm.no.value = no;
	document.frm.useAt.value = "N";
	document.frm.action = "${rootPath}/mobile/cooperation/deleteBusinessContactComment.do";
	document.frm.submit();
}
</script>
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>업무연락</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:list();">목록</a></font></div>
</ul>
<!-- S:콘텐츠 들어가는곳 -->
<ul class="list_vclip">	
<li class="listG wrap_cont">
	<span class="cont">
		<span class="tit_txt list_shadow">${result.bcSj}</span>
		<span class="txt_user bgBtn shadowBtn hitnuma" id="addresseeClick">수신자보기</span>
		<span class="txt_sub"><a href="${rootPath}/mobile/member/selectMember.do?userId=${result.userId}">${result.userNm}</a></span>&nbsp;
		<span class="txt_date">${result.modDt}</em></span>
	</span>				
</li>
<hr class="hr_e1e1e1" />
<div id="addressee" style="display:none">
<form name="frm" method="POST">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
<input type="hidden" name="bcId" value="${result.bcId}"/>
<input type="hidden" name="interestYn" />
<input type="hidden" name="useAt" />
<input type="hidden" name="viewType" />
<input type="hidden" name="no"/>

<table cellspacing="0" border="1" summary="" class="office_b">
<caption></caption>
<colgroup>
<col width="80px">
<col width="*">
<col width="80px">
<col width="*">
</colgroup>
<tbody>
<tr>
	<th scope="col">작성일</th>
	<td scope="col" style="line-height:12px; "><span class="addrdate">${fn:substring(result.regDt,0,10)}<br />(${fn:substring(result.regDt,11,16)})</span></td>
	<th scope="col">변경일</th>
	<td scope="col" style="line-height:12px; "><span class="addrdate">${fn:substring(result.modDt,0,10)}<br />(${fn:substring(result.modDt,11,16)})</span></td>
</tr>
<tr>
	<th scope="col">수신자</th>
	<td scope="col" colspan="3" style="padding:5px 5px;"> 
		<c:forEach items="${result.recieveList}" var="rec" varStatus="c">
			<a href="${rootPath}/mobile/member/selectMember.do?userId=${rec.userId}"><print:user userNo="${rec.userNo}" userNm="${rec.userNm}"/></a>(
			<c:choose>
			<c:when test="${empty rec.readtime}"><span class="fontRed"> 미열람</span></c:when>
			<c:otherwise>${rec.readtime}<span class="fontBlue"> 열람</span></c:otherwise>
			</c:choose>)<br />
		</c:forEach>
	</td>
</tr>
<tr>
	<th scope="col">참조자</th>
	<td scope="col" colspan="3" style="padding:5px 5px;"> 
   		<c:forEach items="${result.referenceList}" var="ref" varStatus="c">
   			<a href="${rootPath}/mobile/member/selectMember.do?userId=${ref.userId}"><print:user userNo="${ref.userNo}" userNm="${ref.userNm}"/></a>(
			<c:choose>
 			<c:when test="${empty ref.readtime}"><span class="fontRed"> 미열람</span></c:when>
			<c:otherwise>${ref.readtime }<span class="fontBlue"> 열람</span></c:otherwise>
			</c:choose>)<br />
   		</c:forEach>
	</td>
</tr>
<tr>

	<th scope="col">프로젝트</th>
	<td scope="col" colspan="3" style="padding:5px 5px;">${result.prjNm}</td>
</tr>
</tbody>
</table>
</form>
</div>

<div class="notice_view"><c:out value="${result.bcCn}" escapeXml="false" /></div>

<h1 class="zipttl">첨부파일</h1>
<hr class="officehr" />
<table cellspacing="0" border="1" summary="" class="office_v">
<caption></caption>
<colgroup>
<col width="*">
</colgroup>
<tbody>
<tr>
	<td scope="col" style="text-align:left; padding-left:10px; font-size:12px;">
		<c:import url="${rootPath}/selectFileInfsForMobile.do" charEncoding="utf-8">
			<c:param name="param_atchFileId" value="${result.attachFileId}" />
		</c:import>
	</td>
</tr>
</tbody>
</table>
<br />
<script>
function confirms(){
	var result = confirm('댓글을 삭제하시겠습니까?');
	if (result) {
		location.href = "./work_view.html";
	}
	else {
		location.href = "./work_view.html";
	}
}
</script>
<div id="commd">
	<c:forEach items='${commentList}' var='comment'>
	<hr>
	<div class="reply"> 
		<dl> 
			<dt>
			<c:if test="${user.no == comment.userNo}"><div class="workm" style="position:absolute; right:8px; top:10px; width:30px;"><a href="javascript:commentUpdateView('${comment.no}');">수정</a></div></c:if>
			<c:if test="${user.no == comment.userNo}"><div class="workm" style="position:absolute; right:50px; top:10px; width:30px;"><a href="javascript:commentDelete('${comment.no}');">삭제</a></div></c:if>
			<a href="${rootPath}/mobile/member/selectMember.do?userId=${comment.userId}"><span><em class="texte">${comment.userNm}(${comment.userId})</em></span></a>
			<span><em class="textz">&nbsp;|&nbsp;${comment.regDt}</em></span>
			</dt> 
			<dd class="userText"><pre>${comment.bcCommentCn}</pre></dd>
			<c:if test="${comment.attachFileId != ''}">
			<span>
				<em class="textz">
					<img src="${commonMobilePath}/image/clip.png" alt="" />
					<c:import url="${rootPath}/selectFileInfsForMobile.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${comment.attachFileId}" />
						<c:param name="param_isComment" value="true" />
					</c:import>
				</em>
			</span>
			</c:if>
		</dl> 					
	</div>
	</c:forEach>
</div>

<br />
<p>
	<a href="work_commt.html">
		<a href="javascript:goCommentWritePage();"><button class="bgBtn shadowBtn btnRadius" style="width:96%;">댓글쓰기<span class="bl_up"><img src="${commonMobilePath}/image/bl_doarowa.png" alt=""/></span></button></a>
	</a>
</p>

<!-- E:콘텐츠 들어가는곳 -->

</div>
<div id="btn_ext">
	<div class="bgBtn shadowBtn btnTop btn_ext" style="width:50px; float:left;"><a href="" class="">위로<span class="bl_select"><img src="${commonMobilePath}/image/bl_select.png" alt="선택"/></span></a></div>
</div>

<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>