<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var queryString = "${queryString}";
//mode, pageIndex
function search(page) {
	var form = $('#approvalVO');
	var mode = ${mode };
	if (isNaN(page)) page = 1;
	var pageIndex = page;
	location.href = "/approval/approvalL.do?mode=" + mode + "&pageIndex=" + pageIndex + "&" + form.serialize(); 
	//form.submit();
	
}
//작업중
function checkDocIdList(){

	var obj = document.getElementsByName("docIdList");
	var bChecked = false; 
	for (var i = 0 ; i < obj.length; i++) { 
		if (obj[i].checked == true) { 
			bChecked = true;
		}
	}
	if(bChecked == false){
		return false;
	}	
}

$(document).ready(function() {

	var queryString = "${queryString}";
	
	var form = $('#approvalVO');
	$('#searchB').click(search);
	$("#chkAll").click(function() {
		var checked_status = this.checked;
		$("input[name=docIdList]").each(function() {
			this.checked = checked_status;
		});
		calcTotal();
	});			

	$('input[name=docIdList]').click(function(){
		calcTotal();		
	});
			
	function calcTotal(){
		var totalSum = 0;
		$('input[name=docIdList]:checked').each(function(key,val){
			 totalSum += parseInt(jsDeleteComma($(this).closest('tr').find('span.personPaid').html()));
		});
		$('#totalSum').html(jsAddComma(totalSum));
	};
	
	$('#approvalVO input').keyup(function(e) {
		if(e.keyCode == 13) {
			search();
		}
	});		
	$('#appHandleCompB').click(function(){
		if(form.find('[name=handleDt]').val() == null || form.find('[name=handleDt]').val().length<8){
			alert("처리완료일을 입력하여 주십시오.");
			return; 
		}
		form.attr("action", "/approval/batchHandle.do?stat=1&" + queryString);
		form.submit();
	});

	$('#appHandleCancleB').click(function(){

		if(form.find('[name=handleDt]').val() == null || form.find('[name=handleDt]').val().length<8){
			alert("처리완료일을 입력하여 주십시오.");
			return; 
		}
		form.attr("action", "/approval//batchHandle.do?stat=2" + queryString);
		form.submit();

	});
	
	$('#acceptBatch').click(function(){
		form.attr("action", "/approval/AcceptBatch.do?${queryString}");
		form.submit();
	});

	$('.acceptBatchSelect').click(function(){
		if(checkDocIdList() == false) {
			alert('일괄결재 문서를 선택해주세요')
			return;
		}		
		form.attr("action", "/approval/acceptBatchSelect.do?${queryString}");
		form.submit();
	});

	$('#refBatchSelect').click(function(){ //복사해서 이름만 변경, 재사용할지 미결정
		if(checkDocIdList() == false) {
			alert('참조할 문서를 선택해주세요')
			return;
		}		
		form.attr("action", "/approval/refBatchSelect.do?${queryString}");
		form.submit();
	});
		
	$('#appRejectB').click(function(){
		form.attr("action", "/approval/appAccept.do?stat=2&ajax=0");
		form.submit();
	});

	$('#deleteB').click(function(){
		if(confirm("삭제된 문서는 되돌릴 수 없습니다. 정말 삭제하시겠습니까?")){
			form.attr('action','/approval/deleteSaveDocs.do?' + queryString);
			form.submit();
		}
	});

	$('#checkAll').change(function(){
		if($(this).attr("checked"))
			$('input[name=checkList]').attr("checked",true);
		else
			$('input[name=checkList]').attr("checked",false);
	});

	if ('${approvalVO.searchAllPeriod}' == '1') {
		$('#searchBgnDe').attr('disabled', true);
		$('#searchEndDe').attr('disabled', true);
	}
});

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.top_search08 input[name=searchWriterNm]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
}

function selectPageUnit(cnt) {
	$('input[name=pageUnit]').val(cnt);
	
	// Cookie에 페이지 조회 줄수 담기(30일 보관)
	setCookie('hanmam_approval_pageunit', cnt, 30);
	
	search(1);
}


