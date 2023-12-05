<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="MemberCareer" staticJavascript="false"	xhtml="true" cdata="false" />
<script>

var updateProcess = false;
function updt() {

	
	if(updateProcess){
		return;
	}
	updateProcess = true;

	//유효성 검사
	if (!validateMemberCareer(document.memberCareerVO)) {
		updateProcess = false; 
		return;
	}
	
	var form = $('#memberCareerVO');
	//학력
	var educationVO = $('#memberCareerVO').toObject({mode: 'first'})['educationArray'];
	form.find("input[name=jsonEducationString]").val(escape(JSON.stringify(educationVO)));

	if(escape(JSON.stringify(educationVO)) == 'undefined'){
		alert('학력을 입력해주세요');
		updateProcess = false; 
		return;
	}
	
	//교육
	var trainVO = $('#memberCareerVO').toObject({mode: 'first'})['trainArray'];
	form.find("input[name=jsonTrainString]").val(escape(JSON.stringify(trainVO)));
	//자격증
	var licenseVO = $('#memberCareerVO').toObject({mode: 'first'})['licenseArray'];
	form.find("input[name=jsonLicenseString]").val(escape(JSON.stringify(licenseVO)));
	//근무처 경력
	var workVO = $('#memberCareerVO').toObject({mode: 'first'})['workArray'];
	form.find("input[name=jsonWorkString]").val(escape(JSON.stringify(workVO)));
	//기술 경력
	var skillVO = $('#memberCareerVO').toObject({mode: 'first'})['skillArray'];
	form.find("input[name=jsonSkillString]").val(escape(JSON.stringify(skillVO)));

	//display:none hidden TR 삭제해야 오류 안남
	$("#educationTable tr:eq(1)").remove(); 
	$("#trainTable tr:eq(1)").remove();
	$("#licenseTable tr:eq(1)").remove();
	$("#workTable tr:eq(1)").remove();
	$("#skillTable tr:eq(1)").remove();
	document.memberCareerVO.action = "<c:url value='${rootPath}/member/updtMemberCareer.do'/>";
	document.memberCareerVO.submit();
}
function updtMember() {
	document.memberCareerVO.action = "<c:url value='${rootPath}/member/updtMemberView.do'/>";
	document.memberCareerVO.submit();
}
//상세정보
function view() {
	$("#educationTable tr:eq(1)").remove(); 
	$("#trainTable tr:eq(1)").remove();
	$("#licenseTable tr:eq(1)").remove();
	$("#workTable tr:eq(1)").remove();
	$("#skillTable tr:eq(1)").remove();
	document.memberCareerVO.action = "<c:url value='${rootPath}/member/selectMemberCareerDetail.do'/>";
	document.memberCareerVO.submit();
}
//목록으로 돌아가기 사용안함
function list() {
	$("#educationTable tr:eq(1)").remove(); 
	$("#trainTable tr:eq(1)").remove();
	$("#licenseTable tr:eq(1)").remove();
	$("#workTable tr:eq(1)").remove();
	$("#skillTable tr:eq(1)").remove();
	document.memberCareerVO.workSt.value = 'W,L';
	document.memberCareerVO.action = "<c:url value='${rootPath}/member/selectMemberCareerList.do'/>";
	document.memberCareerVO.submit();
}
//로우 카운트
var eduCnt = ${fn:length(careerEdu)};
var skillCnt = ${fn:length(careerSkill)};
var trainCnt = ${fn:length(careerTrain)};
var licenseCnt = ${fn:length(careerLicense)};
var workCnt = ${fn:length(careerWork)};
$(document).ready(function(){
    // 옵션추가 버튼 클릭시
    $("#addBtnEdu").click(function(){
        var addedDiv = $("#educationTable tr:eq(1)").clone();
        addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"educationArray[" + eduCnt + "]." + name); 			
		});
        addedDiv.show();
        $("#educationTable").append(addedDiv);
        eduCnt++;
        initialize(addedDiv);
    });
    
    $("#addBtnTrain").click(function(){
        var addedDiv = $("#trainTable tr:eq(1)").clone();
        addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"trainArray[" + trainCnt + "]." + name); 			
		});
        addedDiv.show();
        //$("#trainTable").append(addedDiv);
    	addedDiv.appendTo($('#trainTable'));
        //addedDiv.insertAfter($('#trainTr').last());
        trainCnt++;
        initialize(addedDiv);
    });

    $("#addBtnLicense").click(function(){
        var addedDiv = $("#licenseTable tr:eq(1)").clone();
        addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"licenseArray[" + licenseCnt + "]." + name); 			
		});
        addedDiv.show();
        $("#licenseTable").append(addedDiv);
    	//addedDiv.appendTo($('#licenseTable'));
        //addedDiv.insertAfter($('#licenseTr').last());
        licenseCnt++;
        initialize(addedDiv);
    });

    $("#addBtnWork").click(function(){
        var addedDiv = $("#workTable tr:eq(1)").clone();
        addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"workArray[" + workCnt + "]." + name); 			
		});
        addedDiv.show();
        $("#workTable").append(addedDiv);
    	//addedDiv.appendTo($('#licenseTable'));
        //addedDiv.insertAfter($('#licenseTr').last());
        workCnt++;
        initialize(addedDiv);
    });

    $("#addBtnSkill").click(function(){
    	var addedDiv = $("#skillTable tr:eq(1)").clone();
        addedDiv.find('[name]').each(function(idx,elm){
			var name = $(elm).attr('name');
			$(elm).attr('name',"skillArray[" + skillCnt + "]." + name); 			
		});
        addedDiv.show();
        $("#skillTable").append(addedDiv);
    	//addedDiv.appendTo($('#licenseTable'));
        //addedDiv.insertAfter($('#licenseTr').last());
        skillCnt++;
        initialize(addedDiv);
    });
    
 	//테이블 로우 삭제
 	$(".delBtnTr").click(function(){
		var deletedDiv = $(this).closest('tr');
		deletedDiv.remove();
	});

 	function initialize(target){
 		//테이블 로우 삭제
		target.find('.delBtnTr').click(function(){
			var deletedDiv = $(this).closest('tr');
			deletedDiv.remove();
		});
 	};

});

