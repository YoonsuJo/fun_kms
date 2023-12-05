	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function searchYear(yearMove) {
	document.frm.searchYear.value = new Number("${searchVO.searchYear}") + yearMove;
	document.frm.submit();
}
function selSectorTyp(sectorTyp) {
	document.frm.sectorTyp.value = sectorTyp;
	document.frm.submit();
}
function saveRow(rowNum) {
	var no = document.getElementById("no_" + rowNum).value;;
	var ssNm = document.getElementById("statisticSectorNm_" + rowNum).value;
	var ssVal = document.getElementById("statisticSectorVal_" + rowNum).value;
	var colorTyp = document.getElementById("colorTyp_" + rowNum).value;
		
	document.addFrm.no.value = no;
	document.addFrm.statisticSectorNm.value = ssNm;
	document.addFrm.statisticSectorVal.value = ssVal;
	document.addFrm.colorTyp.value = colorTyp;
	document.addFrm.action = "${rootPath}/admin/organ/updateStatisticSector.do";

	if (ssNm == "" || ssVal == "") {
		alert("값을 입력해주세요.");
		return false;
	}
	
	document.addFrm.submit();
}
function delRow(no) {
	document.addFrm.no.value = no;
	document.addFrm.action = "${rootPath}/admin/organ/deleteStatisticSector.do";

	document.addFrm.submit();
}
function addRow() {
	var ssNm = document.getElementById("statisticSectorNm_0").value;
	var ssVal = document.getElementById("statisticSectorVal_0").value;
	var colorTyp = document.getElementById("colorTyp_0").value;

	document.addFrm.statisticSectorNm.value = ssNm;
	document.addFrm.statisticSectorVal.value = ssVal;
	document.addFrm.colorTyp.value = colorTyp;
	document.addFrm.action = "${rootPath}/admin/organ/insertStatisticSector.do";

	if (ssNm == "" || ssVal == "") {
		alert("값을 입력해주세요.");
		return false;
	}
	
	document.addFrm.submit();
}

var fixHelper = function(e, ui) {
	ui.children().each(function() {
		$(this).width($(this).width());
	});
	return ui;
};

