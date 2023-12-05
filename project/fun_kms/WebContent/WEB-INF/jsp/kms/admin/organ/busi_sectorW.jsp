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
function saveRow(rowNum) {
	var no = document.getElementById("no_" + rowNum).value;;
	var bsNm = document.getElementById("busiSectorNm_" + rowNum).value;
	var bsVal = document.getElementById("busiSectorVal_" + rowNum).value;

	document.addFrm.no.value = no;
	document.addFrm.busiSectorNm.value = bsNm;
	document.addFrm.busiSectorVal.value = bsVal;
	document.addFrm.useAt.value = "Y";
	document.addFrm.action = "${rootPath}/admin/organ/updateBusiSector.do";

	if (bsNm == "" || bsVal == "") {
		alert("값을 입력해주세요.");
		return false;
	}
	
	document.addFrm.submit();
}
function delRow(no) {
	document.addFrm.no.value = no;
	document.addFrm.useAt.value = "N";
	document.addFrm.action = "${rootPath}/admin/organ/updateBusiSector.do";

	document.addFrm.submit();
}
function addRow() {
	var bsNm = document.getElementById("busiSectorNm_0").value;
	var bsVal = document.getElementById("busiSectorVal_0").value;

	document.addFrm.busiSectorNm.value = bsNm;
	document.addFrm.busiSectorVal.value = bsVal;
	document.addFrm.useAt.value = "Y";
	document.addFrm.action = "${rootPath}/admin/organ/insertBusiSector.do";

	if (bsNm == "" || bsVal == "") {
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
			$.post("/ajax/admin/organ/updateBusiSector.do",
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
							<li class="stitle">부서실적집계단위 설정</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">	
					
					<!-- 상단 검색창 시작 -->
					<form name="frm" action="${rootPath}/admin/organ/busiSector.do" method="POST">
					<input type="hidden" name="searchYear" value="${searchVO.searchYear}"/>
					<fieldset>
					<legend>상단 검색</legend>
					<div class="top_search mB20">
						<table cellpadding="0" cellspacing="0" >
						<caption>상단 검색</caption>
						<tbody>
							<tr>
								<td>
									<a href="javascript:searchYear(-1)"><img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지"></a>
									${searchVO.searchYear}년
									<a href="javascript:searchYear(1)"><img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지"></a>
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
							<caption>부서실적집계단위 설정</caption>
							<colgroup>
								<col class="col200" />
								<col width="px" />
								<col class="col100" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">명칭</th>
								<th scope="col">대상부서</th>
								<th class="td_last" scope="col"> </th>
								</tr>
							</thead>
							<tfoot>
								<tr class="bGW">
									<td class="pL10">
										<input type="text" id="busiSectorNm_0" class="span_10"/></td>
									<td class="pL10">
										<input type="hidden" id="busiSectorVal_0"/>
										<input type="text" id="busiSectorValNm_0" class="span_13" onfocus="orgGen('busiSectorValNm_0','busiSectorVal_0',0)"/>
										<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="orgGen('busiSectorValNm_0','busiSectorVal_0',0)"/>	
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
										<input type="text" id="busiSectorNm_${c.count}" class="span_10" value="${result.busiSectorNm}"/>
									</td>
									<td class="pL10">
										<input type="hidden" id="busiSectorVal_${c.count}" value="${result.busiSectorVal}"/>
										<input type="text" id="busiSectorValNm_${c.count}" class="span_13" readonly="readonly" value="${result.busiSectorValNm}" onfocus="orgGen('busiSectorValNm_${c.count}','busiSectorVal_${c.count}',0)"/>
										<img src="${imagePath}/admin/btn/btn_tree.gif" onclick="orgGen('busiSectorValNm_${c.count}','busiSectorVal_${c.count}',0)"/>
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
						
						<form name="addFrm" action="${rootPath}/admin/organ/insertBusiSector.do" method="POST">
							<input type="hidden" name="no"/>
							<input type="hidden" name="busiSectorNm"/>
							<input type="hidden" name="busiSectorVal"/>
							<input type="hidden" name="busiSectorYear" value="${searchVO.searchYear}"/>
							<input type="hidden" name="useAt"/>
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
