<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(moveDate) {
	document.frm.moveDate.value = moveDate;
	document.frm.submit();
}
function searchDetail(attendCd) {
	$.post("${rootPath}/member/dailyWorkStateDatail.do?param_searchDate=${searchVO.searchDate}&param_searchOrgId=${searchVO.searchOrgId}&param_attendCd=" + attendCd, function(data) {
		$('#detailArea').html(data);
		if($('.toggleB').hasClass('btn_arrow_down')){
			$('.toggleB').removeClass('btn_arrow_down');
			$('.toggleB').addClass('btn_arrow_up');
			$('#detailAreaP').removeClass('mB20');
			$('#detailArea').show();
		}
	});
}
function deleteAbsence(wsId) {
	document.frm.wsId.value = wsId;
	document.frm.action = "${rootPath}/member/deleteAbsence.do";
	document.frm.submit();
}

function updateAbsence(wsId) {
	document.frm.wsId.value = wsId;
	document.frm.action = "${rootPath}/member/updateAbsenceView.do";
	document.frm.submit();
}
$('document').ready(function() {
	$('#detailAreaP').addClass('mB20');
	$('#detailArea').hide();
	
	//토글 버튼 활성화
	$('.toggleB').click(function(){
		if($(this).hasClass('btn_arrow_down')){
			$(this).removeClass('btn_arrow_down');
			$(this).addClass('btn_arrow_up');
			$('#detailAreaP').removeClass('mB20');
			$('#detailArea').show();
		}
		else{
			$(this).removeClass('btn_arrow_up');
			$(this).addClass('btn_arrow_down');
			$('#detailAreaP').addClass('mB20');
			$('#detailArea').hide();
		}
	});
});
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
						<li class="stitle">일일근태기록 및 부재등록현황</li>
						<li class="navi">홈 > 인사정보 > 근태정보 > <a href="/member/selectAbsenceState.do">일일근태기록</a></li>
					</ul>
				</div>
				
				<!-- <span class="stxt">휴가, 외근, 출장, 파견근무 등으로 자리를 비운 임직원을 확인할 수 있습니다.</span>
				<span class="stxt_btn"> 등록하기 :
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=N"><img src="${imagePath}/btn/btn_out04.gif"/></a>
					<a href="${rootPath}/approval/approvalW.do?templtId=2"><img src="${imagePath}/btn/btn_vacation.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=O"><img src="${imagePath}/btn/btn_out01.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=T"><img src="${imagePath}/btn/btn_out02.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=S"><img src="${imagePath}/btn/btn_out03.gif"/></a>
				</span>
				-->
				
				<!-- S: section -->
				<div class="section01">
				
					<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/member/dailyWorkStateStatistic.do" onsubmit="search(0); return false;">
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<input type="hidden" name="moveDate" value="0"/>
					<input type="hidden" name="wsId" />
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
								<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
								<span class="option_txt"><input type="text" class="input01 span_4 calGen" name="searchDate" value="${searchVO.searchDate}"/></span>
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
							</li>
							<li class="li_right">
								부서
								<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" size="40"readonly="readonly" onfocus="orgGen('orgNm','orgId',0)"/>
								<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="orgGen('orgNm','orgId',0)"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;"/>
							</li>
							</ul>
						</div>
					</fieldset>
					</form>
					<!--// 상단 검색창 끝 -->
					
					<p class="th_stitle4">출근 기록
						<!-- 버튼 시작 -->
						<span class="btn_area06">
							<c:if test="${user.admin}">
								<a href="${rootPath}/member/insertWorkStateExceptionView.do"><img src="${imagePath}/btn/btn_exemRegist.gif"/></a>
							</c:if>
						</span>
						<!-- 버튼 끝 -->
					</p>
					
					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>출근 기록</caption>
						<colgroup>
							<col width="px" />
							<col class="col50" />
							<col class="col50" />
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
								<th rowspan="2" onclick="searchDetail('');" class="cursorPointer">총대상자</th>
								<th colspan="7" onclick="searchDetail('VC,TR,SD,OT,NT,ET');" class="cursorPointer">부재 (9시 기준)</th>
