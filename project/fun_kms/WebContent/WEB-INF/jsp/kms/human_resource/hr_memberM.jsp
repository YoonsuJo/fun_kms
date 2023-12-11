<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
	document.frm.ihidNum.value = document.frm.ihidNumFront.value + "" + document.frm.ihidNumBack.value;
	document.frm.action="<c:url value='${rootPath}/member/updtMember.do'/>";
	document.frm.submit();
}
function list() {
	document.frm.action = "<c:url value='${rootPath}/member/selectMember.do'/>";
	document.frm.submit();
}

var chkId = true;
function chkUserId() {
	var act = new yAjax("${rootPath}/member/chkUserId.do", "POST");
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
	var act = new yAjax("${rootPath}/member/updtMemberMsn.do", "POST");
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
	var act = new yAjax("${rootPath}/member/updtMemberMsn.do", "POST");
	act.send = "command=insert&userNo=${result.member.no}&msnTyp=" + document.frm.msnTyp.value + "&msnAdres=" + document.frm.msnAdres.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		document.getElementById("MSN_ROW").innerHTML = xml.getValue("data", 0);
	};
	act.action();
}

function pop_photo(typ) {
	if (typ == 1) {
		var popup = window.open('${rootPath}/member/popPhoto.do?picTyp=picFileId&picFileId=${info.picFileId}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}else if (typ == 2) {
		var popup = window.open('${rootPath}/member/popPhoto.do?picTyp=picFileId2&picFileId=${info.picFileId2}', '_POP_PHOTO_', 'top=0px, left=0px, width=340px, height=100px')
	}
	popup.focus();
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
						<li class="stitle">개인정보 수정</li>
						<li class="navi">홈 > 인사정보 > 사원정보 > 사원조회</li>
					</ul>
				</div>	
				
				<!-- S: section -->
				<div class="section01">
					<c:set value="${result.member}" var="info" />
					<c:set value="${result.insaFileList}" var="insaList" />
					<c:set value="${result.msnList}" var="msnList" />
					
					<form:form commandName="KmsMember" name="frm" method="POST">
						<input type="hidden" name="command" value=""/>
						<input type="hidden" name="no" value="<c:out value="${info.no}" />"/>
						<input type="hidden" name="ihidNum" value=""/>
						<input type="hidden" name="promotionYear" value=""/>
						<input type="hidden" name="careerMonthYear" value=""/>
						<input type="hidden" name="careerMonthMonth" value=""/>	
						
						<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
						<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="rankId" value="${searchVO.rankId}"/>
						<input type="hidden" name="workSt" value="${searchVO.workSt}"/>				       
					<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>개인정보 수정</caption>
							<colgroup>
								<col class="col150" />
								<col class="col200" />
								<col class="col150" />
								<col class="col200" />
								<col width="px" />
							</colgroup>
							<tbody>
		                    	<tr>
								    <td class="title">이름</td>
								    <td class="pL10" ><c:out value="${info.userNm}" /></td>
								    <td class="title">영문이름</td>
								    <td class="pL10" ><input type="text" name="userEnm" value="<c:out value="${info.userEnm}" />" class="span_6" /></td>								    
								    <td class="pic" rowspan="14" >
								    	<c:choose>
                    						<c:when test="${empty info.picFileId || info.picFileId == ''}">
                    							소개사진 없음
                    						</c:when>
                    						<c:otherwise>
                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
													<c:param name="atchFileId" value="${info.picFileId}" />
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
													<c:param name="atchFileId" value="${info.picFileId2}" />
													<c:param name="param_width" value="160" />
													<c:param name="param_height" value="250" />
												</c:import>
                    						</c:otherwise>
                    					</c:choose>
								    </td>
		                    	</tr>
		                    	<tr>
								    <td class="title">ID</td>
								    <td class="pL10" ><c:out value="${info.userId}" /></td>
								    <td class="title">사번</td>
								    <td class="pL10" ><c:out value="${info.sabun}" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">비밀번호</td>
								    <td class="pL10" ><input type="password" name="password" class="span_6" /></td>
								    <td class="title">비밀번호확인</td>
								    <td class="pL10" ><input type="password" name="password2" class="span_6" /></td>
		                    	</tr>
		                    	<tr>
								    <td class="title">소속회사</td>
							        <td class="pL10"><c:out value="${info.compnyNm}" /></td>
								    <td class="title">지출결의회사</td>
 								    <td class="pL10"><c:out value="${info.expCompNm}" /></td>
		                    	</tr>
		                    	<tr>
							        <td class="title">소속부서</td>
							        <td class="pL10"><c:out value="${info.orgnztNm}" /></td>
							        <c:if test="${user.isAdmin == 'Y'}">        
							        <td class="title">이름초성</td>
							        <td class="pL10"><input type="text" name="initial" value="<c:out value="${info.initial}" />" class="span_6" /></td>
							        </c:if>
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
							        	<input type="text" name="ihidNumFront" value="<c:out value="${info.ihidNumFront}" />" class="w70" />
							        	-
							        	<input type="text" name="ihidNumBack" value="<c:out value="${info.ihidNumBack}" />" class="w70" />
							        </td>
							        <td class="title">생일</td>
							        <td class="pL10">
							        	<input type="text" name="brth" maxlength="8" value="<c:out value="${info.brth}" />" class="w70 calGen" />
							        	<input type="checkbox" name="greLun" value="L" <c:if test="${info.greLun == 'L'}">checked="checked"</c:if> />음력
							        </td>
		                    	</tr>
		                    	<tr>
							        <td class="title">입사일</td>
							        <td class="pL10" ><c:out value="${info.compinDtPrint}" /></td>
							        <td class="title">퇴사일</td>
							        <td class="pL10" ><c:out value="${info.compotDtPrint}" /></td>
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
							        		<li class="right"><input type="text" name="emailAdres" value="<c:out value="${info.emailAdres}" />" class="w200" />
							        		예)ID@dosanet.co.kr 
							        		</li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">외부메일</li>
							        		<li class="right"><input type="text" name="emailAdres2" value="<c:out value="${info.emailAdres2}" />" class="w200"/>
							        		예)ID@domain.com</li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	
		                    	<!-- 2013.07.24 김대현 웹메일 주소-->
								<tr>
									<td class="title">회사 웹메일 주소</td>
									<td colspan="3">
										<ul class="address">
								       		<li class="right">
								       		<input type="text" name="emailLink" value="<c:out value="${info.emailLink}" />" class="w200" />
								       		예) 도사: mail.dosanet.co.kr / 새하: mail.saeha.com
								    		</li>
								       	</ul>
									</td>
								</tr>
		                    	<tr>
								    <td class="title">연락처</td>
							        <td colspan="3">
							        	<ul class="address">
							        		<li class="left">휴대전화</li>
							        		<li class="right"><input type="text" class="w200" name="moblphonNo" value="<c:out value="${info.moblphonNo}"/>" maxlength="30"/></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">집전화</li>
							        		<li class="right"><input type="text" class="w200" name="homeTelno" value="<c:out value="${info.homeTelno}" />" maxlength="30"/></li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">주소</li>
							        		<li class="right"><input type="text" class="w400" name="homeAdres" value="<c:out value="${info.homeAdres}" />" /></li>
							        	</ul>
		                    		</td>
		                    	</tr>		                    	
		                    	<tr>
		                    		<td class="title">회사연락처</td>		                    		
		                    		<td colspan="3">
							        	<ul class="address02">
							        		<li class="left">근무장소</li>
							        		<li class="right">
									        	<select name="offmId">
								    				<option value="" <c:if test="${info.offmId == ''}">selected="selected"</c:if>>== 선택 ==</option>
									        		<c:forEach items="${offmCode}" var="offm">
										        		<option value="${offm.code}" onclick="$('#offmNm').html('${offm.column1}')" <c:if test="${info.offmId == offm.code}">selected="selected"</c:if> ><c:out value="${offm.codeNm}" /></option>
									        		</c:forEach>
									        	</select>
										    	<p id="offmNm">${info.offmAdres}</p>
											</li>
							        	</ul>
							        	<ul class="address">
							        		<li class="left">전화번호</li>
							        		<li class="right">
							        			<input type="text" name="offmTelno" value="<c:out value="${info.offmTelno}" />" class="w100" />
							        			(내선<input type="text" name="offmTelnoInner" value="<c:out value="${info.offmTelnoInner}" />" class="span_1" />)
		                    		 		</li>
							        	</ul>
		                    		</td>
		                    	</tr>
		                    	<tr>
								    <td class="title">차량번호</td>
								    <td class="pL10" ><input type="text" name="carId" value="<c:out value="${info.carId}" />" class="w80" /></td>
								    <td class="title">면허종류</td>
								    <td class="pL10" colspan="2" >
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
								    <td class="title">좌우명</td>
								    <td class="pL10 pT5 pB5" colspan="4">
								    	<textarea name="abutMe" style="width:540px; height:80px; overflow-y:hidden;"><c:out value="${info.abutMe}" escapeXml="false" /></textarea>
								    </td>
		                    	</tr>         	
		                    </tbody>
		                    </table>
						</div>
					</form:form>
						
					<!--// 게시판 끝  -->
					
					<!-- 버튼 시작 -->
           		   <div class="btn_area04">
	                	<a href="javascript:updt();"><img src="${imagePath}/btn/btn_modify.gif"/></a>
	                	<a href="javascript:list();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
            		</div>
             	    <!-- 버튼 끝 -->

	                <iframe src="<c:url value='${rootPath}/member/selectMemberFilesV.do?no=${info.no}' />" width="100%" height="400px" style="border:none;" >
	                </iframe>	                
		                
	                <!-- 인사정보파일 레이어 추가 -->
					<div id="member_file" style="display:none;">
					 	<ul class="layer_left">
					 		<li>종류</li>
					 		<li>첨부</li>
					 		<li>비고</li>
					 	</ul>
					 	<ul class="layer_right">
					 		<li>
					 			<select name="" class="span_6"><option>이력서</option></select>
					 		</li>
					 		<li>
					 			<input type="text" name="title" class="span_5" />
					 			<img src="${imagePath}btn/btn_search05.gif"/>
					 		</li>
					 		<li><input type="text" name="title" class="span_8" /></li>
					 	</ul>
					 	<ul class="messanger_btn">
					 		<li><img src="${imagePath}btn/btn_add03.gif"/></li>
					 		<li><img src="${imagePath}btn/btn_cancel02.gif"/></li>
					 	</ul>
	                </div>
	                <!--// 인사정보파일 레이어  끝-->
		                		
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
