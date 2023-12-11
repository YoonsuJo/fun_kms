<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(move) {
	document.frm.move.value = move;
	document.frm.submit();
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
function searchDetail(attendCd) {
	$.post("${rootPath}/member/selectAbsenceStateDatail.do?param_searchDate=${searchVO.searchDate}&param_searchOrgId=${searchVO.searchOrgId}&param_attendCd=" + attendCd, function(data) {
		$('#detailArea').html(data);
		if($('.toggleB').hasClass('btn_arrow_down')){
			$('.toggleB').removeClass('btn_arrow_down');
			$('.toggleB').addClass('btn_arrow_up');
			$('#detailAreaP').removeClass('mB20');
			$('#detailArea').show();
		}
	});
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
						<li class="stitle">부재현황 조회 (현재시각기준 부재자 현황)</li>
						<li class="navi">홈 > 인사정보 > 근무현황 > 부재현황</li>
					</ul>
				</div>	
				
				<span class="stxt_btn"> 등록하기 :&nbsp;
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=N"><img src="${imagePath}/btn/btn_out04.gif"/></a>
					<a href="${rootPath}/approval/approvalW.do?templtId=2"><img src="${imagePath}/btn/btn_vacation.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=O"><img src="${imagePath}/btn/btn_out01.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=T"><img src="${imagePath}/btn/btn_out02.gif"/></a>
					<a href="${rootPath}/member/insertAbsenceView.do?wsTyp=S"><img src="${imagePath}/btn/btn_out03.gif"/></a>
				</span>		
				<span class="stxt">
					○ 현재 시각을 기준으로 부재중인 임직원을 확인할 수 있습니다.<br/>
					○ <a href="${rootPath}/member/dailyWorkStateStatistic.do">오늘 날짜를 기준으로 부재등록된 임직원을 보시려면 이곳을 클릭하세요.</a>
				</span>
				
				<!-- S: section -->
				<div class="section01">
				<!-- 상단 검색창 시작 -->
					<form name="frm" method="POST" action="${rootPath}/member/selectAbsenceState.do" onsubmit="search(0); return false;">
					<input type="hidden" name="wsId" />
					<input type="hidden" name="move" value="0"/>
					<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
					<fieldset>
					<legend>상단 검색</legend>
						<div class="scheduleDate mB20">
							<ul>
							<li class="li_left">
				   	 			<!-- 
				   	 			<a href="javascript:search(-1);" class="pR10"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
				   	 			 -->
								<span class="option_txt"><input type="hidden" name="searchDate" class="calGen" value="${searchVO.searchDate}" style="width:50px;" maxlength="8" /></span>
								<!-- 
								<a href="javascript:search(1);" class="pL10"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								 -->
							</li>
							<li class="li_right">
								부서 :
								<input type="text" name="searchOrgNm" id="orgNm" class="search_txt02" value="${searchVO.searchOrgNm}" readonly="readonly" size="40" onfocus="orgGen('orgNm','orgId',0);"/>
								<img src="${imagePath}/btn/btn_tree.gif" id="orgTree" class="cursorPointer" onclick="orgGen('orgNm','orgId',0);"/>
								<input type="image" src="${imagePath}/btn/btn_search02.gif" alt="검색" onclick="search(0); return false;" style="cursor:pointer"/>
								<!-- img src="${imagePath}/btn/btn_allview.gif" alt="전체보기"/-->
							</li>
							</ul>
						</div>
					</fieldset>
					</form>
				<!-- 상단 검색창 끝 -->
					
				<!-- 게시판 시작  -->				
				<p class="th_stitle4">부재현황 </p>
			
					<div class="th_txt">인원수를 클릭하면 상세정보를 보실 수 있습니다.</div>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
<!--							<col class="col16" />-->
						</colgroup>
						<thead>
							<tr>
								<th>지각</th>								
								<th>휴가</th>								
								<th>출장</th>
								<th>파견</th>
								<th>외근</th>
								<th>전일야근</th>
								<th class="td_last">합계</th>
							</tr>
						</thead>
						<tbody>
							<tr>
<!--								<td class="txt_center"><a href="#l">${result.state.l}</a></td>-->
<!--								<td class="txt_center"><a href="#n">${result.state.n}</a></td>-->
<!--								<td class="txt_center"><a href="#v">${result.state.v}</a></td>-->
<!--								<td class="txt_center"><a href="#o">${result.state.o}</a></td>-->
<!--								<td class="txt_center"><a href="#t">${result.state.t}</a></td>-->
<!--								<td class="txt_center"><a href="#s">${result.state.s}</a></td>-->
<!--								<td class="td_last txt_center">${result.state.sum}</td>-->								
								<td class="txt_center cursorPointer" onclick="searchDetail('LT');">${result.state.l}</td>								
								<td class="txt_center cursorPointer" onclick="searchDetail('VC');">${result.state.v}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('TR');">${result.state.t}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('SD');">${result.state.s}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('OT');">${result.state.o}</td>
								<td class="txt_center cursorPointer" onclick="searchDetail('NT');">${result.state.n}</td>
								<td class="bG txt_center td_last cursorPointer" onclick="searchDetail('');">${result.state.sum}</td>										                    	
							</tr>																							
						</tbody>
						</table>
					</div>
				
					<p class="th_stitle2 mT10" id="detailAreaP">상세내역 <img class="btn_arrow_down cursorPointer toggleB" id="monthlyReportTB"/></p>
	                <div id="detailArea" style="display:none;">
		                <c:import url="${rootPath}/member/selectAbsenceStateDatail.do">
		                	<c:param name="param_searchDate" value="${searchVO.searchDate}"/>
		                	<c:param name="param_searchOrgId" value="${searchVO.searchOrgId}"/>
		                	<c:param name="param_attendCd" value=""/>
		                </c:import>
					</div>
					
				<!-- 비고  -->
				<div class="note_layer" style="display:none; z-index:5;">
					<p id="atndNt"></p>
				</div>
				
					<p class="th_stitle4">부재자 정보</p>
					
					<p class="th_stitle2 mT10" id="l">지각</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>지각</caption>
						<colgroup>
							<col class="col70" />
							<col width="px" />
							<col class="col90" />
							<col class="col90" />
							<col class="col90" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>유선전화</th>
								<th>휴대전화</th>
								<th class="td_last">출근시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.lateList}" var="late">
								<tr class="height_td" id="l${night.userNo}">
									<td class="txt_center"><print:user userNo="${late.userNo}" userNm="${late.userNm}"/></td>
									<td class="txt_center">${late.orgnztNm}</td>
									<td class="txt_center">${late.userTelno}</td>
									<td class="txt_center">${late.userMoblphonNo}</td>
									<td class="td_last txt_center">${late.attendTm}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result.lateList}">
								<tr>
									<td class="td_last txt_center" colspan="4">지각 현황이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
					
					<p class="th_stitle2 mT10" id="n">야근</p>
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
						<caption>공지사항 보기</caption>
						<colgroup>
							<col class="col70" />							
							<col class="col120" />
							<col class="col90" />
							<col class="col90" />
							<col width="px" />
							<col class="col60" />
							<col class="col60" />							
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
							<c:forEach items="${result.nightList}" var="night">
								<tr class="height_td" id="n${night.userNo}">
									<td class="txt_center"><print:user userNo="${night.userNo}" userNm="${night.userNm}"/></td>
									<td class="txt_center">${night.orgnztNm}</td>
									<td class="txt_center">${night.userTelno}</td>
									<td class="txt_center">${night.userMoblphonNo}</td>									
									<td class="txt_center"><print:textarea text="${night.wsPurpose}"/></td>
									<td class="txt_center">${night.wsBgnTm}시</td>									
									<td class="td_last txt_center">${night.attendTm}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result.nightList}">
								<tr>
									<td class="td_last txt_center" colspan="7"> 야근 현황이 없습니다.</td>
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
							<col class="col70" />
							<col class="col120" />
							<col class="col130" />
