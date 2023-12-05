<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
							<li class="stitle">전자결재현황</li>
							<li class="navi">홈 > 전자결재 > 전자결재현황</li>
						</ul>
					</div>
					
					<span class="stxt">전자결재 현황을 보여줍니다.</span>
	
					<!-- S: section -->
					<div class="section01">
	
						<p class="th_stitle mB10">진행현황 요약 </p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup>
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
								<th scope="col" colspan="5">내가 상신한 문서</th>
								<th scope="col" rowspan="2">승인할 문서</th>
								<th scope="col" rowspan="2" class="td_last">처리할 문서</th>
								</tr>
								<tr>
								<th>검토중</th>
								<th scope="col">협조중</th>
								<th scope="col">전결중</th>
								<th scope="col">결재실패</th>
								<th scope="col">처리중</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=3">${summaryVO.reviewCnt }</a></td>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=3">${summaryVO.cooperationCnt }</a></td>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=3">${summaryVO.decideCnt }</a></td>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=5">${summaryVO.rejectCnt }</a></td>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=10&searchHandleStatL=0&searchHandleStatL=2">${summaryVO.whileHandingCnt }</a></td>
									<td class="txt_center"><a href="/approval/approvalL.do?mode=2">${summaryVO.doApprovalCnt }</a></td>
									<td class="txt_center td_last"><a href="/approval/approvalL.do?mode=13">${doHandleCnt}</a></td>
								</tr>
							</tbody>
							</table>
						</div>
	
						<p class="th_stitle mB10">내가 승인할 문서
							 <span class="pL10 txt_red">${summaryVO.doApprovalCnt }</span>  
							 <span class="th_plus">
							 	<c:if test="${summaryVO.doApprovalCnt>=6}">
									<a href="/approval/approvalL.do?mode=2"> 더보기 </a> 
							 	</c:if>
							 </span>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup>
								<col class="col130" />
								<col width="px" />
								<col class="col50" />
								<col class="col100" />
								<col class="col120" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
								<th scope="col">기안자</th>
								<th scope="col">기안일시</th>
								<th scope="col">결재상태</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${doApprovalList}" varStatus="status">
								<tr>
									<td class="txt_center">${result.templtNm}</td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=2">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach>
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle mB10">내가 처리할 문서
							 <span class="pL10 txt_red">${doHandleCnt }</span>  
							 <span class="th_plus">
							 	<c:if test="${doHandleCnt>=6}">
									<a href="/approval/approvalL.do?mode=13"> 더보기 </a>
							 	</c:if>
							 </span>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup>
								<col class="col130" />
								<col width="px" />
								<col class="col50" />
								<col class="col100" />
								<col class="col120" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
								<th scope="col">기안자</th>
								<th scope="col">기안일시</th>
								<th scope="col">결재상태</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${doHandleList}" varStatus="status">
								<tr>
									<td class="txt_center">${result.templtNm}</td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=13">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach>												
							</tbody>															
							</table>
						</div>
						
						<p class="th_stitle mB10">결재 진행중인 문서 
						<a href="/approval/approvalL.do?mode=3"><span class="th_plus">더보기</span></a>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup>
								<col class="col130" />
								<col width="px" />
								<col class="col50" />
								<col class="col100" />
								<col class="col120" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
								<th scope="col">기안자</th>
								<th scope="col">기안일시</th>
								<th scope="col">결재상태</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${myApprovalList}" varStatus="status">
								<tr>
									<td class="txt_center">${result.templtNm}</td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=3">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach>											
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle mB10">결재 완료된 문서  
						<a href="/approval/approvalL.do?mode=10"><span class="th_plus">더보기</span></a>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup>
								<col class="col130" />
								<col width="px" />
								<col class="col50" />
								<col class="col60" />
								<col class="col100" />
								<col class="col80" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">구분</th>
								<th scope="col">제목</th>
								<th scope="col">기안자</th>
								<th scope="col">기안일</th>
								<th scope="col">결재상태</th>
								<th scope="col">처리상태</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${myCompApprovalList}" varStatus="status">
								<tr>
									<td class="txt_center">${result.templtNm}</td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=10">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center"><print:date date="${result.writeDtShort}" printType='S'/></td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
									<td class="txt_center">
										${result.handleStatPrint}<c:if test="${result.doHandle=='Y' && (result.handleStat==1 || result.handleStat==2)}">(<print:date date="${result.handleDt }" printType='S'/>)</c:if>
									</td>
								</tr>
							</c:forEach>			
							</tbody>
							</table>
						</div>
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
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>
