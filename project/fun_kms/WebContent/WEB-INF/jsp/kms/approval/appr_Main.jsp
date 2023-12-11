<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){

	/*  $('#doApproval').click(function(){ */
		$.ajax({
			url: "/approval/ajax/main.do",
			type: "POST",
			dataType: "text",
			data : {
				"mode" : "2",
		   	},
			success: function(data) {
				var jsonParse = $.parseJSON(data);
				var result = $.parseJSON(jsonParse.apprList);
				$("#doApprovalTbody").empty();
				for(var i=0;i<result.length;i++){
					var html = "";
					html += '<tr>';
					html += '<td class="txt_center"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=2">'+result[i].templtNm+'</a></td>';
					html += '<td><a href="${rootPath}/approval/approvalV.do?docId='+result[i].docId+'&mode=2">'+result[i].subject+'</a></td>';
					html += '<td class="txt_center"><print:user userNo="'+result[i].writerNo+'" userNm="'+result[i].writerNm+'"/></td>';
					html += '<td class="txt_center">'+result[i].writeDt.substring(2,result[i].length)+'</td>';
					html += '<td class="txt_center">'+docStatPrint(result[i].docStat)+'('+result[i].preAppDt.substring(2,4)+result[i].preAppDt.substring(4,10)+')</td>';
					html += '</tr>';
					$("#doApprovalTbody").append(html);
				}
			},
			error: function(xhr, testStatus, errorThrown) {
				return false;
			 	}
		});
	/* }); */
	 
	 /* $('#doHandleAppr').click(function(){ */
		$.ajax({
			url: "/approval/ajax/main.do",
			type: "POST",
			dataType: "text",
			data : {
				"mode" : "13",
		   	},
			success: function(data) {
				var jsonParse = $.parseJSON(data);
				var result = $.parseJSON(jsonParse.apprList);
				var handleCnt = jsonParse.doHandleCnt;
				$("#doHandleTbody").empty();
				for(var i=0;i<result.length;i++){
					var html = "";
					html += '<tr>';
					html += '<td class="txt_center">'+result[i].templtNm+'</td>';
					html += '<td><a href="${rootPath}/approval/approvalV.do?docId='+result[i].docId+'&mode=13">'+result[i].subject+'</a></td>';
					html += '<td class="txt_center"><print:user userNo="'+result[i].writerNo+'" userNm="'+result[i].writerNm+'"/></td>';
					html += '<td class="txt_center">'+result[i].writeDt.substring(2,result[i].length)+'</td>';
					html += '<td class="txt_center">'+docStatPrint(result[i].docStat)+'('+result[i].preAppDt.substring(2,4)+result[i].preAppDt.substring(4,10)+')</td>';
					html += '</tr>';
					$("#doHandleTbody").append(html);
				}
				if(handleCnt > 0){
					$("#doHandleCnt").empty();
					$("#doHandleCnt").text(handleCnt);	
					$("#doHandleApprPlus").empty();
					$("#doHandleApprPlus").append('<a href="/approval/approvalL.do?mode=13"> 더보기 </a>');
					
				}
				$("#doHandleCntTd").empty();
				$("#doHandleCntTd").text(handleCnt);
				
			},
			error: function(xhr, testStatus, errorThrown) {
				return false;
			 	}
		});
	/* });  */
	 
	 /* $('#myAppr').click(function(){ */
		$.ajax({
			url: "/approval/ajax/main.do",
			type: "POST",
			dataType: "text",
			data : {
				"mode" : "3",
		   	},
			success: function(data) {
				var jsonParse = $.parseJSON(data);
				var result = $.parseJSON(jsonParse.apprList);
				$("#myApprovalTbody").empty();
				for(var i=0;i<result.length;i++){
					var html = "";
					html += '<tr>'
					html += '<td class="txt_center"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=3">'+result[i].templtNm+'</a></td>';
					html += '<td><a href="${rootPath}/approval/approvalV.do?docId='+result[i].docId+'&mode=3">'+result[i].subject+'</a></td>';
					html += '<td class="txt_center"><print:user userNo="'+result[i].writerNo+'" userNm="'+result[i].writerNm+'"/></td>';
					html += '<td class="txt_center">'+result[i].writeDt.substring(2,result[i].length)+'</td>';
					html += '<td class="txt_center">'+docStatPrint(result[i].docStat)+'('+result[i].preAppDt.substring(2,4)+result[i].preAppDt.substring(4,10)+')</td>';
					html += '</tr>';
					$("#myApprovalTbody").append(html);
				}
			},
			error: function(xhr, testStatus, errorThrown) {
				return false;
			 	}
		/* }); */
	}); 
	 
	 /* $('#completeAppr').click(function(){ */
		$.ajax({
			url: "/approval/ajax/main.do",
			type: "POST",
			dataType: "text",
			data : {
				"mode" : "10",
		   	},
			success: function(data) {
				var jsonParse = $.parseJSON(data);
				var result = $.parseJSON(jsonParse.apprList);
				$("#completeApprTbody").empty();
				for(var i=0;i<result.length;i++){
					var html = "";
					html += '<tr>';
					html += '<td class="txt_center">'+result[i].templtNm+'</td>';
					html += '<td><a href="${rootPath}/approval/approvalV.do?docId='+result[i].docId+'&mode=10">'+result[i].subject+'</a></td>';
					html += '<td class="txt_center"><print:user userNo="'+result[i].writerNo+'" userNm="'+result[i].writerNm+'"/></td>';
					html += '<td class="txt_center">'+result[i].writeDt.substring(2,4)+result[i].writeDt.substring(4,10)+'</td>';
					
					html += '<td class="txt_center">'+docStatPrint(result[i].docStat)+'('+result[i].preAppDt.substring(2,4)+result[i].preAppDt.substring(4,10)+')</td>';
					html += '<td class="txt_center">';
					html += handleStatPrint(result[i].doHandle,result[i].handleStat);
					if(result[i].doHandle == 'Y' && (result[i].handleStat == '1' || result[i].handleStat == '2')){
						html += '('+result[i].handleDt.substring(2,4)+"."+result[i].handleDt.substring(5,7)+"."+result[i].handleDt.substring(8,10)+')';
					}
					html += '</td>';
					html += '</tr>';
					$("#completeApprTbody").append(html);
				}
			},
			error: function(xhr, testStatus, errorThrown) {
				return false;
			 	}
		/* }); */
	}); 
});
function docStatPrint(str){
	var resultPrint = "";
	if(str == "APP000"){
		resultPrint = "기안대기";
	}else if(str == "APP001"){
		resultPrint = "<span class=\"txtB_green\">검토중</span>";
	}else if(str == "APP002"){
		resultPrint = "<span class=\"txtB_blue2\">협조중</span>";
	}else if(str == "APP003"){
		resultPrint = "<span class=\"txtB_orange\">전결중</span>";
	}else if(str == "APP004"){
		resultPrint = "<span class=\"txtB_blue\">참조중</span>";
	}else if(str == "APP005"){
		resultPrint = "<span class=\"txtB_grey\">완료</span>";
	}else{
		resultPrint = "결재실패";
	}
	
	return resultPrint; 
}

