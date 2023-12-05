<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

function interest(bcId, bool) {
	document.frm.bcId.value = bcId;
	document.frm.interestYn.value = bool;
	document.frm.action = "${rootPath}/mobile/cooperation/updateBusinessContactInterest.do?returnList=Y";
	document.frm.submit();
}

function goView(bcId){
	document.frm.bcId.value = bcId;
	document.frm.action = "${rootPath}/mobile/cooperation/selectBusinessContact.do";
	document.frm.submit();
}

function goWrite(){
	document.frm.action = "${rootPath}/mobile/cooperation/insertBusinessContactView.do";
	document.frm.submit();
}

</script>
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>업무연락</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:44px;margin-left:5px;"><font class="fontShadow"><a href="javascript:goWrite();" alt=""> 등록</a></font></div>
</ul>
<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->
<div id="searchBoard">
<form name="frm" method="POST" action="${rootPath}/mobile/cooperation/selectBusinessContactList.do" onsubmit="search(1); return false;">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
<input type="hidden" name="interestYn"/>
<input type="hidden" name="bcId"/>
<input type="hidden" name="searchCondition" value="0"/>

<table cellspacing="0" border="1" summary="" class="scheTable">
<caption></caption>
<colgroup>
<col width="*">
<col width="63px">
</colgroup>
<tbody>
<tr>
	<th scope="col"><input type="text" name="searchKeyword" id="searchKeyword" value="${searchVO.searchKeyword}"/></th>
	<td scope="col" style="position:relative">
	<div class="bgBtn btnsearch" style="width:35px; height:20px; position:absolute; right:5px; top:5px; "><span><img src="${commonMobilePath}/image/bl_search.png" alt="search" onclick="javascript:search(1);"/></span></div>
	</td>
</tr>
</tbody>
</table>
</form>
</div>

<ul id="workLists">	
	<c:forEach items="${resultList}" var="result" varStatus="c">
	
	<li id="aa" class="listG">
		<a href="javascript:goView('${result.bcId}');" class="wrap_cont link_video">
		<div id="b">
			<div class="bb">
				<c:choose>
					<c:when test="${result.readYn == 'N'}"><span class="fontRed">${result.bcSj}</span></c:when>
					<c:when test="${result.interestYn == 'Y'}"><span class="fontBlue">${result.bcSj}</span></c:when>
					<c:otherwise>${result.bcSj}</c:otherwise>
				</c:choose>				
			</div>
			<div class="bc">
				<span class="usern">${result.userNm}</span>&nbsp;|&nbsp;
				<em class="textb">${result.modDt}</em>&nbsp;|&nbsp;
				<em class="textcc">${result.readStatPrint}</em>&nbsp;|&nbsp;
				<em class="texta"><c:if test="${result.attachFileId != ''}"><img src="${commonMobilePath}/image/clip.png" alt="" /></c:if></em>
			</div>
		</div>
		<div id="d">
			<!-- favorite -->
			<div class="da">
				<c:choose>
					<c:when test="${result.interestYn == 'Y'}">
						<a href="javascript:interest('${result.bcId}','N')"><img src="${imagePath}/btn/btn_light_on.gif" /></a>
					</c:when>
					<c:otherwise>
						<a href="javascript:interest('${result.bcId}','Y')"><img src="${imagePath}/btn/btn_light_off.gif" /></a>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- counter -->
			<div class="db"><span class="counter bgBtn">${result.commentCnt}</span></div>
		</div>
		</a>
	</li>
	
	
	</c:forEach>	
</ul>
<br />
<!-- E:콘텐츠 들어가는곳 -->
</div>
<div id="btn_ext"></div>
<div id="paginate">
	<c:if test="${paginationInfo.totalRecordCount > 0}">
	<span class="bgBtn shadowBtn pagenum">
		<c:if test="${searchVO.pageIndex == 1}"><a href="javascript:search('${searchVO.pageIndex}');">이전</a></c:if>
		<c:if test="${searchVO.pageIndex > 1}"><a href="javascript:search('${searchVO.pageIndex -1}');">이전</a></c:if>
	</span>
	<span style="width:50px;"><em class="pagef">${searchVO.pageIndex}</em>&nbsp;/&nbsp;<em class="paget">${totPage}</em></span>
	<span class="bgBtn shadowBtn pagenum">
		<c:if test="${searchVO.pageIndex == totPage}"><a href="javascript:search('${searchVO.pageIndex}');">다음</a></c:if>
		<c:if test="${searchVO.pageIndex < totPage}"><a href="javascript:search('${searchVO.pageIndex +1}');">다음</a></c:if>
	</span>
	</c:if>
</div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>