<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

//검색
function search(pageNo) {
	//document.listForm.searchRegDtS.value=document.listForm.curRegDtS.value;
	//document.listForm.searchRegDtE.value=document.listForm.curRegDtE.value;
	document.listForm.pageIndex.value = pageNo;

	/*
	//전체검색조건
	if(document.listForm.allchk.value = "checked"){
		$("#ckValue").val("checked");
	}
	*/
	document.listForm.submit();
}
function toggleInfo(obj, no){
	if($(obj).hasClass('btn_arrow_down')){
		$(obj).removeClass('btn_arrow_down');
		$(obj).addClass('btn_arrow_up');
		$('.toggleInfo' + no).show();
		var clone = $(obj).clone();
		var span = $(obj).closest('span');
		span.html('간단히 ');
		span.append(clone);
	}
	else{
		$(obj).removeClass('btn_arrow_up');
		$(obj).addClass('btn_arrow_down');
		$('.toggleInfo' + no).hide();
		var clone = $(obj).clone();
		var span = $(obj).closest('span');
		span.html('자세히 ');
		span.append(clone);
	}
}
</script>
</head>

<body>
<!-- S: section -->
	<div class="section02">
    	
    	<p class="th_stitle"><span class="txtB_blue">고객사 : </span><span class="txtB_green2">${searchVO.searchCuNm2}</span></p>
		
		<!-- 상단 검색창 시작 -->
    	<form name="listForm" method="POST" action="${rootPath}/cooperation/selectSearchCustNmConsultManageList.do" onsubmit="search(1); return false;">
    	<input type="hidden" name="pageIndex" value="1"/>
    	
    	<input type="hidden" name="consult_no" />
    	<input type="hidden" name="searchTyp" id="searchTyp"/>
    	<input type="hidden" name="searchServiceTyp" id="searchServiceTyp"/>
    	<input type="hidden" name="searchErrorTyp" id="searchErrorTyp"/>
    	<input type="hidden" name="searchCuNm2" value="${searchVO.searchCuNm2}"/>
    	
    	<div class="boardView">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				<caption>상담관리 상세보기</caption>
				<colgroup>
					<col class="col100" />
					<col width="px" />
				</colgroup>
				<thead>
					<tr>
						<th class="write_info">검색</th>
						<th class="write_info2">
							<input type="text" class="span_13" name="searchQCn" value="${searchVO.searchQCn}"/>
							※ '문의내용'으로 검색합니다.
							<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02 th_stitle_right cursorPointer" alt="검색" />
						</th>
					</tr>
				</thead>
			</table>
    	</div>
		</form>
		<!-- 상단 검색창 끝 -->
		
		<!-- 총 건수 시작 -->
		<br/>
		<p><span class="txtB_Black">총 : ${paginationInfo.totalRecordCount}건</span></p>
		<hr/>
		<!-- 총 건수 끝 -->
		
		<!-- 게시판 시작 -->
		<div class="boardView mB20">
			
			<c:forEach items="${resultList}" var="result" varStatus="c">
				<!-- 고객사정보  -->
				<div class="boardView02">
					<!-- 
					<span>자세히 <img class="btn_arrow_down cursorPointer" onclick="javascript:toggleInfo(this, ${result.no});"/></span>
					-->
					<p class="th_stitle">접수 내용</p>
					
					<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
					<caption>고객사정보</caption>
					<colgroup>
						<col class="col90" />
						<col width="px" />
						<col class="col90" />
						<col width="px" />
						<col class="col90" />
						<col width="px" />
					</colgroup>
					<tbody>
						<tr>
							<th>상담번호</th>
							<td>${result.no}</td>
							<th>접수자</th>
							<td>${result.userNm}</td>
							<th>접수일</th>
							<td><print:date date="${result.regDt}"/></td>
						</tr>
						<tr>
							<th>고객명</th>
							<td colspan="2">${result.custManager}</td>
							<th>연락처</th>
							<td colspan="2">${result.custTelno}</td>
						</tr>
						<tr>
							<th>문의내용</th>
							<td class="qtxt" colspan="5"><print:textarea text="${result.qCn}"/></td>
						</tr>
						<tr class="toggleInfo${result.no}">
							<th>담당자</th>
							<td colspan="5">${fn:substring(result.charged, 0, fn:length(result.charged) - 1)}</td>
						</tr>
					</tbody>
					</table>
				</div>
				<!-- 덧글입력부분 임포트S -->  
				<div id="commentArea">
					<c:import url="${rootPath}/cooperation/selectConsultCommentList.do">							
						<c:param name="type" value="pop" />
						<c:param name="consultNo" value="${result.consultNo}" />
					</c:import>
				</div>
				<br/>
		        <!-- 덧글입력부분 임포트E -->
		        
			</c:forEach>
		</div>
		<!--// 게시판 끝 -->
		
		<!-- 페이징 시작 -->
		<div class="paginate">
              	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
		</div>
		<!-- 페이징 끝 -->
	</div>
	<!-- E: section -->

</body>
</html>
