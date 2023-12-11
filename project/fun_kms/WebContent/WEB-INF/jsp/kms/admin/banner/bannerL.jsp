<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function addPop() {
	var popup = window.open('${rootPath}/admin/banner/insertBannerView.do','_POP_BNR_','width=550px, height=450px');
	popup.focus();
}
function updtPop(bnrId) {
	var popName = "_POP_BNR_";
	
	document.subFrm.bnrId.value = bnrId;
	document.subFrm.target = popName;
	
	var popup = window.open("about:blank",popName,'width=550px, height=420px');
	
	document.subFrm.submit();
	popup.focus();
}
function chnageOrder(bnrId, ordNo, type) {
	document.ordFrm.bnrId.value = bnrId;
	document.ordFrm.ordNo.value = ordNo;
	document.ordFrm.changeType.value = type;
	document.ordFrm.action = "<c:url value='${rootPath}/admin/banner/changeBannerOrder.do'/>";
	document.ordFrm.submit();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">배너관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col5" />
								<col class="col40" />
								<col class="col40" />
								<col class="col200" />
								<col width="px" />
								<col class="col150" />
								<col class="col70" />
								<col class="col70" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">번호</th>
								<th scope="col">위치</th>
								<th scope="col">이미지</th>
								<th scope="col">제목</th>
								<th scope="col">게시기간</th>
								<th scope="col">사용여부</th>
								<th scope="col">등록일</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center" colspan="2"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.pageSize + c.count) + 1}"/></td>
										<td class="txt_center">
											${result.ordNo}<br/>
											<span><img src="/images/btn/btn_plus02.gif" class="cursorPointer" onclick="javascript:chnageOrder('${result.bnrId}','${result.ordNo}','increase');"></span>
				                    		<span><img src="/images/btn/btn_minus02.gif" class="cursorPointer" onclick="javascript:chnageOrder('${result.bnrId}','${result.ordNo}','decrease');"></span>
										</td>
										<td class="txt_center pT5 pB5">
											<a href="javascript:updtPop('${result.bnrId}');">
												<c:choose>
		                    						<c:when test="${empty result.bnrFileId || result.bnrFileId == ''}">
		                    							이미지없음
		                    						</c:when>
		                    						<c:otherwise>
		                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
															<c:param name="param_atchFileId" value="${result.bnrFileId}" />
														</c:import>
		                    						</c:otherwise>
		                    					</c:choose>
	                    					</a>
										</td>
										<td class="txt_center"><a href="javascript:updtPop('${result.bnrId}');"><c:out value="${result.bnrSj}" /></a></td>
										<td class="txt_center"><c:out value="${result.ntceSdt}" /> ~ <c:out value="${result.ntceEdt}" /></td>
										<td class="txt_center"><c:out value="${result.useAt}" /></td>
										<td colspan="2" class="txt_center"><c:out value="${result.regDt}" /></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<form name="subFrm" method="POST" action="<c:url value='${rootPath}/admin/banner/updtBannerView.do' />">
							<input type="hidden" name="bnrId" />
						</form>
						<form name="ordFrm" method="POST" action="<c:url value='${rootPath}/admin/banner/chnageBannerOrder.do' />">
							<input type="hidden" name="bnrId" />
							<input type="hidden" name="ordNo" />
							<input type="hidden" name="changeType" />
						</form>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:addPop();"><img src="${imagePath}/btn/btn_add.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->	
		                
					</div>
					<!-- E: section -->	
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->		
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
