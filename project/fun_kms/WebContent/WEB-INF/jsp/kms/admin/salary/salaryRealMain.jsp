<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var rankYear =${year};
var userYear =${year}; 

$(document).ready(function(){	
});
function search() {
	
	var chk = document.frm.workSt;
			
	if ((chk[0].checked || chk[1].checked) == false) {
		alert("재직자 혹은 퇴직자를 선택해주세요.");
		return;
	}
	document.frm.action = "<c:url value='${rootPath}/admin/salary/salaryRealMain.do'/>";	
	document.frm.submit();
}
function searchAll() {
	//document.frm.workSt[0].checked = true;
	//document.frm.workSt[1].checked = false;
	selRadio(0);
	document.frm.rankId.value = "";
	document.frm.action = "<c:url value='${rootPath}/admin/salary/salaryRealMain.do'/>";
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
function rankSalaryMove(pos) {
	var preYear = rankYear;
	rankYear = rankYear + pos;
	
	$.post("/ajax/admin/salary/rankSalaryRealAjax.do?year=" + rankYear, function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			rankYear = preYear;			
		} else {
			$('#rankSalaryD').html(data);
			$('#rankSalaryYearS').html(rankYear+"년 ");			
		}
	});
	ajaxProcessing = false;
}
function userSalaryMove(pos) {
	var preYear = userYear;
	userYear = userYear + pos;
	document.frm.year.value = userYear;
	search();	
}
function userSalaryMoveOld(pos) {
	var preYear = userYear;
	userYear = userYear + pos;
	
	$.post("/ajax/admin/salary/userSalaryRealAjax.do?year=" + userYear, function(data){
		if(data.indexOf("failToLoad")>=0) {
			alert("해당년도 연봉테이블이 작성되어있지 않습니다");
			userYear = preYear;		
		} else {
			$('#userSalaryD').html(data);
			$('#userSalaryYearS').html(userYear+"년 ");			
		}
	});
	ajaxProcessing = false;
}
function editRankSalary(rankCode, target) {	
	var rankName = document.getElementById('rankName'+rankCode).value;
	var salary = document.getElementById('salary'+rankCode).value;
	salary = salary.replace(/,/gi,"");
	//var raiseRate = document.getElementById('raiseRate'+rankCode).value;
	//raiseRate = raiseRate.replace(/,/gi,"");
	var yearDiff = document.getElementById('yearDiff'+rankCode).value;
	yearDiff = yearDiff.replace(/,/gi,"");	
	var gradeDiff = document.getElementById('gradeDiff'+rankCode).value;
	gradeDiff = gradeDiff.replace(/,/gi,"");
	
	if(ajaxProcessing == false){
		ajaxProcessing = true;
			
		$.post("/ajax/admin/salary/rankSalaryRealU.do?year=" + rankYear + "&rankCode=" + rankCode + "&salary=" + salary 
				+ "&yearDiff=" + yearDiff + "&gradeDiff=" + gradeDiff //+ "&raiseRate=" + raiseRate  
				,function(data){
					if(data.indexOf("success"))	{	
						displayMessageSimple(rankName+ " 직급 기준연봉 정보를 수정했습니다", "txtB_grey", target);
						//rankSalaryMove(0);
					} else {					
						displayMessageSimple(rankName+ " 직급 기준연봉 정보 수정에 실패했습니다", "txtB_grey", target);						
					}
		});	
		ajaxProcessing = false;
	} else{
		displayMessageSimple("입력 처리중입니다", "txtB_grey", target, "short");
		return;
	}
}
var ajaxProcessing = false;