<!--								<th colspan="5" onclick="searchDetail('VC,TR,SD,OT');" class="cursorPointer">부재 (9시 기준)</th>-->
								<th colspan="3" onclick="searchDetail('EA,AT');" class="cursorPointer">출근</th>
<!--								<th colspan="3" onclick="searchDetail('NT,ET');" class="cursorPointer">면제</th>-->
								<th rowspan="2" class="td_last" onclick="searchDetail('LT');" class="cursorPointer">지각</th>
							</tr>
							<tr>
								<th onclick="searchDetail('VC');" class="cursorPointer">휴가</th>
								<th onclick="searchDetail('TR');" class="cursorPointer">출장</th>
								<th onclick="searchDetail('SD');" class="cursorPointer">파견</th>
								<th onclick="searchDetail('OT');" class="cursorPointer">외근</th>
								<th onclick="searchDetail('NT');" class="cursorPointer">전일<br/>야근</th>
								<th onclick="searchDetail('ET');" class="cursorPointer">기타</th>
								<th onclick="searchDetail('VC,TR,SD,OT,NT,ET');" class="cursorPointer">소계</th>
<!--								<th onclick="searchDetail('VC,TR,SD,OT');" class="cursorPointer">소계</th>-->
								<th onclick="searchDetail('EA');" class="cursorPointer">조기<br/>출근</th>
								<th onclick="searchDetail('AT');" class="cursorPointer">정상<br/>출근</th>
								<th onclick="searchDetail('EA,AT');" class="cursorPointer">소계</th>
<!--								<th onclick="searchDetail('NT');" class="cursorPointer">전일야근</th>-->
<!--								<th onclick="searchDetail('ET');" class="cursorPointer">기타</th>-->
<!--								<th onclick="searchDetail('NT,ET');" class="cursorPointer">소계</th>-->
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="bG txt_center cursorPointer" onclick="searchDetail('');">${result.userCnt}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('VC');">${result.vac}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('TR');">${result.bizTrip}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('SD');">${result.send}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('OT');">${result.workOut}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('NT');">${result.night}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('ET');">${result.etc}</td>
								<td class="bG02 txt_center cursorPointer" onclick="searchDetail('VC,TR,SD,OT,NT,ET');">${result.abs + result.exception}</td>
<!--								<td class="bG02 txt_center cursorPointer" onclick="searchDetail('VC,TR,SD,OT');">${result.abs}</td>-->
								<td class="txt_center cursorPointer" onclick="searchDetail('EA');">${result.earlyAtnd}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('AT');">${result.atnd}</td>
								<td class="bG02 txt_center cursorPointer" onclick="searchDetail('EA,AT');">${result.attend}</td>
