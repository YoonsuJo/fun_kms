<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>

<style type="text/css">
.decide_layer {position:absolute; border:1px solid #d7d7d7; width:220px; background-color:#fff; padding:10px;}
</style>


<%@ include file="../include/top_inc.jsp"%>
<script>
function search(cnt){
	var form = $('#searchVO');
	form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) + parseInt(cnt));
	form.submit();
}

/*
function decide(docId){
	if(confirm("매출을 확정하시겠습니까?")) {
		var form = $('#searchVO');
		$('<input type="hidden" name="docId" value="'+docId + '"/>').appendTo(form);
		form.attr("action",'/management/updateSalesDecideYn.do');
		form.submit();
	}
};
*/

$(document).ready(function(){
	$('#searchOrgNm, #searchOrgTreeB').click(function(){
		orgGen('searchOrgNm','searchOrgId',2);
	});

	$('[name=searchBusiId]').change(setOrgId);
});

function setOrgId() {
	var act = new yAjax("${rootPath}/ajax/selectUnderOrgList.do", "POST");
	act.send = "searchOrgId=" + document.searchVO.searchBusiId.value;
	act.statechange = function(){
		var xml = act.getResXmlObject();
		var id = xml.getValue("id",0);
		var nm = xml.getValue("nm",0);
		document.searchVO.searchOrgId.value = id;
		document.searchVO.searchOrgNm.value = nm;
	};
	act.action();
}


//매출확정 레이어 show/hide
function clickDecideYn(docId, checkboxId) {
	if ($('#'+checkboxId).is(':checked')) {
		// 버튼 초기화
		$('.decideChk').attr('checked', false);
		$('#'+checkboxId).attr('checked', true);
		
		decideLayerShow(docId, checkboxId);
	} else {
		decideLayerHide();
	}
}

function decideLayerShow(docId, checkboxId) {
	
	
	var stDt = '';
	var colDueDt = '';
	var templtId = '';
	
	// ajax로 문서 정보(템플릿ID, 매출일, 최종수금예정일) 가져오기
	$.ajax({
		url: "/ajax/approval/selectDocStDt.do",
		data: {
			docId: docId
		},
		type: "POST",
		async: false,
		dataType: "json",
		success: function(data) {
			templtId = data.TEMPLT_ID;
			stDt = data.ST_DT;
			colDueDt = data.COL_DUE_DT;
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("문서에 대한 데이터를 가져오는데 실패하였습니다.");
			return false;
  	 	}
	});
	
	$('input[name=docId]').val(docId);
	$('input[name=templtId]').val(templtId);
	var stDtTr ='<tr>' +
				'	<td class="title" >매출일</td>' + 
				'	<td class="pL10">' +
				'		<input type="text" name="stDt" class="input01 span_5 calGen" value="' + stDt + '"/>' +
				'	</td>' +
				'</tr>';
	var colDueDtTr ='<tr>' +
					'	<td class="title" >최종수금예정일</td>' + 
					'	<td class="pL10">' +
					'		<input type="text" name="colDueDt" class="input01 span_5 calGen" value="' + colDueDt + '"/>' +
					'	</td>' +
					'</tr>'; 
	
	if (templtId == '21')
		$('#decideTBody').html(stDtTr + colDueDtTr);
	else if (templtId == '20')
		$('#decideTBody').html(colDueDtTr);
	
	// Layer 위치 show및 위치 셋팅
	var position = $('#'+checkboxId).position();
	var height = $('#'+checkboxId).height();
	
	$('#decideLayer').show();
	document.getElementById("decideLayer").style.top = position.top + height + "px";
	document.getElementById("decideLayer").style.left = (position.left - parseInt($("#decideLayer").css('width'))) + 'px';
	document.getElementById("decideLayer").style.zIndex = "1";
}

function decideLayerHide() {
	$('#decideLayer').hide();
	$('.decideChk').attr('checked', false);
}

