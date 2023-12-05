<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/top_inc.jsp"%>   

<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='${rootPath}/mobile/support/selectBoardList.do'/>";
	document.frm.submit();	
}

function view(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>";
	document.subForm.submit();
}

function goWriteView(){
	document.frm.action = "${rootPath}/mobile/support/addBoardArticle.do";
	document.frm.submit();
}

if(mobileOS == "IOS") {
	document.location.href = "mobilekms:initialize:${user.userId}:${user.password}";
}else if(mobileOS == "Android") { 
	mobilekms.initialize("${user.userId}","${user.password}");
	mobilekms.setAddressOutOfficeRegister("http://hm.hanmam.kr/mobile/member/insertAbsenceView.do?wsTyp=O");
}

</script>

<div id="showhidden"></div>
	<!-- S:Section Area -->
	<ul class="sectionttl bgTop">
		<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
		<li>공지사항</li>
		<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:44px;margin-left:5px;"><font class="fontShadow"><a href="javascript:goWriteView();" alt=""> 등록</a></font></div>
	</ul>

	<div id="viw">
	


	<!-- S:콘텐츠 들어가는곳 -->
	<div id="searchBoard">
		<table cellspacing="0" border="1" summary="" class="scheTable">
			<caption></caption>
			<colgroup>
			<col width="*">
			<col width="60px">
			</colgroup>
			<tbody>
			<tr>
				<form name="frm" action ="<c:url value='${rootPath}/mobile/support/selectBoardList.do'/>" method="post">
				
				<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
				<input type="hidden" name="nttId"  value="0" />
				<input type="hidden" name="no"/>
				<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
				<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
				<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>			
				<th scope="col"><input type="text" name="searchWrd"></th>
				<td scope="col" style="position:relative">
				<div class="bgBtn btnsearch" style="width:35px; position:absolute; right:4px; top:5px; height:21px; ">
				<span>
				<img src="${commonMobilePath}/image/bl_search.png" onclick="search('1'); return false;"  alt="search"/>
				</span>
				</div>
				</td>
				</form>
			</tr>
			</tbody>
		</table>
	</div>
	
	<ul class="notice_vclip">


		<c:forEach items="${resultList}" var="result" varStatus="c">

			<li class="listG">
			
				<a href="javascript:view('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>','<c:out value="${result.readBool}"/>');" class="wrap_cont link_video">
					<div id="b">
						<div class="bb">
							<span class="tit_txt list_shadow">
									<c:if test="${result.replyAt == 'Y'}">
									    <c:forEach begin="1" end="${result.replyLc}">
									    	&nbsp;&nbsp;
									    </c:forEach>
									    <img src="${imagePath}/board/icon_re.gif" />
									</c:if>
									<c:choose>
										<c:when test="${result.readBool == 'Y'}">
											<c:out value="${result.nttSj}"/>
										</c:when>
										<c:otherwise>
											<span class="fontRed"><c:out value="${result.nttSj}"/></span>&nbsp;<span class="txt_date">[<c:out value="${result.commentCount}"/>]</span>
										</c:otherwise>
									</c:choose>
							</span>
						</div>
						<div class="bc">
							<span><em class="textcc"><c:out value="${result.ntcrNm}"/></em> (<c:out value="${result.ntcrId}"/>) </span>&nbsp;|&nbsp;
							<em class="textcc"><c:out value="${result.frstRegisterPnttm}"/></em>
						</div>
					</div>
									
					<div id="d">
							<div class="db"><span class="counter bgBtn"><c:out value="${result.commentCount}"/></span></div>
					</div>	
					
				</a>
			</li>
			
			
		</c:forEach>

	</ul>
	<br />

<!-- E:콘텐츠 들어가는곳 -->
</div>

<!-- 페이징 시작 -->

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

	<!-- 페이징 끝 -->
	
	<form name="subForm" method="post" action="<c:url value='${rootPath}/mobile/support/selectBoardArticle.do'/>">
		<input type="hidden" name="bbsId" />
		<input type="hidden" name="nttId" />
		<input type="hidden" name="readBool" />
		<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
		<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
		<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
	</form>

<jsp:include page="../include/footer.jsp"></jsp:include>

