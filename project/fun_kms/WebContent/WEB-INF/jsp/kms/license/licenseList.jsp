<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){
	// fn_licenseSerch();
	//alert("hello");
});
function search(page) {
	document.frm.page.value = page;
	document.frm.action = "${rootPath}/license/licenseList.do";
	document.frm.submit();
	
}
function view(licenseId,date) {
	document.frm.flagVM.value = "view";
	document.frm.licenseId.value = licenseId;
	document.frm.date.value = date;
	document.frm.action = "${rootPath}/license/licenseView.do";
	document.frm.submit();
}

function regist(){
	document.frm.action = "${rootPath}/license/licenseIssue.do";
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
		<!%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
			<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">라이선스조회 </li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 라이선스조회</li>
						</ul>
					</div>	

					<!-- S: section -->
					<div class="section01">
	
						<!-- 상단 검색창 시작 -->
						<form name="frm" method="POST" action="${rootPath}/license/licenseList.do" onsubmit="search(1); return false;">
							<input type="hidden" name="flagVM">
							<input type="hidden" name="licenseId">
							<input type="hidden" name="date">
							<input type="hidden" name="page" value="${searchVO.page}">
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
								<table cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<tbody>
									<tr>
									
										<td class="pT10">
											회사명  <input type="text" class="span_11 input01" name="searchCompanyName" value="${searchVO.searchCompanyName}"/>
											<span class="pL7"></span>
											만료일 <input type="text" class="span_5 calGen" name="searchExpireDateStart" maxlength="8" value="${searchVO.searchExpireDateStart}"/>
											<input type="text" class="span_5 calGen" name="searchExpireDateEnd" maxlength="8" value="${searchVO.searchExpireDateEnd}"/>
										</td>
									</tr>
									<tr>
										<td>
											&nbsp;제        품&nbsp;
											<input type="checkbox" name="searchProduct" value="ChorusVC" <c:if test="${searchVO.searchProduct =='ChorusVC' or searchVO.searchProduct =='ChorusVC,Multiview'}">checked="checked"</c:if>/> ChorusVC
											<span class="pL7"></span>
											<input type="checkbox" name="searchProduct" value="Multiview" <c:if test="${searchVO.searchProduct=='Multiview' or searchVO.searchProduct =='ChorusVC,Multiview'}">checked="checked"</c:if>/> Multiview
										</td>
										<td class="search_right" rowspan="2">												
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
						<p class="th_stitle">라이선스조회 (검색된 라이선스 : ${searchVO.rowTotalCount}건)</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>라이선스 조회</caption>
							<colgroup>
								<col class="col20" />
								<col class="col50" />
								<col class="col40" />
								<col class="col70" />
								<col class="col40" />
								<col class="col90" />
								<col class="col60" />
								<col class="col40" />
								<col class="col40" />
								<col class="col40" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">NO.</th>
								<th scope="col">회사명</th>
								<th scope="col">업체담당자</th>
								<th scope="col">연락처</th>
								<th scope="col">발급자</th>
								<th scope="col">제품</th>
								<th scope="col">접속 제한 수</th>
								<th scope="col">발급일</th>
								<th scope="col">만료일</th>
								<th scope="col">발급횟수</th>
								</tr>
							</thead>
							<tbody>
							
								<c:if test="${fn:length(licenseList) == 0}">
									<tr>
										<td class="txt_center" colspan="10">등록된 라이선스 정보가 없습니다.</td>
									</tr>
								</c:if>
								
								<c:if test="${fn:length(licenseList) != 0}">
								
								
								<c:forEach items="${licenseList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center">${(searchVO.page * searchVO.rowLen) - searchVO.rowLen + c.count}</td>
										<td class="txt_center"><a href="javascript:view('${result.licenseId}','${result.licenseView.regDateTime}');">${result.companyName}</a></td>
										<td class="txt_center">${result.person}</td>
										<td class="txt_center">${result.phone}</td>
										<td class="txt_center">${result.regUserName}</td>
										<td class="txt_center">${result.licenseView.product}</td>
										<td class="txt_center">${result.licenseView.maxUserLimit}/${result.licenseView.maxUser}</td>
										<td class="txt_center">
											<fmt:formatDate value="${result.licenseView.regDateTime}" pattern="yyyy-MM-dd"/>
										</td>
										<td class="txt_center">
											<c:if test="${result.licenseView.expireDate eq '99999999'}">
												무한																			
											</c:if>	
											<c:if test="${result.licenseView.expireDate ne '99999999'}">
												<c:out value="${fn:substring(result.licenseView.expireDate, 0, 4)}-${fn:substring(result.licenseView.expireDate, 4, 6)}-${fn:substring(result.licenseView.expireDate, 6, 8)}"/>																				
											</c:if>	
											
										</td>
										<td class="txt_center">${result.issueCount}</td>
										
									</tr>
								</c:forEach>
								</c:if>
								
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="right">
		                			<a href="javascript:regist();"><img src="${imagePath}/btn/btn_issue.gif"/></a>
		                		</li>
		                	</ul>
		                </div>
		                <!-- 버튼 끝 -->
		                
						<!-- 페이징 시작 -->
						<div class="paginate">
	                		<ui:pagination paginationInfo="${listPage}" jsFunction="search" type="image"/>
						</div>
						<!-- 페이징 끝 -->
					
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
