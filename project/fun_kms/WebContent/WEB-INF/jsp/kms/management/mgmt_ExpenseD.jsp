<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveMonth) {
	if (document.frm.searchAccTyp[0].checked) {
		document.frm.searchAccId.value = "";
		document.frm.searchAccNm.value = "";
	}
	
	document.frm.moveMonth.value = moveMonth;
	document.frm.submit();
}
function searchAll() {
	document.frm.searchCondition[2].checked = true;
	document.frm.searchCompanyCd.value = "";
	document.frm.searchUserMixes.value = "";
	document.frm.searchOrgNm.value = "";
	document.frm.searchPrjNm.value = "";
	document.frm.searchOrgId.value = "";
	document.frm.searchPrjId.value = "";
	document.frm.searchAccId.value = "";
	document.frm.searchAccNm.value = "";
	
	document.frm.submit();
}
function selRadio(i, setValue) {
	document.frm.searchCondition[i].checked = true;
	
	var comCd = document.getElementById("comCd");
	var usrNm = document.getElementById("usrNm");
	var orgNm = document.getElementById("orgNm");
	var orgId = document.getElementById("orgId");
	var prjNm = document.getElementById("prjNm");
	var prjId = document.getElementById("prjId");
	var usrTree = document.getElementById("usrTree");
	var orgTree = document.getElementById("orgTree");
	var prjTree = document.getElementById("prjTree");

	if (setValue == null) {
		comCd.value = "";
		usrNm.value = "";
		orgNm.value = "";
		orgId.value = "";
		prjNm.value = "";
		prjId.value = "";
	}
	
	if (i == 0) {
		comCd.style.display = "";
		usrNm.style.display = "none";
		orgNm.style.display = "none";
		prjNm.style.display = "none";
		usrTree.style.display = "none";
		orgTree.style.display = "none";
		prjTree.style.display = "none";
	}
	else if (i == 1) {
		comCd.style.display = "none";
		usrNm.style.display = "";
		orgNm.style.display = "none";
		prjNm.style.display = "none";
		usrTree.style.display = "";
		orgTree.style.display = "none";
		prjTree.style.display = "none";
	}
	else if (i == 2) {
		comCd.style.display = "none";
		usrNm.style.display = "none";
		orgNm.style.display = "";
		prjNm.style.display = "none";
		usrTree.style.display = "none";
		orgTree.style.display = "";
		prjTree.style.display = "none";
	}
	else if (i == 3) {
		comCd.style.display = "none";
		usrNm.style.display = "none";
		orgNm.style.display = "none";
		prjNm.style.display = "";
		usrTree.style.display = "none";
		orgTree.style.display = "none";
		prjTree.style.display = "";
	}
}
function statistic() {
	document.frm.action = "${rootPath}/management/selectExpenseStatistic.do";
	document.frm.submit();
}
function excelDown() {
	document.frm.action = "${rootPath}/management/selectExpenseDetailExcel.do";
	document.frm.submit();
}
function expLayerShow(tit, ct, obj) {
	var position = $(obj).position();

	document.getElementById("tit").innerHTML = tit;
	document.getElementById("ct").innerHTML = ct;

	document.getElementById("expLayer").style.top = (position.top + $(obj).height()) + "px";
	document.getElementById("expLayer").style.left = (position.left + ($(obj).width() *2 / 3)) + "px";
	
	$("#expLayer").show();
}
function expLayerHide() {
	$("#expLayer").hide();
}
function chkIncludeCost(bool) {
	document.frm.chkCost.checked = bool;
	document.frm.includeCost.value = bool ? "Y" : "N";
}
function chkIncludeExp(bool) {
	document.frm.chkExp.checked = bool;
	document.frm.includeExp.value = bool ? "Y" : "N";
}
function chkIncludeNew(bool) {
	document.frm.chk.checked = bool;
	document.frm.includeNew.value = bool ? "Y" : "N";
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
						<li class="stitle">경비지출 상세내역</li>
						<li class="navi">홈 > 경영정보 > 경비관리 > 경비지출내역</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
			    	<form name="frm" onsubmit="search(0); return false;" method="POST" action="${rootPath}/management/selectExpenseDetail.do">
			    	<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
			    	<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
					<input type="hidden" name="searchAccId" id="accId" value="${searchVO.searchAccId}"/>
					<input type="hidden" name="includeCost"/>
					<input type="hidden" name="includeExp"/>
					<input type="hidden" name="includeNew"/>
			    	<input type="hidden" name="moveMonth"/>
					<fieldset>
					<legend>상단 검색</legend>
                    <div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
	                    	<col class="col150" />
	                    	<col width="px"/>
	                    	<col class="col80" />
                    	</colgroup>
						<tbody>
							<tr>
								<td>
		               	 			<a href="javascript:search(-1);" class="pR5"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
		                			${searchVO.searchYear}년 ${searchVO.searchMonth}월
									<a href="javascript:search(1);" class="pL5"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</td>
								<td class="search_right" colspan="2">
									<label><input type="checkbox" class="check" name="chkCost" onclick="chkIncludeCost(this.checked);"/> <span class="T11B">매출원가</span></label>
									<label><input type="checkbox" class="check" name="chkExp" onclick="chkIncludeExp(this.checked);"/> <span class="T11B">판관비</span></label>
									<label><input type="checkbox" class="check" name="chk" onclick="chkIncludeNew(this.checked);"/> <span class="T11B">결재진행중인 지출내역 포함</span></label>
								</td>
							</tr>
							<tr>
								<td class=" search_right" colspan="2">
									계정과목 :
									<label><input type="radio" class="radio" name="searchAccTyp" <c:if test="${empty searchVO.searchAccId}">checked="checked"</c:if>/> 전체</label> 
									<label><input type="radio" class="radio" name="searchAccTyp" <c:if test="${not empty searchVO.searchAccId}">checked="checked"</c:if>/> 선택</label> 
									<input type="text" name="searchAccNm" id="accNm" class="input01 span_29" value="${searchVO.searchAccNm}" readonly="readonly" onclick="accGen('accNm','accId',10)"/>
									<img id="accTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="accGen('accNm','accId',10)"/>
								</td>
								<td class="search_right">
									<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="search_right">
									<label><input type="radio" class="radio" name="searchCondition" value="0" onclick="selRadio(0);"/> 회사구분</label>
									<label><input type="radio" class="radio" name="searchCondition" value="1" onclick="selRadio(1);"/> 사용자</label>
									<label><input type="radio" class="radio" name="searchCondition" value="2" onclick="selRadio(2);"/> 부서</label>
									<label><input type="radio" class="radio" name="searchCondition" value="3" onclick="selRadio(3);"/> 프로젝트</label>
									<select name="searchCompanyCd" id="comCd">
										<option value="">===선택===</option>
										<c:forEach items="${comCdList}" var="comCd">
											<option value="${comCd.code}" <c:if test="${comCd.code == searchVO.searchCompanyCd}">selected="selected"</c:if>>${comCd.codeNm}</option>
										</c:forEach>
									</select>
									<input type="text" name="searchUserMixes" id="usrNm" class="input01 span_29 userNamesAuto userValidateCheck" value="${searchVO.searchUserMixes}"/>
									<input type="text" name="searchOrgNm" id="orgNm" class="input01 span_29" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0)"/>
									<input type="text" name="searchPrjNm" id="prjNm" class="input01 span_29" value="${searchVO.searchPrjNm}" readonly="readonly" onfocus="prjGen('prjNm','prjId',1)"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="usrGen('usrNm',0);"/>
									<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
									<img id="prjTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" onclick="prjGen('prjNm','prjId',1);"/>
								</td>
								<td class="search_right">
									<input type="image" src="${imagePath}/btn/btn_allview.gif" class="search_btn02" alt="검색" onclick="searchAll();"/>
								</td>
							</tr>
						</tbody>
						</table>
                    </div>
	                </fieldset>
			    	</form>
			    	<script>
			    		selRadio("${searchVO.searchCondition}", "");
		    			chkIncludeNew("${searchVO.includeNew}" == "Y");
		    			chkIncludeExp("${searchVO.includeExp}" == "Y");
		    			chkIncludeCost("${searchVO.includeCost}" == "Y");
			    	</script>
	            	<!--// 상단 검색창 끝 -->
	            
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col width="px" />
	                    	<col class="col100" />
	                    	<col class="col90" />
	                    	<col class="col50" />
	                    	<col class="col80" />
	                    	<col class="col80" />
	                    	<col class="col80" />
	                    	<col class="col20" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>프로젝트</th>
	                    		<th>계정과목</th>
	                    		<th>회사구분</th>
	                    		<th>상신자</th>
	                    		<th>지출일자</th>
	                    		<th>지출구분</th>
	                    		<th>금액</th>
	                    		<th class="td_last">&nbsp;</th>
	                    	</tr>
	                    </thead>
	                    <tbody>
	                    	<c:set var="sum" value="0" />
	                    	<c:forEach items="${resultList}" var="result">
		                    	<tr>
			                    	<td class="pL10"><print:project prjId="${result.prjId}" prjCd="${result.prjCd}" prjNm="${result.prjNm}"/></td>
			                    	<td class="txt_center" onmouseover="expLayerShow('${result.accNm}','${result.expCtPrint}',this);" onmouseout="expLayerHide();">${result.prntNm}<br/>(${result.accNm})</td>
			                    	<td class="txt_center">
			                    		<c:forEach items="${comCdList}" var="comCd">
											<c:if test="${comCd.code == result.companyCd}">${comCd.codeNm}</c:if>
										</c:forEach>
			                    	</td>
			                    	<td class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
			                    	<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">${result.expDtPrint}</a></td>
			                    	<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">${result.expSpendTypPrint}</a></td>
			                    	<td class="txt_center"><a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">${result.expSpendPrint}</a></td>
			                    	<td class="td_last txt_center">
			                    		<c:if test="${user.admin && searchVO.includeNew == 'N'}">
<!--			                    			<img src="${imagePath}/btn/btn_plus02.gif" onclick="alert('준비중입니다.')" class="cursorPointer"/>-->
			                    			<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPointer"/>
			                    		</c:if>
			                    	</td>
		                    	</tr>
		                    <c:set var="sum" value="${sum+result.expSpend}" />
	                    	</c:forEach>
	                    </tbody>
	                    <tfoot>
	                    	<tr>
		                    	<td class="txt_center" colspan="6">합계</td>
		                    	<td class="td_last txt_center Bg" colspan="2"><fmt:formatNumber value="${sum}" pattern="#,##0"/></td>
	                    	</tr>
	                    </tfoot>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					
					<!-- 실적 레이어  -->
					<div class="expense_layer" id="expLayer" style="display:none">
						<dl>
							<dt id="tit"></dt>
							<dd id="ct"></dd>
						</dl>
					</div>
					<!--// 실적 레이어  끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
                		<a href="javascript:statistic();"><img src="${imagePath}/btn/btn_statsView.gif"/></a>
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