function clickChkboxDate() {
	var allchk = $('#searchAllPeriod');

	$('#searchBgnDe').attr('disabled', allchk.is(':checked'));
	$('#searchEndDe').attr('disabled', allchk.is(':checked'));
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
							<li class="stitle">${pageSj }</li>
							<li class="navi">${pageNavi }</li>
						</ul>
					</div>
					<span class="stxt">${pageDesc }</span>
					<form:form commandName="approvalVO" name="approvalVO" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="pageUnit" value="${paginationInfo.recordCountPerPage}"/>
					<div class="section01">
					<!-- S: section -->
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
											<div class="top_search08 mT5">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col80"/>
								<col class="col18p"/>
								<col class="col80"/>
								<col class="col18p"/>
								<col class="col80"/>
								<col class="col20p"/>
								<col width="px"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="fr pT5 pR5 txtB_Black">결재양식</td>
									<td><form:select path="searchTempltId" items="${templtIdMap}"></form:select></td>
									<td class="fr pT5 pR5 txtB_Black">회사</td>
									<td colspan="3"><form:select path="searchCompanyId" items="${companyIdMap}"></form:select></td>
									<td class="pL10">
										<img id="searchB" class="cursorPointer"
											 <c:choose>
												<c:when test="${(searchBox==1)||(searchBox==2) }">
													src='${imagePath}/btn/btn_search02.gif'
												</c:when>
												<c:otherwise>
													src='${imagePath}/btn/btn_search02.gif'
												</c:otherwise>
											 </c:choose>
										/>
									</td>
								</tr>
								<tr>
									<td class="fr pT5 pR5 txtB_Black">
										<c:if test="${(searchBox==1)||(searchBox==3)}"> 
											기안자
										</c:if>
									</td>
									<td>
										<c:if test="${(searchBox==1)||(searchBox==3)}"> 
											<form:input path="searchWriterNm" id="searchWriterNm" cssClass="span_80p input01 userNameAutoHead"/>
											<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchWriterNm',1,cutUsrGenName);" class="cursorPointer">
										</c:if>
									</td>
									<td class="fr pT5 pR5 txtB_Black">제목</td>
									<td colspan="3"><form:input path="searchSubject" cssClass="span_90p input01"/></span></td>
								</tr>
								
								<c:if test="${(searchBox==1)||(searchBox==2) }"> 
								<tr>
									<td class="fr pT5 pR5 txtB_Black">기안일</td>
									<td colspan="3">
										<form:input path="searchBgnDe" id="searchBgnDe" cssClass="span_4 input01 calGen" maxlength="8" />&nbsp;~
										<form:input path="searchEndDe" id="searchEndDe" cssClass="span_4 input01 calGen" maxlength="8" />&nbsp;
										<input type="hidden" id="ckValue" name="ckValue" value=""/>
										<label><form:checkbox cssClass="check" path="searchAllPeriod" id="searchAllPeriod" value="1" onclick="clickChkboxDate();"/> 전체</label>
									</td>
									<td class="fr pT5 pR5 txtB_Black">결재상태:</td>
									<td>
										<label><form:checkbox cssClass="check" path="searchdocStatL" value="APP004" /> 참조중</label> 
										<label><form:checkbox cssClass="check" path="searchdocStatL" value="APP005" /> 참조완료</label>
									</td>
								</tr>
								
								<tr>
									<td class="fr pT5 pR5 txtB_Black">지출금액</td>
									<td><form:input path="searchExpMoney" cssClass="span_90p input01"/></td>
									<td class="fr pT5 pR5 txtB_Black">지출내용</td>
									<td><form:input path="searchExpDesc" cssClass="span_90p input01"/></span></td>
									<td class="fr pT5 pR5 txtB_Black">처리상태:</td>
									<td>
										<label><form:checkbox cssClass="check" path="searchHandleStatL" value="0"/> 처리중</label>
										<label><form:checkbox cssClass="check" path="searchHandleStatL" value="1"/> 처리완료</label>
										<!-- <form:checkbox cssClass="check" path="searchHandleStatL" value="2"/> 취소 -->
										<!--<form:checkbox cssClass="check" path="searchDoHandle"  value="N" /> 처리불필요-->
									</td>
								</tr>
								</c:if>
							</tbody>
							</table>
							<div class="clear"></div>
							</div>
						</fieldset>
						<!-- 상단 검색창 끝 -->
						
						<div class="boardList mB20">
						
						<!-- 상단 바 시작 -->
						<div class="pB10">
							<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
								<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
								<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
								<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
							</select>
							<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
							
							<c:if test="${mode==2 || mode==12}">
							<!--일괄결재 기능에서 선택결재 기능으로 변경, 버튼은 그대로 사용-->						
							<!--<a href="/approval/AcceptBatch.do?${queryString}"><img src="${imagePath}/btn/btn_approval.gif"/></a>-->
								<img class="acceptBatchSelect cursorPointer" src="${imagePath}/btn/btn_approval.gif"/>
							</c:if>
						</div>
						<!-- 상단 바 끝 -->
						
						<c:choose>

						<c:when test="${mode==13}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>13 처리할 문서</caption>
						<colgroup>
							<col class="col20" />
							<col class="col40" />							
							<col class="col70" />
							<col class="col11" />
							<col width="px" />
							<col class="col50" />
							<col class="col60" />
							<col class="col80" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>
							<th scope="col">번호</th>							
							<th scope="col">구분</th>
							<th scope="col"></th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일</th>
							<th scope="col">결재상태</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
						<tbody>

						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="txt_center"><input type="checkbox" name="docIdList" value="${result.docId}"/></td>
								<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
								<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
									${result.templtNmBr}</a>
								</td>
								<td class="txt_center"></td>
								<td>
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										<c:if test="${result.newAt == 0}"><span class="txtS_green">[무효]</span></c:if>
										<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
											${result.subject}
										</span>
										<c:if test="${10 <= result.templtId && result.templtId <= 19}">
											<span class="txt_blue">[개인결제금액 : <span class="personPaid"><print:currency cost="${result.expSum}" /></span>원]</span>
										</c:if>
										<c:if test="${result.exceedManage == 'Y'}">
										<span class="txtS_yellow2">[판관비초과]</span>
										</c:if>
										<c:if test="${result.expiredDate == 'Y'}">
										<span class="txtS_yellow2">[기한초과]</span>
										</c:if>
									</a>
								</td>
								<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
								<td class="txt_center">${fn:substring(result.writeDtMedium, 3, 8)}<br/>${fn:substring(result.writeDtMedium, 9, fn:length(result.writeDtMedium))}</td>
								<td class="txt_center" >
									${result.docStatPrint}<br/>(<print:date date="${result.preAppDtShort}" printType='M'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}">(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
							</tr>
						 </c:forEach>																																																														
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode==14}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>14 모든 결재문서</caption>
						<colgroup>
							<col class="col20" />
							<col class="col40" />							
							<col class="col70" />
							<col class="col11" />
							<col width="px" />
							<col class="col50" />
							<col class="col60" />
							<col class="col80" />
							<col class="col60" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col"></th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일</th>
							<th scope="col">결재상태</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
						<tbody>

						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
								<td class="txt_center"><input type="checkbox" name="docIdList" value="${result.docId}"/></td>
								<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
								<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
									${result.templtNmBr}</a>
								</td>
								<td class="txt_center"></td>
								<td>
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										<c:if test="${result.newAt == 0}"><span class="txtS_green">[무효]</span></c:if>
										<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
											${result.subject}
										</span>
										<c:if test="${10 <= result.templtId && result.templtId <= 19}">
											<span class="txt_blue">[개인결제금액 : <span class="personPaid"><print:currency cost="${result.expSum}" /></span>원]</span>
										</c:if>
										<c:if test="${result.exceedManage == 'Y'}">
										<span class="txtS_yellow2">[판관비초과]</span>
										</c:if>
										<c:if test="${result.expiredDate == 'Y'}">
										<span class="txtS_yellow2">[기한초과]</span>
										</c:if>
									</a>
								</td>
								<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
								<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
								<td class="txt_center" >
									${result.docStatPrint}<br/>(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}"><br/>(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
							</tr>
						</c:forEach>
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode==10 || mode == 11 }">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>10 내가 기안한문서 11 내가 결재한문서</caption>
						<colgroup>
							<col class="col40" />
							<col class="col130" />
							<col width="px" />
							<col class="col50" />
							<col class="col60" />
							<col class="col100" />
							<col class="col80" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일</th>
							<th scope="col">결재상태</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
									<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										${result.templtNmBr}</a>
									</td>
									<td>
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<c:if test="${result.newAt == 0}"><span class="txtS_green">[무효]</span></c:if>
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if> 
											<c:if test="${(!empty result.srchDt) && result.stat == 0 && mode == 12}">class="txtS_yellow2"</c:if> >
												${result.subject}
											</span>
											<c:if test="${10 <= result.templtId && result.templtId <= 19}">
												<span class="txt_blue">
													[개인결제금액 : 
													<span class="personPaid">
														<print:currency cost="${result.expSum}" />
													</span>
													원]
												</span>
											</c:if>
											<c:if test="${result.exceedManage == 'Y'}">
												<span class="txtS_yellow2">[판관비초과]</span>
											</c:if>
											<c:if test="${result.expiredDate == 'Y'}">
												<span class="txtS_yellow2">[기한초과]</span>
											</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
								<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
								<td class="txt_center" >
									${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}"><br/>(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
								</tr>
							 </c:forEach>																																																													
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode==1}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>1 저장된문서</caption>
						<colgroup>
							<col class="col40" />
							<col class="col40" />
							<col class="col130" />
							<col width="px" />
							<col class="col50" />
							<col class="col110" />
							<col class="col120" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col"><label><input type="checkbox" class="check" id="checkAll"/></label></th>
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일시</th>
							<th scope="col">결재상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="txt_center">
										<label><input type="checkbox" name="checkList" value="${result.docId}" class="check"/></label>
									</td>
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
									<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										${result.templtNmBr}</a>
									</td>
									<td >
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
												${result.subject} </span>
											<c:if test="${result.exceedManage == 'Y'}">
											<span class="txtS_yellow2">[판관비초과]</span>
											</c:if>
											<c:if test="${result.expiredDate == 'Y'}">
											<span class="txtS_yellow2">[기한초과]</span>
											</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">
									${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							 </c:forEach>																																																													
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode==2}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>2 승인할문서</caption>
						<colgroup>
							<col class="col20" />
							<col class="col50" />							
							<col class="col70" />
							<col class="col11" />
							<col width="px" />
							<col class="col60" />
							<col class="col60" />
							<col class="col80" />							
						</colgroup>
						<thead>
							<tr>												
							<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>							
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col"></th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일시</th>
							<th scope="col">결재상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="txt_center"><input type="checkbox" name="docIdList" value="${result.docId}"/></td>
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
									<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										${result.templtNmBr}</a>
									</td>
									<td class="txt_center"></td>
									<td >
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
												${result.subject} </span>
											<c:if test="${10 <= result.templtId && result.templtId <= 19}">
											<span class="txt_blue">[개인결제금액 : <span class="personPaid"><print:currency cost="${result.expSum}" /></span>원]</span>
											</c:if>
											<c:if test="${result.exceedManage == 'Y'}">
											<span class="txtS_yellow2">[판관비초과]</span>
											</c:if>
											<c:if test="${result.expiredDate == 'Y'}">
											<span class="txtS_yellow2">[기한초과]</span>
											</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${fn:substring(result.writeDtMedium, 3, 8)}<br/>${fn:substring(result.writeDtMedium, 9, fn:length(result.writeDtMedium))}</td>
									<td class="txt_center">
									${result.docStatPrint}<br/>(<print:date date="${result.preAppDtShort}" printType='M'/>)</td>
								</tr>
							 </c:forEach>																																																													
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode == 12 }">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>12 참조할문서</caption>
						<colgroup>
							<col class="col20" />
							<col class="col50" />							
							<col class="col70" />
							<col class="col11" />
							<col width="px" />
							<col class="col60" />
							<col class="col60" />
							<col class="col80" />
							<col class="col80" />							
						</colgroup>
						<thead>
							<tr>												
							<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>							
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col"></th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일시</th>
							<th scope="col">결재상태</th>
							<th scope="col">처리상태</th>
							</tr>
						</thead>
												
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="txt_center"><input type="checkbox" name="docIdList" value="${result.docId}"/></td>
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
									<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										${result.templtNmBr}</a>
									</td>
									<td class="txt_center"></td>
									<td>
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<c:if test="${result.newAt == 0}"><span class="txtS_green">[무효]</span></c:if>
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if> 
											<c:if test="${(!empty result.srchDt) && result.stat == 0 && mode == 12}">class="txtS_yellow2"</c:if> >
												${result.subject}
											</span>
											<c:if test="${10 <= result.templtId && result.templtId <= 19}">
												<span class="txt_blue">
													[개인결제금액 : 
													<span class="personPaid">
														<print:currency cost="${result.expSum}" />
													</span>
													원]
												</span>
											</c:if>
											<c:if test="${result.exceedManage == 'Y'}">
												<span class="txtS_yellow2">[판관비초과]</span>
											</c:if>
											<c:if test="${result.expiredDate == 'Y'}">
												<span class="txtS_yellow2">[기한초과]</span>
											</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
