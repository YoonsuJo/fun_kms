<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Customer" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function update() {
	if (!validateCustomer(document.frm)) {
		return;
	}
	document.frm.submit();
}
function view() {
	document.frm.action = "${rootPath}/cooperation/selectCustomer.do";
	document.frm.submit();
}

function addPerson() {
	document.frm.personCnt.value = new Number(document.frm.personCnt.value) + 1;

	var tr1 = document.createElement("tr");
	var td1_1 = document.createElement("td");
	var td1_2 = document.createElement("td");
	var td1_3 = document.createElement("td");
	var td1_4 = document.createElement("td");
	var td1_5 = document.createElement("td");

	td1_1.className = "title";
	td1_1.innerHTML = "담당자명";
	
	td1_2.className = "pL10";
	td1_2.innerHTML = '<input type="text" class="span_9" name="personNm"/>';

	td1_3.className = "title";
	td1_3.innerHTML = "E-Mail";

	td1_4.className = "pL10";
	td1_4.innerHTML = '<input type="text" class="span_9" name="personEmail" />';

	td1_5.className = "pic";
	td1_5.rowSpan = "3";
	td1_5.innerHTML = '<img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer" onclick="delPerson(this.parentNode.parentNode);">';

	tr1.appendChild(td1_1);
	tr1.appendChild(td1_2);
	tr1.appendChild(td1_3);
	tr1.appendChild(td1_4);
	tr1.appendChild(td1_5);

	var tr2 = document.createElement("tr");
	var td2_1 = document.createElement("td");
	var td2_2 = document.createElement("td");
	var td2_3 = document.createElement("td");
	var td2_4 = document.createElement("td");

	td2_1.className = "title";
	td2_1.innerHTML = "휴대전화";
	
	td2_2.className = "pL10";
	td2_2.innerHTML = '<input type="text" class="span_9" name="personHpno" />';

	td2_3.className = "title";
	td2_3.innerHTML = "유선전화";

	td2_4.className = "pL10";
	td2_4.innerHTML = '<input type="text" class="span_9" name="personTelno" />';

	tr2.appendChild(td2_1);
	tr2.appendChild(td2_2);
	tr2.appendChild(td2_3);
	tr2.appendChild(td2_4);
	
	var tr3 = document.createElement("tr");
	var td3_1 = document.createElement("td");
	var td3_2 = document.createElement("td");

	td3_1.className = "title";
	td3_1.innerHTML = "비고";
	
	td3_2.className = "pL10";
	td3_2.colSpan = "3";
	td3_2.innerHTML = '<input type="text" class="span_22" name="personNote" />';

	tr3.appendChild(td3_1);
	tr3.appendChild(td3_2);

	var tBody = document.getElementById("tBody");
	tBody.appendChild(tr1);
	tBody.appendChild(tr2);
	tBody.appendChild(tr3);
}
function delPerson(obj) {
	document.frm.personCnt.value = new Number(document.frm.personCnt.value) - 1;

	obj.nextSibling.nextSibling.innerHTML = "";
	obj.nextSibling.innerHTML = "";
	obj.innerHTML = "";
	obj.nextSibling.nextSibling.removeNode(true);
	obj.nextSibling.removeNode(true);
	obj.removeNode(true);
}

