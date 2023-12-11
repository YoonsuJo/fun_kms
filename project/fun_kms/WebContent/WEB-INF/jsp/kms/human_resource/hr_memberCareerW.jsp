<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="MemberCareer" staticJavascript="false"	xhtml="true" cdata="false" />
<script>
function insert() {
	//alert("t");
	/*
	if (chkId == false) {
		alert("사용중인 아이디입니다.");
		return;
	}
	document.frm.ihidNum.value = document.frm.ihidNumFront.value + "" + document.frm.ihidNumBack.value;
	*/
	if (!validateMemberCareer(document.frm)) {
		return;
	}
	if(confirm("등록하시겠습니까?")){
		document.frm.action="<c:url value='${rootPath}/member/insertCareer.do'/>";
		document.frm.submit();
	}
}
function list() {
	document.frm.action = "<c:url value='${rootPath}/member/selectMember.do'/>";
	document.frm.submit();
}

var edu=5;
var car=5;
var train=5;
var license=5;
function addLine(infoType){	
	if(infoType=='edu'){
		if(edu == 20){
			alert("더이상 추가할 수 없습니다.");
			return;
		}	
		//if(!carrerVaidation()) return;
		edu++;	
		document.getElementById("eduTb"+edu).style.display = "block";
	} else if (infoType=='career'){
		if(car == 20){
			alert("더이상 추가할 수 없습니다.");
			return;
		}	
		//if(!carrerVaidation()) return;
		car++;	
		document.getElementById("carTb"+car).style.display = "block";
	} else if (infoType=='train'){
		if(train == 20){
			alert("더이상 추가할 수 없습니다.");
			return;
		}	
		//if(!carrerVaidation()) return;
		train++;	
		document.getElementById("trainTb"+train).style.display = "block";
	} else if (infoType=='license'){
		if(license == 20){
			alert("더이상 추가할 수 없습니다.");
			return;
		}	
		//if(!carrerVaidation()) return;
		license++;	
		document.getElementById("licenseTb"+license).style.display = "block";
	}
}
function delLine(infoType){
	if(infoType=='edu'){
		if(edu == 5){
			//alert("더이상 삭제할 수 없습니다.");
			//return;
		}		
		document.getElementById("sname"+edu).value = "";
		document.getElementById("major"+edu).value = "";
		document.getElementById("estDt"+edu).value = "";
		document.getElementById("eedDt"+edu).value = "";
		document.getElementById("graduationYn"+edu).value = "";
		document.getElementById("eduTb"+edu).style.display = "none";
		edu--;
	} else if (infoType=='career'){
		if(car == 5){
			//alert("더이상 삭제할 수 없습니다.");
			//return;
		}		
		document.getElementById("sname"+car).value = "";
		document.getElementById("major"+car).value = "";
		document.getElementById("estDt"+car).value = "";
		document.getElementById("eedDt"+car).value = "";
		document.getElementById("graduationYn"+car).value = "";
		document.getElementById("carTb"+car).style.display = "none";
		car--;
	} else if (infoType=='train'){
		if(train == 5){
			//alert("더이상 삭제할 수 없습니다.");
			//return;
		}		
		document.getElementById("sname"+train).value = "";
		document.getElementById("major"+train).value = "";
		document.getElementById("estDt"+train).value = "";
		document.getElementById("eedDt"+train).value = "";
		document.getElementById("graduationYn"+train).value = "";
		document.getElementById("trainTb"+train).style.display = "none";
		train--;
	} else if (infoType=='license'){
		if(license == 5){
			//alert("더이상 삭제할 수 없습니다.");
			//return;
		}		
		document.getElementById("sname"+license).value = "";
		document.getElementById("major"+license).value = "";
		document.getElementById("estDt"+license).value = "";
		document.getElementById("eedDt"+license).value = "";
		document.getElementById("graduationYn"+license).value = "";
		document.getElementById("licenseTb"+license).style.display = "none";
		license--;
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
							<li class="stitle">이력 등록</li>
							<li class="navi">홈 > 인사정보 > 이력관리 > 이력등록</li>
						</ul>
					</div>

					<!-- S: section -->
					<div class="section01">
					<form:form commandName="MemberCareer" name="frm" method="POST"  enctype="multipart/form-data">
						<input type="hidden" name="command" />
						<input type="hidden" name="no" value="${user.no}"/>
						<input type="hidden" name="ihidNum" value="" />
						<input type="hidden" name="num" value="5" />
						<input type="hidden" name="swLevelVal" value="" />
						<input type="hidden" name="graduationYN" value="" />
						<input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
						<!-- 게시판 시작  -->
						<ul>
							<li class="th_stitle04 mB10">이력관리</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>이력관리 쓰기</caption>
								<colgroup>
									<col width="170px" />
									<col width="px" />
								</colgroup>
								<tbody>
									<tr>
										<td class="title">해당분야 근무경력</td>
										<td class="pL10"><input type="text" class="span_5 calGen" name="career_dt"/></td>
									</tr>
						
									<tr>
										<td class="title">비밀취급인가 근거</td>
										<td class="pL10"><input type="text" name="sbasis"/></td>
									</tr>
						
									<tr>
										<td class="title">비밀취급인가증 번호</td>
										<td class="pL10"><input type="text" name="snum" /></td>
									</tr>
						
									<tr>
										<td class="title">병역사항</td>
										<td class="pL10">군별 <input type="text" name="militaryService" size="10"> 기간 <input type="text" name="msStDt" size="8" class="calGen"> ~ <input type="text" name="msEdDt" size="8" class="calGen">
										제대계급 <input type="text" name="msLevel" size="10"></td>
									</tr>
									
									<tr>
										<td class="title">자 격 증</td>
										<td class="pL10"><input type="text" name="license" style="width:400px; height:30px;"></td>
									</tr>
									<tr>
										<td class="title">기 술</td>										
									</tr>
									<tr>
										<td class="title">개발언어 </td>
										<td class="pL10"><input type="text" name="skillLang" style="width:400px; height:30px;"></td>
									</tr>
									<tr>
										<td class="title">DBMS</td>
										<td class="pL10"><input type="text" name="skillDBMS" style="width:400px; height:30px;"></td>
									</tr>
									<tr>
										<td class="title">Tool</td>
										<td class="pL10"><input type="text" name="skillTool" style="width:400px; height:30px;"></td>
									</tr>
									<tr>
										<td class="title">OS</td>
										<td class="pL10"><input type="text" name="skillOS" style="width:400px; height:30px;"></td>
									</tr>
									<tr>
										<td class="title">SW기술등급${career.swLevel}</td>
										<td class="pL10" ><select name="swLevel">
											<option value="선택없음"> 선택없음</option>
											<option value="초급기능사">초급기능사</option>
											<option value="중급기능사">중급기능사</option>
											<option value="고급기능사">고급기능사</option>
											<option value="초급기술자">초급기술자</option>
											<option value="중급기술자">중급기술자</option>
											<option value="고급기술자">고급기술자</option>
											<option value="특급기술자">특급기술자</option>
											<option value="기술사">기술사</option>
										</select></td>
									</tr>
									<tr>
										<td class="title">첨부파일</td>
										<td class="pL10">
											<input name="file_1" id="egovComFileUploader" type="file" class="write_input" style="width:400px;"/>
											<div id="egovComFileList"></div>
											<script type="text/javascript">
												var maxFileNum = document.frm.posblAtchFileNumber.value;
												if(maxFileNum==null || maxFileNum==""){
													maxFileNum = 3;
												}
												var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
												multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											</script>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
<!--						자동생성되는 줄의 개수를 정하는 변수-->
						<c:set var="rowsCount" value="2"/>
						<ul>
							<li class="th_stitle04 mB10">학력</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." border="0">
								<caption>학력 쓰기</caption>
								<colgroup>
									<col width="180px" />
					             	<col width="px" />
					             	<col width="210px" />
					             	<col width="100px" />
								</colgroup>
								<thead>
					           		<tr> 
										<th scope="col">학교</th>
										<th scope="col">전공</th>
										<th scope="col">기간</th>
										<th scope="col">졸업유무</th>
									</tr>
					            </thead> 
								<tbody>
									<c:forEach var="edu" begin="1" end="20" step="1" varStatus="c">
										<tr id="eduTb${c.count}" valign="middle" <c:if test="${c.count > rowsCount}">style="display:none"</c:if>>
											<td class="pL10"><input type="text" name="arr_sname" id="sname${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_major" id="major${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_estDt" id="estDt${c.count }" style="width: 90px" class="span_5 calGen"/> ~ <input type="text" name="arr_eedDt" id="eedDt${c.count }" class="span_5 calGen" style="width: 90px" /></td>
											<td class="pL10" align="center"><select name="arr_graduationYn" id="graduationYn${c.count }" style="width:75px"/>
												<option value="">선택없음</option>
												<option value="graduation">졸업</option>
												<option value="being">재학</option>
												<option value="leave">중퇴</option>
												<option value="stop">휴학</option>
											</select></td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="4">
											<span class="fr">
												<a href="javascript:addLine('edu');"><img src="${imagePath}/btn/btn_add03.gif" /></a>
												<a href="javascript:delLine('edu');"><img src="${imagePath}/btn/btn_delete03.gif" /></a>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<ul>
							<li class="th_stitle04 mB10">교육</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." border="0">
								<caption>교육 쓰기</caption>
								<colgroup>
									<col width="180px" />
					             	<col width="px" />
					             	<col width="210px" />
					             	<col width="100px" />
								</colgroup>
								<thead>
					           		<tr> 
										<th scope="col">교육과정명</th>
										<th scope="col">교육기관</th>
										<th scope="col">교육기간</th>
										<th scope="col">수료번호</th>
									</tr>
					            </thead> 
								<tbody>								
									<c:forEach var="edu" begin="1" end="20" step="1" varStatus="c">
										<tr id="eduTb${c.count}" valign="middle" <c:if test="${c.count > rowsCount}">style="display:none"</c:if>>
											<td class="pL10"><input type="text" name="arr_TrainName" id="sname${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_TrainOrgName" id="major${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_TrainStDt" id="estDt${c.count }" style="width: 90px" class="span_5 calGen"/>
											 ~ <input type="text" name="arr_TrainEdDt" id="eedDt${c.count }" class="span_5 calGen" style="width: 90px" /></td>
											<td class="pL10" align="center">
												<input type="text" name="arr_sname" id="sname${c.count }" style="width: 80px;"/>
											</td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="4">
											<span class="fr">
												<a href="javascript:addLine('edu');"><img src="${imagePath}/btn/btn_add03.gif" /></a>
												<a href="javascript:delLine('edu');"><img src="${imagePath}/btn/btn_delete03.gif" /></a>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<ul>
							<li class="th_stitle04 mB10">자격증</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." border="0">
								<caption>교육 쓰기</caption>
								<colgroup>
									<col width="180px" />
					             	<col width="px" />
					             	<col width="210px" />
					             	<col width="100px" />
								</colgroup>
								<thead>
					           		<tr> 
										<th scope="col">종목 및 등급</th>
										<th scope="col">발급기관</th>
										<th scope="col">자격등록번호</th>
										<th scope="col">합격년월일</th>
									</tr>
					            </thead> 
								<tbody>
									<c:forEach var="edu" begin="1" end="20" step="1" varStatus="c">
										<tr id="eduTb${c.count}" valign="middle" <c:if test="${c.count > rowsCount}">style="display:none"</c:if>>
											<td class="pL10"><input type="text" name="arr_sname" id="sname${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_major" id="major${c.count }" style="width: 160px;"/></td>
											<td class="pL10"><input type="text" name="arr_major" id="major${c.count }" style="width: 160px;"/></td>
											<td class="pL10" align="center"><input type="text" name="arr_estDt" id="estDt${c.count }" style="width: 90px" class="span_5 calGen"/></td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="4">
											<span class="fr">
												<a href="javascript:addLine('edu');"><img src="${imagePath}/btn/btn_add03.gif" /></a>
												<a href="javascript:delLine('edu');"><img src="${imagePath}/btn/btn_delete03.gif" /></a>
											</span>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<ul>
							<li class="th_stitle04 mB10">근무처 경력</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>경력 쓰기</caption>
								<colgroup>
									<col width="150px" />
									<col width="220px" />
					             	<col width="px" />
					             	<col width="120px" />
					             	<col width="100px" />
								</colgroup>
								<thead>
					           		<tr> 
										<th scope="col">회사명</th>
										<th scope="col">근무기간</th>
										<th scope="col">담당업무</th>
										<th scope="col">부서</th>
										<th scope="col">직위</th>
									</tr>
					            </thead> 
								<tbody>
									<c:forEach var="car" begin="1" end="20" step="1" varStatus="c">
										<tr id="carTb${c.count}" valign="middle" <c:if test="${c.count > rowsCount}">style="display:none"</c:if>>
											<td class="pL10"><input type="text" name="arr_prjId" id="prjId${c.count }" style="width: 130px"/></td>
											<td class="pL10"><input type="text" name="arr_cstDt" id="cstDt${c.count }" style="width: 90px" class="span_5 calGen"/> 
											~ <input type="text" name="arr_cedDt" id="cedDt${c.count }" class="span_5 calGen" style="width: 90px"/></td>
											<td class="pL10"><input type="text" name="arr_business" id="business${c.count }" style="width: 100px"/></td>
											<td class="pL10"><input type="text" name="arr_corder" id="corder${c.count }" style="width: 110px"/></td>
											<td class="pL10"><input type="text" name="arr_etc" id="etc${c.count }" style="width: 80px"/></td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="5">
											<span class="fr">
												<a href="javascript:addLine('car');"><img src="${imagePath}/btn/btn_add03.gif" /></a>
												<a href="javascript:delLine('car');"><img src="${imagePath}/btn/btn_delete03.gif" /></a>
											</span>	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<ul>
							<li class="th_stitle04 mB10">기술 경력</li>
						</ul>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>경력 쓰기</caption>
								<colgroup>
									<col width="150px" />
									<col width="210px" />
					             	<col width="px" />
					             	<col width="120px" />
					             	<col width="100px" />
								</colgroup>
								<thead>
					           		<tr> 
										<th scope="col">사업명</th>
										<th scope="col">참여기간</th>
										<th scope="col">담당업무</th>
										<th scope="col">발주처</th>
										<th scope="col">비고</th>
									</tr>
					            </thead> 
								<tbody>
									<c:forEach var="car" begin="1" end="20" step="1" varStatus="c">
										<tr id="carTb${c.count}" valign="middle" <c:if test="${c.count > rowsCount}">style="display:none"</c:if>>
											<td class="pL10"><input type="text" name="arr_prjId" id="prjId${c.count }" style="width: 130px"/></td>
											<td class="pL10"><input type="text" name="arr_cstDt" id="cstDt${c.count }" style="width: 90px" class="span_5 calGen"/> ~ <input type="text" name="arr_cedDt" id="cedDt${c.count }" class="span_5 calGen" style="width: 90px"/></td>
											<td class="pL10"><input type="text" name="arr_business" id="business${c.count }" style="width: 100px"/></td>
											<td class="pL10"><input type="text" name="arr_corder" id="corder${c.count }" style="width: 100px"/></td>
											<td class="pL10"><input type="text" name="arr_etc" id="etc${c.count }" style="width: 80px"/></td>
										</tr>
									</c:forEach>
									<tr>
										<td colspan="5">
											<span class="fr">
												<a href="javascript:addLine('car');"><img src="${imagePath}/btn/btn_add03.gif" /></a>
												<a href="javascript:delLine('car');"><img src="${imagePath}/btn/btn_delete03.gif" /></a>
											</span>	
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						
												
						
					</form:form> 
					<!--// 게시판 끝  --> 
					<!-- 버튼 시작 -->
					<div class="btn_area04">
						<a href="javascript:updt();"><a href="javascript:insert();"><img src="${imagePath}/btn/btn_regist.gif" /></a>
						<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif" /></a>
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