<!--								<td class="txt_center cursorPointer" onclick="searchDetail('NT');">${result.night}</td>-->
<!--								<td class="txt_center cursorPointer" onclick="searchDetail('ET');">${result.etc}</td>-->
<!--								<td class="bG02 txt_center cursorPointer" onclick="searchDetail('NT,ET');">${result.exception}</td>-->
								<td class="bG txt_center td_last cursorPointer" onclick="searchDetail('LT');">${result.late}</td>
							</tr>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="detailAreaP">상세내역 <img class="btn_arrow_down cursorPointer toggleB" id="monthlyReportTB"/></p>
					<div id="detailArea" style="display:none;">
						<c:import url="${rootPath}/member/dailyWorkStateDatail.do">
							<c:param name="param_searchDate" value="${searchVO.searchDate}"/>
							<c:param name="param_searchOrgId" value="${searchVO.searchOrgId}"/>
							<c:param name="param_attendCd" value=""/>
						</c:import>
					</div>
				
				<!-- 비고  -->
				<div class="note_layer" style="display:none; z-index:5;">
					<p id="atndNt"></p>
				</div>
				
				<!-- 게시판 시작  -->
				<p class="th_stitle4" >부재등록현황 </p>
					<div class="th_txt">인원수를 클릭하면 상세정보를 보실 수 있습니다.</div>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col16" />
							<col class="col16" />
							<col class="col16" />
							<col class="col16" />
							<col class="col16" />
							<col class="col16" />
						</colgroup>
						<thead>
							<tr>
								<th>야근</th>
								<th>휴가</th>
								<th>외근</th>
								<th>출장</th>
								<th>파견</th>
								<th class="td_last">합계</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="txt_center"><a href="#n">${result2.state.n}</a></td>
								<td class="txt_center"><a href="#v">${result2.state.v}</a></td>
								<td class="txt_center"><a href="#o">${result2.state.o}</a></td>
								<td class="txt_center"><a href="#t">${result2.state.t}</a></td>
								<td class="txt_center"><a href="#s">${result2.state.s}</a></td>
								<td class="td_last txt_center">${result2.state.sum}</td>
							</tr>
						</tbody>
						</table>
					</div>
					
<!--					<p class="th_stitle2 mT10">상세내역</p>-->
					<p class="th_stitle2 mT10" id="n">야근</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col60" />
							<col class="col110" />
							<col class="col90" />
							<col class="col90" />
							<col width="px" />
							<col class="col60" />
							<col class="col70" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>유선전화</th>
								<th>휴대전화</th>
								<th>사유</th>
								<th>야근시간</th>
								<th class="td_last">출근시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result2.nightList}" var="night">
								<tr class="height_td" id="n${night.userNo}">
									<td class="txt_center"><print:user userNo="${night.userNo}" userNm="${night.userNm}"/></td>
									<td class="txt_center">${night.orgnztNm}</td>
									<td class="txt_center">${night.userTelno}</td>
									<td class="txt_center">${night.userMoblphonNo}</td>
									<td class="pL5"><print:textarea text="${night.wsPurpose}"/></td>
									<td class="txt_center">${night.wsBgnTm}시</td>
									<td class="td_last txt_center">${night.attendTm}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result2.nightList}">
								<tr>
									<td class="td_last txt_center" colspan="7">야근 현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="v">휴가</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col60" />
							<col class="col110" />
							<col class="col100" />
							<col class="col140" />
<!--							<col class="col90" />-->
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>휴대전화</th>
								<th>기간</th>
<!--								<th>유선전화</th>-->
								<th class="td_last">사유</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result2.vacList}" var="vac">
								<tr class="height_td" id="v${vac.userNo}">
									<td class="txt_center"><print:user userNo="${vac.userNo}" userNm="${vac.userNm}"/></td>
									<td class="txt_center">${vac.orgnztNm}</td>
									<td class="txt_center">${vac.userMoblphonNo}</td>
									<td class="txt_center">
										${vac.wsBgnDe }
										<c:if test="${vac.wsBgnTm < 11 }">오전</c:if>
										<c:if test="${vac.wsBgnTm > 11 }">오후</c:if>
										<br/>
										~${vac.wsEndDe }
										<c:if test="${vac.wsEndTm < 13 }">오전</c:if>
										<c:if test="${vac.wsEndTm > 13 }">오후</c:if>
									</td>
