<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function add() {
	document.frm.action = "${rootPath}/member/insertDiningMoneyAddView.do";
	document.frm.submit();
}
function stats() {
	document.frm.submit();
}
function del(no) {
	document.frm.no.value = no;
	document.frm.action = "${rootPath}/member/deleteDiningMoneyAdd.do";
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
						<li class="stitle">팀장경비 예산 현황</li>
						<li class="navi">홈 > 인사정보 > 복리후생 > 팀장경비 사용내역</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
					
					<p class="th_stitle">${searchVO.searchOrgNm}(${searchVO.searchYear}년)</p>
					<p class="th_stitle2 mT10">기본배정금액</p>
					<span class="stxt pL10">매월 부서 인원수에 따라 자동으로 배정되는 금액입니다.</span>
					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col200" />
							<col class="col200" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
								<th>월</th>
								<th>인원수</th>
								<th class="td_last">금액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${monthResultList}" var="result">
								<tr>
									<td class="txt_center">${result.mm}월</td>
									<td class="txt_center">${result.userCnt}</td>
									<td class="td_last txt_center">${result.moneyPrint}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty monthResultList}">
								<tr>
									<td colspan="3" class="td_last txt_center">해당 부서에 인원이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10">추가배정금액</p>
					<span class="stxt pL10">워크샵 등의 목적으로 추가 배정되는 금액입니다. 추가 예산 관련사항은 관리자에게 문의해 주시기 바랍니다.</span>
					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col80" />
							<col class="col100" />
							<col width="px" />
							<col class="col80" />
						</colgroup>
						<thead>
							<tr>
								<th>월</th>
								<th>금액</th>
								<th>사유</th>
								<th class="td_last">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${addResultList}" var="result">
								<tr>
									<td class="txt_center">${result.mm}월</td>
									<td class="txt_center">${result.moneyPrint}</td>
									<td class="txt_center">${result.note}</td>
									<td class="td_last txt_center">
										<a href="javascript:del('${result.no}')"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty addResultList}">
								<tr>
									<td colspan="4" class="td_last txt_center">추가로 배정된 팀장경비 예산이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					<!-- 버튼 시작 -->
					<div class="btn_area">
						<a href="javascript:add();"><img src="${imagePath}/btn/btn_addBudgetRegist.gif"/></a> 
						<a href="javascript:stats();"><img src="${imagePath}/btn/btn_grpEatStats.gif"/></a>
					</div>
					<form name="frm" action="${rootPath}/member/diningMoneyStatisticView.do" method="POST">
						<input type="hidden" name="no"/>
						<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}"/>
					</form>
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
