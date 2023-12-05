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
function register() {
	if (!validateCustomer(document.frm)) {
		return;
	}
	document.frm.submit();
}

//업무공유 리스트
function listArticle() {
	location.href = '${rootPath}/cooperation/selectConsultCustomerList.do';
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
//$('#tBody').ready(addPerson);
</script>
</head>

<body>

<div id="wrap">
	
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">고객사정보 등록</li>
							<li class="navi">홈 > 업무공유 > 고객사정보</li>
						</ul>
					</div>
					
					<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>
					
					<!-- S: section -->
					<div class="section01">
					
						<!-- 게시판 시작-->
						<form:form name="frm" commandName="Customer" method="POST" action="${rootPath}/cooperation/insertCustomer.do" enctype="multipart/form-data">
						<p class="th_stitle">고객사 정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>고객사 정보</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">업체명(*)</td>
			                    	<td class="pL10" colspan="3"><input type="text" name="custNm" class="span_22" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">사업자등록번호</td>
			                    	<td class="pL10">
			                    		<input type="text" class="span_10" name="custBusiNo" maxlength="14"/>
		                    		</td>
			                    	<td class="title">대표자</td>
			                    	<td class="pL10">
			                    		<input type="text" name="custRepNm" class="span_9" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">주소</td>
			                    	<td class="pL10" colspan="3">
			                    		<input type="text" name="custAdres" class="span_22" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">전화번호</td>
			                    	<td class="pL10">
			                    		<input type="text" name="custTelno" class="span_9" />
		                    		</td>
		                    		<td class="title">FAX</td>
			                    	<td class="pL10">
			                    		<input type="text" name="custFaxno" class="span_9" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">업태</td>
			                    	<td class="pL10">
			                    		<input type="text" name="custBusiCond" class="span_9" />
		                    		</td>
		                    		<td class="title">업종</td>
			                    	<td class="pL10">
			                    		<input type="text" name="custBusiTyp" class="span_9" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">비고</td>
			                    	<td class="pL10 pT5 pB5" colspan="3">
			                    		<textarea class="span_15 height_35" name="note"></textarea>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">계좌정보</td>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">은행 : </span><input type="text" name="bankNm" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">계좌번호 : </span><input type="text" name="bankNo" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">예금주 : </span><input type="text" name="bankUserNm" class="span_5" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">첨부파일</td>
			                    	<td class="pL10" colspan="3">
										<input name="file_1" id="egovComFileUploader" type="file" class="span_22"/>
										<div id="egovComFileList"></div>
										<script type="text/javascript">
											var maxFileNum = 3;
											var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , "span_22");
											multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
										</script>
			                    	</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title" rowspan="5">세금계산서<br/>수신정보</td>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail1" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm1" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno1" class="span_5" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail2" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm2" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno2" class="span_5" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail3" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm3" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno3" class="span_5" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail4" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm4" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno4" class="span_5" />
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="pL10" colspan="3">
			                    		<span class="txtB_grey T11">E-Mail : </span><input type="text" name="taxEmail5" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">담당자 : </span><input type="text" name="taxUserNm5" class="span_5" /><span class="pL7"></span>
			                    		<span class="txtB_grey T11">연락처 : </span><input type="text" name="taxTelno5" class="span_5" />
		                    		</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						
						<p class="th_stitle">담당자 정보 <img src="${imagePath}/btn/btn_add.gif" class="cursorPointer" onclick="addPerson();"/></p>
						<input type="hidden" name="personCnt" value="0"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col120" /><col width="px" /><col class="col50" /></colgroup>
		                    <tbody id="tBody">
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 게시판 끝-->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register()"><img src="${imagePath}/btn/btn_regist.gif"/></a> 
		                	<a href="javascript:listArticle()"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
