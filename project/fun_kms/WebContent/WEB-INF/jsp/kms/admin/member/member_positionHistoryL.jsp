<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function view() {
	document.getElementById("member_appointment").style.display = "";
}

function cancel() {
	document.getElementById("member_appointment").style.display = "none";
}

function deleteLastHistory() {
	if (confirm('정말로 최근 발령사항을 삭제하시겠습니까?')) {
		var action = '<c:url value="${rootPath}/admin/member/deleteLastPositionHistory.do"/>';
		document.frm.action = action;
		document.frm.submit();
	}
}

function register() {
	if (document.frm.chngDt.value == "") {
		alert("발령일을 입력해주세요");
		return;
	}
	if (document.frm.chngDt.value < document.frm.bfrChngDt.value) {
		alert("발령일 이후에 발령기록이 있습니다.\r\n확인 후 등록해주세요.");
		return;
	}
	if (document.frm.chngDt.value > "${today}") {
		//alert("오늘 이후의 날짜로 발령을 낼 수 없습니다.");
		//return;
	}
	
	var chngCode = document.frm.chngCode;
	var code = "";
	if (chngCode.checked == true) {
		code = chngCode.value;;
	} else {
		for (var i=0; i<chngCode.length; i++) {
			if(chngCode[i].checked) {
				code = chngCode[i].value;
			}
		}
	}

	if (code == "") {
		alert("발령구분을 선택해주세요");
		return;
	}
	
	var rank = document.frm.aftRankId;
	var comp = document.frm.aftCompId;
	var group = document.frm.aftOrgnztId;
	var position = document.frm.aftPosition;
	
	if (code == "CH") { //변경
	} else if (code == "EN") { //입사
		setPosition("N");
	} else if (code == "RT") { //퇴직
		//rank.value = "";
		comp.disabled = false;
		comp.value = "${result.member.compnyId}";
		group.value = "";
		setPosition("N");
	} else if (code == "RE") { //재입사
		setPosition("N");
	} else if (code == "LV") { //휴직
		rank.disabled = false;
		rank.value = "${result.member.rankId}";
		comp.disabled = false;
		comp.value = "${result.member.compnyId}";
		group.value = "${result.member.orgnztId}";
		setPosition("N");
	} else if (code == "BK") { //복귀
		rank.disabled = false;
		rank.value = "${result.member.rankId}";
		comp.disabled = false;
		comp.value = "${result.member.compnyId}";
		group.value = "${result.member.orgnztId}";
		setPosition("N");
	}
	document.frm.submit();
}

function disableSetting(obj) {
	var code = obj.value;
	
	var rank = document.frm.aftRankId;
	var comp = document.frm.aftCompId;
	var group = document.frm.aftOrgnzt;
	var orgTree = document.getElementById("orgTree");
	
	if (code == "CH") {
		rank.disabled = false;
		comp.disabled = false;
		group.disabled = false;
		orgTree.onclick = new Function("orgGen('aftOrgnzt','aftOrgnztId',1)");
		disablePosition(false);
	} else if (code == "EN") {
		rank.disabled = false;
		comp.disabled = false;
		group.disabled = false;
		orgTree.onclick = new Function("orgGen('aftOrgnzt','aftOrgnztId',1)");
		disablePosition(true);
	} else if (code == "RT") {
		rank.disabled = true;
		comp.disabled = true;
		group.disabled = true;
		orgTree.onclick = "";
		disablePosition(true);
	} else if (code == "RE") {
		rank.disabled = false;
		comp.disabled = false;
		group.disabled = false;
		orgTree.onclick = new Function("orgGen('aftOrgnzt','aftOrgnztId',1)");
		disablePosition(true);
	} else if (code == "LV") {
		rank.disabled = true;
		comp.disabled = true;
		group.disabled = true;
		orgTree.onclick = "";
		disablePosition(true);
	} else if (code == "BK") {
		rank.disabled = true;
		comp.disabled = true;
		group.disabled = true;
		orgTree.onclick = "";
		disablePosition(true);
	} else {
		alert("error");
		return;
	}
}

