<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function positionHistory() {
	document.frm.action = "<c:url value='${rootPath}/member/selectPositionHistoryList.do' />";
	document.frm.submit();
}
function modify() {
	document.frm.action = "<c:url value='${rootPath}/member/updtMemberView.do' />";
	document.frm.submit();
}
function goList() {
	document.frm.submit();
}
function chngMemberLogin(no){
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/member/chngMemberLogin.do' />";
	document.frm.submit();
}
</script>
</head>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
					<c:set value="${result.member}" var="info" />
						<ul>
							<li class="stitle"><a href="${rootPath}/member/selectMemberMain.do?no=${info.no}">사원정보 보기</a></li>
							<li class="navi">인사정보 > 사원조회</li>
						</ul>
					</div>	
					
					<!-- S: section -->
					<div class="section01">
						<c:set value="${result.member}" var="info" />
						<c:set value="${result.insaFileList}" var="insaList" />
						<c:set value="${result.msnList}" var="msnList" />
			                
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>개인정보 조회</caption>
								<colgroup>
									<col class="col150" />
									<col class="col200" />
									<col class="col150" />
									<col class="col200" />
									<col width="px" /></colgroup>
								<tbody>
		                    	<tr>
								    <td class="title">이름</td>
								    <td class="pL10" ><c:out value="${info.userNm}" /></td>
								    <td class="title">영문이름</td>
								    <td class="pL10" ><c:out value="${info.userEnm}" /></td>								    
								    <td class="pic" rowspan="14" >
								    	<c:choose>
	                   						<c:when test="${empty info.picFileId || info.picFileId == ''}">
	                   							<img src="${imagePath}/inc/img_no_photo.gif" alt="소개사진 없음"/>
	                   						</c:when>
	                   						<c:otherwise>
	                   							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId}" />
													<c:param name="param_width" value="160" />
													<c:param name="param_height" value="200" />
												</c:import>
	                   						</c:otherwise>
	                   					</c:choose><br/><br/>
								    	<c:choose>
	                   						<c:when test="${empty info.picFileId2 || info.picFileId2 == ''}">
	                   							<img src="${imagePath}/inc/img_no_id_photo.gif" alt="증명사진 없음"/>
	                   						</c:when>
	                   						<c:otherwise>
	                   							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId2}" />
													<c:param name="param_width" value="160" />
													<c:param name="param_height" value="200" />
												</c:import>
	                   						</c:otherwise>
	                   					</c:choose>
	                   				</td>
		                    	</tr>
		                    	<tr>
								    <td class="title">ID</td>
								    <td class="pL10" ><c:out value="${info.userId}" />
								    <c:if test="${user.loginauth }">
										   (${info.password}) <input type="button" value="로그인" onclick="javascript:chngMemberLogin(${info.no});" >
									</c:if>
								    </td>
								    <td class="title">사번</td>
								    <td class="pL10" ><c:out value="${info.sabun}" />
								    <c:if test="${user.loginauth }">
										   (${info.no}) 
									</c:if>
								    </td>
		                    	</tr>
		                    	<tr>
								    <td class="title">소속회사</td>
							        <td class="pL10"><c:out value="${info.compnyNm}" /></td>
								    <td class="title">지출결의회사</td>
 								    <td class="pL10"><c:out value="${info.expCompNm}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">소속부서</td>
							        <td class="pL10" colspan="3"><c:out value="${info.orgnztNmFullLong}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">직급</td>
							        <td class="pL10"><c:out value="${info.rankNm}" /></td>
							        <td class="title">보직</td>
							        <td class="pL10"><c:out value="${info.positionPrint}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">주민등록번호</td>
							        <td class="pL10">
								    	<c:choose>
								    		<c:when test="${user.admin || user.no == info.no}"><c:out value="${info.ihidNumFront}" />-<c:out value="${info.ihidNumBack}" /></c:when>
								    		<c:otherwise><c:out value="${info.ihidNumPrint}" /></c:otherwise>
								    	</c:choose>
							        </td>
							        <td class="title">생일</td>
							        <td class="pL10"><c:out value="${info.brthPrint}" /> (<c:out value="${info.greLunPrint}" />)</td>
		                    	</tr>
		                    	<tr>
							        <td class="title">입사일</td>
							        <td class="pL10" ><c:out value="${info.compinDt}" /></td>
							        <td class="title">퇴사일</td>
							        <td class="pL10" ><c:out value="${info.compotDt}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">근무상태</td>
							        <td class="pL10" ><c:out value="${info.workStPrint}" /></td>
							        <td class="title">재직기간</td>
							        <td class="pL10" ><c:out value="${info.workMonthPrint}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">이메일</td>
							        <td colspan="3">
							        	<ul class="address">
							        		<li class="left">회사메일</li>
							        		<li class="right"><c:out value="${info.emailAdres}" /></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">외부메일</li>
							        		<li class="right"><c:out value="${info.emailAdres2}" /></li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<!-- 2013.07.24 김대현 웹메일 주소-->
								<tr>
									<td class="title">회사 웹메일 주소</td>
									<td colspan="3">
										<ul class="address">
								       		<li class="right"><c:out value="${info.emailLink}" /></li>
								       	</ul> * 우측상단 회사웹메일 링크
									</td>
								</tr>
		                    	<tr>
								    <td class="title">개인연락처</td>
							        <td colspan="3">
							        	<ul class="address">
							        		<li class="left">휴대전화</li>
							        		<li class="right"><c:out value="${info.moblphonNo}" /></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">집전화</li>
							        		<li class="right"><c:out value="${info.homeTelno}" /></li>
							        	</ul>
							        	<ul class="address02">
							        		<li class="left">주소</li>
							        		<li class="right"><c:out value="${info.homeAdres}" /></li>
							        	</ul>
		                    		</td>
		                    	</tr>		                    	
		                    	<tr>
		                    		<td class="title">회사연락처</td>		                    		
		                    		<td colspan="3">
							        	<ul class="address02">
							        		<li class="left">근무장소</li>
							        		<li class="right"><c:out value="${info.offmNm}" /> (<c:out value="${info.offmAdres}" />)</li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">전화번호</li>
							        		<li class="right"><c:out value="${info.offmTelno}" /> (내선 <c:out value="${info.offmTelnoInner}" />)</li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사진</td>
		                    		<td colspan="3">
							        	<ul class="address">
							        		<li class="left">소개사진</li>
							        		<li class="right">
										    	<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId}" />
												</c:import>
											</li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">증명사진</li>
							        		<li class="right">
										    	<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId2}" />
												</c:import>
							        		</li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<tr>
								    <td class="title">차량번호</td>
								    <td class="pL10" ><c:out value="${info.carId}" /></td>
								    <td class="title">면허종류</td>
								    <td class="pL10" colspan="2"><c:out value="${info.carLicTypPrint}" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">좌우명</td>
								    <td class="pL10 pT5 pB5 wordB" colspan="4"><c:out value="${info.abutMePrint}" escapeXml="false"/></td>
		                    	</tr>
		                    	<c:if test="${user.no == info.no || user.admin}">
			                    	<tr>
									    <td class="title" rowspan="${fn:length(insaList) + 1}">인사정보파일</td>
									    <c:choose>
											<c:when test="${empty insaList}">
												<td class="txt_center" colspan="4">등록된 인사정보파일이 없습니다.</td>
											</c:when>
											<c:otherwise>
											    <td class="title2">종류</td>
											    <td class="title2" colspan="2">첨부파일</td>
											    <td class="title2">비고</td>
											</c:otherwise>
									    </c:choose>
									</tr>
									<c:forEach items="${insaList}" var="insa">
										<tr>
										    <td class="pL10"><c:out value="${insa.fileTyp}" /></td>
										    <td class="pL10" colspan="2">
												<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${insa.atchFileId}" />
												</c:import>
											</td>
										    <td class="pL10"><c:out value="${insa.note}" /></td>
										</tr>
									</c:forEach>
		                    	</c:if>
		                    	<c:if test="${user.admin}">
		                    		<tr>
		                    			<td class="title">비고</td>
		                    			<td class="pL10" colspan="4"><c:out value="${info.adminNote}"/></td>
		                    		</tr>
		                    	</c:if>
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						<form name="frm" method="POST" action="<c:url value='${rootPath}/member/selectMemberList.do' />">
							<input type="hidden" name="mode" value="${searchVO.mode}"/>
							<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
							<input type="hidden" name="no" value="${searchVO.no}"/>
							<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
							<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
							<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
							<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
							<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
							<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
							<input type="hidden" name="rankId" value="${searchVO.rankId}"/>
							<input type="hidden" name="workSt" value="${searchVO.workSt}"/>
						</form>
	
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<c:if test="${user.no == info.no || user.admin}">
			                	<a href="javascript:modify();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
		                	</c:if>
		                	<c:if test="${searchVO.searchCondition != 'MYPAGE'}">
		                		<a href="javascript:goList();"><img src="${imagePath}/btn/btn_list.gif"/></a>
		                	</c:if>
		                </div>
		                <!-- 버튼 끝 -->	
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->				
			<%@ include file="../include/right.jsp"%>
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
