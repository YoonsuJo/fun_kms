<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="equipReg" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateEquipReg(document.frm)) {
		return;
	}

	document.getElementById("buy_price").value=document.getElementById("buy_price").value.replace(/\,/gi,"");
	document.frm.submit();
}
// 콤마 찍기(구매금액)
function formatNumber(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;// 정규식(3자리마다 ,를 붙임)
	n += "";// 숫자를 문자열로 변환
	n = n.replace(/\,/gi,"");//정규식을 이용해서 모든 콤마 제거
	// n값의 첫째자리부터 마지막자리까지
	while (reg.test(n)) {
		n = n.replace(reg, "$1" + "," + "$2");//인자로 받은 n 값을 ,가 찍힌 값으로 변환시킴
	}
	return n; // 바뀐 n 값을 반환.
}
function changeValue(num) {
	document.getElementById("buy_price").value=formatNumber(num);
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
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">전산장비 등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<!-- 장비정보 등록 시작  -->
						<form:form name="frm" commandName="equipReg" action="${rootPath}/support/insertEquip.do" method="POST">
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>전산장비 등록</caption>
							<colgroup><col class="col120" /><col width="px" /></colgroup>
							<tbody>
								<tr>
									<td class="title">관리번호</td>
									<td class=" pL10"><input type="text" class="input01 span_29" name="serial_no"/></td>
								</tr>
								<tr>
									<td class="title">장비구분</td>
									<td class=" pL10">
										<select class="select01" name="equip_type">
											<c:forEach items="${equipTypeList}" var="equipType">
											<option value="${equipType.type_value}" <c:if test="${searchVO.searchSelect == equipType.type_value}">selected="selected"</c:if>>${equipType.type_name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td class="title">모델명</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="model"/></td>
								</tr>
								<tr>
									<td class="title">CPU</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="cpu"/></td>
								</tr>
								<tr>
									<td class="title">MEMORY</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="memory"/></td>
								</tr>
								<tr>
									<td class="title">VGA</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="vga"/></td>
								</tr>
								<tr>
									<td class="title">HDD</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="hdd"/></td>
								</tr>
								<tr>
									<td class="title">ODD</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="odd"/></td>
								</tr>
								<tr>
									<td class="title">시리얼 번호</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="sirial_no"/></td>
								</tr>
								<tr>
									<td class="title">구입처</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="buy_place"/></td>
								</tr>
								<tr>
									<td class="title">구입처 주소</td>
									<td class=" pL10"><input type="text" class="input01 span_23" name="buy_addr"/></td>
								</tr>
								<tr>
									<td class="title">구입처 전화번호</td>
									<td class=" pL10"><input type="text" class="input01 span_22" name="buy_tel"/></td>
								</tr>
								<tr>
									<td class="title">구입시기</td>
									<td class=" pL10"><input type="text" name="buy_dt" id="buy_dt" class="input01 span_6 calGen" /></td>
								</tr>
								<tr>
									<td class="title">구입금액</td>
									<td class=" pL10"><input type="text" name="buy_price" id="buy_price" class="input01 span_6" onblur="changeValue(this.value);" /></td>
								</tr>
							</tbody>
							</table>
						</div>
						</form:form>
						<!--// 장비정보 등록  끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
							<a href="${rootPath}/support/selectEquipList.do"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
