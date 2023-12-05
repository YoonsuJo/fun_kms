<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var rankYear = ${year};
var userYear = ${year}; 

$(document).ready(function(){
	
});

function search() {
	
	var chk = document.frm.workSt;
	//var rankId = document.frm.rankId.value;
		
	//if ((chk[0].checked || chk[1].checked) == false) {
	//	alert("재직자 혹은 퇴직자를 선택해주세요.");
	//	return;
	//}
	document.frm.action = "<c:url value='${rootPath}/admin/salary/selectEmpContractList.do'/>";	
	document.frm.submit();
}
function searchAll() {
	//document.frm.workSt[0].checked = true;
	//document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.action = "<c:url value='${rootPath}/admin/salary/selectEmpContractList.do'/>";
	document.frm.submit();
}
function selRadio(n) {
	document.frm.searchCondition[n].checked = true;
	document.frm.searchConditionH.value = n;
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
function userSalaryMove(pos)
{
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;
	document.frm.action = "<c:url value='${rootPath}/admin/salary/selectEmpContractList.do'/>";	
	document.frm.submit();
}
function clickOrderBy(n){
	document.frm.orderBy.value = n;
	search();
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
							<li class="stitle">사원연봉계약서관리</li>
						</ul>
					</div>
					
					<span class="stxt">
						사원연봉계약서관리 화면입니다.<br>
						연봉관리자만 관련연봉관리 화면 모두와 연봉협상, 연봉계약서 조회가 가능합니다.						
					</span>
	
					<!-- S: section -->
					<div class="section01">	
										
						<!-- 게시판 시작 -->
						
						<p class="th_stitle mB10">사원연봉계약서관리</p>
												
						<form name="frm" method="POST" action="${rootPath}/admin/salary/memberEvaluationMain.do" onsubmit="search(); return false;">						
						<input type="hidden" name="year" id="year" value="${year}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchConditionH" id="searchConditionH" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="orderBy" id="orderBy" value="${searchVO.orderBy}"/>						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col width="120px"/>
								<col width="*"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="search_left"> 
										<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
										<span id="userSalaryYearS" class="option_txt">${year }년</span>
										<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
									</td>
									<td class="search_right">
										상태
										<select id="status" name="status" class="span_3" style="vertical-align:top;">
											<option value="">선택</option>
											<c:forEach items="${statusCode}" var="status">
												<option value="${status.code}" <c:if test="${status.code == searchVO.status}">selected="selected"</c:if> >
												<c:out value="${status.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="0" onclick="selRadio(0);" 
										<c:if test="${searchVO.searchCondition == 0}">checked="checked"</c:if>>직급</label>
										<select id="rankId" name="rankId" class="span_3" style="vertical-align:top;">
											<option value="">선택</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}" <c:if test="${rank.code == searchVO.rankId}">selected="selected"</c:if> >
												<c:out value="${rank.codeNm}"/></option>
											</c:forEach>
										</select><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="1" onclick="selRadio(1);" 
										<c:if test="${searchVO.searchCondition == 1}">checked="checked"</c:if>>사용자</label><span class="pL7"></span>
										<label><input type="radio" id="searchCondition" name="searchCondition" value="2" onclick="selRadio(2);" 
										<c:if test="${searchVO.searchCondition == 2}">checked="checked"</c:if>>부서</label>
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
						
						<div id="userSalaryD" class="boardList">
						
<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
	<caption>사원연봉결정</caption>
	<colgroup>
		<col width="px" />
		<col class="col50" />
		<col class="col60" />									
		<col class="col60" />
		<col class="col50" />
			
		<col class="col80" />
		<col class="col80" />
		<col class="col80" />											
		<col class="col80" />
						
		<col class="col30" />		
		<col class="col30" />
		<col class="col30" />
		<col class="col60" />
		
		<col class="col60" />
		<col class="col70" />
		
	</colgroup>
	<thead>	
		<tr>
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'org'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'org'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('org');">부서</a></th>									
		<th scope="col" 
			<c:if test="${searchVO.orderBy != 'name'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'name'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('name');">이름</a></th>
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'age'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'age'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('age');">나이</a></th>
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'degree'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'degree'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('degree');">학력</a></th>										
		<th scope="col"
			<c:if test="${searchVO.orderBy != 'rank'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rank'}">class="th_a2"</c:if> >
			<a href="javascript:clickOrderBy('rank');">직급</a></th>
				
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'workIn'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'workIn'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('workIn');">재직기간</a></span><br>
			<span 
			<c:if test="${searchVO.orderBy != 'work'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'work'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('work');">(총경력)</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salary'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salary'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salary');">당해연봉</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'salaryHope'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salaryHope'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salaryHope');">(희망연봉)</a></span></th>						
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'salarySuggest'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'salarySuggest'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('salarySuggest');">차년도연봉</a></span></th>										
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'increase'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'increase'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('increase');">인상금액</a></span><br>
			<span
			<c:if test="${searchVO.orderBy != 'rate'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'rate'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('rate');">(인상률)</a></span></th>	
			
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'score1'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'score1'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('score1');">1차<br>점수</a></span></th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'score2'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'score2'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('score2');">2차<br>점수</a></span></th>
		<th scope="col">최종<br>점수</th>
		<th scope="col">
			<span
			<c:if test="${searchVO.orderBy != 'status'}">class="th_a1"</c:if> 
			<c:if test="${searchVO.orderBy == 'status'}">class="th_a2"</c:if> >
				<a href="javascript:clickOrderBy('status');">상태</a></span></th>
				
		<th scope="col">연봉협상</th>
		<th scope="col">연봉계약서</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
			<tr>				
<!--				부서-->
				<td class="txt_center">${result.orgnztNm } </td>
<!--				이름-->
				<td class="txt_center">
					<print:user userNo="${result.userNo}" userNm="${result.userNm}"/>
				</td>
<!--				나이-->
				<td class="txt_center">
					만${result.age }세<br>
					(${result.ageKor }세) 
				</td>
<!--				학력-->
				<td class="txt_center">
				<c:forEach items="${degreeCode}" var="degree">								        		 
					<c:if test="${result.degree == degree.code}">
						<c:out value="${degree.codeNm}" />
					</c:if>								        		
				</c:forEach>									
				</td>
<!--				직급-->
				<td class="txt_center">
					${result.rankNm } <br>
					<c:if test="${year < result.promotionYear - 1}">진급이전</c:if>
					<c:if test="${year == result.promotionYear - 1}">진급예정</c:if>
					<c:if test="${year >= result.promotionYear}">${year - result.promotionYear + 1}년차 </c:if>
				</td>
<!--				입사일-->
<!--				<td class="txt_center">				-->
<!--					${fn:substring(result.compinDt,0,4)}년-->
<!--					<br>-->
<!--					${fn:substring(result.compinDt,4,6)*1}월-->
<!--					${fn:substring(result.compinDt,6,8)*1}일									  -->
<!--				</td>										-->
<!--				재직기간 총경력-->
				<td class="txt_center">
				<c:if test="${result.workYearIn > 0}">${result.workYearIn}년</c:if>${result.workMonthIn}개월<br>
				(<c:if test="${result.workYear > 0}">${result.workYear}년</c:if>${result.workMonth}개월)
				</td>
<!--				당해연봉 희망연봉-->
				<td class="txt_center userSalary1">
				<input type="hidden" name="status${result.userNo }" id="status${result.userNo }" value="${result.status}" />
				<input type="hidden" name="salaryName${result.userNo }" id="salaryName${result.userNo }" value="${result.userNm}" />
				<input type="hidden" name="salaryReal${result.userNo }" id="salaryReal${result.userNo }" value="<print:currency cost='${result.salaryReal }'/>"/>
				<input type="hidden" name="salaryHope${result.userNo }" id="salaryHope${result.userNo }" value="<print:currency cost='${result.salaryHope }'/>"/>
				<print:currency cost='${result.salaryReal }'/><br/>(<print:currency cost='${result.salaryHope }'/>)
				</td>
<!--				차년도연봉-->
				<td class="txt_center userSalary3">
				<print:currency cost='${result.salarySuggest }'/>				
				</td>
<!--				인상률-->
				<td class="txt_center">
				<print:currency cost='${result.salarySuggest - result.salaryReal }'/><br>
				(${result.increaseRate }%)
				</td>
<!--				1차 평가자점수-->
				<td class="txt_center">
				<print:user userNo="${result.eva1}" userNm="${result.score1 } "/></td>
<!--				2차 평가자점수-->
				<td class="txt_center">
				<print:user userNo="${result.eva2}" userNm="${result.score2 } "/></td>
<!--				평가등급-->
				<td class="txt_center">${result.grade }</td>
<!--				상태-->
				<td class="txt_center">
					<c:forEach items="${statusCode}" var="status">					 
						<c:if test="${status.code == result.status}">
							${status.codeNm }
						</c:if>					
					</c:forEach>
				</td>
<!--				연봉협상-->
				<td class="txt_center">												
					<a href="/member/selectMemberSalaryNego.do?userNo=${result.userNo}&year=${year }" target="_empContract"> 
					<img  class="cursorPointer" id="acceptBtn" name="acceptBtn"	src="${imagePath}/btn/btn_ok.gif"/>
					</a>					
				</td>
<!--				연봉계약서-->
				<td class="txt_center">												
					<a href="/member/selectEmpContract.do?userNo=${result.userNo}&year=${year }" target="_empContract"> 
					<img  class="cursorPointer" id="acceptBtn" name="acceptBtn"	src="${imagePath}/btn/btn_ok.gif"/>
					</a>					
				</td>
			</tr>									
		</c:forEach>									
	</tbody>
	</table>
						</div>													
						<!-- 게시판 끝  -->
						
						<!-- 페이징 시작 -->
						<div class="paginate">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
						</div>					
						<!-- 페이징 끝 -->
						
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