$(document).ready(function() {
	$('#tableBody').sortable({
		helper: fixHelper,
		update: function(event, ui) { 

			var order = new Object();
			$('#tableBody').children('tr').each(function(idx, elm) {
				var no = (elm.id).toString().substring(4);
				order[idx] = no;
			});

			order = JSON.stringify(order);
			order = escape(order);
			$.post("/ajax/admin/organ/updateStatisticSector.do",
				{"orderResult" : order}
				, function(data) {}
			);
		 }
	});
	$('#tableBody').disableSelection();
});

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
							<li class="stitle">구분별 사업실적 집계단위 설정</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">	
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" action="${rootPath}/admin/organ/statisticSector.do" method="POST">
					<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
					<input type="hidden" name="sectorTyp" value="${searchVO.sectorTyp}"/>
					<fieldset>
					<legend>상단 검색</legend>
					<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<colgroup>
								<col class="col100" />
								<col width="px" />
							</colgroup>
						<tbody>
							<tr>
								<td>
									<a href="javascript:searchYear(-1)"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									${searchVO.searchYear}년
									<a href="javascript:searchYear(1)"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
								</td>
								<td class="pL10">
									<label class="pR10"><input type="radio" name="searchSectorTyp" value="1" onclick="selSectorTyp(1);" 
											<c:if test="${searchVO.sectorTyp==1}">checked</c:if>>사업부</label>
									<label class="pR10"><input type="radio" name="searchSectorTyp" value="2" onclick="selSectorTyp(2);"
											<c:if test="${searchVO.sectorTyp==2}">checked</c:if>>수행부</label>
									<label><input type="radio" name="searchSectorTyp" value="3" onclick="selSectorTyp(3);"
											<c:if test="${searchVO.sectorTyp==3}">checked</c:if>>공통비</label>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
					</fieldset>
					</form>
					<!--// 상단 검색창 끝 -->
					
						<!-- 게시판 시작  -->
						<div class="boardList02">
							<table cellpadding="0" cellspacing="0" summary="">
							<caption>분별 사업실적 집계단위 설정</caption>
							<colgroup>
								<col class="col180" />
								<col width="px" />
								<col class="col60" />
								<col class="col100" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">명칭</th>
								<th scope="col">대상부서</th>
								<th scope="col">색상타입</th>
								<th class="td_last" scope="col"> </th>
								</tr>
							</thead>
							<tfoot>
								<tr class="bGW">
									<td class="pL10">
										<input type="text" id="statisticSectorNm_0" class="span_9"/>
									</td>
									<c:if test="${searchVO.sectorTyp!=3}">
										<td class="pL10">
											<input type="hidden" id="statisticSectorVal_0"/>
											<input type="text" id="statisticSectorValNm_0" class="span_28" onfocus="orgGen('statisticSectorValNm_0','statisticSectorVal_0',0)"/>
											<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="orgGen('statisticSectorValNm_0','statisticSectorVal_0',0)"/>
										</td>
									</c:if>
									<c:if test="${searchVO.sectorTyp==3}">
										<td class="pL10">
											<input type="hidden" id="statisticSectorVal_0"/>
											<!-- <input type="text" id="statisticSectorValNm_0" readonly class="span_28"/> -->
											<input type="text" id="statisticSectorValNm_0" class="span_28" onfocus="prjGen('statisticSectorValNm_0','statisticSectorVal_0',2)"/>
											<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="prjGen('statisticSectorValNm_0','statisticSectorVal_0',2)"/>
										</td>
									</c:if>
									<td class="pL10">
										<input type="text" id="colorTyp_0" class="span_1"/>
									</td>
									<td class="td_last txt_center">
										<a href="javascript:addRow();"><img src="${imagePath}/admin/btn/btn_save02.gif"/></a>
									</td>
								</tr>
							</tfoot>
							<tbody id="tableBody">
								<c:forEach items="${resultList}" var="result" varStatus="c">
								<tr id="idx_${result.no}">
									<td class="pL10">
										<input type="hidden" id="no_${c.count}" value="${result.no}"/>
										<input type="text" id="statisticSectorNm_${c.count}" class="span_9" value="${result.statisticSectorNm}"/>
									</td>
									<c:if test="${searchVO.sectorTyp!=3}">
										<td class="pL10">
											<input type="hidden" id="statisticSectorVal_${c.count}" value="${result.statisticSectorVal}"/>
											<input type="text" id="statisticSectorValNm_${c.count}" class="span_28" readonly="readonly" value="${result.statisticSectorValNm}" onfocus="orgGen('statisticSectorValNm_${c.count}','statisticSectorVal_${c.count}',0)"/>
											<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="orgGen('statisticSectorValNm_${c.count}','statisticSectorVal_${c.count}',0)"/>
										</td>
									</c:if>
									<c:if test="${searchVO.sectorTyp==3}">
										<td class="pL10">
											<input type="hidden" id="statisticSectorVal_${c.count}" value="${result.statisticSectorVal}"/>
											<!-- <input type="text" id="statisticSectorValNm_${c.count}" class="span_28" readonly value="${result.statisticSectorValNm}"/> -->
											<input type="text" id="statisticSectorValNm_${c.count}" class="span_28" readonly value="${result.statisticSectorValNm}" onfocus="prjGen('statisticSectorValNm_${c.count}','statisticSectorVal_${c.count}',2)"/>
											<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="prjGen('statisticSectorValNm_${c.count}','statisticSectorVal_${c.count}',2)"/>
										</td>
									</c:if>
									<td class="pL10">
										<input type="text" id="colorTyp_${c.count}" class="span_1" value="${result.colorTyp}"/>
									</td>
									<td class="td_last txt_center">
										<a href="javascript:saveRow('${c.count}');"><img src="${imagePath}/admin/btn/btn_save02.gif"/></a>
										<a href="javascript:delRow('${result.no}');"><img src="${imagePath}/admin/btn/btn_delete04.gif"/></a>
									</td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!--// 게시판 끝  -->
						
						<form name="addFrm" action="${rootPath}/admin/organ/statisticSector.do" method="POST">
							<input type="hidden" name="no"/>
							<input type="hidden" name="sectorTyp" value="${searchVO.sectorTyp}"/>
							<input type="hidden" name="statisticSectorNm"/>
							<input type="hidden" name="statisticSectorVal"/>
							<input type="hidden" name="colorTyp"/>
							<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
						</form>
						
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
