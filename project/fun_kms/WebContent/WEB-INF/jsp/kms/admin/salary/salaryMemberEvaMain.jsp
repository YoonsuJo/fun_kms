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
		
	//if ((chk[0].checked || chk[1].checked) == false) {
	//	alert("재직자 혹은 퇴직자를 선택해주세요.");
	//	return;
	//}
	document.frm.action = "<c:url value='${rootPath}/admin/salary/memberEvaluationMain.do'/>";	
	document.frm.submit();
}
function searchAll() {
	//document.frm.workSt[0].checked = true;
	//document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.action = "<c:url value='${rootPath}/admin/salary/memberEvaluationMain.do'/>";
	document.frm.submit();
}
function clickOrderBy(n){
	document.frm.orderBy.value = n;
	search();
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

var ajaxProcessing = false;

function userSalaryMove(pos)
{
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;	
	search();
}

function userSalaryMoveOld(pos)
{
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;
	
	var searchCondition = document.frm.searchConditionH.value;	
	var rankId = document.frm.rankId.value;
	var searchOrgId = document.frm.searchOrgId.value;
	var searchOrgNm = document.frm.searchOrgNm.value;
	var searchUserNm = document.frm.searchUserNm.value;	
	var orderBy  = document.frm.orderByH.value;	

	$.post("/ajax/admin/salary/memberEvaluationMain.do?year=" + userYear + "&searchCondition=" + searchCondition + "&rankId=" + rankId 
			+ "&searchOrgId=" + searchOrgId + "&searchOrgNm=" + searchOrgNm + "&searchUserNm=" + searchUserNm + "&orderBy=" + orderBy
			, function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			userYear = preYear;			
		} else {
			$('#userSalaryD').html(data);
			$('#userSalaryYearS').html(userYear+"년 ");
			ajaxProcessing = false;
		}
	});
}

function editUserSalary(userNo, target)
{	
	var eva1Nm = document.getElementById('eva1Nm'+userNo).value;
	var score1 = document.getElementById('score1'+userNo).value;
	var eva2Nm = document.getElementById('eva2Nm'+userNo).value;
	var score2 = document.getElementById('score2'+userNo).value;
	var grade = document.getElementById('grade'+userNo).value;
	var userName = document.getElementById('userName'+userNo).value;
	grade = grade.toUpperCase();
	
	if(isNaN(score1) || isNaN(score2)){
					
	 		//alert("점수에 올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");
	 		msg = "점수에 올바르지 않은 값이 작성되어 있습니다.\n숫자 형식만 입력하여 주세요";
	 		displayMessageSimple(msg, "txtB_grey", target);	 		
	 		return;
	}
	
	if(ajaxProcessing == false){
		ajaxProcessing = true;
		
		$.post("/ajax/admin/salary/userSalaryMemberEvaU.do?year=" + userYear + "&userNo=" + userNo 
				+ "&eva1Nm=" + encodeURIComponent(eva1Nm) + "&score1=" + score1  + "&eva2Nm=" + encodeURIComponent(eva2Nm) + "&score2=" + score2  + "&grade=" + grade 
				,function(data){
				if(data.indexOf("success"))	{
					displayMessageSimple(userYear + "년 " + userName + " 사원의 평가정보를 수정했습니다.", "txtB_grey", target);					
					//userSalaryMove(0);
					ajaxProcessing = false;
				} else {
					displayMessageSimple(userYear + "년 " + userName + " 사원의 평가정보 수정에 실패했습니다", "txtB_grey", target);					
					ajaxProcessing = false;				
				}
		});

	} else{
		displayMessageSimple("입력 처리중입니다", "txtB_grey", target, "short");
		return;
	}
}
//최종점수 계산
function calRate(userNo){
	var score1 = document.getElementById('score1'+userNo).value *1;
	var score2 = document.getElementById('score2'+userNo).value *1;	
	
	var avg = Math.floor((score1 + score2)/2 * 10) / 10;	
	document.getElementById('grade'+userNo).value = avg;
}
function editUserSalary2(userNo, target){
	target = document.getElementById(target);
	editUserSalary(userNo, target);
}
function enterUserSalary(userNo, target){
	if(inputEnter()){		
		editUserSalary(userNo, target);
	}
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
							<li class="stitle">사원평가관리</li>
						</ul>
					</div>
					
					<span class="stxt">
						사원평가관리 화면입니다.
						사원연봉관리 기능에서 연봉 데이터를 먼저 입력하면 신규데이터가 자동 생성됩니다.<br>
						1차 2차 평가자를 입력해야 평가점수가 입력됩니다.<br>
						평가점수는 3자리 숫자이며 최종점수는 두 점수의 평균으로 자동계산됩니다.
					</span>
	
					<!-- S: section -->
					<div class="section01">	
		                				
						<!-- 게시판 시작 -->
						<p class="th_stitle mB10">사원평가관리</p>
												
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
							<jsp:include page="${jspPath}/admin/salary/include/userSalaryMemberEva.jsp"></jsp:include>
						</div>													
						<!-- 게시판 끝  -->
							
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
