<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function update() {
	if (document.frm.wsPurpose == "") {
		alert("사유를 입력해주세요.");
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
						<li class="stitle">근태 면제 등록</li>
						<li class="navi">홈 > 인사정보 > 근태정보 > 일일근태현황</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
	            	
	            	<form name="frm" action="${rootPath}/member/updateWorkStateException.do" method="POST">
              		<input type="hidden" name="wsTyp" value="E"/>
              		<input type="hidden" name="wsId" value="${result.wsId}"/>
              		<input type="hidden" name="ref" value="${ref}"/>
		            <!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col200" />
	                    	<col width="px" />
	                   	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="bG txt_center">날짜</td>
		                    	<td class="td_last pL10">${result.wsBgnDe}</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="bG txt_center">사용자</td>
		                    	<td class="td_last pL10"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="bG txt_center">사유</td>
		                    	<td class="td_last pL10"><input type="text" class="input01 span_12" name="wsPurpose" value="${result.wsPurpose }"/></td>
	                    	</tr>
	                    </tbody>
	                    </table>
	                </div>
	            	</form>
	                
	            	<!-- 버튼 시작 -->
	                <div class="btn_area">
	                	<a href="javascript:update();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
	                	<a href="javascript:cancel();"><img src="${imagePath}/btn/btn_cancel.gif"/></a> 
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
