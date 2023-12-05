<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript">
function insertCarFix() {
	location.href = "${rootPath}/support/insertCarFixInfoView.do?carId=${result.carId}";
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
							<li class="stitle">법인차량관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인차량 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<!-- 차량정보 시작  -->
						<p class="th_stitle">차량정보</p>
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>차량정보 보기</caption>
		                    <colgroup>
			                    <col class="col120" />
			                    <col width="px" />
		                    </colgroup>
		                    <tbody>
		                    	<tr>
		                    		<td class="title">차종</td>
			                    	<td class="td_last pL10">${result.carTyp}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">차량번호</td>
			                    	<td class="td_last pL10">${result.carId}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">사용자</td>
			                    	<td class="td_last pL10">${result.userPrint}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험회사</td>
			                    	<td class="td_last pL10">${result.insComp}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험회사 연락처</td>
			                    	<td class="td_last pL10">${result.insCallNo}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험 만료일</td>
			                    	<td class="td_last pL10">${result.insEdatePrint}</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">보험연령</td>
			                    	<td class="td_last pL10">만 ${result.insAge}세 이상</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">면허종류</td>
			                    	<td class="td_last pL10">${result.insLicTypPrint} 이상</td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">소유회사</td>
			                    	<td class="td_last pL10">${result.compnyNm}</td>
		                    	</tr>		                    			                    			                    	
		                    </tbody>
		                    </table>
						</div>
						<!--// 차량정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin}">
			                	<a href="${rootPath}/support/updateCarInfoView.do?carId=${result.carId}"><img src="${imagePath}/btn/btn_modify.gif"/></a>
			                	<a href="${rootPath}/support/deleteCarInfo.do?carId=${result.carId}"><img src="${imagePath}/btn/btn_delete.gif"/></a>
		                	</c:if>
		                	<a href="${rootPath}/support/selectCarList.do"><img src="${imagePath}/btn/btn_carList.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->
		                
		                <div id="carFixArea">
		                	<c:import url="${rootPath}/support/selectCarFixList.do">
		                	</c:import>
		                </div>
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