<!--									<td class="txt_center">${vac.userTelno}</td>-->
									<td class="td_last pL5">
										<print:textarea text="${vac.wsPurpose}"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result2.vacList}">
								<tr>
									<td class="td_last txt_center" colspan="5">휴가현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="o">외근</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col50" />
							<col class="col90" />
							<col class="col100" />
							<col class="col50" />
							<col class="col120" />
							<col width="px" />
							<col class="col50" />
							<col class="col70" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>휴대전화</th>
								<th>시간</th>
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th>등록시간</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result2.outList}" var="out">
								<tr class="height_td" id="o${out.userNo}">
									<td class="txt_center"><print:user userNo="${out.userNo}" userNm="${out.userNm}"/></td>
									<td class="txt_center">${out.orgnztNm}</td>
									<td class="txt_center">${out.userMoblphonNo}</td>
									<td class="txt_center">${out.wsBgnTm}~${out.wsEndTm}</td>
									<td class="txt_center">${out.wsPlace}</td>
									<td class="pL5"><print:textarea text="${out.wsPurpose}"/></td>
									<td class="txt_center"><print:user userNo="${out.writerNo}" userNm="${out.writerNm}"/></td>
									<td class="txt_center">${out.regDtLong}</td>
									<td class="td_last txt_center">
										<c:if test="${out.userNo == user.no || out.writerNo == user.no || user.admin}">
											<a href="javascript:updateAbsence('${out.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="javascript:deleteAbsence('${out.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result2.outList}">
								<tr>
									<td class="td_last txt_center" colspan="9">외근현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="t">출장</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col50" />
							<col class="col110" />
							<col class="col100" />
							<col class="col110" />
							<col class="col90" />
							<col width="px" />
							<col class="col50" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>휴대전화</th>
								<th>기간</th>
<!--								<th>유선전화</th>-->
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result2.tripList}" var="trip">
								<tr class="height_td" id="t${trip.userNo}">
									<td class="txt_center"><print:user userNo="${trip.userNo}" userNm="${trip.userNm}"/></td>
									<td class="txt_center">${trip.orgnztNm}</td>
									<td class="txt_center">${trip.userMoblphonNo}</td>
									<td class="txt_center">&nbsp;${trip.wsBgnDe}<br/>~${trip.wsEndDe}</td>
<!--									<td class="txt_center">${trip.userTelno}</td>-->
									<td class="txt_center">${trip.wsPlace}</td>
									<td class="pL5"><print:textarea text="${trip.wsPurpose}"/></td>
									<td class="txt_center"><print:user userNo="${trip.writerNo}" userNm="${trip.writerNm}"/></td>
									<td class="td_last txt_center">
										<c:if test="${trip.userNo == user.no || trip.writerNo == user.no || user.admin}">
											<a href="javascript:updateAbsence('${trip.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="javascript:deleteAbsence('${trip.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result2.tripList}">
								<tr>
									<td class="td_last txt_center" colspan="8">출장현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="s">파견</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col50" />
							<col class="col110" />
							<col class="col100" />
							<col class="col110" />
							<col class="col90" />
							<col width="px" />
							<col class="col50" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>휴대전화</th>
								<th>기간</th>
<!--								<th>유선전화</th>-->
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result2.sendList}" var="send">
								<tr class="height_td" id="s${send.userNo}">
									<td class="txt_center"><print:user userNo="${send.userNo}" userNm="${send.userNm}"/></td>
									<td class="txt_center">${send.orgnztNm}</td>
									<td class="txt_center">${send.userMoblphonNo}</td>
									<td class="txt_center">&nbsp;${send.wsBgnDe}<br/>~${send.wsEndDe}</td>
<!--									<td class="txt_center">${send.userTelno}</td>-->
									<td class="txt_center">${send.wsPlace}</td>
									<td class="pL5"><print:textarea text="${send.wsPurpose}"/></td>
									<td class="txt_center"><print:user userNo="${send.writerNo}" userNm="${send.writerNm}"/></td>
									<td class="td_last txt_center">
										<c:if test="${send.userNo == user.no || send.writerNo == user.no || user.admin}">
											<a href="javascript:updateAbsence('${send.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="javascript:deleteAbsence('${send.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result2.sendList}">
								<tr>
									<td class="td_last txt_center" colspan="8">파견현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					<!--// 게시판  끝  -->
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
