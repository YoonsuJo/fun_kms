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
function search(page)
{
	var form = $('#approvalVO');
	var mode = "${mode}";
	var pageIndex ="${approvalVO.pageIndex}";
	if(!isNaN(page))
		pageIndex = page;
	location.href = "/approval/approvalL.do?mode="+ mode + "&pageIndex="+pageIndex +"&" + form.serialize(); 
	//form.submit();
	
}
$(document).ready(function() {

	var queryString = "${queryString}";
	
	var form = $('#approvalVO');
	$('#searchB').click(search);
	$("#chkAll").click(function()				
	{
		var checked_status = this.checked;
		$("input[name=docIdList]").each(function()
		{
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
		
});


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
		<%@ include file="left.jsp"%>
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
					<div class="section01">
					<!-- S: section -->
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
	                    <div class="top_search08 mT5">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col160" />
								<col class="col200" />
								<col width="px" />
								<col class="col40" />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<span class="mL15"><form:select path="searchTempltId" items="${templtIdMap}"></form:select></span>
									</td>
									<td class="txt_right">
										<span class="mL15"><c:if test="${(searchBox==1)||(searchBox==3)}"> 
											기안자 : <form:input path="searchWriterNm" cssClass="span_6 input01"/>
										</c:if></span>
									</td>
									<td class="txt_right pR15">
										<span class="mL15">제목 : <form:input path="searchSubject" cssClass="span_8 input01"/></span>
									</td>
									<td rowspan="3" class="pL10">
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
								
								<c:if test="${(searchBox==1)||(searchBox==2) }"> 
								<tr>
									<td></td>
									<td class="txt_right">
										<span class="mL15"> 
											지출금액 : <form:input path="searchExpMoney" cssClass="span_6 input01"/>
										</span>
									</td>
									<td class="txt_right pR15">
										<span class="mL15">지출내용 : <form:input path="searchExpDesc" cssClass="span_8 input01"/></span>
									</td>
								</tr>
								<tr>
									<td class="pR20" colspan="3">
										<span class="mL15">결재상태 :</span> 
										<form:checkbox cssClass="check" path="searchdocStatL" value="APP004" /> 참조중 
										<form:checkbox cssClass="check" path="searchdocStatL" value="APP005" /> 참조완료
										<span class="pL70">처리상태 :</span>
										<form:checkbox cssClass="check" path="searchHandleStatL" value="0"/> 처리중
										<form:checkbox cssClass="check" path="searchHandleStatL" value="1"/> 처리완료
										<form:checkbox cssClass="check" path="searchHandleStatL" value="2"/> 취소
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
						<c:choose>
						<c:when test="${mode==13 || mode==14}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col20" />
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
							<th scope="col"><input type="checkbox" name="chk" id="chkAll"/></th>
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
								<td class="txt_center"><input type="checkbox" name="docIdList" value="${result.docId}"/></td>
								<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageSize + status.index)}"/></td>
								<td class="txt_center">${result.templtNm}</td>
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
									${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}">(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
							</tr>
						 </c:forEach>																																																														
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode>=10}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
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
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageSize + status.index)}"/></td>
									<td class="txt_center">${result.templtNm}</td>
									<td>
										<a href="/approval/approvalV.do?docId=${result.docId }&${queryString}">
											<c:if test="${result.newAt == 0}"><span class="txtS_green">[무효]</span></c:if>
											<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if> <c:if test="${(!empty result.srchDt) && result.stat == 0 && mode == 12}">class="txtS_yellow2"</c:if>>
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
									${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								<td class="txt_center">
									${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}">(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
								</td>
								</tr>
							 </c:forEach>																																																													
						</tbody>
						</table>
						</c:when>
						
						<c:when test="${mode==1}">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col40" />
							<col class="col130" />
							<col width="px" />
							<col class="col50" />
							<col class="col100" />
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
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageSize + status.index)}"/></td>
									<td class="txt_center">${result.templtNm}</td>
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
						
						<c:otherwise>
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40" />
							<col class="col130" />
							<col width="px" />
							<col class="col50" />
							<col class="col100" />
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
									<td class="txt_center"><c:out value="${resultCnt - ((approvalVO.pageIndex-1) * approvalVO.pageSize + status.index)}"/></td>
									<td class="txt_center">${result.templtNm}</td>
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
					
					<c:if test="${mode==13 || (mode==14 && handleCheckBox==1)}">
						<jsp:include page="${jspPath}/approval/include/handleWrite.jsp"></jsp:include>
					</c:if>
					<c:if test="${mode==1}">
						<div class="btn_area">
	                		  <img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" id="deleteB"/>
	               	    </div>
               	    </c:if>
					<c:if test="${mode==2}">
						<div class="btn_area">
	                		  <a href="/approval/AcceptBatch.do?${queryString}"><img src="${imagePath}/btn/btn_approval.gif"/></a>
	               	    </div>
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
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>