<!--								<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>-->
								<td class="txt_center">${fn:substring(result.writeDtMedium, 3, 8)}<br/>${fn:substring(result.writeDtMedium, 9, fn:length(result.writeDtMedium))}</td>
								<td class="txt_center" >
									${result.docStatPrint}<br/>(<print:date date="${result.preAppDtShort}" printType='M'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}"><br/>(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
								</tr>
							 </c:forEach>																																																													
						</tbody>
						</table>
						</c:when>
						
						<c:otherwise>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>그외 3 기안한문서 4 결재이후문서 5 반려된 문서 7 결재이전문서 (2012.01.26 이후 미사용 모드 6 확인완료된 반려문서 8 내가 참조할 문서 9 결재진행중인 모든문서)</caption>
						<colgroup>							
							<col class="col40" />
							<col class="col130" />
							<col width="px" />
							<col class="col50" />
							<col class="col110" />
							<col class="col120" />
						</colgroup>
						<thead>
							<tr>			
							<th scope="col">번호</th>
							<th scope="col">구분</th>
							<th scope="col">제목</th>
							<th scope="col">기안자</th>
							<th scope="col">기안일시</th>
							<th scope="col">결재상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr>
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageUnit + status.index)}"/></td>
									<td class="txt_center">
									<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
										${result.templtNmBr}</a>
									</td>
									<td >
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
												${result.subject} </span>
											<c:if test="${10 <= result.templtId && result.templtId <= 19}">
											<span class="txt_blue">[개인결제금액 : <span class="personPaid"><print:currency cost="${result.expSum}" /></span>원]</span>
											</c:if>
											<c:if test="${result.exceedManage == 'Y'}">
											<span class="txtS_yellow2">[판관비초과]</span>
											</c:if>
											<c:if test="${result.expiredDate == 'Y'}">
											<span class="txtS_yellow2">[기한초과]</span>
											</c:if>
										</a>
									</td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">
									${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							 </c:forEach>
						</tbody>
						</table>
						</c:otherwise>
						</c:choose>
					</div>
					
					<div class="paginate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />	
					</div>	
					
					<!-- 하단 바 시작 -->
					<div class="pB10">
						<select class="select01" onchange="selectPageUnit(this.options[this.selectedIndex].value)">
							<option value="15" <c:if test="${paginationInfo.recordCountPerPage==15}">selected="selected"</c:if> >15줄</option>
							<option value="30" <c:if test="${paginationInfo.recordCountPerPage==30}">selected="selected"</c:if> >30줄</option>
							<option value="50" <c:if test="${paginationInfo.recordCountPerPage==50}">selected="selected"</c:if> >50줄</option>
						</select>
						<span class="txtB_Black mR20">총 : ${paginationInfo.totalRecordCount}건</span>
					
					
						<c:if test="${mode==1}">
							<div class="btn_area">
							<img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" id="deleteB"/>
						</div>
					</c:if>
						<c:if test="${mode==2 || mode==12}">
							<!--일괄결재 기능에서 선택결재 기능으로 변경, 버튼은 그대로 사용-->						
							<!--<a href="/approval/AcceptBatch.do?${queryString}"><img src="${imagePath}/btn/btn_approval.gif"/></a>-->
							<img class="acceptBatchSelect cursorPointer" src="${imagePath}/btn/btn_approval.gif"/>
						</c:if>
					
					</div>
					<!-- 하단 바 끝 -->
					
					<c:if test="${mode==13 || (mode==14 && handleCheckBox==1)}">
						<jsp:include page="${jspPath}/approval/include/handleWrite.jsp"></jsp:include>
					</c:if>
					
					<c:if test="${mode==14 && handleComplete==1}">
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>댓글달기</caption>
								<colgroup>
									<col width="120" />
									<col width="px" />
								</colgroup>
								<tr>
									<td class="title">지급총액</td>
									<td class="pL10 pT5 pB5"><span class="txt_blue" id="totalSum">0</span>원</td>
								</tr>
							</table>
						</div>
					</c:if>
						
					</div>
					</form:form>
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

