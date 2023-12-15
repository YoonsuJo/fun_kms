<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${rootPath}/html/egovframework/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/adminMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="KmsMember" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function updt() {
	if (chkId == false) {
		alert("사용중인 아이디입니다.");
		return;
	}
	if (!validateKmsMember(document.frm)) {
		return;
	}
	
	document.frm.careerMonth.value = document.frm.careerMonthYear.value * 12 + document.frm.careerMonthMonth.value * 1;	
	document.frm.ihidNum.value = document.frm.ihidNumFront.value + "" + document.frm.ihidNumBack.value;
	document.frm.action="<c:url value='${rootPath}/admin/member/updtMember.do'/>";
	document.frm.submit();
}
function updt2() {
	//수정후 목록으로 돌아가기
	if (chkId == false) {
		alert("사용중인 아이디입니다.");
		return;
	}
	if (!validateKmsMember(document.frm)) {
		return;
	}
	
	document.frm.careerMonth.value = document.frm.careerMonthYear.value * 12 + document.frm.careerMonthMonth.value * 1;	
	document.frm.ihidNum.value = document.frm.ihidNumFront.value + "" + document.frm.ihidNumBack.value;
	document.frm.action="<c:url value='${rootPath}/admin/member/updtMember2.do'/>";
	document.frm.submit();
}

function list() {
	document.frm.action = "<c:url value='${rootPath}/admin/member/selectMember.do'/>";
	document.frm.submit();
}

var chkId = true;
function chkUserId() {
	if (document.frm.userId.value == "${result.member.userId}") {
		chkId = true;
		return;
	}
	var act = new yAjax("${rootPath}/admin/member/chkUserId.do", "POST");
	act.send = "userId=" + document.frm.userId.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var result = xml.getValue("result", 0);
		if (result == "success") {
			chkId = true;
		} else {
			chkId = false;
		}
	};
	act.action();
}
function msnDelete(no) {
	var act = new yAjax("${rootPath}/admin/member/updtMemberMsn.do", "POST");
	act.send = "command=delete&userNo=${result.member.no}&no=" + no;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		document.getElementById("MSN_ROW").innerHTML = xml.getValue("data", 0);
	};
	act.action();
}
function msnInsert() {
	if (document.frm.msnTyp.value == "") {
		alert("메신저 종류를 입력해주세요.");
		return;
	}
	if (document.frm.msnAdres.value == "") {
		alert("메신저 계정을 입력해주세요.");
		return;
	}
	var act = new yAjax("${rootPath}/admin/member/updtMemberMsn.do", "POST");
	act.send = "command=insert&userNo=${result.member.no}&msnTyp=" + document.frm.msnTyp.value + "&msnAdres=" + document.frm.msnAdres.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		document.getElementById("MSN_ROW").innerHTML = xml.getValue("data", 0);
	};
	act.action();
}

