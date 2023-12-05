	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>



$(document).ready(
function(){

	var fixHelper = function(e, ui) {
		ui.children().each(function() {
			$(this).width($(this).width());
		});
		return ui;
	};
		
	$('#tableBody').sortable({
		 	helper: fixHelper,
			update: function(event, ui) { 
			//var result = $('#tableBody').sortable("toArray");
			var result2 = $('#tableBody').sortable("serialize",{ key: 'id'});

			var order = new Object();
			$('#tableBody').children('tr').each(function(idx, elm) {
				var templtId = (elm.id.split('_')[1]).toString();
			  	order[templtId] = idx.toString();

			});  
			order = JSON.stringify(order);
			order = escape(order);
			$.post("/admin/approval/ajaxOrderUpdate.do",
					{"orderResult" : order}
					, function(data) {
				 //f  alert("Data Loaded: " + data);
					}
			);
		 }
	}).disableSelection();
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
			<div id="center_bg" >
				<!-- S: center -->
				<div id="center" >
					<div class="path_navi">
						<ul>
							<li class="stitle">전자결재 양식설정 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01" >	
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재 양식설정 관리</caption>
							<colgroup><col class="col5" /><col class="col140" /><col width="px" /><col class="col70" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">양식명</th>
								<th scope="col">설명</th>
								<th scope="col">사용여부</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody id="tableBody" >
								<c:forEach var="result" items="${resultList}" varStatus="status">
									
									<tr id ="order_${result.templtId }">
										<td class="txt_center" colspan="2">
											<a href="/admin/approval/approvalV.do?templtId=${result.templtId}">${result.docSj}</a>
										</td>
										<td class="pL10 pT5 pB5">
											<a href="/admin/approval/approvalV.do?templtId=${result.templtId}">
												<print:textarea text="${result.docCt}"/>
											</a>
										</td>
										<td class="txt_center" colspan="2">
										<c:choose>
											<c:when test="${result.useYn==1}">
												사용중
											</c:when>
											<c:otherwise>
												사용중지
											</c:otherwise>
										</c:choose>
										</td>
										
									</tr>
								</c:forEach>
								
							</tbody>
							</table>
						</div>
						
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<!--추가버튼 비활성화 
		                <div class="btn_area">
		                	<a href="/admin/approval/approvalW.do">
		                		<img src="${imagePath}/btn/btn_add.gif"/>
		                	</a>
		                </div>
		                -->
		               <br/>※ 각 항목을 끌었다 놓음으로써 정렬 순서를 변경할 수 있습니다.<br/>
		                	
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
