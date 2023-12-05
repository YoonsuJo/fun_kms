<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="equipRegistDetail" staticJavascript="false" xhtml="true" cdata="false"/>
<script>
function register() {
	if (!validateEquipRegistDetail(document.frm)) {
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
							<li class="stitle">전산장비 사용등록</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 장비정보 사용등록 시작  -->
						<form name="frm" commandName="equipRegistDetail" action="${rootPath}/support/insertEquipDetail.do" method="POST">
						<input type="hidden" name="equip_no" value="${equipVO.equip_no}"/>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>전산장비 사용등록</caption>
		                    <colgroup><col class="col120" /><col width="px" /></colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">장비형태</td>
			                    	<td class="td_last pL10">
										<c:choose>
				                    		<c:when test="${equipVO.equip_type == 'monitor'}">모니터</c:when>
				                    		<c:when test="${equipVO.equip_type == 'desktop'}">데스크탑</c:when>
				                    		<c:when test="${equipVO.equip_type == 'notebook'}">노트북</c:when>
				                    		<c:when test="${equipVO.equip_type == 'server'}">서버</c:when>
				                    		<c:when test="${equipVO.equip_type == 'printer'}">프린터</c:when>
				                    		<c:when test="${equipVO.equip_type == 'webcam'}">웹캠</c:when>
				                    		<c:when test="${equipVO.equip_type == 'w-headset'}">헤드셋</c:when>
				                    		<c:when test="${equipVO.equip_type == 'wibro'}">와이브로</c:when>
				                    		<c:when test="${equipVO.equip_type == 'internetPhone'}">인터넷폰</c:when>
				                    		<c:when test="${equipVO.equip_type == 'tool'}">공구</c:when>
				                    		<c:otherwise></c:otherwise>
			                    		</c:choose>			                    	
									</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">관리번호</td>
			                    	<td class="td_last pL10">${equipVO.serial_no}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용자</td>
			                    	<td class=" pL10">
										<input type="text" name="user_nm" id="usrNm" class="search_txt02 userNameAuto" />
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">소속</td>
			                    	<td class=" pL10">
			                    		<input type="text" name="team_name" id="team_name" readonly="readonly" onfocus="orgGen('team_name','orgnztId',1);"/>
										<!--  <img id="orgTree" src="${imagePath}/btn/btn_tree.gif" onclick="orgGen('orgnztNm','orgnztId',1);" class="cursorPointer"/> -->
			                    		<input type="hidden" name="orgnztId" id="orgnztId" />
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용처</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="place"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">상태</td>
			                    	<td class=" pL10">
										<select name="status">
											<option value="1-public">공용</option>
											<option value="2-personal">개인용</option>
											<option value="3-server">서버용</option>
											<option value="4-repair">수리중</option>
											<option value="5-extra">여분</option>
											<option value="6-disuse">폐기</option>
			                    		</select>
			                    	</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용목적</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="use_purps"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">비고</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_29" name="etc"/></td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 장비정보 사용등록  끝  -->
						
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
