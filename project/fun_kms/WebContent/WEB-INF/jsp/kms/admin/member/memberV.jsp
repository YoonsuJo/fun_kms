<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function positionHistory() {
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectPositionHistoryList.do' />";
	document.frm.submit();
}
function modify() {
	document.frm.action = "<c:url value='${rootPath}/admin/member/updtMemberView.do' />";
	document.frm.submit();
}
function goList() {
	document.frm.submit();
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
							<li class="stitle">사원정보보기</li>
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
		                    <caption>사원정보보기</caption>
		                    <colgroup><col class="col120" /><col class="col70" /><col class="col100" /><col class="col100" /><col class="col150" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">이름</td>
			                    	<td class="pL10" colspan="2"><c:out value="${info.userNm}" /></td>
			                    	<td class="title">영문이름</td>
			                    	<td class="pL10"><c:out value="${info.userEnm}" /></td>
			                    	<td class="pic2" rowspan="18">
								    	<c:choose>
                    						<c:when test="${empty info.picFileId || info.picFileId == ''}">
                    							소개사진 없음
                    						</c:when>
                    						<c:otherwise>
                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId}" />
													<c:param name="param_width" value="160" />
													<c:param name="param_height" value="250" />
												</c:import>
                    						</c:otherwise>
                    					</c:choose><br/>
								    	<c:choose>
                    						<c:when test="${empty info.picFileId2 || info.picFileId2 == ''}">
                    							증명사진 없음
                    						</c:when>
                    						<c:otherwise>
                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${info.picFileId2}" />
													<c:param name="param_width" value="160" />
													<c:param name="param_height" value="250" />
												</c:import>
                    						</c:otherwise>
                    					</c:choose>
			                    	</td>
		                    	</tr>
  								<tr>
								    <td class="title">ID</td>
									<td class="pL10" colspan="2"><c:out value="${info.userId}" />
									<c:if test="${user.userId == 'taisoup' || user.userId == 'arvin'}">
										   (${info.password})
									</c:if>
									</td>
								    <td class="title">사번</td>
 								    <td class="pL10"><c:out value="${info.sabun}" />
 								    <c:if test="${user.userId == 'taisoup' || user.userId == 'arvin'}">
										   (${info.no})
									</c:if>
									</td>
								</tr>
								<tr>
								    <td class="title">소속회사</td>
									<td class="pL10" colspan="2"><c:out value="${info.compnyNm}" /></td>
								    <td class="title">지출결의회사</td>
 								    <td class="pL10"><c:out value="${info.expCompNm}" /></td>
 								</tr>
								<tr>
 									<td class="title">소속부서</td>
								    <td class="pL10" colspan="2"><c:out value="${info.orgnztNm}" /></td>
								    <td class="title">이름초성</td>
								    <td class="pL10"><c:out value="${info.initial}" /></td>
								</tr>
								<tr>
								    <td class="title">직급</td>
 									<td class="pL10" colspan="2"><c:out value="${info.rankNm}" />
 										<c:out value="${info.promotionPeriodPrint}" />
 									</td>
								    <td class="title">보직</td>
								    <td class="pL10"><c:out value="${info.positionPrint}" /></td>
								</tr>
								<tr>								   
								    <td class="title">진급년도</td>
								    <td class="pL10" colspan="2">								   
										${info.promotionYear}										
								    </td>
								    <td class="title">재직기간</td>
								    <td class="pL10"><c:out value="${info.workMonthPrint}" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">근무상태</td>
								    <td class="pL10" colspan="2"><c:out value="${info.workStPrint}" /></td>
								    <td class="title">경력</td>
								    <td class="pL10""><c:out value="${info.workPeriodPrint}" /></td>
								</tr>
								<tr>								   
								    <td class="title">입사전 인정경력</td>
								    <td class="pL10" colspan="2"><c:out value="${info.careerMonthPrint}" /></td>
								    <td class="title">생일</td>
								    <td class="pL10"><c:out value="${info.brthPrint}" /> (<c:out value="${info.greLunPrint}" />)</td>
		                    	</tr>		
								<tr>
								    <td class="title">주민등록번호</td>
								    <td class="pL10" colspan="2">
								    	<c:choose>
								    		<c:when test="${user.admin || user.no == info.no}"><c:out value="${info.ihidNumFront}" />-<c:out value="${info.ihidNumBack}" /></c:when>
								    		<c:otherwise><c:out value="${info.ihidNumPrint}" /></c:otherwise>
								    	</c:choose>
								    </td>
								    <td class="title">나이</td>
								    <td class="pL10">
								    	<c:out value="${result.agePrint}" />
									</td>
								</tr>
								<tr>
								    <td class="title">학력</td>
								    <td class="pL10" colspan="2">
								    	${info.degreePrint}								    		
								    </td>
								    <td class="title">인정입사일</td>
								    <td class="pL10" colspan="2"><c:out value="${info.acceptCompinDtPrint}" /></td>
								</tr>														
		                    	<tr>
								    <td class="title">입사일</td>
								    <td class="pL10" colspan="2"><c:out value="${info.compinDtPrint}" /></td>
								    <td class="title">퇴사일</td>
								    <td class="pL10"><c:out value="${info.compotDtPrint}" /></td>								   
								</tr>
								<tr>
								    <td class="title">이메일</td>
								    <td class="pL10" colspan="4">
								    	회사메일 : <c:out value="${info.emailAdres}" /> / 외부메일 : <c:out value="${info.emailAdres2}" />
								    </td>
								</tr>
								<tr>
								    <td class="title">메신저계정</td>
								    <td class="pL10" colspan="4">
								    	<ul class="messanger">
								    		<c:forEach items="${msnList}" var="msn">
								    			<li><c:out value="${msn.msnTyp}" /> : <c:out value="${msn.msnAdres}" /></li>
								    		</c:forEach>
								    	</ul>
								    </td>
								</tr>
								<tr>
								    <td class="title" rowspan="3">개인연락처</td>
								    <td class="title3">휴대전화</td>
								    <td class="pL10" colspan="3"><c:out value="${info.moblphonNo}" /></td>
								</tr>
								<tr>
								    <td class="title3">집전화</td>
								    <td class="pL10" colspan="3"><c:out value="${info.homeTelno}" /></td>
								</tr>
								<tr>
								    <td class="title3">주소</td>
								    <td class="pL10" colspan="3"><c:out value="${info.homeAdres}" /></td>
								</tr>
								<tr>
								    <td class="title" rowspan="2">회사연락처</td>
								    <td class="title3">근무장소</td>
								    <td class="pL10" colspan="3"><c:out value="${info.offmNm}" /> (<c:out value="${info.offmAdres}" />)</td>
								</tr>
								<tr>
								    <td class="title3">전화번호</td>
								    <td class="pL10" colspan="3"><c:out value="${info.offmTelno}" /> (내선 <c:out value="${info.offmTelnoInner}" />)</td>
								</tr>
								<tr>
								    <td class="title" rowspan="2">사진</td>
								    <td class="title3">소개사진</td>
								    <td class="pL10" colspan="3">
								    	<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${info.picFileId}" />
										</c:import>
								    </td>
								</tr>
								<tr>
								    <td class="title3">증명사진</td>
								    <td class="pL10" colspan="3">
								    	<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${info.picFileId2}" />
										</c:import>
								    </td>
								</tr>
								<tr>
								    <td class="title">차량번호</td>
								    <td class="pL10" colspan="2"><c:out value="${info.carId}" /></td>
								    <td class="title">면허종류</td>
								    <td class="pL10"><c:out value="${info.carLicTypPrint}" /></td>
								</tr>
								<tr>
								    <td class="title">차량소유</td>
								    <td class="pL10" colspan="2">
								    	${info.carOwnPrint}
