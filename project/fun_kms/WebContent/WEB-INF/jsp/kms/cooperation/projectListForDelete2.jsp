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
	if (${deleteEnableYn == 'Y'}) {
		$('#prjListForDelete').show();
	}
	else {
		$('#notice_checkDbSchema').show();
	}
});

function search() {
	document.frm.action = "<c:url value='${rootPath}/cooperation/projectListForDelete.do'/>";
	document.frm.submit();
}

function deleteProject(prjId) {
	if (!confirm('프로젝트를 삭제하시겠습니까?')) {
		return false;
	}

	document.frm.prjIdToDel.value = prjId;
	document.frm.action = "<c:url value='${rootPath}/cooperation/deleteProject.do'/>";
	document.frm.submit();
}

function deleteProjectSubData(prjId, mode) {
	if (!confirm('프로젝트 자료를 삭제하시겠습니까?')) {
		return false;
	}
	document.frm.mode.value = mode;
	document.frm.prjIdToDel.value = prjId;
	document.frm.action = "<c:url value='${rootPath}/cooperation/deleteProjectSubData.do'/>";	
	document.frm.submit();
}
</script>
</head>

<body>

<div id="wrap"><%@ include file="../common/menu/head.jsp"%>
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
							<li class="stitle">프로젝트 삭제</li>
							<li class="navi">홈 > 업무공유  > 프로젝트  > 프로젝트 삭제</li>
						</ul>
					</div>	
	
					<span class="stxt">
						프로젝트를 검색하여 삭제 가능 여부를 확인 가능합니다. 임의로 프로젝트 삭제는 불가합니다. 경영기획실에 요청하세요. 
					</span>

					<!-- S: section -->
					<div id="prjListForDelete" class="section01" style="display:none;">	
						<p class="th_stitle">삭제 가능 프로젝트 확인</p>
				    <!-- 상단 검색창 시작 -->
				    	<form name="frm" method="POST" onsubmit="search(); return false;">
				    	<input type="hidden" name="prjIdToDel" />
				        <input type="hidden" name="mode" />
						<fieldset>
		                    <div class="bot_search mT10 mB20">
		                		<ul>
									<li class="option_txt">
		                				프로젝트ID, 프로젝트코드, 프로젝트명, 주관부서ID, 주관부서명
		                			</li>
									<li class="search_box">
										<input type="text" class="search_txt02 span_11" name="searchKeyword" value='<c:out value="${searchKeyword}"/>' />
									</li>
									<li>
										<img src="${imagePath}/btn/btn_search02.gif" alt="검색" style="cursor:pointer;" onclick="search(); return false;"/>
									</li>
		                		</ul>
							</div>
		                </fieldset>
				    	</form>
		            <!--// 상단 검색창 끝 -->

						<div class="boardList02 mB20 T11">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>댓글달기</caption>
								<colgroup>
									<col width="px" />
									<col class="col40" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
									<col class="col50" />
								</colgroup>
			                    <thead>
									<tr>
										<th scope="col" rowspan="4">프로젝트</th>
										<th scope="col" rowspan="4">삭제<br/>가능<br/>여부</th>
										<th scope="col">하위<br/>PRJ</th>
										<th scope="col">PRJ<br/>게시판</th>
										<th scope="col">업무<br/>연락</th>
										<th scope="col">예산승인<br/>요청</th>
										<th scope="col">경비<br/>지출</th>
										<th scope="col">일반매출<br/>보고</th>
										<th scope="col">휴일<br/>근무</th>
										<th scope="col">프리셋</th>
										<th scope="col" rowspan="4" class="td_last">삭제</th>
									</tr>
									<tr>
										<th scope="col">사내매출<br/>보고</th>
										<th scope="col">종합매출<br/>보고</th>
										<th scope="col">판관비<br/>계획</th>
										<th scope="col">인건비<br/>계획</th>
										<th scope="col">PRJ<br/>투입</th>
										<th scope="col">PRJ<br/>투입계획</th>
										<th scope="col">사내매입<br/>(비용)</th>
										<th scope="col">사내매입<br/>(인력)</th>
									</tr>
									<tr>
										<th scope="col">사외<br/>매입</th>
										<th scope="col">매출</th>
										<th scope="col">작업</th>
										<th scope="col">세금<br/>계산서</th>
										<th scope="col">회의실</th>
										<th scope="col">계약건</th>
										<th scope="col">실적<br/>집계</th>
										<th scope="col">이력<br/>관리</th>
									</tr>
									<tr>
										<th scope="col">자금<br/>관리</th>
										<th scope="col">재고</th>
										<th scope="col">재고<br/>history</th>
										<th scope="col">-</th>
										<th scope="col">-</th>
										<th scope="col">-</th>
										<th scope="col">-</th>
										<th scope="col">-</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty resultList}">
										<tr>
											<td class="txt_center td_last" colspan="11">검색 결과가 없습니다.</td>
										</tr>
									</c:if>
			                    	<c:forEach items="${resultList}" var="result">
										<tr>
