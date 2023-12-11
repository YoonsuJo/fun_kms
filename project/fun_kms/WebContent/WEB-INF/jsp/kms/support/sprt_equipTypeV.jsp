<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
function equipUpdate(){
		document.searchVO.action = '<c:url value="${rootPath}/support/updateEquipType.do" />';
		document.searchVO.submit();
}

function equipDelete(){
	if(confirm("삭제하시겠습니까?")){
		document.searchVO.action = '<c:url value="${rootPath}/support/deleteEquipType.do" />';
		document.searchVO.submit();
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
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">

					<div class="path_navi">
						<ul>
							<li class="stitle">전산장비종류 상세정보</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 전산장비종류 관리</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						<!-- 장비정보 시작  -->
						<p class="th_stitle">전산장비종류 정보</p>
						<div class="boardWrite02 mB20">
						<form name="searchVO" method="post" id="searchVO">
							<input type="hidden" name="type_no" value="${equipVO.type_no}"/>
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>전산장비종류 보기</caption>
			                    <colgroup>
				                    <col class="col120" />
				                    <col width="px" />
			                    </colgroup>
			                    <tbody>
		                    	<tr>
		                    		<td class="title">장비종류명</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_22" name="type_name" value="${equipVO.type_name}"/></td>
		                    	</tr>
		                    	<tr>
		                    		<td class="title">DB저장값</td>
			                    	<td class=" pL10"><input type="text" class="input01 span_22" name="type_value" value="${equipVO.type_value}"/></td>
		                    	</tr>

			                    </tbody>
		                    </table>
						</form>
						</div>
						<!--// 장비정보 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<c:if test="${user.admin}">
		                		<a href="javascript:equipUpdate();"><img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" /></a>
		                		<a href="javascript:equipDelete();"><img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" /></a>
		                	</c:if>
		                	<a href="/support/selectEquipTypeList.do"><img src="${imagePath}/btn/btn_list.gif" class="cursorPointer" /></a>
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