<!--								    	<c:if test="${info.carOwn == ''}">미입력</c:if>-->
<!--								    	<c:if test="${info.carOwn == 'Y'}">소유</c:if>-->
<!--								    	<c:if test="${info.carOwn == 'N'}">비소유</c:if>	-->
								    </td>
								    <td class="title">입사추천인</td>
								    <td class="pL10">								   
										${info.recommender}										
								    </td>
		                    	</tr>		                    	
								<tr>
								    <td class="title">좌우명</td>
								    <td class="pL10" colspan="5"><c:out value="${info.abutMePrint}" escapeXml="false"/></td>
								</tr>
								<tr>
								    <td class="title" rowspan="${fn:length(insaList) + 1}">인사정보파일</td>
								    <c:choose>
										<c:when test="${empty insaList}">
											<td class="txt_center" colspan="5">등록된 인사정보파일이 없습니다.</td>
										</c:when>
										<c:otherwise>
										    <td class="title2" colspan="2">종류</td>
										    <td class="title2" colspan="2">첨부파일</td>
										    <td class="title2">비고</td>
										</c:otherwise>
								    </c:choose>
								</tr>
								<c:forEach items="${insaList}" var="insa">
									<tr>
									    <td class="pL10" colspan="2"><c:out value="${insa.fileTyp}" /></td>
									    <td class="pL10" colspan="2">
											<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${insa.atchFileId}" />
											</c:import>
										</td>
									    <td class="pL10"><c:out value="${insa.note}" /></td>
									</tr>
								</c:forEach>
								<tr>
								    <td class="title" class="title">비고</td>
								    <td class="pL10" colspan="5"><c:out value="${info.adminNote}" /></td>
								</tr>                   	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						<form name="frm" method="POST" action="<c:url value='${rootPath}/admin/member/selectMemberList.do' />">
							<input type="hidden" name="no" value="${searchVO.no}"/>
							<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
							<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
							<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>							
							<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
							<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
							<input type="hidden" name="rankId" value="${searchVO.rankId}"/>
							<input type="hidden" name="workSt" value="${searchVO.workSt}"/>
						</form>
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:positionHistory();"><img src="${imagePath}/admin/btn/btn_appointment.gif"/></a>
		                	<a href="javascript:modify();"><img src="${imagePath}/admin/btn/btn_modify.gif"/></a>
		                	<a href="javascript:goList();"><img src="${imagePath}/admin/btn/btn_list.gif"/></a>
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