function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "block";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "block";
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
							<li class="stitle">고객사정보 수정</li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 고객사정보</li>
						</ul>
					</div>
					
					<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>
					
					<!-- S: section -->
					<div class="section01">
					
						<!-- 게시판 시작 -->
						<form:form name="frm" commandName="Customer" method="POST" action="${rootPath}/cooperation/updateCustomer.do" enctype="multipart/form-data">
						<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
						<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
						<input type="hidden" name="searchBusiNo" value="${searchVO.searchBusiNo}"/>
						<input type="hidden" name="searchPersonNm" value="${searchVO.searchPersonNm}"/>
						<input type="hidden" name="searchTelno" value="${searchVO.searchTelno}"/>
						<input type="hidden" name="searchFaxno" value="${searchVO.searchFaxno}"/>
						<input type="hidden" name="searchUserMix" value="${searchVO.searchUserMix}"/>
						<input type="hidden" name="custId" value="${result.custId}"/>
						
						<input type="hidden" name="returnUrl" value="${rootPath}/cooperation/updateCustomerView.do"/>
						
						<p class="th_stitle">고객사 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>고객사 정보</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">최초등록자</td>
			                    	<td class="pL10"><print:user userNo="${result.userNoReg}" userNm="${result.userNmReg}"/></td>
			                    	<td class="title">등록일시</td>
			                    	<td class="pL10">${result.regDt}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">최종수정자</td>
			                    	<td class="pL10"><print:user userNo="${result.userNoMod}" userNm="${result.userNmMod}"/></td>
			                    	<td class="title">수정일시</td>
			                    	<td class="pL10">${result.modDt}</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업체명(*)</td>
			                    	<td class="pL10" colspan="3"><input type="text" class="span_22" name="custNm" value="${result.custNm}" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">사업자등록번호</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_10" name="custBusiNo" value="${result.custBusiNo}" maxlength="14"/>
		                    		</td>
			                    	<td class="title">대표자</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_9" name="custRepNm" value="${result.custRepNm}" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">주소</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="text" class="span_22" name="custAdres" value="${result.custAdres}" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">전화번호</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_9" name="custTelno" value="${result.custTelno}" />
		                    		</td>
		                    		<td class="title">FAX</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_9" name="custFaxno" value="${result.custFaxno}" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업태</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_9" name="custBusiCond" value="${result.custBusiCond}" />
		                    		</td>
		                    		<td class="title">업종</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_9" name="custBusiTyp" value="${result.custBusiTyp}" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">비고</td>
			                    	<td class="pL10 pT5 pB5" colspan="3">
			                    		<textarea class="span_15 height_35" name="note">${result.note}</textarea>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">계좌정보</td>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">은행 : </span><input type="text" class="span_5" name="bankNm" value="${result.bankNm}" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">계좌번호 : </span><input type="text" class="span_5" name="bankNo" value="${result.bankNo}" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">예금주 : </span><input type="text" class="span_5" name="bankUserNm" value="${result.bankUserNm}" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">첨부파일</td>
			                    	<td class="pL10" colspan="3">
										<c:if test="${not empty result.atchFileId}">
											<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${result.atchFileId}" />
											</c:import>
										</c:if>	
										<c:if test="${result.atchFileId == ''}">
											<input type="hidden" name="fileListCnt" value="0" />
										</c:if>
										<div id="file_upload_posbl"  style="display:none;" >	
											<input name="file_1" id="egovComFileUploader" type="file" class="span_22"/>
											<div id="egovComFileList"></div>
										</div>
										<div id="file_upload_imposbl"  style="display:none;" >
											<spring:message code="common.imposbl.fileupload" />
										</div>		    

										<script type="text/javascript">
										var existFileNum = document.frm.fileListCnt.value;
										var maxFileNum = 3;
										
										if (existFileNum=="undefined" || existFileNum ==null) {
											existFileNum = 0;
										}
										var uploadableFileNum = maxFileNum - existFileNum;
										if (uploadableFileNum<0) {
											uploadableFileNum = 0;
										}
										if (uploadableFileNum != 0) {
											fn_egov_check_file('Y');
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum, "span_22");
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										} else {
											fn_egov_check_file('N');
										}
										</script>
									</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title" rowspan="5">세금계산서<br/>수신정보</td>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail1" class="span_5" value="${result.taxEmail1}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm1" class="span_5" value="${result.taxUserNm1}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno1" class="span_5" value="${result.taxTelno1}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail2" class="span_5" value="${result.taxEmail2}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm2" class="span_5" value="${result.taxUserNm2}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno2" class="span_5" value="${result.taxTelno2}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail3" class="span_5" value="${result.taxEmail3}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm3" class="span_5" value="${result.taxUserNm3}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno3" class="span_5" value="${result.taxTelno3}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail4" class="span_5" value="${result.taxEmail4}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm4" class="span_5" value="${result.taxUserNm4}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno4" class="span_5" value="${result.taxTelno4}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail5" class="span_5" value="${result.taxEmail5}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm5" class="span_5" value="${result.taxUserNm5}"/><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno5" class="span_5" value="${result.taxTelno5}"/>
		                    		</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">담당자 정보 <img src="${imagePath}/btn/btn_add.gif" class="cursorPointer" onclick="addPerson();"/></p>
						<input type="hidden" name="personCnt" value="${fn:length(result.personList)}"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col120" /><col width="px" /><col class="col50" /></colgroup>
		                    <tbody id="tBody">
		                    	<c:forEach items="${result.personList}" var="person">
			                    	<tr>
				                    	<td class="title" >담당자명</td>
				                    	<td class="pL10" ><input type="text" class="span_9" name="personNm" value="${person.personNm}"/></td>
				                    	<td class="title" >E-Mail</td>
				                    	<td class="pL10" ><input type="text" class="span_9" name="personEmail" value="${person.personEmail}"/></td>
				                    	<td class="pic" rowspan="3"><img src="${imagePath}/btn/btn_delete04.gif" class="cursorPointer" onclick="delPerson(this.parentNode.parentNode);"></td>
			                    	</tr><tr>
				                    	<td class="title" >휴대전화</td>
				                    	<td class="pL10" ><input type="text" class="span_9" name="personHpno" value="${person.personHpno}"/></td>
				                    	<td class="title" >유선전화</td>
				                    	<td class="pL10" ><input type="text" class="span_9" name="personTelno" value="${person.personTelno}"/></td>
			                    	</tr><tr>
				                    	<td class="title" >비고</td>
				                    	<td class="pL10" colspan="3" ><input type="text" class="span_22" name="personNote" value="${person.personNote}"/></td>
			                    	</tr>
		                    	</c:forEach>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 게시판 끝 -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_regist.gif"/></a> 
		                	<a href="javascript:view();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
