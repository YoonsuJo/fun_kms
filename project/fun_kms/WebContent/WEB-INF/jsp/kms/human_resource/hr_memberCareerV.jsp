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
	document.frm.action = "<c:url value='${rootPath}/member/selectPositionHistoryList.do' />";
	document.frm.submit();
}
function modifyMemberInfo() {
	document.frm.action = "<c:url value='${rootPath}/member/updtMemberView.do' />";
	document.frm.submit();
}
function modifyCareer() {
	document.frm.action = "<c:url value='${rootPath}/member/updtCareerView.do' />";
	document.frm.submit();
}
function deleteCareer(no) {
	if(confirm("삭제하시겠습니까?")){
		document.frm.action = "<c:url value='${rootPath}/member/deleteCareer.do' />";
		document.frm.submit();
	}
}
function listCareer() {
	document.frm.no.value='';
	document.frm.action="<c:url value='${rootPath}/member/selectMemberCareerList.do' />";
	document.frm.submit();
}
function popPrint() {
	var POP_NAME = "_POP_MEMBER_CAREER_PRINT_";
	document.frm.target = POP_NAME;
	document.frm.action = "${rootPath}/member/printMemberCareerDetail.do";
	
	var popup = window.open("about:blank",POP_NAME,"width=700px,height=500px;");
	document.frm.submit();
	popup.focus();
}
function excelDown() {
	document.frm.action = "/member/selectMemberCareerExcel.do";
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
						<ul>
							<li class="stitle">이력관리 상세정보</li>
							<li class="navi">홈 > 인사정보 > 사원정보 > 이력관리 상세정보</li>
						</ul>
					</div>	
					
					<!-- S: section -->
					<div class="section01">
						
			            <ul>
							<li class="th_stitle04 mB10">기본정보</li>
						</ul>
						
						<!-- 게시판 시작  -->
						<form:form commandName="memberVO" name="detailForm">
							<div class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>개인정보</caption>
			                    <colgroup>
			                    	<col class="col180" />
			                    	<col class="col120" />
			                    	<col class="px" />
			                    	<col class="col120" />
			                    	<col width="px" />
			                    </colgroup>
			                    <tbody>
			                    	<tr>
<!--			                    		<td class="pL10" rowspan="7">-->
			                    		<td class="pL10" rowspan="8">
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
										
										<td class="txt_center bc01">이름</td>
										<td class="pL10" >
											<print:user userNo="${info.no}" userNm="${info.userNm}"/>
											(${info.age}세)
										</td>
										<td class="txt_center bc01">영문이름</td>
										<td class="pL10" ><c:out value="${info.userEnm}" /></td>										
		                    		</tr>
		                    				                    		
		                    		<tr>
										<td class="txt_center bc01">소속부서</td>
										<td class="pL10" colspan="1"><c:out value="${info.orgnztNm}" /></td>
				                    	<td class="txt_center bc01">직급</td>
										<td class="pL10"><c:out value="${info.rankNm}" /></td>
									</tr>									
									<tr>
										<td class="txt_center bc01">주민등록번호</td>
										<td class="pL10"><c:out value="${info.ihidNumPrint}" /></td>
										<td class="txt_center bc01">회사메일</td>
										<td class="pL10"><c:out value="${info.emailAdres}" /></td>
									</tr>									
									<tr>	
										<td class="txt_center bc01">입사일</td>
										<td class="pL10">
											${fn:substring(info.compinDt,0,4)}.${fn:substring(info.compinDt,4,6)}.${fn:substring(info.compinDt,6,8)}
										</td>
										<td class="txt_center bc01">휴대전화</td>
										<td class="pL10"><c:out value="${info.moblphonNo}" /></td>										
									</tr>
									<tr>
										<td class="txt_center bc01">주소</td>
										<td class="pL10" colspan="3"><c:out value="${info.homeAdres}" /></td>
									</tr>								
									<tr>
										<td class="txt_center bc01">면허종류</td>
				                    	<td class="pL10" colspan="1">${info.carLicTypPrint}</td>	
										<td class="txt_center bc01">차량번호</td>
										<td class="pL10" ><c:out value="${info.carId}" /></td>					
				                    </tr>									
		                    		<tr>
				                    	<td class="txt_center bc01">SW기술등급</td>
				                    	<td class="pL10" colspan="1">${careerMain.swLevel}</td>	
				                    	<td class="txt_center bc01">경력기간</td>
				                    	<td class="pL10"> 
				                    		<c:if test="${careerMain.workMonth==null}">미입력</c:if>
				                    		<c:if test="${careerMain.workMonth!=null}">
				                    			${careerMain.workYear}년
				                    			${careerMain.workMonth}개월
				                    		</c:if>
<!--				                    	${careerMain.careerDt}-->
				                    	</td>
		                    		</tr>		                    		
		                    		<tr>
				                    	<td class="txt_center bc01">병역사항</td>
				                    	<td class="pL10" colspan="3">				                    	
				                    		<c:if test="${careerMain.militaryService==null}">미입력</c:if>				                    		
				                    		<c:if test="${careerMain.militaryService==''}">없음</c:if>				                    		
				                    		<c:if test="${careerMain.militaryService!=null && careerMain.militaryService != ''}">
				                    						                    		
				                    		<b>군별</b> :					                    	
					                    	<c:if test="${careerMain.militaryService!=null}">${careerMain.militaryService}</c:if>
					                    	
					                    	<b>기간</b> :
					                    	<c:if test="${careerMain.msStDt==null || careerMain.msStDt==''}">미입력</c:if>
					                    	<c:if test="${careerMain.msStDt!=null && careerMain.msStDt!=''}">					                    	
						                    	${fn:substring(careerMain.msStDt,0,4)}.${fn:substring(careerMain.msStDt,4,6)}.${fn:substring(careerMain.msStDt,6,8)} 
						                    	~ 
						                    	${fn:substring(careerMain.msEdDt,0,4)}.${fn:substring(careerMain.msEdDt,4,6)}.${fn:substring(careerMain.msEdDt,6,8)} 
					                    	</c:if>		                    	   	
				                    	   	<b>계급</b> :
					                    	<c:if test="${careerMain.msLevel==null || careerMain.msLevel==''}">미입력</c:if>
					                    	<c:if test="${careerMain.msLevel!=null && careerMain.msLevel!=''}">${careerMain.msLevel}</c:if>
					                    	
					                    	</c:if>
				                    	</td>
		                    		</tr>
		                    				                    		
								</tbody>
								</table>
								
								<c:if test="${user.no == info.userNo || user.admin}">
									<div class="btn_area02">
										<a href="javascript:modifyMemberInfo();"><img src="${imagePath}/btn/btn_modifyMemberInfo.gif"/></a>
									</div>
								</c:if>
								
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>개인정보</caption>
			                    <colgroup>
			                    	<col class="col180" />
			                    	<col class="col120" />
			                    	<col class="px" />
			                    	<col class="col120" />
			                    	<col width="px" />
			                    </colgroup>
			                    <tbody>			                    	                    		
		                    		<tr>
		                    			<td class="txt_center bc01" colspan="5">기   술</td>
		                    		</tr>
		                    		<tr>		                    			
		                    			<td class="txt_center bc01">개발언어</td>
				                    	<td class="pL10" colspan="4">
				                    	<print:textarea text="${careerMain.skillLang}"/>
				                    	</td>
		                    		</tr>
		                            <tr>
		                    			<td class="txt_center bc01">DBMS</td>
				                    	<td class="pL10" colspan="4">
				                    	<print:textarea text="${careerMain.skillDbms}"/>
				                    	</td>
		                    		</tr>		                    		
		                    		<tr>
		                    			<td class="txt_center bc01">Tool</td>
				                    	<td class="pL10" colspan="4">
				                    	<print:textarea text="${careerMain.skillTool}"/>
				                    	</td>
		                    		</tr>		                    		
		                    		<tr>
		                    			<td class="txt_center bc01">OS</td>
				                    	<td class="pL10" colspan="4">
				                    	<print:textarea text="${careerMain.skillOs}"/>
				                    	</td>
		                    		</tr>
		                    		       	
									<!-- 첨부파일 시작 -->
									<tr> 
										<td class="txt_center bc01">첨부 파일</td>
										<td class="pL10" colspan="4">
											<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${careerMain.atchFileId}" />
											</c:import>
										</td>
									</tr>
									<!-- 첨부파일 끝 -->
									
									<tr>
				                    	<td class="txt_center bc01">비밀취급인가 근거</td>
				                    	<td class="pL10" colspan="2">${careerMain.securityBasis}</td>
				                    	<td class="txt_center bc01">비밀취급인가증 번호</td>
				                    	<td class="pL10" colspan="1">${careerMain.securityNo}</td>
		                    		</tr>		                    		
								</tbody>
								</table>
							</div>						
						
						<c:if test="${memberCareerAuthority!=true}">학력 정보는 본인, 팀장, 부서장, 본부장만 조회 가능합니다.</c:if>
						<c:if test="${memberCareerAuthority==true}">							
							<ul>
								<li class="th_stitle04 mB10">학력</li>
							</ul>
							<div id="scholarListDiv" class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>학력</caption>
			                    <colgroup>
			                    	<col width="50px" />
			                    	<col width="180px" />
			                    	<col width="px" />
			                    	<col width="200px" />
			                    	<col width="80px" />
			                    </colgroup>
			                    <thead>
		                    		<tr> 
										<th scope="col">번호</th>
										<th scope="col">학교</th>
										<th scope="col">전공</th>
										<th scope="col">기간</th>
										<th scope="col">졸업유무</th>
										<!--td class="title">이동</td -->
									</tr>
		                    	</thead> 
			                    <tbody>
			                    	<c:forEach items="${careerEdu}" var="edu" varStatus="c">
										<tr> 
											<td class="txt_center" >${c.count }</td>
											<td class="txt_center">${edu.schoolName}</td>
											<td class="txt_center">${edu.major}</td>
											<td class="txt_center">
												<c:if test="${edu.stDt==null && edu.edDt==null}">미입력</c:if>												
						                    	<c:if test="${edu.stDt!=null}">					                    	
							                    	${fn:substring(edu.stDt,0,4)}.${fn:substring(edu.stDt,4,6)}.${fn:substring(edu.stDt,6,8)} ~
							                    </c:if>
							                    <c:if test="${edu.stDt==null && edu.edDt!=null}">~</c:if>							
												<c:if test="${edu.edDt!=null}">													
													${fn:substring(edu.edDt,0,4)}.${fn:substring(edu.edDt,4,6)}.${fn:substring(edu.edDt,6,8)}
						                    	</c:if>												
											</td>
											<td class="txt_center">
												<c:if test="${edu.graduationYn=='graduation'}">졸업</c:if>
												<c:if test="${edu.graduationYn=='leave'}">중퇴</c:if>
												<c:if test="${edu.graduationYn=='stop'}">휴학</c:if>
												<c:if test="${edu.graduationYn=='being'}">재학</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								</table>
							</div>														
						</c:if>
							
							
							
							<ul>
								<li class="th_stitle04 mB10">교육</li>
							</ul>
							<div id="scholarListDiv" class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>교육</caption>
			                    <colgroup>
			                    	<col width="50px" />
			                    	<col width="180px" />
			                    	<col width="px" />
			                    	<col width="200px" />
			                    	<col width="80px" />
			                    </colgroup>
			                    <thead>
		                    		<tr> 
										<th scope="col">번호</th>
										<th scope="col">교육과정명</th>
										<th scope="col">교육기관</th>
										<th scope="col">교육기간</th>
										<th scope="col">수료번호</th>
									</tr>
		                    	</thead> 
			                    <tbody>
									<c:forEach items="${careerTrain}" var="train" varStatus="c">
										<tr> 
											<td class="txt_center" >${c.count }</td>
											<td class="txt_center">${train.trainNm}</td>
											<td class="txt_center">${train.trainOrgNm}</td>
											<td class="txt_center">													
						                    	<c:if test="${train.stDt==null && train.edDt==null}">미입력</c:if>												
						                    	<c:if test="${train.stDt!=null}">					                    	
							                    	${fn:substring(train.stDt,0,4)}.${fn:substring(train.stDt,4,6)}.${fn:substring(train.stDt,6,8)} ~
							                    </c:if>
							                    <c:if test="${train.stDt==null && edu.edDt!=null}">~</c:if>							
												<c:if test="${train.edDt!=null}">													
													${fn:substring(train.edDt,0,4)}.${fn:substring(train.edDt,4,6)}.${fn:substring(train.edDt,6,8)}
						                    	</c:if>														
											</td>
											<td class="txt_center">${train.trainNo}</td>
										</tr>
									</c:forEach>
								</tbody>
								</table>
							</div>
														
<!--							<td class="txt_center bc01">자 격 증</td> 	<td class="pL10" colspan="3">${career.license}</td>-->
		                    		
							<ul>
								<li class="th_stitle04 mB10">자격증</li>
							</ul>
							<div id="scholarListDiv" class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>자격증</caption>
			                    <colgroup>
			                    	<col width="50px" />
			                    	<col width="180px" />
			                    	<col width="px" />
			                    	<col width="200px" />
			                    	<col width="80px" />
			                    </colgroup>
			                    <thead>
		                    		<tr> 
										<th scope="col">번호</th>
										<th scope="col">종목 및 등급</th>
										<th scope="col">발급기관</th>
										<th scope="col">자격등록번호</th>
										<th scope="col">합격년월일</th>
										<!--td class="title">이동</td -->
									</tr>
		                    	</thead> 
			                    <tbody>									
									<c:forEach items="${careerLicense}" var="license" varStatus="c">
										<tr> 
											<td class="txt_center" >${c.count }</td>
											<td class="txt_center">${license.licenseNm}</td>
											<td class="txt_center">${license.issuedOrg}</td>
											<td class="txt_center">${license.licenseNo}</td>
											<td class="txt_center">
<!--											${license.passedDate}-->
												<c:if test="${license.passedDate==null }">미입력</c:if>												
						                    	<c:if test="${license.passedDate!=null}">					                    	
							                    	${fn:substring(license.passedDate,0,4)}.${fn:substring(license.passedDate,4,6)}.${fn:substring(license.passedDate,6,8)}
							                    </c:if>							                   
											</td>
										</tr>
									</c:forEach>
								</tbody>
								</table>
							</div>
							
							<ul>
								<li class="th_stitle04 mB10">근무처 경력 </li>
							</ul>
							<div id="workListDiv" class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>근무처 경력</caption>
			                    <colgroup>
			                    	<col width="50px" />
			                    	<col width="180px" />
			                    	<col width="px" />
			                    	<col width="80px" />
			                    	<col width="100px" />
			                    	<col width="80px" />
			                    </colgroup>
			                    <thead>
		                    		<tr>
		                    			<th scope="col">번호</th>
										<th scope="col">회사명</th>
										<th scope="col">근무기간</th>
										<th scope="col">담당업무</th>
										<th scope="col">부서</th>
										<th scope="col">직위</th>
									</tr>
		                    	</thead>
			                    <tbody>									
									<c:forEach items="${careerWork}" var="work" varStatus="c">
										<tr> 
											<td class="txt_center" >${c.count }</td>
											<td class="txt_center">${work.companyNm}</td>
											<td class="txt_center">												
						                    	<c:if test="${work.stDt==null && work.edDt==null}">미입력</c:if>												
						                    	<c:if test="${work.stDt!=null}">					                    	
							                    	${fn:substring(work.stDt,0,4)}.${fn:substring(work.stDt,4,6)}.${fn:substring(work.stDt,6,8)} ~
							                    </c:if>
							                    <c:if test="${work.stDt==null && work.edDt!=null}">~</c:if>							
												<c:if test="${work.edDt!=null}">													
													${fn:substring(work.edDt,0,4)}.${fn:substring(work.edDt,4,6)}.${fn:substring(work.edDt,6,8)}
						                    	</c:if>									
											</td>											
											<td class="txt_center">${work.task}</td>											
											<td class="txt_center">${work.orgnztNm}</td>											
											<td class="txt_center">${work.rankNm}</td>
										</tr>											
									</c:forEach>
								</tbody>
								</table>
							</div>
							
							<ul>
								<li class="th_stitle04 mB10">기술경력</li>
							</ul>
							<div id="workListDiv" class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>경력</caption>
			                    <colgroup>
			                    	<col width="50px" />
			                    	<col width="180px" />
			                    	<col width="px" />
			                    	<col width="80px" />
			                    	<col width="100px" />
			                    	<col width="80px" />
			                    </colgroup>
			                    <thead>
		                    		<tr>
		                    			<th scope="col">번호</th>
										<th scope="col">사업명</th>
										<th scope="col">참여기간</th>
										<th scope="col">담당업무</th>
										<th scope="col">발주처</th>
										<th scope="col">비고</th>
									</tr>
		                    	</thead> 
			                    <tbody>
			                    	<c:forEach items="${careerSkill}" var="skill" varStatus="c">
										<tr> 
											<td class="txt_center">${c.count }</td>
											<td class="pL10" >${skill.prjNm}</td>
											<td class="txt_center" >
<!--											${skill.stDt} ~ ${skill.edDt}-->
												<c:if test="${skill.stDt==null && skill.edDt==null}">미입력</c:if>												
						                    	<c:if test="${skill.stDt!=null}">					                    	
							                    	${fn:substring(skill.stDt,0,4)}.${fn:substring(skill.stDt,4,6)}.${fn:substring(skill.stDt,6,8)} ~
							                    </c:if>
							                    <c:if test="${skill.stDt==null && skill.edDt!=null}">~</c:if>							
												<c:if test="${skill.edDt!=null}">													
													${fn:substring(skill.edDt,0,4)}.${fn:substring(skill.edDt,4,6)}.${fn:substring(skill.edDt,6,8)}
						                    	</c:if>	
											</td>
											<td class="txt_center" >${skill.task}</td>
											<td class="txt_center" >${skill.clientNm}</td>
											<td class="txt_center" >${skill.note}</td>
										</tr>										
									</c:forEach>
								</tbody>
								</table>
							</div>
							
							
						<!-- 게시판 끝  -->
						</form:form>
						
						
						<form name="frm" method="POST" action="<c:url value='${rootPath}/member/selectMemberList.do' />">
							<input type="hidden" name="no" value="${info.no }"/>							
<!--							<input type="hidden" name="workSt" value="W,L"/>-->
							<input type="hidden" name="workSt" value="${searchVO.workSt}"/>
							<input type="hidden" name="rankIdFrom" value="${searchVO.rankIdFrom}"/>
							<input type="hidden" name="rankIdTo" value="${searchVO.rankIdTo}"/>
							<input type="hidden" name="careerFrom" value="${searchVO.careerFrom}"/>
							<input type="hidden" name="careerTo" value="${searchVO.careerTo}"/>
							<input type="hidden" name="searchSkill" value="${searchVO.searchSkill}"/>
							<input type="hidden" name="searchLicense" value="${searchVO.searchLicense}"/>
							<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>								
						</form>
	
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                		
		                	<c:if test="${user.no == info.userNo || user.admin}">
		                	<!-- 수정 버튼 -->
		                		<a href="${rootPath}/member/updtCareerView.do?no=${info.no }"><img src="${imagePath}/btn/btn_modify.gif"/></a>
<!--			                	<a href="javascript:modifyCareer();"><img src="${imagePath}/btn/btn_modify.gif"/></a>-->
<!--		                		<a href="javascript:deleteCareer();"><img src="${imagePath}/btn/btn_delete.gif"/></a>-->
		                	</c:if>
		                	<!-- 목록 버튼 -->
		                	<a href="${rootPath}/member/selectMemberCareerList.do"><img src="${imagePath}/btn/btn_list.gif"/></a>
<!--		                	<a href="javascript:listCareer();"><img src="${imagePath}/btn/btn_list.gif"/></a>-->
							<!-- 인쇄 버튼 -->
							<a href="javascript:popPrint();"><img src="${imagePath}/btn/btn_print.gif"/></a>
							<!-- 엑셀다운 버튼 -->
		                	<c:if test="${user.isHmdev == 'Y'}">
                				<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
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