function handleStatPrint(doHandle,str){
	var resultPrint = "-";
	if(doHandle == "Y"){
		if(str == "0"){
			resultPrint =  "<span class=\"txtB_orange\">처리중</span>"; 
		}else if(str == "1"){
			resultPrint = "<span class=\"txtB_grey\">완료</span>"; 
		}else if(str == "2"){
			resultPrint = "<span class=\"txtB_blue2\">취소</span>"; 
		}
	}

	
	return resultPrint; 
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
									<td class="txt_center td_last"><a href="/approval/approvalL.do?mode=13" id="doHandleCntTd">${doHandleCnt}</a></td>
								</tr>
							</tbody>
							</table>
						</div>
	
						<p class="th_stitle mB10" id="doApproval">내가 승인할 문서
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
							<tbody id="doApprovalTbody">
							<%-- <c:forEach var="result" items="${doApprovalList}" varStatus="status">
								<tr>
									<td class="txt_center"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=2">${result.templtNm}</a></td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=2">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach> --%>
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle mB10" id="doHandleAppr">내가 처리할 문서
							 <span class="pL10 txt_red" id="doHandleCnt"></span>  
							 <span class="th_plus" id="doHandleApprPlus">
								<!-- <a href="/approval/approvalL.do?mode=13"> 더보기 </a> -->
							 </span>
						</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>내가 처리할 문서</caption>
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
							<tbody id="doHandleTbody">
						<%-- 	<c:forEach var="result" items="${doHandleList}" varStatus="status">
								<tr>
									<td class="txt_center">${result.templtNm}</td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=13">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach>	 --%>											
							</tbody>															
							</table>
						</div>
						
						<p class="th_stitle mB10" id="myAppr">결재 진행중인 문서 
						<span class="pL10 txt_red">${summaryVO.reviewCnt + summaryVO.cooperationCnt + summaryVO.decideCnt}</span>									
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
							<tbody id="myApprovalTbody">
							<%-- <c:forEach var="result" items="${myApprovalList}" varStatus="status">
								<tr>
									<td class="txt_center"><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=3">${result.templtNm}</a></td>
									<td><a href="${rootPath}/approval/approvalV.do?docId=${result.docId}&mode=3">${result.subject}</a></td>
									<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
									<td class="txt_center">${result.writeDtLong}</td>
									<td class="txt_center">${result.docStatPrint}(<print:date date="${result.preAppDtShort}" printType='S'/>)</td>
								</tr>
							</c:forEach>	 --%>										
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle mB10" id="completeAppr">결재 완료된 문서  
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
							<tbody id="completeApprTbody">
							<%-- <c:forEach var="result" items="${myCompApprovalList}" varStatus="status">
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
							</c:forEach>	 --%>		
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
