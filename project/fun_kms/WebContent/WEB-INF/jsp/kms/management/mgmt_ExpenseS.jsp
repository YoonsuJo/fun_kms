<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveYear) {
	document.frm.searchYear.value = new Number(document.frm.searchYear.value) + moveYear;
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
function detail(accId, accNm, month) {
	document.frm.searchMonth.value = month;
	document.frm.searchAccId.value = accId;
	document.frm.searchAccNm.value = accNm;
	document.frm.action = "${rootPath}/management/selectExpenseDetail.do";
	document.frm.submit();
}
function chkIncludeNew(bool) {
	document.frm.chkNew.checked = bool;
	document.frm.includeNew.value = bool ? "Y" : "N";
}
function chkIncludeCost(bool) {
	document.frm.chkCost.checked = bool;
	document.frm.includeCost.value = bool ? "Y" : "N";
}
function chkIncludeExp(bool) {
	document.frm.chkExp.checked = bool;
	document.frm.includeExp.value = bool ? "Y" : "N";
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
						<li class="stitle">경비지출내역</li>
						<li class="navi">홈 > 경영정보 > 경비관리 > 경비지출내역</li>
					</ul>
				</div>
				<span class="stxt">계정과목별 경비지출 추이를 확인할 수 있습니다.</span>
				<!-- S: section -->
				<div class="section01">
				
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" onsubmit="search(0); return false;" method="POST" action="${rootPath}/management/selectExpenseStatistic.do">
			    	<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="searchPrjId" id="prjId" value="${searchVO.searchPrjId}"/>
			    	<input type="hidden" name="searchMonth"/>
			    	<input type="hidden" name="searchAccId"/>
			    	<input type="hidden" name="searchAccNm"/>
			    	<input type="hidden" name="includeNew"/>
					<input type="hidden" name="includeCost"/>
					<input type="hidden" name="includeExp"/>
					<fieldset>
					<legend>상단 검색</legend>
                    <div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td>
		               	 			<a href="javascript:search(-1);" class="pR5"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
		                			${searchVO.searchYear}년
									<a href="javascript:search(1);" class="pL5"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</td>
								<td class="search_right">
									<label><input type="checkbox" class="check" name="chkCost" onclick="chkIncludeCost(this.checked);"/> <span class="T11B">매출원가</span></label>
									<label><input type="checkbox" class="check" name="chkExp" onclick="chkIncludeExp(this.checked);"/> <span class="T11B">판관비</span></label>
									<label><input type="checkbox" class="check" name="chkNew" onclick="chkIncludeNew(this.checked);"/> <span class="T11B">결재진행중인 지출내역 포함</span></label>
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
									<input type="text" name="searchUserMixes" id="usrNm" class="input01 span_10 userNamesAuto userValidateCheck" value="${searchVO.searchUserMixes}"/>
									<input type="text" name="searchOrgNm" id="orgNm" class="input01 span_10" value="${searchVO.searchOrgNm}" readonly="readonly" onfocus="orgGen('orgNm','orgId',0)"/>
									<input type="text" name="searchPrjNm" id="prjNm" class="input01 span_10" value="${searchVO.searchPrjNm}" readonly="readonly" onfocus="prjGen('prjNm','prjId',1)"/>
									<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02" onclick="usrGen('usrNm',0);"/>
									<img id="orgTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02" onclick="orgGen('orgNm','orgId',0);"/>
									<img id="prjTree" src="${imagePath}/btn/btn_tree.gif" class="search_btn02" onclick="prjGen('prjNm','prjId',1);"/>
									<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									<input type="image" src="${imagePath}/btn/btn_allview.gif" class="search_btn02" alt="검색" onclick="searchAll();"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
			    	</form>
			    	<script>
			    		chkIncludeNew("${searchVO.includeNew}" == "Y");
			    		chkIncludeCost("${searchVO.includeCost}" == "Y");
			    		chkIncludeExp("${searchVO.includeExp}" == "Y");
			    		selRadio("${searchVO.searchCondition}", "");
			    	</script>
	            	<!--// 상단 검색창 끝 -->
	            
	           		 	<!-- 게시판 시작  -->
					<p class="th_plus02">단위 : 천원</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col110" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
	                    	<col width="px" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                    		<th>계정과목</th>
	                    		<th class="T11">1월</th>
	                    		<th class="T11">2월</th>
	                    		<th class="T11">3월</th>
	                    		<th class="T11">4월</th>
	                    		<th class="T11">5월</th>
	                    		<th class="T11">6월</th>
	                    		<th class="T11">7월</th>
	                    		<th class="T11">8월</th>
	                    		<th class="T11">9월</th>
	                    		<th class="T11">10월</th>
	                    		<th class="T11">11월</th>
	                    		<th class="T11">12월</th>
	                    		<th class="td_last T11">합계</th>
	                    	</tr>
	                    </thead>
	                    <tfoot>
	                    	<tr>
	                    		<td class="txt_center">총합계</td>
	                    		<td class="txt_center T11">${sum.exp01Print}</td>
	                    		<td class="txt_center T11">${sum.exp02Print}</td>
	                    		<td class="txt_center T11">${sum.exp03Print}</td>
	                    		<td class="txt_center T11">${sum.exp04Print}</td>
	                    		<td class="txt_center T11">${sum.exp05Print}</td>
	                    		<td class="txt_center T11">${sum.exp06Print}</td>
	                    		<td class="txt_center T11">${sum.exp07Print}</td>
	                    		<td class="txt_center T11">${sum.exp08Print}</td>
	                    		<td class="txt_center T11">${sum.exp09Print}</td>
	                    		<td class="txt_center T11">${sum.exp10Print}</td>
	                    		<td class="txt_center T11">${sum.exp11Print}</td>
	                    		<td class="txt_center T11">${sum.exp12Print}</td>
	                    		<td class="td_last txt_center T11">${sum.sumPrint}</td>
	                    	</tr>
	                    </tfoot>
	                    <tbody>
	                    	<c:forEach items="${resultList}" var="result" varStatus="c">
		                    	<tr>
			                    	<td class="txt_center">${result.prntNm}<br/>(${result.accNm})</td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','01');">${result.exp01Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','02');">${result.exp02Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','03');">${result.exp03Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','04');">${result.exp04Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','05');">${result.exp05Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','06');">${result.exp06Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','07');">${result.exp07Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','08');">${result.exp08Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','09');">${result.exp09Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','10');">${result.exp10Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','11');">${result.exp11Print}</a></td>
			                    	<td class="txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','12');">${result.exp12Print}</a></td>
			                    	<td class="td_last txt_center T11"><a href="javascript:detail('${result.accId}','${result.accNm}','');">${result.sumPrint}</a></td>
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
	            	
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