function editUserSalary(userNo, target) {
	var salaryReal = document.getElementById('salaryReal'+userNo).value;
	var salaryHope = document.getElementById('salaryHope'+userNo).value;
	var salarySuggest = document.getElementById('salarySuggest'+userNo).value;
	var salaryName = document.getElementById('salaryName'+userNo).value;
	salaryReal = salaryReal.replace(/,/gi,"");
	salaryHope = salaryHope.replace(/,/gi,"");
	salarySuggest = salarySuggest.replace(/,/gi,"");
	var carCost = document.getElementById('carCost'+userNo).value;
	var mealCost = document.getElementById('mealCost'+userNo).value;
	var babyCost = document.getElementById('babyCost'+userNo).value;
	var communicationCost = document.getElementById('communicationCost'+userNo).value;
	var note = document.getElementById('note'+userNo).value;
	
	var hopeNote = document.getElementById('hopeNote'+userNo).value;
	var adminNote = document.getElementById('adminNote'+userNo).value;
	
	//TBL_USERINFO 데이터 속성
	var promotionYear = document.getElementById('promotionYear'+userNo).value;
	var careerMonthYear = document.getElementById('careerMonthYear'+userNo).value * 1;
	var careerMonthMonth = document.getElementById('careerMonthMonth'+userNo).value * 1;	
	var careerMonth = careerMonthYear * 12 + careerMonthMonth;
	var degree = document.getElementById('degree'+userNo).value;
	
	carCost = carCost.replace(/,/gi,"");
	mealCost = mealCost.replace(/,/gi,"");
	babyCost = babyCost.replace(/,/gi,"");
	communicationCost = communicationCost.replace(/,/gi,"");

	var status = document.getElementById('status'+userNo).value;
	if(status==null || status=='')
		status = '1';
	
	//alert(carCost + "      " + mealCost + "      ");	
	
	if(salaryReal==null || salaryReal=="" || isNaN(salaryReal)
		|| salaryHope==null || salaryHope=="" || isNaN(salaryHope)
		|| salarySuggest==null || salarySuggest=="" || isNaN(salarySuggest) ){
			
	 	//alert("올바르지 않은 값이 작성되어 있습니다. 숫자 형식만 입력하여 주십시오");	 	
	 	msg = "올바르지 않은 값이 작성되어 있습니다.\n숫자 형식만 입력하여 주세요";
	 	displayMessageSimple(msg, "txtB_grey", target);	 	
	 	return;
	}
	
	if(ajaxProcessing == false){
		ajaxProcessing = true;
		
		$.post("/ajax/admin/salary/userSalaryRealU.do?year=" + userYear + "&userNo=" + userNo 
				+ "&salaryReal=" + salaryReal + "&salaryHope=" + salaryHope  + "&salarySuggest=" + salarySuggest 
				+ "&promotionYear=" + promotionYear + "&degree=" + degree  + "&careerMonth=" + careerMonth 
				+ "&carCost=" + carCost + "&mealCost=" + mealCost + "&babyCost=" + babyCost +"&communicationCost=" + communicationCost + "&status=" + status + "&note=" + encodeURIComponent(note) + "&hopeNote=" + encodeURIComponent(hopeNote)
				+ "&hopeNote=" + encodeURIComponent(hopeNote) + "&adminNote=" + encodeURIComponent(adminNote)
				,function(data){ 
				if(data.indexOf("success"))	{
					displayMessageSimple(userYear + "년 " + salaryName + " 님의 연봉정보를 수정했습니다", "txtB_grey", target);
					//userSalaryMove(0);
					ajaxProcessing = false;
				} else {
					displayMessageSimple(userYear + "년 " + salaryName + " 님의 연봉정보 수정에 실패했습니다", "txtB_grey", target);
					ajaxProcessing = false;
				}
		});
	} else{
		displayMessageSimple("입력 처리중입니다", "txtB_grey", target, "short");
		return;
	}
}
//model 단에서 받는게 int라서 21억까지만 들어감
function inputjsMakeCurrency(name){	
	var input = document.getElementById(name);	
	
	if( ((event.keyCode > 47) && (event.keyCode < 58))
		|| ((event.keyCode > 95) && (event.keyCode < 106)) ) {
		jsMakeCurrency(input);
	} 
	//alert(event.keyCode);
	if((event.keyCode > 64) && (event.keyCode < 91)) {
		event.returnValue = false;
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
							<li class="stitle">연봉 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle mB10">직급별 기준연봉</p>
						
						<!-- 날짜 선택창 시작 -->
                 	    <div class="scheduleDate mB10">
	                		<img id="rankSalaryMonthBackB" class="pR10 cursorPointer" onclick="javascript:rankSalaryMove(-1);" 
	                		src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
	                		<span class="option_txt" id="rankSalaryYearS">${year}년 </span>
							<img id="rankSalaryYearForwardB" class="pL10 cursorPointer" onclick="javascript:rankSalaryMove(+1);"  
							src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
						</div>	
	        		    <!-- 날짜 선택창 끝 -->
	        		    
						<div id="rankSalaryD" class="boardList mB20">
							<jsp:include page="${jspPath}/admin/salary/include/rankSalaryReal.jsp"></jsp:include>
						</div>
						
						<p class="th_stitle mB10">개인별 연봉</p>
													        		    
	        		    <form name="frm" method="POST" action="${rootPath}/admin/salary/salaryRealMain.do" onsubmit="search(); return false;">						
						<input type="hidden" name="year" id="year" value="${year}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchConditionH" id="searchConditionH" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="orderBy" id="orderByH" value="${searchVO.orderBy}"/>						
	        		    <!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>
								<col width="300px"/>
								<col width="*"/>
							</colgroup>
							<tbody>
								<tr>							
									<td class="search_left"> 
										<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
				                		<span id="userSalaryYearS" class="option_txt">${year }년</span>
										<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
										검색범위 :
										<input type="checkbox" name="workSt" value="W,L" <c:if test="${searchVO.working}">checked="checked"</c:if> /> 재직자
										<span class="pL7"></span>
										<input type="checkbox" name="workSt" value="R" <c:if test="${searchVO.retired}">checked="checked"</c:if> /> 퇴직자
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
	        		    
						<div id="userSalaryD" class="boardList03">
							<jsp:include page="${jspPath}/admin/salary/include/userSalaryReal.jsp"></jsp:include>
						</div>
						
						<br>
						재직중인 사원은 모두 표시되니 데이터 입력후 수정버튼을 누르면 신규데이터도 입력됩니다.<br>
						연봉데이터를 입력할 때 사원평가 데이터도 같이 생성됩니다.<br>
						즉 사원평가 데이터를 생성하려면 먼저 연봉데이터를 입력해야합니다.<br>
						사원평가 데이터가 입력되어야 사원연봉결정 메뉴에 데이터가 나옵니다.
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

<!-- foor hidden dialog -->
<div id="tab1">
</div>
</body>
</html>
