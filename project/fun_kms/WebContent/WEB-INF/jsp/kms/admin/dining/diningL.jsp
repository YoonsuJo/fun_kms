<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function addPop() {
	window.open('${rootPath}/admin/dining/insertDiningView.do','_POP_BNR_','width=400px, height=240px');
}
function updtPop(no) {
	var popName = "_POP_DIN_";
	
	document.subFrm.no.value = no;
	document.subFrm.target = popName;
	
	window.open("about:blank",popName,'width=400px, height=240px');

	document.subFrm.submit();
}
</script>
</head>

<body>

<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">팀장경비 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>사원조회</caption>
							<colgroup>
								<col class="col5" />
								<col class="col50" />
								<col width="px" />
								<col class="col200" />
								<col class="col200" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">번호</th>
								<th scope="col">년도</th>
								<th scope="col">1인당 월별 배정금액</th>
								<th scope="col">부서별 인원수 산정 기준일자</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr onclick="javascript:updtPop('${result.no}');" class="cursorPointer">
										<td class="txt_center" colspan="2"><c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.pageSize + c.count) + 1}"/></td>
										<td class="txt_center"><c:out value="${result.dinYear}" /></td>
										<td class="txt_center"><print:currency cost="${result.dinMoney}" /></td>
										<td colspan="2" class="txt_center"><c:out value="${result.dinDate}" /></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<form name="subFrm" method="POST" action="<c:url value='${rootPath}/admin/dining/updtDiningView.do' />">
							<input type="hidden" name="no" />
						</form>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:addPop();"><img src="${imagePath}/btn/btn_add.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->	
		                
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
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
