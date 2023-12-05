<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>
$(document).ready(function(){

	$('#confirmChangeB').click(function(){
		if (${user.userId == 'admin'  || user.isHmdev == 'Y'} == false) {
			alert('변경사항을 승인하려면 [admin] 계정으로 접속해 주세요.');
			return;
		}
		if (!confirm('DB구조 변경시 쿼리도 함께 수정해야 하는 기능들을 모두 점검한 후 승인하시기 바랍니다. (e.g. 프로젝트삭제 기능 등)\r\n\r\n관련 기능을 모두 점검하셨습니까?')) {
			return false;
		}
		location.replace("<c:url value='${rootPath}/admin/dbManage/confirmSchemaChange.do'/>");
	});

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
							<li class="stitle">DB 스키마 변경 점검</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						<p class="th_stitle">최근 변경사항</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
								<caption>댓글달기</caption>
								<colgroup>
									<col width="px" />
									<col width="px" />
									<col width="px" />
								</colgroup>
			                    <thead>
									<tr>
										<th scope="col">테이블명</th>
										<th scope="col">컬럼명</th>
										<th scope="col" class="td_last">변경사항</th>
									</tr>
								</thead>
								<tbody>
			                    	<c:if test="${empty resultList}">
			                    		<tr>
			                    			<td class="txt_center" colspan="3">최근 변경사항이 없습니다.</td>
			                    		</tr>
			                    	</c:if>
			                    	<c:forEach items="${resultList}" var="result">
										<tr>
											<td class="txt_center">${result.tableName}</td>
											<td class="txt_center">${result.columnName}</td>
											<td class="txt_center">
												<c:if test="${result.changeType == 'ADD'}">추가</c:if>
												<c:if test="${result.changeType == 'DEL'}">삭제</c:if>
											</td>
										</tr>
			                    	</c:forEach>
								</tbody>
							</table>
						</div>

						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<c:if test="${user.userId == 'admin' || user.isHmdev == 'Y'}">
			                	<img src="${imagePath}/admin/btn/btn_changeapply.gif" class="cursorPointer" id="confirmChangeB"/>
		                	</c:if>
		                </div>
		                <!-- 버튼 끝 -->	

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
