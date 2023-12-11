<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
function equipDelete(equip_no){
	if(confirm("장비 사용이력도 같이 삭제 됩니다. 정말 삭제하시겠습니까?")){
		document.searchVO.equip_no.value = equip_no;
		document.searchVO.action = '<c:url value="${rootPath}/support/deleteEquip.do" />';
		document.searchVO.submit();
	}
}
function equipViewDetail(equip_no,idx) {
	document.searchVO.equip_no.value = equip_no;
	document.searchVO.idx.value = idx;
	document.searchVO.action = '<c:url value="${rootPath}/support/selectEquipDetailView.do" />';
	document.searchVO.submit();
}
</script>
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
							<li class="stitle">전산장비 상세정보</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
					<form name="searchVO" method="post" id="searchVO">
						<input type="hidden" name="equip_no" value="${equipVO.equip_no}"/>
						<input type="hidden" name="idx"/>
					</form>
					
					<!-- S: section -->
					<div class="section01">
						<!-- 장비정보 시작  -->
						<p class="th_stitle">장비정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>장비정보 보기</caption>
								<colgroup>
									<col class="col120" />
									<col width="px" />
								</colgroup>
								<tbody>
									<tr>
										<td class="title">장비형태</td>
										<td class="td_last pL10">
											<c:forEach items="${equipTypeList}" var="equipType">
											<c:if test="${equipVO.equip_type == equipType.type_value}">${equipType.type_name}</c:if>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<td class="title">관리번호</td>
										<td class="td_last pL10">${equipVO.serial_no}</td>
									</tr>
									<tr>
										<td class="title">모델명</td>
										<td class="td_last pL10">${equipVO.model}</td>
									</tr>
									<tr>
										<td class="title">CPU</td>
										<td class="td_last pL10">${equipVO.cpu}</td>
									</tr>
									<tr>
										<td class="title">MEMORY</td>
										<td class="td_last pL10">${equipVO.memory}</td>
									</tr>
									<tr>
										<td class="title">VGA</td>
										<td class="td_last pL10">${equipVO.vga}</td>
									</tr>
									<tr>
										<td class="title">HDD</td>
										<td class="td_last pL10">${equipVO.hdd}</td>
									</tr>
									<tr>
										<td class="title">ODD</td>
										<td class="td_last pL10">${equipVO.odd}</td>
									</tr>
									<tr>
										<td class="title">기타</td>
										<td class="td_last pL10">${equipVO.etc}</td>
									</tr>
									<tr>
										<td class="title">담당자</td>
										<td class="td_last pL10">${equipVO.user_nm}</td>
									</tr>
									<tr>
										<td class="title">사용처</td>
										<td class="td_last pL10">${equipVO.place}</td>
									</tr>
									<tr>
										<td class="title">시리얼 번호</td>
										<td class="td_last pL10">${equipVO.sirial_no}</td>
									</tr>
									<tr>
										<td class="title">구입처</td>
										<td class="td_last pL10">${equipVO.buy_place}</td>
									</tr>
									<tr>
										<td class="title">구입처 주소</td>
										<td class="td_last pL10">${equipVO.buy_addr}</td>
									</tr>
									<tr>
										<td class="title">구입처 전화번호</td>
										<td class="td_last pL10">${equipVO.buy_tel}</td>
									</tr>
									<tr>
										<td class="title">구입시기</td>
										<td class="td_last pL10">${fn:substring(equipVO.buy_dt,0,4)}-${fn:substring(equipVO.buy_dt,4,6)}-${fn:substring(equipVO.buy_dt,6,8)}</td>
									</tr>
									<tr>
										<td class="title">구입금액</td>
										<td class="td_last pL10">\ <fmt:formatNumber value="${equipVO.buy_price}" pattern="#,###" /></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--// 장비정보 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area02">
							<c:if test="${user.admin}">
								<a href="/support/updateEquipInfoView.do?equip_no=${equipVO.equip_no}"><img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" /></a>
								<a href="javascript:equipDelete('${equipVO.equip_no}');"><img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" /></a>
							</c:if>
							<a href="/support/selectEquipList.do"><img src="${imagePath}/btn/btn_list.gif" class="cursorPointer" /></a>
						</div>
						<!-- 버튼 끝 -->
						
						<!-- 사용이력 시작  -->
						<p class="th_stitle">사용이력</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>사용이력 보기</caption>
								<colgroup>
									<col class="col80" />
									<col class="col160" />
									<col class="col80" />
									<col class="col80" />
									<col class="col140" />
									<col width="*" />
									<col class="col40" />
								</colgroup>
								<thead>
									<tr>
										<th>사용자</th>
										<th>사용기간</th>
										<th>사용처</th>
										<th>상태</th>
										<th>사용목적</th>
										<th>비고</th>
										<th class="td_last"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${equipHistoryVOList}" var="result">
										<tr class="cursorPointer">
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">${result.user_nm}</td>
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">${result.reg_dt}</td>
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">${result.place}</td>
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">
												<c:choose>
													<c:when test="${result.status == '1-public'}">공용</c:when>
													<c:when test="${result.status == '2-personal'}">개인용</c:when>
													<c:when test="${result.status == '3-server'}">서버용</c:when>
													<c:when test="${result.status == '4-repair'}">수리중</c:when>
													<c:when test="${result.status == '5-extra'}">여분</c:when>
													<c:when test="${result.status == '6-disuse'}">폐기</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</td>
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">${result.use_purps}</td>
											<td onclick='equipViewDetail("${result.equip_no}","${result.idx}");' class="txt_center">${result.etc}</td>
											<td class="td_last pL10">
												<a href="/support/updateEquipDetailView.do?idx=${result.idx}&equip_no=${equipVO.equip_no}"><img src="${imagePath}/btn/btn_plus02.gif" class="cursorPoineter" /></a>
												<a href="/support/deleteEquipDetail.do?idx=${result.idx}&equip_no=${equipVO.equip_no}"><img src="${imagePath}/btn/btn_minus02.gif" class="cursorPoineter" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!--// 사용이력 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<c:if test="${user.admin}">
								<a href="/support/insertEquipDetailView.do?idx=${result.idx}&equip_no=${equipVO.equip_no}">
								<img src="${imagePath}/btn/btn_useRegist.gif" class="cursorPoineter" /></a>
							</c:if>
							</div>
						<!-- 버튼 끝 -->
						
						<!-- 수리이력 시작  -->
						<p class="th_stitle">수리이력</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>수리이력 보기</caption>
								<colgroup>
									<col class="col60" />
									<col class="col180" />
									<col class="col100" />
									<col class="col100" />
									<col width="*" />
									<col class="col40" />
								</colgroup>
								<thead>
									<tr>
										<th>등록자</th>
										<th>수리일자</th>
										<th>수리비용</th>
										<th>수리내역</th>
										<th>비고</th>
										<th class="td_last"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${equipRepairHistoryVOList}" var="result">
										<tr class="cursorPointer">
											<td class="txt_center">
												<a href="${rootPath}/support/selectEquipRepairView.do?equip_no=result.equip_no&idx=${result.idx}">
												${result.regNm}</a></td>
											<td class="txt_center">
												<a href="${rootPath}/support/selectEquipRepairView.do?equip_no=result.equip_no&idx=${result.idx}">
												${result.repairDt}</a></td>
											<td class="txt_center">
												<a href="${rootPath}/support/selectEquipRepairView.do?equip_no=result.equip_no&idx=${result.idx}">
												${result.cost}</a></td>
											<td class="txt_center">
												<a href="${rootPath}/support/selectEquipRepairView.do?equip_no=result.equip_no&idx=${result.idx}">
												${result.content}</a></td>
											<td class="txt_center">
												<a href="${rootPath}/support/selectEquipRepairView.do?equip_no=result.equip_no&idx=${result.idx}">
												${result.note}</a></td>
											<td class="td_last pL10">
												<a href="/support/updateEquipRepairView.do?idx=${result.idx}&equip_no=${equipVO.equip_no}">
												<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPoineter" /></a>
												<a href="/support/deleteEquipRepair.do?idx=${result.idx}&equip_no=${equipVO.equip_no}">
												<img src="${imagePath}/btn/btn_minus02.gif" class="cursorPoineter" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!--// 수리이력 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<c:if test="${user.admin}">
								<a href="/support/insertEquipRepairView.do?equip_no=${equipVO.equip_no}">
								<img src="${imagePath}/btn/btn_useRegist.gif" class="cursorPoineter" /></a>
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
