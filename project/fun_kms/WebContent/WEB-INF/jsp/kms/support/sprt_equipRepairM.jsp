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
<validator:javascript formName="equipRegistRepair" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateEquipRegistRepair(document.frm)) {
		return;
	}
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
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">전산장비 수리내역 수정</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 장비정보 사용등록 시작  -->
						<form name="frm" commandName="equipRegistRepair" action="${rootPath}/support/updateEquipRepair.do" method="POST">
						<input type="hidden" name="equip_no" value="${equipVO.equip_no}"/>
						<input type="hidden" name="idx" value="${equipVO.idx}"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>전산장비 수리 수정</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
<!--		                    	<tr>-->
<!--		                    		<td class="title">장비형태</td>-->
<!--			                    	<td class="td_last pL10">-->
<!--									</td>-->
<!--		                    	</tr>-->
		                    	<tr>
		                    		<td class="title">관리번호</td>
			                    	<td class="td_last pL10">${equipVO.equip_no}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">수리일자</td>
			                    	<td class=" pL10"><input type="text" class="calGen span_29" name="repairDt" value="${equipVO.repairDt}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">수리비용</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="cost" value="${equipVO.cost}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">수리내역</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="content" value="${equipVO.content}"/></td>
		                    	</tr>		                    	
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="note" value="${equipVO.note}"/></td>
		                    	</tr>		                    	
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 장비정보 사용등록  끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="javascript:register();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:history.back();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