function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
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
								<li class="stitle">이력정보 수정</li>
								<li class="navi">홈 > 인사정보 > 이력관리 > 이력정보 수정</li>
							</ul>
						</div>

						<!-- S: section -->
						<div class="section01">
						<form:form commandName="memberCareerVO" id="memberCareerVO" name="memberCareerVO" method="POST" enctype="multipart/form-data">
							<input type="hidden" name="command" />
<!--							<input type="hidden" name="no" value="${careerMain.userNo}"/>-->
							<input type="hidden" name="no" value="${userNo}"/>
							<input type="hidden" name="userNo" value="${userNo}"/>
							<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/member/updtCareerViewBypass.do'/>"/>
						<!--<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/member/updtCareerView.do'/>"/>-->
							<input type="hidden" name="workSt" value="${searchVO.workSt}"/>
							<input type="hidden" name="rankIdFrom" value="${searchVO.rankIdFrom}"/>
							<input type="hidden" name="rankIdTo" value="${searchVO.rankIdTo}"/>
							<input type="hidden" name="careerFrom" value="${searchVO.careerFrom}"/>
							<input type="hidden" name="careerTo" value="${searchVO.careerTo}"/>
							<input type="hidden" name="searchSkill" value="${searchVO.searchSkill}"/>
							<input type="hidden" name="searchLicense" value="${searchVO.searchLicense}"/>
							<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>	
							
							<input type="hidden" name="jsonEducationString" />
							<input type="hidden" name="jsonTrainString" />
							<input type="hidden" name="jsonLicenseString" />
							<input type="hidden" name="jsonWorkString" />
							<input type="hidden" name="jsonSkillString" />
							
							<!-- 게시판 시작  -->
							
							<!-- 이력정보 시작 -->
							<ul>
								<li class="th_stitle04 mB10">이력관리</li>
							</ul>
							<div class="boardList mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>이력관리 수정</caption>
									<colgroup>
										<col width="170px" />
										<col width="px" />
									</colgroup>
									<tbody>
										<tr>
											<td class="txt_center bc01">이름</td>
											<td class="pL10" >
												<print:user userNo="${info.no}" userNm="${info.userNm}"/>
												(${info.age}세)
											</td>
										</tr>
										<tr>
											<td class="txt_center bc01">소속부서</td>
											<td class="pL10" colspan="1"><c:out value="${info.orgnztNm}" /></td>					                    	
										</tr>
										<tr>
											<td class="txt_center bc01">직급</td>
											<td class="pL10"><c:out value="${info.rankNm}" /></td>
										</tr>
										<tr>
											<td class="title">SW기술등급*</td>
											<td class="pL10" >
												<select name="swLevel">
													<option value="선택없음" <c:if test="${careerMain.swLevel==''}"> selected="selected"</c:if>> 선택없음</option>
													<option value="초급기능사" <c:if test="${careerMain.swLevel=='초급기능사'}"> selected="selected"</c:if>> 초급기능사</option>
													<option value="중급기능사" <c:if test="${careerMain.swLevel=='중급기능사'}"> selected="selected"</c:if>>중급기능사</option>
													<option value="고급기능사" <c:if test="${careerMain.swLevel=='고급기능사'}"> selected="selected"</c:if>>고급기능사</option>
													<option value="초급기술자" <c:if test="${careerMain.swLevel=='초급기술자'}"> selected="selected"</c:if>>초급기술자</option>
													<option value="중급기술자" <c:if test="${careerMain.swLevel=='중급기술자'}"> selected="selected"</c:if>>중급기술자</option>
													<option value="고급기술자" <c:if test="${careerMain.swLevel=='고급기술자'}"> selected="selected"</c:if>>고급기술자</option>
													<option value="특급기술자" <c:if test="${careerMain.swLevel=='특급기술자'}"> selected="selected"</c:if>>특급기술자</option>
													<option value="기술사" <c:if test="${careerMain.swLevel=='기술사'}"> selected="selected"</c:if>>기술사</option>
												</select>
											</td>
										</tr>
										<tr>
											<td class="title">해당분야 근무 시작일자*<br/>(경력기간 계산기준일)</td>
											<td class="pL10">
												<input type="text" class="span_5 calGen" name="careerDt" value="${careerMain.careerDt}">
												예) 휴직, 실직, 타직종 근무 총 3년, 경력시작 20040101 경우 공백기 제외하고 20070101로 입력
											</td>
										</tr>														
										<tr>
											<td class="title">병역사항</td>
											<td class="pL10">군별 <input type="text" name="militaryService" value="${careerMain.militaryService}" size="10">
											군별 : 육군, 해군, 공군, 해병대, 면제, 공익근무
											<br/>
												기간 <input type="text" name="msStDt" value="${careerMain.msStDt}" class="calGen" size="8"> 
												~ <input type="text" name="msEdDt" value="${careerMain.msEdDt}" size="8" class="calGen">
											제대계급 <input type="text" name="msLevel" value="${careerMain.msLevel}" size="10"></td>
										</tr>
										
										<tr>
											<td class="title" colspan="2">기 술</td>											
										</tr>
										<tr>
											<td class="title">개발언어</td>
											<td class="pL10">
												<textarea name="skillLang" class="textarea height_70"  cols="50" rows="4" ><c:out value="${careerMain.skillLang}" /></textarea>
											</td>
										</tr>
										<tr>
											<td class="title">DBMS</td>
											<td class="pL10">
												<textarea name="skillDbms" class="textarea height_70"  cols="50" rows="4" ><c:out value="${careerMain.skillDbms}" /></textarea>												
											</td>
										</tr>
										<tr>
											<td class="title">Tool</td>
											<td class="pL10">
												<textarea name="skillTool" class="textarea height_70"  cols="50" rows="4" ><c:out value="${careerMain.skillTool}" /></textarea>												
											</td>
										</tr>
										<tr>
											<td class="title">OS</td>
											<td class="pL10">
												<textarea name="skillOs" class="textarea height_70"  cols="50" rows="4" ><c:out value="${careerMain.skillOs}" /></textarea>												
											</td>
										</tr>
										
										<tr>
											<td class="title">증명자료 첨부파일<br/>(자격증 등 최대 10개)</td>
											<td class="pL10">
												<c:if test="${not empty careerMain.atchFileId}">
													<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
														<c:param name="param_atchFileId" value="${careerMain.atchFileId}" />
													</c:import>
												</c:if>	
												<c:if test="${empty careerMain.atchFileId}">
													<input type="hidden" name="fileListCnt" value="0" />
												</c:if>
												<div id="file_upload_posbl"  style="display:none;" >	
													<input type="file" name="file_1" id="egovComFileUploader" class="write_input" style="width:400px;"/>
													<div id="egovComFileList"></div>
												</div>
												<div id="file_upload_imposbl"  style="display:none;" >
													<spring:message code="common.imposbl.fileupload" />
												</div>			
						
												<script type="text/javascript">
												var existFileNum = document.memberCareerVO.fileListCnt.value;
												var maxFileNum = 10;
												
												if (existFileNum=="undefined" || existFileNum ==null) {
													existFileNum = 0;
												}
												var uploadableFileNum = maxFileNum - existFileNum;
												if (uploadableFileNum<0) {
													uploadableFileNum = 0;
												}
												if (uploadableFileNum != 0) {
													fn_egov_check_file('Y');
													var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
													multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
												} else {
													fn_egov_check_file('N');
												}
												</script>
												
											</td>
										</tr>
										
										<tr>
											<td class="title">비밀취급인가 근거<br/>(국방부 공문 번호)</td>
											<td class="pL10"><input type="text" name="securityBasis" value="${careerMain.securityBasis}" style="width:400px"></td>
										</tr>
							
										<tr>
											<td class="title">비밀취급인가증 번호<br/>국방부</td>
											<td class="pL10"><input type="text" name="securityNo" value="${careerMain.securityNo}">
											</td>
										</tr>
										
									</tbody>
								</table>
							</div>
							<!-- 이력정보 끝 -->
																					
							<span class="txtB_red">
								필수정보*는 반드시 입력해주세요 <br/>
								최신 정보를 아래에 추가하시면 저장 후 시작일 기준 최신순 정렬됩니다.<br/>
								입력하신 학력 정보는 본인, 팀장, 부서장, 본부장만 조회 가능합니다.<br/>
								입력 개수 제한은 없으며 한 칸 당 200자까지 입력 가능합니다.<br/>
								<br/>
							</span>
							
							<!-- 학력 시작 -->							
							<ul>
								<li class="th_stitle mB10" >학력*
								<span class="fr"><img id="addBtnEdu" class="cursorPointer" src="${imagePath}/btn/btn_add.gif" /></span>
								</li>
							</ul>							
							<div id="educationListDiv" class="boardList mB20">
								<table id="educationTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						             <caption>학력</caption>
						             <colgroup>
						             	<col width="180px" />
						             	<col width="px" />
						             	<col width="160px" />
						             	<col width="100px" />
						             	<col width="80px" />
						             </colgroup>
						             <thead>
						           		<tr> 
											<th scope="col">학교</th>
											<th scope="col">전공</th>
											<th scope="col">기간</th>
											<th scope="col">졸업유무</th>
											<th scope="col"></th>
										</tr>
						             </thead> 
						             <!-- 학력 본문 시작 -->						             
						             <tbody>
						             	<tr id="educationTr" valign="middle" style="display:none">											
											<td class="txt_center"> 
												<input type="hidden" name="no" value="${careerMain.userNo}"/>
												<input type="hidden" name="educationNo" />
												<input type="text" name="schoolName"  class="span_8" />
											</td>
											<td class="pL10">
												<input type="text" name="major" class="span_9">
											</td>
											<td class="txt_center">
												<input type="text" name="stDt" class="span_4 calGen"/> ~ 
												<input type="text" name="edDt" class="span_4 calGen"/>
											</td>
											<td class="txt_center" align="center">
												<select name="graduationYn" style="width:75px">
													<option value="">선택없음</option>
													<option value="graduation">졸업</option>
													<option value="leave">중퇴</option>
													<option value="stop">휴학</option>
													<option value="being">재학</option>
												</select>
											</td>
											<td class="pL10" align="center">
												<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
											</td>
										</tr>
																											
						              	<c:forEach items="${careerEdu}" var="edu" varStatus="c">
											<tr id="educationTr[${c.count - 1}]" valign="middle">											
												<td class="txt_center"> 
													<input type="hidden" name="educationArray[${c.count - 1}].no" value="${careerMain.userNo}"/>
													<input type="hidden" name="educationArray[${c.count - 1}].educationNo" value="${edu.no}"/>
													<input type="text" name="educationArray[${c.count - 1}].schoolName" value="${edu.schoolName}" class="span_8" />
												</td>
												<td class="pL10 ">
													<input type="text" name="educationArray[${c.count - 1}].major" value="${edu.major}" class="span_9">
												</td>
												<td class="txt_center">
													<input type="text" name="educationArray[${c.count - 1}].stDt" class="span_4 calGen" value="${edu.stDt}" /> ~ 
													<input type="text" name="educationArray[${c.count - 1}].edDt" class="span_4 calGen" value="${edu.edDt}" />
												</td>
												<td class="txt_center" align="center">
													<select name="educationArray[${c.count - 1}].graduationYn" style="width:75px">
														<option value="" <c:if test="${edu.graduationYn==''}"> selected="selected"</c:if>>선택없음</option>
														<option value="graduation" <c:if test="${edu.graduationYn=='graduation'}"> selected="selected"</c:if>>졸업</option>
														<option value="leave" <c:if test="${edu.graduationYn=='leave'}"> selected="selected"</c:if>>중퇴</option>
														<option value="stop" <c:if test="${edu.graduationYn=='stop'}"> selected="selected"</c:if>>휴학</option>
														<option value="being" <c:if test="${edu.graduationYn=='being'}"> selected="selected"</c:if>>재학</option>
													</select>
												</td>
												<td class="pL10" align="center">
													<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- 학력 본문 끝 -->
								</table>
							</div>							
							<!-- 학력 끝-->
							
							<!-- 교육 시작 -->							
							<ul>
								<li class="th_stitle mB10" >교육
								<span class="fr"><img id="addBtnTrain" class="cursorPointer" src="${imagePath}/btn/btn_add.gif" /></span>
								</li>
							</ul>							
							<div id="trainListDiv" class="boardList mB20">
								<table id="trainTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						             <caption>교육</caption>
						             <colgroup>
						             	<col width="180px" />
						             	<col width="px" />
						             	<col width="160px" />
						             	<col width="100px" />
						             	<col width="80px" />
						             </colgroup>
						             <thead>
						           		<tr> 
											<th scope="col">교육과정명</th>
											<th scope="col">교육기관</th>
											<th scope="col">교육기간</th>
											<th scope="col">수료번호</th>
											<th scope="col"></th>
										</tr>
						             </thead> 
						             <!-- 교육 본문 시작 -->						             
						             <tbody>
						             	<tr id="trainTr" valign="middle" style="display:none">											
											<td class="txt_center"> 
												<input type="hidden" name="no" value="${careerMain.userNo}"/>
												<input type="hidden" name="trainNoPk" />
												<input type="text" name="trainNm" class="span_8" />
											</td>
											<td class="pL10">
												<input type="text" name="trainOrgNm" class="span_9">
											</td>
											<td class="txt_center">
												<input type="text" name="stDt" class="span_4 calGen"/> ~ 
												<input type="text" name="edDt" class="span_4 calGen"/>
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="trainNo" class="span_5">
											</td>
											<td class="pL10" align="center">
												<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
											</td>
										</tr>
																											
						              	<c:forEach items="${careerTrain}" var="train" varStatus="c">
											<tr id="trainTr[${c.count - 1}]" valign="middle">											
												<td class="txt_center"> 
													<input type="hidden" name="trainArray[${c.count - 1}].no" value="${careerMain.userNo}"/>
													<input type="hidden" name="trainArray[${c.count - 1}].trainNoPk" value="${train.no}"/>
													<input type="text" name="trainArray[${c.count - 1}].trainNm" value="${train.trainNm}" class="span_8" />
												</td>
												<td class="pL10 ">
													<input type="text" name="trainArray[${c.count - 1}].trainOrgNm" value="${train.trainOrgNm}" class="span_9">
												</td>
												<td class="txt_center">
													<input type="text" name="trainArray[${c.count - 1}].stDt" id="stDt${c.count }" class="span_4 calGen" value="${train.stDt}" /> ~ 
													<input type="text" name="trainArray[${c.count - 1}].edDt" id="edDt${c.count }" class="span_4 calGen" value="${train.edDt}" />
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="trainArray[${c.count - 1}].trainNo" class="span_5" value="${train.trainNo}">
												</td>
												<td class="pL10" align="center">
													<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- 교육 본문 끝 -->
								</table>
							</div>							
							<!-- 교육 끝-->
							
							<!-- 자격증 시작 -->							
							<ul>
								<li class="th_stitle mB10" >자격증
								<span class="fr"><img id="addBtnLicense" class="cursorPointer" src="${imagePath}/btn/btn_add.gif" /></span>
								</li>
							</ul>							
							<div id="licenseListDiv" class="boardList mB20">
								<table id="licenseTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						             <caption>자격증</caption>
						             <colgroup>
						             	<col width="180px" />
						             	<col width="px" />
						             	<col width="160px" />
						             	<col width="100px" />
						             	<col width="80px" />
						             </colgroup>
						             <thead>
						           		<tr> 
											<th scope="col">종목 및 등급</th>
											<th scope="col">발급기관</th>
											<th scope="col">자격등록번호</th>
											<th scope="col">합격년월일</th>
											<th scope="col"></th>
										</tr>
						             </thead> 
						             <!-- 자격증 본문 시작 -->						             
						             <tbody>
						             	<tr id="licenseTr" valign="middle" style="display:none">											
											<td class="txt_center"> 
												<input type="hidden" name="no" value="${careerMain.userNo}"/>
												<input type="hidden" name="licenseNoPk" />
												<input type="text" name="licenseNm" class="span_8" />
											</td>
											<td class="pL10">
												<input type="text" name="issuedOrg" class="span_9">
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="licenseNo" class="span_5">
											</td>
											<td class="txt_center">
												<input type="text" name="passedDate" class="span_4 calGen"/>
											</td>
											<td class="pL10" align="center">
												<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
											</td>
										</tr>
																											
						              	<c:forEach items="${careerLicense}" var="license" varStatus="c">
											<tr id="licenseTr[${c.count - 1}]" valign="middle">											
												<td class="txt_center"> 
													<input type="hidden" name="licenseArray[${c.count - 1}].no" value="${careerMain.userNo}"/>
													<input type="hidden" name="licenseArray[${c.count - 1}].licenseNoPk" value="${license.no}"/>
													<input type="text" name="licenseArray[${c.count - 1}].licenseNm" value="${license.licenseNm}" class="span_8" />
												</td>
												<td class="pL10 ">
													<input type="text" name="licenseArray[${c.count - 1}].issuedOrg" value="${license.issuedOrg}" class="span_9">
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="licenseArray[${c.count - 1}].licenseNo" class="span_5" value="${license.licenseNo}">
												</td>
												<td class="txt_center">
													<input type="text" name="licenseArray[${c.count - 1}].passedDate" class="span_4 calGen" value="${license.passedDate}" />
												</td>												
												<td class="pL10" align="center">
													<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
												</td>												
											</tr>
										</c:forEach>
									</tbody>
									<!-- 자격증 본문 끝 -->
								</table>
							</div>							
							<!-- 자격증 끝-->
							
							<!-- 근무처 경력 시작 -->							
							<ul>
								<li class="th_stitle mB10" >근무처 경력*
								<span class="fr"><img id="addBtnWork" class="cursorPointer" src="${imagePath}/btn/btn_add.gif" /></span>
								</li>
							</ul>							
							<div id="workListDiv" class="boardList mB20">
								<table id="workTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						             <caption>근무처 경력</caption>
						             <colgroup>
						             	<col width="160px" />
						             	<col width="150px" />
						             	<col width="px" />						             	
						             	<col width="100px" />
						             	<col width="100px" />
						             	<col width="70px" />
						             </colgroup>
						             <thead>
						           		<tr> 
											<th scope="col">회사명</th>
											<th scope="col">근무기간</th>
											<th scope="col">담당업무</th>
											<th scope="col">부서</th>
											<th scope="col">직위</th>
											<th scope="col"></th>
										</tr>
						             </thead> 
						             <!-- 근무처 경력 본문 시작 -->						             
						             <tbody>
						             	<tr id="workTr" valign="middle" style="display:none">											
											<td class="txt_center"> 
												<input type="hidden" name="no" value="${careerMain.userNo}"/>
												<input type="hidden" name="workNo" />
												<input type="text" name="companyNm" class="span_8" />
											</td>											
											<td class="txt_center">
												<input type="text" name="stDt" class="span_4 calGen"/> ~ 
												<input type="text" name="edDt" class="span_4 calGen"/>
											</td>
											<td class="txt_center">
												<input type="text" name="task" class="span_5">
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="orgnztNm" class="span_5">
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="rankNm" class="span_5">
											</td>
											<td class="pL10" align="center">
												<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
											</td>
										</tr>
																											
						              	<c:forEach items="${careerWork}" var="work" varStatus="c">
											<tr id="workTr[${c.count - 1}]" valign="middle">											
												<td class="txt_center">
													<input type="hidden" name="workArray[${c.count - 1}].no" value="${careerMain.userNo}"/>
													<input type="hidden" name="workArray[${c.count - 1}].workNo" value="${work.no}"/>
													<input type="text" name="workArray[${c.count - 1}].companyNm" value="${work.companyNm}" class="span_8" />
												</td>
												<td class="txt_center">
													<input type="text" name="workArray[${c.count - 1}].stDt" id="stDt${c.count }" class="span_4 calGen" value="${work.stDt}" /> ~ 
													<input type="text" name="workArray[${c.count - 1}].edDt" id="edDt${c.count }" class="span_4 calGen" value="${work.edDt}" />
												</td>							
												<td class="txt_center" align="center">
													<input type="text" name="workArray[${c.count - 1}].task" class="span_5" value="${work.task}">
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="workArray[${c.count - 1}].orgnztNm" class="span_5" value="${work.orgnztNm}">
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="workArray[${c.count - 1}].rankNm" class="span_5" value="${work.rankNm}">
												</td>
												<td class="pL10" align="center">
													<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- 근무처 경력 본문 끝 -->
								</table>
							</div>							
							<!-- 근무처 경력 끝-->
							
							<!-- 기술 경력 시작 -->							
							<ul>
								<li class="th_stitle mB10" >기술 경력*
								<span class="fr"><img id="addBtnSkill" class="cursorPointer" src="${imagePath}/btn/btn_add.gif" /></span>
								</li>
							</ul>							
							<div id="skillListDiv" class="boardList mB20">
								<table id="skillTable" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						             <caption>기술 경력</caption>
						             <colgroup>
						             	<col width="160px" />
						             	<col width="110px" />
						             	<col width="px" />						             	
						             	<col width="130px" />
						             	<col width="120px" />
						             	<col width="70px" />
						             </colgroup>
						             <thead>
						           		<tr> 
											<th scope="col">사업명</th>
											<th scope="col">참여기간</th>
											<th scope="col">담당업무</th>
											<th scope="col">발주처</th>
											<th scope="col">비고</th>
											<th scope="col"></th>
										</tr>
						             </thead> 
						             <!-- 기술 경력 본문 시작 -->						             
						             <tbody>
						             	<tr id="skillTr" valign="middle" style="display:none">											
											<td class="txt_center"> 
												<input type="hidden" name="no" value="${careerMain.userNo}"/>
												<input type="hidden" name="skillNo" />
												<input type="text" name="prjNm" class="span_8" />
											</td>											
											<td class="txt_center">
												<input type="text" name="stDt" class="span_4 calGen"/>부터 
												<input type="text" name="edDt" class="span_4 calGen"/>까지
											</td>
											<td class="pL10">
												<input type="text" name="task" class="span_6">
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="clientNm" class="span_7">
											</td>
											<td class="txt_center" align="center">
												<input type="text" name="note" class="span_5">
											</td>
											<td class="pL10" align="center">
												<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
											</td>
										</tr>
																											
						              	<c:forEach items="${careerSkill}" var="skill" varStatus="c">
											<tr id="skillTr[${c.count - 1}]" valign="middle">											
												<td class="txt_center"> 
													<input type="hidden" name="skillArray[${c.count - 1}].no" value="${careerMain.userNo}"/>
													<input type="hidden" name="skillArray[${c.count - 1}].skillNo" value="${skill.no}"/>
													<input type="text" name="skillArray[${c.count - 1}].prjNm" value="${skill.prjNm}" class="span_8" />
												</td>
												<td class="txt_center">
													<input type="text" name="skillArray[${c.count - 1}].stDt" id="stDt${c.count }" class="span_4 calGen" value="${skill.stDt}" />부터 
													<input type="text" name="skillArray[${c.count - 1}].edDt" id="edDt${c.count }" class="span_4 calGen" value="${skill.edDt}" />까지
												</td>							
												<td class="txt_center" align="center">
													<input type="text" name="skillArray[${c.count - 1}].task" class="span_6" value="${skill.task}">
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="skillArray[${c.count - 1}].clientNm" class="span_7" value="${skill.clientNm}">
												</td>
												<td class="txt_center" align="center">
													<input type="text" name="skillArray[${c.count - 1}].note" class="span_5" value="${skill.note}">
												</td>
												<td class="pL10" align="center">
													<img src="${imagePath}/btn/btn_delete03.gif" class="cursorPointer delBtnTr"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<!-- 기술 경력 본문 끝 -->
								</table>
							</div>							
							<!-- 기술 경력 끝-->
							
							
							<!-- 경력 끝 -->
						</form:form> 
						<!--// 게시판 끝  -->

					
						<!-- 버튼 시작 -->
						<div class="btn_area04">
<!--							<a href="javascript:updt();"><img src="${imagePath}/btn/btn_modify.gif" /></a>-->
							<a href="javascript:updt();"><img src="${imagePath}/btn/btn_save.gif" /></a>
							<a href="javascript:view();"><img src="${imagePath}/btn/btn_cancel.gif" /></a>
							<a href="${rootPath}/member/selectMemberCareerList.do"><img src="${imagePath}/btn/btn_list.gif"/></a>
<!--							<a href="javascript:list();"><img src="${imagePath}/btn/btn_list.gif"/></a>-->
<!--							<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif" /></a>-->
						</div>
						<!-- 버튼 끝 -->
					</div>	
				</div>
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

