<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function searchRule() {
	document.rule.action = '<c:url value="${rootPath}/support/ruleS.do" />';
	document.rule.submit();
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
						<li class="stitle">제반규정</li>
						<li class="navi">업무지원 > 업무처리지원 > 제반규정</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
					<p class="th_stitle mB20">제반규정 검색 결과</p>
					
					<form name="rule" action ="<c:url value='${rootPath}/support/ruleS.do'/>" method="post">
					
				    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									내용<span class="pL7"></span>
								</li>
								<li class="search_box"><input type="text" name="searchTxt" class="search_txt02 span_11" value='<c:out value="${searchTxt}"/>' /></li>
								<li><img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="javascript:searchRule(); return false;"/></li>
                        	</ul>
	                    </div>
	                </fieldset>
					<!-- 상단 검색창 끝 -->
	            	</form>
					
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>내 게시물</caption>
						<colgroup>
							<col class="col40" />
							<col class="col150" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col" class="td_last">내용</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${empty resultList}">
								<tr>
									<td colspan="3" class="txt_center td_last pT10 pB10">
										<a href="${rootPath }/support/ruleL.do">※ 검색 결과가 없습니다.<br/>
										클릭하면 제반규정 페이지로 돌아갑니다.</a>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
							<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center">${c.count }</td>
									<td class="txt_center"><a href="${rootPath }/support/ruleL.do?contentNo=${result.contentNo}">${result.ord}. ${result.sj}</a></td>
									<td class="td_last"><a href="${rootPath }/support/ruleL.do?contentNo=${result.contentNo}">… ${result.content } …</a></td>
								</tr>
							</c:forEach>
							</c:otherwise>
							</c:choose>
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