function disablePosition(bool) {
	var position = document.frm.aftPosition;
	for (var i=0; i<position.length; i++) {
		position[i].disabled = bool;
	}
}
function setPosition(input) {
	var position = document.frm.aftPosition;
	for (var i=0; i<position.length; i++) {
		if (position[i].value == input) {
			position[i].checked = true;
			position[i].disabled = false;
		}
	}
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
							<li class="stitle">인사발령 내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
					
						<!-- 게시판 시작  -->
						<p class="th_stitle">인사발령 대상자</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col120" /><col class="col120" /><col class="col120" /><col class="col120" /><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
			                    	<td class="title">사번</td>
			                    	<td class="pL10"><c:out value="${result.member.sabun}" /></td>
			                    	<td class="title">이름</td>
			                    	<td class="pL10"><c:out value="${result.member.userNm}" /></td>
			                    	<td class="title">직급</td>
			                    	<td class="pL10"><c:out value="${result.member.rankNm}" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">소속회사</td>
			                    	<td class="pL10"><c:out value="${result.member.compnyNm}" /></td>
			                    	<td class="title">소속부서</td>
			                    	<td class="pL10"><c:out value="${result.member.orgnztNmFull}" /></td>
			                    	<td class="title">보직</td>
			                    	<td class="pL10"><c:out value="${result.member.positionPrint}" /></td>
		                    	</tr>
		                    	<tr>
			                    	<td class="title">입사일</td>
			                    	<td class="pL10"><c:out value="${result.member.compinDtPrint}" /></td>
			                    	<td class="title">퇴사일</td>
			                    	<td class="pL10"><c:out value="${result.member.compotDtPrint}" /></td>
			                    	<td class="title">근무상태</td>
			                    	<td class="pL10"><c:out value="${result.member.workStPrint}" /></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
		                <div class="btn_area">
	                    	<a href="javascript:view();"><img src="${imagePath}/admin/btn/btn_appointment.gif"/></a>
	                    	<a href="javascript:deleteLastHistory();"><img src="${imagePath}/btn/btn_appointDel.gif"/></a>
		                </div>
	              		
						<p class="th_stitle">인사발령 이력</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>인사발령 이력</caption>
							<colgroup>
								<col class="col5" />
								<col class="col70" />
								<col class="col60" />
								<col class="col40" />
								<col class="col90" />
								<col class="col220" />
								<col class="col70" />
								<col width="px" />
								<col class="col50" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">발령일자</th>
								<th scope="col">발령사항</th>
								<th scope="col">직급</th>
								<th scope="col">소속회사</th>
								<th scope="col">부서</th>
								<th scope="col">보직</th>
								<th scope="col">비고</th>
								<th scope="col">처리자</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="r">
									<tr>
										<td class="txt_center" colspan="2"><c:out value="${r.chngDtPrint}" /></td>
										<td class="txt_center"><c:out value="${r.chngCodePrint}" /></td>
										<td class="txt_center"><c:out value="${r.aftRankNm}" /></td>
										<td class="txt_center"><c:out value="${r.aftCompNm}" /></td>
										<td class="txt_center"><c:out value="${r.aftOrgnztNm}" /></td>
										<td class="txt_center"><c:out value="${r.aftPositionPrint}" /></td>
										<td class="txt_center"><c:out value="${r.note}" escapeXml="false"/></td>
										<td colspan="2" class="txt_center"><c:out value="${r.adminNm}" /></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>						
						<!--// 게시판 끝  -->
						
						<!-- 레이어  -->
						<div id="positionWrite">
							<c:import url="${rootPath}/admin/member/chngPositionHistoryView.do" charEncoding="utf-8">
							</c:import>
						</div>
						<!-- // 레이어 끝-->
						
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