<!--							<col class="col90" />-->
							<col class="col90" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>기간</th>
								<th>휴대전화</th>
								<th class="td_last">사유</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.vacList}" var="vac">
								<tr class="height_td" id="v${vac.userNo}">
									<td class="txt_center"><print:user userNo="${vac.userNo}" userNm="${vac.userNm}"/></td>
									<td class="txt_center">${vac.orgnztNm}</td>
									<td class="txt_center">
										${vac.wsBgnDe }										
										<c:if test="${vac.wsBgnTm < 11 }">오전</c:if>
										<c:if test="${vac.wsBgnTm > 11 }">오후</c:if>
										<br/>
										~${vac.wsEndDe }
										<c:if test="${vac.wsEndTm < 13 }">오전</c:if>
										<c:if test="${vac.wsEndTm > 13 }">오후</c:if>
									</td>
									<td class="txt_center">${vac.userMoblphonNo}</td>
									<td class="td_last txt_center">
										<print:textarea text="${vac.wsPurpose}"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result.vacList}">
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
							<col class="col50" />
							<col class="col90" />
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
								<th>시간</th>
								<th>휴대전화</th>
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th>등록시간</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.outList}" var="out">
								<tr class="height_td" id="o${out.userNo}">
									<td class="txt_center"><print:user userNo="${out.userNo}" userNm="${out.userNm}"/></td>
									<td class="txt_center">${out.orgnztNm}</td>
									<td class="txt_center">${out.wsBgnTm}~${out.wsEndTm}</td>
									<td class="txt_center">${out.userMoblphonNo}</td>
									<td class="txt_center">${out.wsPlace}</td>
									<td class="pL5">
										<print:textarea text="${out.wsPurpose}"/>
									</td>
									<td class="txt_center"><print:user userNo="${out.writerNo}" userNm="${out.writerNm}"/></td>
									<td class="txt_center">${out.attendTm}</td>
									<td class="td_last txt_center">
										<c:if test="${out.userNo == user.no || out.writerNo == user.no || user.admin}">											
											<a href="javascript:updateAbsence('${out.wsId}');"><img src="${imagePath}/btn/btn_plus02.gif"/></a>
											<a href="javascript:deleteAbsence('${out.wsId}');"><img src="${imagePath}/btn/btn_minus02.gif"/></a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty result.outList}">
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
							<col class="col120" />
							<col class="col100" />
							<col class="col80" />
							<col class="col80" />
							<col width="px" />
							<col class="col50" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>기간</th>
