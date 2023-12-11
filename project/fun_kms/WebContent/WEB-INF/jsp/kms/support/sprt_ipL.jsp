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
	$('select[name="bw"]').change(function(){
		$('tbody tr').hide();
		if($('select[name="bw"]').val() == 'ALL'){
			$('tbody tr').show();
		}else{
			$('[data-ip="'+$('select[name="bw"]').val()+'"]').show();
		}
	});
})

function insertIpUse(){
	document.frm.action = '<c:url value="${rootPath}/support/selectIpW.do" />';
	document.frm.submit();
}

function modifyIpUse(no){
	document.frm.no.value = no;
	document.frm.action = '<c:url value="${rootPath}/support/selectIpM.do" />';
	document.frm.submit();
}

function deleteIpUse(no){
	document.frm.no.value = no;
	document.frm.action = '<c:url value="${rootPath}/support/deleteIpInfo.do" />';
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
		<!-- S: container -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">사내 IP 관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 사내 IP 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<div class="bot_search mB10">
							<ul>
								<li class="option_txt">
									<label>대역
										<select name="bw" class="span_8" value="">
											<option value="ALL" selected>전체</option>
											<option value="172.16.30">172.16.30 [서버]</option>
											<option value="172.16.31">172.16.31 [공용PC]</option>
											<option value="172.16.32">172.16.32 [자동할당]</option>
											<option value="172.16.33">172.16.33 [3,4 사무실]</option>
											<option value="172.16.34">172.16.34 [1,2 사무실]</option>
										</select>
									</label>
								</li>
								<li style="float:right; padding-right:6px;">
									<img src="../../images/btn/btn_regist.gif" onclick="javascript:insertIpUse();" class="cursorPointer"/>
								</li>
							</ul>
						</div>
						<form name="frm" method="post">
							<input type="hidden" name="no" value="${result.no}" />
							
							<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0">
								<colgroup>
									<col class="col120"/>
									<col class="col150"/>
									<col class="col250"/>
									<col class="col100"/>
									<col class="col150"/>
									<col class="col130"/>
								</colgroup>
								<thead>
									<tr>
									<th scope="col">IP</th>
									<th scope="col">사용자</th>
									<th scope="col">목적</th>
									<th scope="col">발급일</th>
									<th scope="col">발급자</th>
									<th scope="col"></th>
									<th scope="col">&nbsp;</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList}" var="result" varStatus="status">
										<tr data-ip="${result.bw}">
											<td class="txt_center">${result.bw}.${result.ip}</td>
											<td class="txt_center">
												<span class="cursorPointer" onclick="openUsrLayer('${result.ipUserNo}', this)">${result.ipUserNm}(${result.ipUserId})</span>
											</td>
											<td class="txt_center">${result.ipPurpose}</td>
											<td class="txt_center">${result.ipModDate}</td>
											<td class="txt_center">
												<span class="cursorPointer" onclick="openUsrLayer(${result.ipModUserNo}, this)">${result.ipModUserNm}(${result.ipModUserId})</span>
											</td>
											<td>
												<a href="javascript:modifyIpUse('${result.no}');"><img src="${imagePath}/btn/btn_modify.gif" /></a>
												<a href="javascript:deleteIpUse('${result.no}');"><img src="${imagePath}/btn/btn_delete.gif" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</form>
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