<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search() {
	var chk = document.frm.workSt;

	if ((chk[0].checked || chk[1].checked) == false) {
		alert("재직자 혹은 퇴직자를 선택해주세요.");
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectMemberList.do'/>";	
	document.frm.submit();
}
function searchAll() {
	document.frm.workSt[0].checked = true;
	document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectMemberList.do'/>";
	document.frm.submit();
}
function view(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectMember.do'/>";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	if (n == 0) {
		document.frm.rankId.style.display = "";
	}
	else if (n == 1) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "";
		document.getElementById("orgNm").style.display = "none";
		document.getElementById("orgTree").style.display = "none";
	}
	else if (n == 2) {
		document.frm.rankId.style.display = "none";
		document.getElementById("usrNm").style.display = "none";
		document.getElementById("orgNm").style.display = "";
		document.getElementById("orgTree").style.display = "";
	}
}
function excelDown() {
	document.frm.action = "/admin/member/selectMemberListExcel.do";
	document.frm.submit();
}
function modify(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/admin/member/updtMemberView.do' />";
	document.frm.submit();
}
function positionHistory(no) {
	document.frm.no.value = no;
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectPositionHistoryList.do' />";
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
		<div id="admin_contents2">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">사용자 인사목록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">						
	
						<form name="frm" method="POST" action="${rootPath}/admin/member/selectMemberList.do" onsubmit="search(); return false;">
						<input type="hidden" name="no" value="0"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
										검색범위 :
										<input type="checkbox" name="workSt" value="W,L" <c:if test="${searchVO.working}">checked="checked"</c:if> /> 재직자
										<span class="pL7"></span>
										<input type="checkbox" name="workSt" value="R" <c:if test="${searchVO.retired}">checked="checked"</c:if> /> 퇴직자
									</td>
								</tr>
								<tr>
									<td class="search_right">
										<label><input type="radio" name="searchCondition" value="0" onclick="selRadio(0);" <c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>>직급</label>
										<select name="rankId" class="span_3">
											<option value="">선택</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankId}">selected="selected"</c:if> ><c:out value="${rank.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" name="searchCondition" value="1" onclick="selRadio(1);" <c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>>사용자</label><span class="pL7"></span>
										<label><input type="radio" name="searchCondition" value="2" onclick="selRadio(2);" <c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>>부서</label>
										<input type="text" name="searchUserNm" id="usrNm" class="search_txt02 userNameAuto" value="${searchVO.searchUserNm}" />
										<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" onfocus="orgGen('orgNm','orgId',0);" readonly="readonly" style="display:none"/>
										<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);" style="display:none"/>
										<input type="image" src="${imagePath}/admin/btn/btn_search02.gif" />
										<a href="javascript:searchAll();"><img src="${imagePath}/admin/btn/btn_allview.gif" alt="전체보기"/></a>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
						</form>
						<script>selRadio("${searchVO.searchCondition}");</script>
		                <!-- 상단 검색창 끝 -->
		                
		                <!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->	
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">사원조회(검색된 사용자 : ${fn:length(resultList)}명)</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col5" />
								<col class="col30" />
								<col class="col60" />
								<col class="col60" />
								<col class="col90" />
								<col class="col70" />
								
								<col class="col80" />
								<col class="col60" />
								<col class="col80" />
								<col class="col70" />								
								<col width="px" />		
														
								<col class="col40" />								
								<col class="col50" />
								<col class="col60" />								
								<col class="col30" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">사번</th>
								<th scope="col">이름</th>
								<th scope="col">초성</th>
								<th scope="col">나이</th>
								<th scope="col">ID</th>
								
								<th scope="col">직급</th>
								<th scope="col">진급년도</th>
								<th scope="col">경력</th>
								<th scope="col">입사전<br>인정경력</th>								
								<th scope="col">소속부서</th>
								
								<th scope="col">상태</th>																
								<th scope="col">차량</th>
								<th scope="col">학력</th>																								
								<th scope="col">수정</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result">
									<tr>
										<td class="txt_center"></td>
<!--										사번-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.sabun}"/></a>
										</td>
<!--										이름-->
										<td class="txt_center">											
											<print:user userNo="${result.no}" userNm="${result.userNm}"/>
										</td>
<!--										초성-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											${result.initial}</a>
										</td>
<!--										나이-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.agePrint}" /></a>
										</td>
<!--										ID-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.userId}"/></a>
										</td>
<!--										직급-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.rankNm}"/> <c:out value="${result.promotionPeriodPrint}" /></a>
										</td>										
<!--										진급년도-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											${result.promotionYear}</a>
										</td>
<!--										경력-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.workPeriodPrint}"/></a>
										</td>										
<!--										입사전 인정경력-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.careerMonthPrint}"/></a>
										</td>
<!--										소속부서-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<print:org orgnztNm="${result.orgnztNm}" orgnztId="${result.orgnztId}"/></a>
										</td>
<!--										상태-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											<c:out value="${result.workStPrint}"/></a>
										</td>
<!--										차량-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
											${result.carOwnPrint}</a>
										</td>
<!--										학력-->
										<td class="txt_center">
											<a href="javascript:view('<c:out value="${result.no}"/>');">
<!--											<c:forEach items="${degreeCode}" var="degree">								        		 -->
<!--								        		<c:if test="${result.degree == degree.code}">-->
<!--								        			<c:out value="${degree.codeNm}" />-->
<!--								        		</c:if>								        		-->
<!--							        		</c:forEach>	-->
											${result.degreePrint}</a>
										</td>
<!--										수정-->
										<td class="txt_center">
											<a href="javascript:modify('${result.no}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="javascript:positionHistory('${result.no}');"><img src="${imagePath}/btn/btn_plus.gif"/></a>
										</td>
										<td class="txt_center"></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="${rootPath}/admin/member/insertMemberView.do"><img src="${imagePath}/btn/btn_add.gif"/></a>
		                	<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
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
