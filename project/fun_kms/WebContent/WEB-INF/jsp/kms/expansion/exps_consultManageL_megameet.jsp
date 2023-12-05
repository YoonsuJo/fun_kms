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
//상담관리 상세화면 이동
function view(no) {
	document.listForm.consult_no.value = no;	
	document.listForm.action = "${rootPath}/cooperation/withoutLogin/selectConsultManage.do";
	document.listForm.submit();
}
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
	
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="listForm" method="POST" action="${rootPath}/cooperation/withoutLogin/selectConsultManageList.do" onsubmit="search(1); return false;">
			    	<input type="hidden" name="pageIndex" value="1"/>
			    	<input type="hidden" name="consult_no" />
	                </form>
                	<!-- 상단 검색창 끝 -->
					
					<!-- 게시판 시작 -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
						<caption>고객사정보</caption>
						<colgroup>
							<col width="20px" />
							<col width="30px" />
							<col width="30px" />
							<col width="30px" />
							<col width="px" />
							<col class="col90" />
							<col class="col50" />
							<col class="col90" />
							<col class="col50" />
							<col class="col40" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col"> </th>
							<th scope="col">구분</th>
							<th scope="col">분류</th>
							<th scope="col">지라</th>
							<th scope="col">문의내용</th>
							<th scope="col">고객사</th>
							<th scope="col">상담원</th>
							<th scope="col">담당자</th>
							<th scope="col">접수<br/>일시</th>
							<th scope="col">처리<br/>상태</th>							
							<th scope="col">열람</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="txt_center">
										<c:if test="${result.typ == '1'}">멀티</c:if>
										<c:if test="${result.typ == '2'}">메가</c:if>
										<c:if test="${result.typ == '3'}">스쿨</c:if>
										<c:if test="${result.typ == '4'}">KT</c:if>
										<c:if test="${result.typ == '5'}">메신</c:if>
										<c:if test="${result.typ == '6'}">코덱</c:if>
									</td>
									<td class="txt_center">
										<c:if test="${result.serviceTyp == '1'}">일반</c:if>
										<c:if test="${result.serviceTyp == '2'}">영업</c:if>
										<c:if test="${result.serviceTyp == '3'}">장애</c:if>
										<c:if test="${result.serviceTyp == '4'}">화상</c:if>
										<c:if test="${result.serviceTyp == '5'}">기타</c:if>
									</td>
									<td class="txt_center">${result.jiraYn}</td>
									<td class="pL5">
			                    		<a href="javascript:view('${result.consultNo}');">
		                    				<c:if test="${fn:length(result.qCn) > 40}">
                   								${fn:substring(result.qCn, 0, 40)}...
                   							</c:if>
                   							<c:if test="${fn:length(result.qCn) <= 40}">
                   								${result.qCn}
                   							</c:if>
			                    			<c:if test="${result.commentCnt > 0}">[${result.commentCnt}]</c:if>
			                    		</a>
			                    	</td>
									<td class="pL5">
										<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custNm}</div>
									</td>
									<td class="txt_center">${result.userNm}</td>
									<td class="txt_center">
										<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${fn:substring(result.charged, 0, fn:length(result.charged) - 1)}</div>
									</td>
									<td class="txt_center"><print:date date="${result.regDt}" printType="S"/></td>
									<td class="txt_center">
										<c:if test="${result.state == '1'}">접수</c:if>
										<c:if test="${result.state == '2'}">처리중</c:if>
										<c:if test="${result.state == '3'}">처리<br/>완료</c:if>
										<c:if test="${result.state == '4'}">종료</c:if>
										<c:if test="${result.state == '5'}">미종료</c:if>
									</td>
									<td class="txt_center">${result.readStat}</td>
								</tr>						
							</c:forEach>
						</tbody>
						</table>
					</div>
					<!--// 게시판 끝 -->
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
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
</div>
</body>
</html>