function pop_photo(typ) {
	if (typ == 1) {
		var popup = window.open('${rootPath}/admin/member/popPhoto.do?picTyp=picFileId&picFileId=${info.picFileId}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}else if (typ == 2) {
		var popup = window.open('${rootPath}/admin/member/popPhoto.do?picTyp=picFileId2&picFileId=${info.picFileId2}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}
	popup.focus();
}

$(document).ready(function() {
	$('.calGen.birthDate').each(function() {
		if (!$(this).data("datepicker")) {
			$(this).datepicker();
		}
		$(this).datepicker('option', 'yearRange', '1900:2023');
	});

	var members = [
		<c:forEach items="${memberList}" var="member" varStatus="status">
		{ label: "<c:out value='${member.userNm}'/>", value: "<c:out value='${member.userNm}'/>" }
		<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	$('.memberSelector').autocomplete({
		source: members,
		select: function(event, ui) {
			$(this).val(ui.item.label);
			return false;
		}
	});

	$('#offmIdSelect').change(function() {
		var selectedOption = $(this).find('option:selected');
		if (selectedOption.val() === "") {
			$('#offmNm').html('');
		} else {
			var selectedColumn1 = selectedOption.data('column1');
			$('#offmNm').html(selectedColumn1);
		}
	});
});
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
							<li class="stitle">사원정보 수정</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<c:set value="${result.member}" var="info" />
						<c:set value="${result.insaFileList}" var="insaList" />
						<c:set value="${result.msnList}" var="msnList" />
						
						<form:form commandName="KmsMember" name="frm" method="POST">						
						<input type="hidden" name="searchCondition" value="${searchCondition}"/>
						<input type="hidden" name="searchKeyword" value="${searchKeyword}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
						<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>	
						<input type="hidden" name="rankId" value="${rankId}"/>
						<input type="hidden" name="workSt" value="${workSt}"/>
						
						<input type="hidden" name="command" value=""/>
						<input type="hidden" name="no" value="<c:out value="${info.no}" />"/>
						<input type="hidden" name="ihidNum" value=""/>
						<input type="hidden" name="careerMonth" value="0"/>
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>사원정보 수정</caption>
		                    <colgroup><col class="col120" /><col class="col140" /><col class="col120" /><col class="col140" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
								    <td class="title">이름</td>
								    <td class="pL10"><input type="text" name="userNm" value="<c:out value="${info.userNm}" />" class="span_5" /></td>
								    <td class="title">영문이름</td>
								    <td class="pL10"><input type="text" name="userEnm" value="<c:out value="${info.userEnm}" />" class="span_5" /></td>								    
								    <td class="pic2" rowspan="15">
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
								    <td class="pL10"><input type="text" name="userId" value="<c:out value="${info.userId}" />" class="span_5" onchange="chkUserId();" /></td>
								    <td class="title">사번</td>
								    <td class="pL10"><input type="text" name="sabun" value="<c:out value="${info.sabun}" />" class="span_5" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">비밀번호</td>
							        <td class="pL10" colspan="3"><input type="password" name="password" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">소속회사</td>
							        <td class="pL10"><c:out value="${info.compnyNm}" /></td>
								    <td class="title">지출결의회사</td>
 								    <td class="pL10">
							        	<select name="expCompId" class="span_7">
								    		<option value="" <c:if test="${info.expCompId == ''}">selected="selected"</c:if>>== 선택 ==</option>
							        		<c:forEach items="${compnyCode}" var="company">
								        		<option value="${company.code}" <c:if test="${info.expCompId == company.code}">selected="selected"</c:if> ><c:out value="${company.codeNm}" /></option>
							        		</c:forEach>
							        	</select>
							        </td>
		                    	</tr>
		                    	<tr>
							        <td class="title">소속부서</td>
							        <td class="pL10"><c:out value="${info.orgnztNm}" /></td>
							        <td class="title">이름초성</td>
							        <td class="pL10"><input type="text" name="initial" value="<c:out value="${info.initial}" />" class="span_6" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">직급</td>
							        <td class="pL10"><c:out value="${info.rankNm}" /></td>
							        <td class="title">보직</td>
							        <td class="pL10"><c:out value="${info.positionPrint}" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">진급년도</td>
								    <td class="pL10">								   
										<input type="text" maxlength=4 name="promotionYear" value="<c:out value="${info.promotionYear}" />" class="span_5" />										
								    </td>	
							        <td class="title">재직기간</td>
							        <td class="pL10"><c:out value="${info.workMonthPrint}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">근무상태</td>
							        <td class="pL10"><c:out value="${info.workStPrint}" /></td>
								    <td class="title">경력</td>
								    <td class="pL10""><c:out value="${info.workPeriodPrint}" /></td>
		                    	</tr>
		                    	<tr>								   
								    <td class="title">입사전 인정경력</td>
								    <td class="pL10">
								    <input type="text" maxlength=3 name="careerMonthYear" value="<c:out value="${info.careerMonthPrintYear}" />" class="span_1" /> 년
								    <input type="text" maxlength=2 name="careerMonthMonth" value="<c:out value="${info.careerMonthPrintMonth}" />" class="span_1" /> 개월								   
								    </td>
							        <td class="title">생일</td>
							        <td class="pL10">
							        	<input type="text" name="brth" maxlength="8" value="<c:out value="${info.brth}" />" class="calGen span_3 birthDate" autocomplete="off" />
							        	<input type="checkbox" name="greLun" value="L" <c:if test="${info.greLun == 'L'}">checked="checked"</c:if> />음력
							        </td>
		                    	</tr>		
		                    	<tr>
							        <td class="title">주민등록번호</td>
							        <td class="pL10">
							        	<input type="text" name="ihidNumFront" value="<c:out value="${info.ihidNumFront}" />" class="span_3" maxlength="6" />
							        	-
							        	<input type="text" name="ihidNumBack" value="<c:out value="${info.ihidNumBack}" />" class="span_3" maxlength="7" />
							        </td>
								    <td class="title">나이</td>
									<td class="pL10">
										<c:choose>
											<c:when test="${empty info.age}">
												만 -세
											</c:when>
											<c:otherwise>
												만 <c:out value="${info.age}" />세
											</c:otherwise>
										</c:choose>
										(<c:choose>
											<c:when test="${empty info.ageKor}">
												-세
											</c:when>
											<c:otherwise>
												<c:out value="${info.ageKor}" />세
											</c:otherwise>
										</c:choose>)
									</td>
		                    	</tr>
		                    	<tr>
								    <td class="title">학력</td>
								    <td class="pL10">
								    	<select name="degree" class="span_7">
								    		<option value="" <c:if test="${info.degree == ''}">selected="selected"</c:if>>== 선택 ==</option>
							        		<c:forEach items="${degreeCode}" var="degree">
								        		<option value="${degree.code}" 
								        		<c:if test="${info.degree == degree.code}">selected="selected"</c:if> >
								        		<c:out value="${degree.codeNm}" /></option>
							        		</c:forEach>
							        	</select>							        	
								    </td>
								    <td class="title">인정입사일</td>
								    <td class="pL10"><input type="text" name="acceptCompinDt" maxlength="8" value="<c:out value="${info.acceptCompinDt}" />" class="calGen span_3" autocomplete="off"/></td>
		                    	</tr>	
		                    	
		                    	
		                    	<tr>
							        <td class="title">입사일</td>
							        <td class="pL10"><c:out value="${info.compinDtPrint}" /></td>
							        <td class="title">퇴사일</td>
							        <td class="pL10"><c:out value="${info.compotDtPrint}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">이메일</td>
							        <td class="pL10 pT5 pB5" colspan="3">
							        	회사메일 : <input type="text" name="emailAdres" value="<c:out value="${info.emailAdres}" />" class="span_7" /><br/>
							        	외부메일 : <input type="text" name="emailAdres2" value="<c:out value="${info.emailAdres2}" />" class="span_7" />
							          </td>
		                    	</tr>
		                    	<!-- Ajax --- S -->
		                    	<tr>
							        <td class="title" rowspan="2">메신저계정</td>
							        <td class="title2">종류</td>
							        <td class="title2">계정</td>
							        <td class="title2">&nbsp;</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="pL10" colspan="3">
		                    			<div id="MSN_ROW" >
		                    				<c:forEach items="${msnList}" var="msn" varStatus="c">
												<div class="msn_data_input1">
													<c:out value="${msn.msnTyp}" />
												</div>
												<div class="msn_data_input2">
													<c:out value="${msn.msnAdres}" />
												</div>
												<div class="msn_data_btn">
													<a href="javascript:msnDelete('<c:out value="${msn.no}" />');"><img src="${imagePath}/admin/btn/btn_delete03.gif"/></a>
												</div>
											</c:forEach>
 											<div class="msn_data_input1">
         										<input type="text" class="span_6" name="msnTyp"/>
         									</div>
          									<div class="msn_data_input2">
       											<input type="text" class="span_11" name="msnAdres"/>
      										</div>
      										<div class="msn_data_btn">
												<a href="javascript:msnInsert();"><img src="${imagePath}/admin/btn/btn_add03.gif"/></a>
      							     		</div>
       								  	</div>  
		                    		</td>
		                    	</tr>
		                    	<!-- Ajax --- S -->
		                    	<tr>
							        <td class="title">개인연락처</td>
							        <td colspan="3">
							        	<ul class="address">
							        		<li class="left">휴대전화</li>
							        		<li class="right"><input type="text" class="span_28" name="moblphonNo" value="<c:out value="${info.moblphonNo}" />" maxlength="30"/></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">집전화</li>
							        		<li class="right"><input type="text" class="span_28" name="homeTelno" value="<c:out value="${info.homeTelno}" />" maxlength="30"/></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">주소</li>
							        		<li class="right"><input type="text" class="span_28" name="homeAdres" value="<c:out value="${info.homeAdres}" />"/></li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<tr>
							        <td class="title">회사연락처</td>
							        <td colspan="3">
							        	<ul class="address" style="display: flex; align-items: center; white-space: nowrap;">
							        		<li class="left">근무장소</li>
							        		<li class="right" style="display: flex; align-items: center; white-space: nowrap;">
									        	<select name="offmId" id="offmIdSelect">
								    				<option value="" <c:if test="${info.offmId == ''}">selected="selected"</c:if>>== 선택 ==</option>
									        		<c:forEach items="${offmCode}" var="offm">
										        		<option value="${offm.code}" data-column1="${offm.column1}" <c:if test="${info.offmId == offm.code}">selected="selected"</c:if> ><c:out value="${offm.codeNm}" /></option>
									        		</c:forEach>
									        	</select>
										    	<p id="offmNm">${info.offmAdres}</p>
		                    		 		</li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">전화번호</li>
							        		<li class="right">
							        			<input type="text" name="offmTelno" value="<c:out value="${info.offmTelno}" />" class="span_11" />
							        			(내선<input type="text" name="offmTelnoInner" value="<c:out value="${info.offmTelnoInner}" />" class="span_1" />)
		                    		 		</li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<tr>
								    <td class="title">차량번호</td>
								    <td class="pL10"><input type="text" name="carId" value="<c:out value="${info.carId}" />" class="span_4" /></td>
								    <td class="title">면허종류</td>
								    <td class="pL10">
								    	<select name="carLicTyp" class="span_6">
								    		<option value="" <c:if test="${info.carLicTyp == ''}">selected="selected"</c:if>>== 선택 ==</option>
								    		<option value="A" <c:if test="${info.carLicTyp == 'A'}">selected="selected"</c:if>>1종대형</option>
								    		<option value="B" <c:if test="${info.carLicTyp == 'B'}">selected="selected"</c:if>>1종보통</option>
								    		<option value="C" <c:if test="${info.carLicTyp == 'C'}">selected="selected"</c:if>>2종보통</option>								    		
								    		<option value="D" <c:if test="${info.carLicTyp == 'D'}">selected="selected"</c:if>>2종소형</option>
								    		<option value="E" <c:if test="${info.carLicTyp == 'E'}">selected="selected"</c:if>>원동기장치</option>
								    	</select>
								    </td>
		                    	</tr>
		                    	<tr>
								    <td class="title">차량소유</td>
								    <td class="pL10">
								    	<select name="carOwn" class="span_6">
								    		<option value="" <c:if test="${info.carOwn == ''}">selected="selected"</c:if>>== 선택 ==</option>
								    		<option value="Y" <c:if test="${info.carOwn == 'Y'}">selected="selected"</c:if>>소유</option>
								    		<option value="N" <c:if test="${info.carOwn == 'N'}">selected="selected"</c:if>>비소유</option>								    		
								    	</select>
								    </td>
								    <td class="title">입사추천인</td>
								    <td class="pL10">								   
										<input type="text" name="recommender" value="<c:out value="${info.recommender}" />" class="span_11 memberSelector" autocomplete="off" />
								    </td>
		                    	</tr>
		                    	<tr>
								    <td class="title">좌우명</td>
								    <td class="pL10 pT5 pB5" colspan="4">
								    	<textarea name="abutMe" style="width:540px; height:80px; overflow-y:hidden;"><c:out value="${info.abutMe}" escapeXml="false" /></textarea>
								    </td>
		                    	</tr> 
		                    	<tr>
								    <td class="title">비고(관리자메모)</td>
								    <td class="pL10" colspan="4">
								    	<input type="text" name="adminNote" value="<c:out value="${info.adminNote}" />" class="span_23" />
								    </td>
		                    	</tr>
		                    	
		                    </tbody>
		                    </table> 	
						</div>
						</form:form>
						<!-- 게시판 끝  -->
		                
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:updt2();">수정후 목록으로 돌아가기</a>
		                	<a href="javascript:updt();"><img src="${imagePath}/admin/btn/btn_modify.gif"/></a>
		                	<a href="javascript:list();"><img src="${imagePath}/admin/btn/btn_cancel.gif"/></a>
		                </div>
		                
		                <iframe src="<c:url value='${rootPath}/admin/member/selectMemberFilesV.do?no=${info.no}' />" width="100%" height="400px" style="border:none;" >
		                </iframe>
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
