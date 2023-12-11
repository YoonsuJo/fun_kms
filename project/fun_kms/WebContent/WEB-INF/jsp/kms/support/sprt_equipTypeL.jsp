<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function equipSearch(pageIndex) {
	document.frm.pageIndex.value = pageIndex;
	document.frm.action = '<c:url value="${rootPath}/support/selectEquipTypeList.do" />';
	document.frm.submit();
}
function equipView(type_no) {
	document.frm.type_no.value = type_no;
	document.frm.action = '<c:url value="${rootPath}/support/selectEquipTypeView.do" />';
	document.frm.submit();
}

function equipDelete(type_no){
	if(confirm("삭제하시겠습니까?")){
		document.frm.type_no.value = type_no;
		document.frm.action = '<c:url value="${rootPath}/support/deleteEquipType.do" />';
		document.frm.submit();
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
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">전산장비종류 관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비종류 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<!-- 상단 검색창 시작 -->
						<form name="frm" action ="<c:url value='${rootPath}/support/selectEquipTypeList.do'/>" method="post">
						<input name="type_no" type="hidden"/>
		            	</form>		            	
		            	<!-- 상단 검색창 끝 -->	
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="">
								<caption>공지사항</caption>
								<colgroup>
									<col class="px" />
									<col class="px" />
									<col class="px" />
									<col class="px" />
<!--									<col class="col80" />-->
<!--									<col width="px" />-->
<!--									<col class="col40" />-->
								</colgroup>
								<thead>
									<tr>
									<th scope="col">장비종류명</th>
									<th scope="col">DB저장값</th>
									<th scope="col">사용개수</th>
									<th scope="col">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList}" var="result" varStatus="status">
										<tr class="cursorPointer">
											<td onclick="equipView('${result.type_no}');" class="txt_center">${result.type_name}</td>
											<td onclick="equipView('${result.type_no}');" class="txt_center">${result.type_value}</td>
											<td class="txt_center">${result.type_cnt}</td>
											<td class="txt_center">
												<c:if test="${user.admin}">
													<a href="javascript:equipView('${result.type_no}');"><img src="${imagePath}/btn/btn_plus02.gif" class="cursorPoineter" /></a>
													<a href="javascript:equipDelete('${result.type_no}');"><img src="${imagePath}/btn/btn_minus02.gif" class="cursorPoineter" /></a>
												</c:if>
											 </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

						<!-- 버튼 시작 -->
		                <div class="btn_area">
			                <c:if test="${user.admin}">
			                	<a href="${rootPath}/support/insertEquipTypeView.do"><img src="${imagePath}/btn/btn_regist.gif" /></a>
			                </c:if>
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
