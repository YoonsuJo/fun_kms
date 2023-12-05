<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var fixHelper = function(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
};

$(document).ready(
function(){
	
	$('#tableBody').sortable({
	 	helper: fixHelper,
		update: function(event, ui) { 

			var order = new Object();
			$('#tableBody').children('tr').each(function(idx, elm) {
				var expId = (elm.id).toString();
			  	order[idx] = expId;
			});

			order = JSON.stringify(order);
			order = escape(order);
			$.post("/admin/expansion/ajaxOrderUpdate.do",
				{"orderResult" : order}
				, function(data) {}
			);
		 }
	});
	$('#tableBody').disableSelection();
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
							<li class="stitle">확장기능 관리</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">	
						<!-- 게시판 시작 -->
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>확장기능 관리</caption>
							<colgroup><col class="col5" /><col class="col120" /><col class="col90" /><col width="px" /><col class="col90" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">아이콘</th>
								<th scope="col">제목</th>
								<th scope="col">설명</th>
								<th scope="col">사용여부</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody id="tableBody">
								<c:forEach items="${resultList}" var="result" varStatus="s">
									<tr id="<c:out value="${result.expId}" />">
										<td colspan="2" class="td_ico2">
											<c:choose>
	                    						<c:when test="${empty result.expFileId || result.expFileId == ''}">
	                    							이미지없음
	                    						</c:when>
	                    						<c:otherwise>
	                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
														<c:param name="param_atchFileId" value="${result.expFileId}" />
														<c:param name="param_width" value="50" />
														<c:param name="param_height" value="45" />
													</c:import>
	                    						</c:otherwise>
	                    					</c:choose>
										</td>
										<td class="txt_center"><a href="${rootPath}/admin/expansion/updtExpansionView.do?expId=${result.expId}"><c:out value="${result.expSj}" /></a></td>
										<td class="txt_center"><c:out value="${result.expCnShort}" /></td>
										<td colspan="2" class="txt_center"><c:out value="${result.useAtPrint}" /></td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						<br/>※ 각 항목을 끌었다 놓음으로써 정렬 순서를 변경할 수 있습니다.<br/>
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="${rootPath}/admin/expansion/insertExpansionView.do"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a>
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
