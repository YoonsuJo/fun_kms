<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}
function view(custId) {
	document.frm.custId.value = custId;
	document.frm.action = "${rootPath}/cooperation/selectCustomer.do";
	document.frm.submit();
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
							<li class="stitle">고객사정보</li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 고객사정보</li>
						</ul>
					</div>
	
				<!-- S: section -->
				<div class="section01">
			    	
			    	<!-- 상단 검색창 시작 -->
			    	<form name="frm" method="POST" action="${rootPath}/cooperation/selectCustomerList.do" onsubmit="search(1); return false;">
			    	<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
			    	<input type="hidden" name="custId"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="top_search07 mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td class="pT5">
									업체명 <input type="text" class="span_11 input01" name="searchKeyword" value="${searchVO.searchKeyword}"/>
									<span class="pL7"></span>사업자등록번호 <input type="text" class="span_11 input01" name="searchBusiNo" value="${searchVO.searchBusiNo}"/>
								</td>
							</tr>
							<tr>
								<td>
									담당자 <input type="text" class="span_5 input01" name="searchPersonNm" value="${searchVO.searchPersonNm}"/>
									전화번호 <input type="text" class="span_5 input01" name="searchTelno" value="${searchVO.searchTelno}"/>
									팩스번호 <input type="text" class="span_5 input01" name="searchFaxno" value="${searchVO.searchFaxno}"/>
									등록자 <input type="text" class="span_5 input01 userNameAuto" name="searchUserMix" id="searchUserMix" value="${searchVO.searchUserMix}"/>
									<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserMix',1);">
									<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" onclick="search(1); return false;"/>
								</td>
							</tr>
						</tbody>
						</table>
	                    </div>
	                </fieldset>
	                </form>
                	<!-- 상단 검색창 끝 -->
					
					<!-- 게시판 시작 -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="고객사정보 목록입니다.">
						<caption>고객사정보</caption>
						<colgroup>
							<col class="col40" />
							<col width="px" />
							<col class="col90" />
							<col class="col90" />
							<col class="col70" />
							<col class="col90" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">업체명</th>
							<th scope="col">전화번호</th>
							<th scope="col">FAX</th>
							<th scope="col">등록자</th>
							<th scope="col">등록일</th>
							<th scope="col">최종수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/></td>
									<td class="pL10"><a href="javascript:view('${result.custId}');">${result.custNm}</a> [${result.commentCnt}]</td>
									<td class="txt_center">${result.custTelno}</td>
									<td class="txt_center">${result.custFaxno}</td>
									<td class="txt_center"><print:user userNo="${result.userNoReg}" userNm="${result.userNmReg}"/></td>
									<td class="txt_center">${result.regDt}</td>
									<td class="txt_center">${result.modDt}</td>
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
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="${rootPath}/cooperation/insertCustomerView.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
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
