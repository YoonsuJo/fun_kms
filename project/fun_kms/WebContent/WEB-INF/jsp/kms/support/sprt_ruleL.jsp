<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script>
function searchRule() {
	document.frm.action = '<c:url value="${rootPath}/support/ruleS.do" />';
	document.frm.submit();
}
function writeRule() {
	$.post("${rootPaht}/support/ruleW.do", function(data) {
		$('#rule').html(data);
	});
}
function insertRule() {
	document.rule.cn.value = myeditor.outputBodyHTML();
	document.rule.action = '<c:url value="${rootPath}/support/ruleI.do" />';
	document.rule.submit();
}
function modifyRule() {
	$.post("${rootPaht}/support/ruleM.do?contentNo=" + document.rule.contentNo.value, function(data) {
		$('#rule').html(data);
	});
}
function updateRule() {
	document.rule.cn.value = myeditor.outputBodyHTML();
	document.rule.action = '<c:url value="${rootPath}/support/ruleU.do" />';
	document.rule.submit();
}
function deleteRule() {
	document.rule.action = '<c:url value="${rootPath}/support/ruleD.do" />';
	document.rule.submit();
}
function recoverRule() {
	document.rule.action = '<c:url value="${rootPath}/support/ruleR.do" />';
	document.rule.submit();
}
function modifyOrder() {
	$.post("${rootPaht }/support/ruleListM.do", function(data) {
		$('#ruleList').html(data);
	});
}
function updateOrder() {

	var ord = document.ruleList.ord_ord;
	var valid = true;
	for (var i = 0; i < ord.length; i++) {
		for (var j = 0; j < ord.length; j++) {
			if (j != i && ord[j].value == ord[i].value) {
				valid = false;
				break;
			}
		}
	}

	if (valid) {
		document.ruleList.action = '<c:url value="${rootPath}/support/ruleListU.do" />';
		document.ruleList.submit();
	} else {
		alert("중복된 숫자가 있습니다.");
	}
}
function toggleDeletedRules(obj) {
	$('#showBtn').toggle();
	$('#hideBtn').toggle();
	$('.del').toggle();
}
function toggleHistory() {
	$('#history').toggle();
}
$(document).ready(function() {
	$('.del').hide();
	if ($('.del').length > 0)
		$('#toggleB').show();
	if ($('.use').length > 1)
		$('#modifyOrderB').show();
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
						<li class="stitle">제반규정</li>
						<li class="navi">업무지원 > 업무처리지원 > 제반규정</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
					<p class="th_stitle mB20">제반규정</p>
					
					<form name="frm" action ="<c:url value='${rootPath}/support/ruleS.do'/>" method="post">
					
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
							<col class="col150" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">목록</th>
							<th scope="col" class="td_last"> </th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="pL5 pT10 pB10 txt_top">
									<form:form commandName="ruleListFrm" name="ruleList" method="post" enctype="multipart/form-data" >
									<div id="ruleList" class="lh25">
										<c:forEach items="${resultList}" var="result">
											<div class="
											<c:choose><c:when test="${result.useAt == 'Y'}">use</c:when><c:otherwise>del</c:otherwise></c:choose>
											"><input type="hidden" id="title" value="${result.titleNo }" /><a href="/support/ruleL.do?titleNo=${result.titleNo }"><span <c:if test="${result.useAt != 'Y'}">class="txt_red"</c:if>>${result.ord }. ${result.sj }</span></a><br/></div>
										</c:forEach>
										
										<br/><a href="javascript:toggleDeletedRules(this);" id="toggleB" style="display:none;" ><br/><img id="showBtn" src="${imagePath}/btn/btn_showDeletedRule.gif" /><img style="display:none;" id="hideBtn" src="${imagePath}/btn/btn_hideDeletedRule.gif" /></a>
										<c:if test="${user.admin}">
										<a href="javascript:modifyOrder();" id="modifyOrderB" style="display:none;" ><img src="${imagePath}/btn/btn_modifyRuleOrder.gif" class="mT5" /></a>
										</c:if>
									</div>
									</form:form>
								</td>
								<td class="txt_center td_last">
									<form:form commandName="ruleFrm" name="rule" method="post" enctype="multipart/form-data" >
									<div id="rule"><c:import url="${rootPath}/support/ruleV.do"></c:import></div>
									</form:form>
								</td>
							</tr>
						</tbody>
						</table>
					</div>
	            	
	            	<c:if test="${user.admin}">
	            	<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<a href="javascript:writeRule();"><img id="writeB" src="${imagePath}/btn/btn_create.gif"/></a>
           		    	<a href="javascript:insertRule();"><img id="insertB" style="display:none;" src="${imagePath}/btn/btn_regist.gif"/></a>
           		    	<a href="javascript:modifyRule();"><img id="modifyB" src="${imagePath}/btn/btn_modify.gif"/></a>
           		    	<a href="javascript:updateRule();"><img id="updateB" style="display:none;" src="${imagePath}/btn/btn_save.gif"/></a>
           		    	<a href="javascript:deleteRule();"><img id="deleteB" src="${imagePath}/btn/btn_delete.gif"/></a>
           		    	<a href="javascript:recoverRule();"><img id="recoverB" style="display:none;" src="${imagePath}/btn/btn_recover.gif"/></a>
           		    	<a href="${rootPath }/support/ruleL.do"><img id="cancelB" src="${imagePath}/btn/btn_cancel.gif"/></a>
               	    </div>
                 	<!-- 버튼 끝 -->
                 	</c:if>
	            	
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