<!--								<th>유선전화</th>-->
								<th>휴대전화</th>
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.tripList}" var="trip">
								<tr class="height_td" id="t${trip.userNo}">
									<td class="txt_center"><print:user userNo="${trip.userNo}" userNm="${trip.userNm}"/></td>
									<td class="txt_center">${trip.orgnztNm}</td>
									<td class="txt_center">&nbsp;${trip.wsBgnDe}<br/>~${trip.wsEndDe}</td>
<!--									<td class="txt_center">${trip.userTelno}</td>-->
									<td class="txt_center">${trip.userMoblphonNo}</td>
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
							<c:if test="${empty result.tripList}">
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
							<col class="col120" />
							<col class="col100" />
							<col class="col90" />
							<col class="col90" />
							<col width="px" />
							<col class="col50" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
								<th>이름</th>
								<th>소속부서</th>
								<th>기간</th>
<!--								<th>유선전화</th>-->
								<th>휴대전화</th>
								<th>장소</th>
								<th>목적</th>
								<th>등록자</th>
								<th class="td_last">변경</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${result.sendList}" var="send">
								<tr class="height_td" id="s${send.userNo}">
									<td class="txt_center"><print:user userNo="${send.userNo}" userNm="${send.userNm}"/></td>
									<td class="txt_center">${send.orgnztNm}</td>
									<td class="txt_center">&nbsp;${send.wsBgnDe}<br/>~${send.wsEndDe}</td>
<!--									<td class="txt_center">${send.userTelno}</td>-->
									<td class="txt_center">${send.userMoblphonNo}</td>
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
							<c:if test="${empty result.sendList}">
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