<!--										<tr class="TrBg${searchVO.today == result.date ? 2 : 3}">'-->
											<td class="pL5 pR5" rowspan="4">
												<print:project prjId="${result.prjId}" prjNm="${result.prjNm}" prjCd="${result.prjCd}" newWnd="Y"/>
											</td>
											<td class="txt_center" rowspan="4">
												<c:if test="${result.cntAll == 0}"><span class="txtS_red">가능</span></c:if>
												<c:if test="${result.cntAll != 0}">불가</c:if>
											</td>
											<td class="txt_center">${result.c00}</td>
											<td class="txt_center">${result.c01}</td>
											<td class="txt_center">${result.c02}</td>
											<td class="txt_center">${result.c03}</td>
											<td class="txt_center">${result.c04}</td>
											<td class="txt_center">${result.c05}</td>
											<td class="txt_center">${result.c06}</td>
											<td class="txt_center">${result.c07}</td>
											<td class="txt_center td_last" rowspan="4">
												<c:if test="${result.cntAll == 0}">
													<c:if test="${user.admin || user.isProjectadmin == 'Y' || user.isPrjtransferadmin == 'Y'}">
														<img src="${imagePath}/admin/btn/btn_delete04.gif" class="cursorPointer" onclick="deleteProject('${result.prjId}');"/>
													</c:if>	
												</c:if>
											</td>
										</tr>
										<tr>
											<td class="txt_center">${result.c08}</td>
											<td class="txt_center">${result.c09}</td>
											<td class="txt_center">${result.c10}</td>
											<td class="txt_center">${result.c11}</td>
											<td class="txt_center">${result.c12}</td>
											<td class="txt_center">${result.c13}</td>
											<td class="txt_center">${result.c14}</td>
											<td class="txt_center">${result.c15}</td>
										</tr>
										<tr>
											<td class="txt_center">${result.c16}</td>
											<td class="txt_center">${result.c17}</td>
											<td class="txt_center">${result.c18}</td>
											<td class="txt_center">${result.c19}</td>
											<td class="txt_center">${result.c20}</td>
											<td class="txt_center">${result.c21}</td>
											<td class="txt_center">
											<a href="javascript:deleteProjectSubData('${result.prjId}', 'resTotal');">${result.c22}</a>
											</td>
											<td class="txt_center">${result.c23}</td>
										</tr>
										<tr>
											<td class="txt_center">${result.c24}</td>
											<td class="txt_center">${result.c25}</td>
											<td class="txt_center">${result.c26}</td>
											<td class="txt_center">-</td>
											<td class="txt_center">-</td>
											<td class="txt_center">-</td>
											<td class="txt_center">-</td>
											<td class="txt_center">-</td>
										</tr>
			                    	</c:forEach>
								</tbody>
							</table>
							
							

<!--	<table width="100%" border="0" cellspacing="0" cellpadding="0">-->
<!--	<colgroup>-->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--        -->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--        -->
<!--    	<col width="" />-->
<!--    	<col width="" />-->
<!--        <col width="" />-->
<!--    	<col width="" />-->
<!---->
<!--        <col width="" />-->
<!--    	<col width="" />-->
<!--        <col width="" />-->
<!--    	<col width="" />-->
<!--    </colgroup>-->
<!--        <tbody>-->
<!--            <tr>-->
<!--                <td colspan="3" class="title">프로젝트명</td>-->
<!--                <td colspan="11" class="txt_center">&nbsp;</td>-->
<!--                <td class="title">삭제가능여부</td>-->
<!--                <td>불가</td>-->
<!--            </tr>-->
<!--            <tr>-->
<!--                <td class="title">PRJ게시판</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">하위PRJ</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">PRJ투입</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">PRJ투입계획</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">업무연락</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">예산승인요청</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">경비지출</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">휴일근무</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--            </tr>-->
<!--            <tr>-->
<!--                <td class="title">일반배출보고</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">사내매출보고</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">종합매출보고</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">판관비계획</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">인건비계획</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">사내매입(비용)</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">사내매입(인력)</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">사외매입</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--            </tr>-->
<!--            <tr>-->
<!--                <td class="title">매출</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">작업</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">세금계산서</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">회의실</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">계약건</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">실적집계</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">이력관리</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">자금관리</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--            </tr>-->
<!--            <tr>-->
<!--                <td class="title">재고</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">재고기록</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">프리셋</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">&nbsp;</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">&nbsp;</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">&nbsp;</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">&nbsp;</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--                <td class="title">&nbsp;</td>-->
<!--                <td class="txt_center">&nbsp;</td>-->
<!--            </tr>-->
<!--        </tbody>-->
<!--    </table>-->




						</div>


					</div>

					<div id="notice_checkDbSchema" class="section01" style="display:none;">	
						<p class="th_stitle">삭제 가능 프로젝트 확인 불가</p>
						<span class="T15">
							<br/>
							DB 스키마가 변경되어 프로젝트 삭제조회를 할 수 없습니다.<br/><br/>
							경영기획실 담당자에게 연락하여 조치받으시기 바랍니다.<br/><br/>
						</span> 
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
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>
