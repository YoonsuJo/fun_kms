<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript">

$(document).ready(function(){
	$("input[name='ip']").change(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,"").replace(/(\..*)\./g, '$1'));
	});
})

function handleOnInput(el, maxlength){
	if(el.value.length > maxlength){
		el.value = el.value.substr(0, maxlength);
	}
}

function updateIpInfo(no) {
	if($("input[name='ip']").val() > 254 || $("input[name='ip']").val() < 2){
		alert("IP 범위는 2~254입니다.");
		$("input[name='ip']").focus();
		return false;
	}
	
	document.ipFrm.no.value = no;
	document.ipFrm.action = '<c:url value="${rootPath}/support/updateIpInfo.do" />';
	document.ipFrm.submit();
}

var expanded = 0;
function expandWindow() {	
	//self.resizeTo(500, 565);
	if(expanded == 0){
		self.resizeBy(0,250);
		expanded = 1;
	}			
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
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">IP등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 사내 IP 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<form name="ipFrm" method="POST">
							<input type="hidden" name="no" value="${result.no}" />
							<input type="hidden" name="ipModUserNo" value="${user.no}" />
							<!-- IP 등록 시작 -->
							<ul>
								<li class="th_stitle04 mB10" style="clear:both">IP등록</li>
							</ul>
							<div class="boardList04 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
									<caption>IP등록</caption>
									<colgroup>
										<col width="100px"/>
										<col width="px"/>
									</colgroup>
									<thead>
										<tr>
											<th scope="col" colspan="2" class="tal">등록 내용을 체크하세요</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="txt_center bc01">대역</td>
											<td class="pL10">
												<select name="bw" class="span_8" value="">
													<option value="172.16.30" <c:if test="${result.bw == '172.16.30'}"> selected</c:if>>172.16.30 [서버]</option>
													<option value="172.16.31" <c:if test="${result.bw == '172.16.31'}"> selected</c:if>>172.16.31 [공용PC]</option>
													<option value="172.16.32" <c:if test="${result.bw == '172.16.32'}"> selected</c:if>>172.16.32 [자동할당]</option>
													<option value="172.16.33" <c:if test="${result.bw == '172.16.33'}"> selected</c:if>>172.16.33 [3,4 사무실]</option>
													<option value="172.16.34" <c:if test="${result.bw == '172.16.34'}"> selected</c:if>>172.16.34 [1,2 사무실]</option>
												</select>
											</td>
										</tr>
										<tr>
											<td class="txt_center bc01">IP</td>
											<td class="pL10">
												<input type="number" oninput="handleOnInput(this, 3)" name="ip" class="span_7" min="2" max="254" value="${result.ip}"/>
												범위) 2~254
											</td>
										</tr>
										<tr>
											<td class="txt_center bc01">사용자</td>
											<td class="pL10">
												<input type="text" name="ipUserList" id="ipUserList" class="input_left write_input8 userNamesAuto userValidateCheck" value="${result.ipUserNm}(${result.ipUserId})"/>
												<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="expandWindow();usrGen('ipUserList',0);">
											</td>
										</tr>
										<tr>
											<td class="txt_center bc01">목적</td>
											<td class="pL10">
												<input type="text" class="span_10" name="ipPurpose" value="${result.ipPurpose}"/>
												ex) 업무용, 개발용
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- S: button -->
							<div class="btn_area">
								<img src="../../images/btn/btn_regist.gif" onclick="javascript:updateIpInfo('${result.no}');" class="cursorPointer"/>
                				<img src="../../images/btn/btn_cancel.gif" onclick="javascript:history.back();" class="cursorPointer"/>
							</div>
							<!-- E: button -->
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