function decide(){
	if(confirm("매출을 확정하시겠습니까?")) {
		var form = $('#decideFrm');
		
		form.attr("action",'/management/updateSalesDecideYn.do');
		form.submit();
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
				<div id="center2">
					<div class="path_navi">
						<ul>
							<li class="stitle">매출건 관리</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 매출건관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 상단 검색창 시작 -->
						<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
<!--									<td colspan="2">-->
<!--										레이아웃을 center2 로 넓게 쓰면서 변경함. 별탈없이 사용하면 나중에 볼때 주석 삭제 -->
<!--									</td>-->
<!--								</tr>-->
<!--								<tr>-->
									<td>
										<a href="javascript:search(-1);"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
										${searchVO.searchYear}년
										<a href="javascript:search(1);"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
										<c:forEach begin="1" end="12" var="mnth">
											<label><input type="radio" class="radio" name="searchMonth" value="${mnth}" 
												<c:if test="${mnth == searchVO.searchMonth}">checked="checked"</c:if>
												onclick="search(0);"> ${mnth}월
											</label>
										</c:forEach>
									</td>
									<td class="search_right">
										<label><input type="checkbox" name="includeResult" value="Y" <c:if test="${searchVO.includeResult == 'Y'}">checked="checked"</c:if>/> 예상실적포함</label>
									</td>
								</tr>
								<tr>
									<td class="search_right">
										<!-- 
										<span class="option_txt">사업구분 : </span>
										<select name="searchBusiId">
											<option value="">============ 선택 ============</option>
											<c:forEach items="${busiIdList}" var="busiId">
												<option value="${busiId.id}" <c:if test="${busiId.id == searchVO.searchBusiId}">selected="selected"</c:if>>${busiId.nm}</option>
											</c:forEach>
										</select><span class="pL7"></span>
										 -->
										<span class="option_txt">부서 : </span>
										<input type="text" class="span_90p" name="searchOrgNm" id="searchOrgNm" value="${searchVO.searchOrgNm}" readonly="readonly"/>
										<input type="hidden" name="searchOrgId" id="searchOrgId" value="${searchVO.searchOrgId}" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" id="searchOrgTreeB"/>
										
									</td>
									<td class="search_right">
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/>
									</td>
								</tr>
							</tbody>
							</table>
							</div>
						</fieldset>
						</form:form>
						<!-- 상단 검색창 끝 -->
						
						10배 이상 손실의 이익률은 0.0%로 표시
						
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 천원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>공지사항 보기</caption>
								<colgroup>
									<col width="px" />
									<col class="px" />
									<col class="col70" />
									<col class="col70" />
									<col class="col60" />
									<col class="col60" />
									<col class="col60" />
									<col class="col60" />
									<col class="col60" />
									<col class="col40" />
									<col class="col40" />
								</colgroup>
								<thead>
									<tr class="height_th">
										<th>프로젝트</th>
										<th>매출명</th>
										<th>매출일</th>
										<th>총매출액</th>
										<th>당월매출</th>
										<th>사외매입</th>
										<th>사내매입</th>
										<th>매출이익</th>
										<th>이익률</th>
										<th>구분</th>
										<th class="td_last">수정</th>
									</tr>
								</thead>
								<tfoot>
									<c:forEach items="${resultSum}" var="resultSumObj">
									<tr>
										<td class="txt_center <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>" colspan="3">${resultSumObj.orgnztNm}</td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.salesSum}" divideBy="${divideby}"/> </td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.sales}" divideBy="${divideby}"/></td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.purchaseOut}" divideBy="${divideby}"/></td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.purchaseIn}" divideBy="${divideby}"/></td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>"><print:currency cost="${resultSumObj.salesProfit}" divideBy="${divideby}"/></td>
										<td class="txt_center bG <c:if test="${resultSumObj.prjId != 'up'}">nb</c:if>">${resultSumObj.salesProfitPercent}%</td>
										<td class="txt_center bG"></td>
										<td class="td_last txt_center bG"></td>
									</tr>
									</c:forEach>
								</tfoot>
								<tbody>
									<c:forEach items="${resultList}" var="result">
										<c:choose>
											<c:when test="${not empty result.docId}">
												<tr>
													<td class="pL10">
														<print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/>
													</td>
													<td class="pL10">
														<a href="/approval/approvalV.do?docId=${result.docId }" target="_blank">${result.salesCt }</a>
													</td>
													<td class="txt_center"><print:date date="${result.salesDt}"/> </td>
													<td class="txt_center"><print:currency cost="${result.salesSum}" divideBy="${divideby}"/> </td>
													<td class="txt_center"><print:currency cost="${result.sales}" divideBy="${divideby}"/></td>
													<td class="txt_center"><print:currency cost="${result.purchaseOut}" divideBy="${divideby}"/></td>
													<td class="txt_center"><print:currency cost="${result.purchaseIn}" divideBy="${divideby}"/></td>
													<td class="txt_center"><print:currency cost="${result.salesProfit}" divideBy="${divideby}"/></td>
													<td class="txt_center">${result.salesProfitPercent}%</td>
													<td class="txt_center">
													<c:choose>
														<c:when test="${result.decideYn=='Y'}">
															확정
														</c:when>
														<c:otherwise>
															예상
															<c:if test="${user.admin || result.writerNo == user.no}">
																<input type="checkbox" id="chk_${result.docId}" class="decideChk" onclick="clickDecideYn('${result.docId}', 'chk_${result.docId}');"/>
															</c:if>
														</c:otherwise>
													</c:choose>
												</td>
													<td class="td_last txt_center">
														<a href="/approval/approvalRW.do?docId=${result.docId }" target="_blank">
															<img src="${imagePath}/btn/btn_plus02.gif">
														</a>
													</td>
													</tr>
											</c:when>
											<c:otherwise>
												<td class="txt_center bG02" colspan="3"><print:project prjCd="${result.prjCd}" prjId="${result.prjId}" prjNm="${result.prjNm}"/> 소계</td>
												<td class="txt_center bG02"><print:currency cost="${result.salesSum}" divideBy="${divideby}"/> </td>
												<td class="txt_center bG02"><print:currency cost="${result.sales}" divideBy="${divideby}"/></td>
												<td class="txt_center bG02"><print:currency cost="${result.purchaseOut}" divideBy="${divideby}"/></td>
												<td class="txt_center bG02"><print:currency cost="${result.purchaseIn}" divideBy="${divideby}"/></td>
												<td class="txt_center bG02"><print:currency cost="${result.salesProfit}" divideBy="${divideby}"/></td>
												<td class="txt_center bG02">${result.salesProfitPercent}%</td>
												<td class="txt_center bG02">
												</td>
												<td class="td_last txt_center bG02"></td>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</tbody>
								</table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 처리상태 변경 레이어  -->
						<form id="decideFrm" name="decideFrm" method="post">
						<div id="decideLayer" class="decide_layer" style="display:none;">
							<p><span class="txtB_Black">※ 매출 확정</span></p>
							<div class="boardWrite02 mB20">
							<input type="hidden" name="docId" value="" />
							<input type="hidden" name="templtId" value="" />
							
							<table cellpadding="0" cellspacing="0">
								<colgroup><col class="col100" /><col width="px"/></colgroup>
								<tbody id="decideTBody">
									
								</tbody>
							</table>
							</div>
							
							<div class="pop_btn_area">
								<input type="button" value="확정" class="btn_gray" onclick="javascript:decide();"/>
								<input type="button" value="취소" class="btn_gray" onclick="javascript:decideLayerHide();"/>
							</div>
						</div>
						</form>
						<!--// 처리상태 변경 레이어  -->
						
					</div>
					<!-- E: section -->
				</div>
<!--				 E: center 				-->
<!--				< %@ include file="../include/right.jsp"%>-->
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
