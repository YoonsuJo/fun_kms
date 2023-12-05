	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function view(presetId,presetTyp)
{
	location.href ="/admin/approval/modifyPreset.do?presetId=" + presetId + "&presetTyp=" +presetTyp;
}
function deletePreset(presetId)
{
	if(confirm("정말 삭제하시겠습니까?"))
	{
		location.href ="/admin/approval/deletePreset.do?presetId=" + presetId;	
	}
}
$(document).ready(function() {
		
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
							<li class="stitle">지출결의서 프리셋 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						<p class="th_stitle">업무경비 프리셋</p>
						<div class="boardList mB20" id="presetListD1">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>업무경비 프리셋</caption>
							<colgroup>
								<col class="col5" />
								<col class="col120" />
								<col class="col200" />
								<col width="px" />
								<col class="col50" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">이름</th>
								<th scope="col">계정과목</th>
								<th scope="col" >프로젝트</th>
								<th scope="col" >삭제</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${generalList}" var="result">
									
									<tr >
										<td class="txt_center cursorPointer" colspan="2" onclick="view('${result.presetId}','${result.presetTyp}');" >${result.presetNm }</td>
										<td class="txt_center cursorPointer" onclick="view('${result.presetId}','${result.presetTyp}');" class="cursorPointer">
											${result.accNm }
										</td>
										<td class="txt_center cursorPointer" onclick="view('${result.presetId}','${result.presetTyp}');" class="cursorPointer">
											${result.prjFnm }
										</td>
										<td>
											<a href="javascript:deletePreset('${result.presetId}');">
												<img src="${imagePath}/admin/btn/btn_delete04.gif" class="cursorPointer"/>
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="/admin/approval/writePreset.do?presetTyp=G"><img src="${imagePath }/admin/btn/btn_regist.gif" /></a>
		                </div>
		                <!-- 버튼 끝 -->	
		                
		                
		                
		                <div class="boardList mB20">
		                	<p class="th_stitle">자기개발비 프리셋</p>
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>결재문서 양식별 프리셋</caption>
							<colgroup>
								<col class="col5" />
								<col width="px" />
								<col class="col50" />
								<col class="col5" />
							</colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">프로젝트</th>
								<th scope="col" >삭제</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${selfdevList}" var="result">
										<tr >
											<td class="txt_center cursorPointer" colspan="2" onclick="view('${result.presetId}','${result.presetTyp}');" >
												${result.prjFnm }
											</td>
											<td colspan="2" class="txt_center">
												<a href="javascript:deletePreset('${result.presetId}');">
													<img src="${imagePath}/admin/btn/btn_delete04.gif" class="cursorPointer"/>
												</a>
											</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<div class="btn_area">
		                	<a href="/admin/approval/writePreset.do?presetTyp=S"><img src="${imagePath }/admin/btn/btn_regist.gif" /></a>
	                	</div>
<!-- 		                
		                <div class="boardList mB20">
		                	<p class="th_stitle">팀장경비 프리셋</p>
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>결재문서 양식별 프리셋</caption>
							<colgroup><col class="col5" /><col width="px" /><col class="col90" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">프로젝트</th>
								<th scope="col" >삭제</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${diningList}" var="result">
										<tr >
											<td class="txt_center cursorPointer" colspan="2" onclick="view('${result.presetId}','${result.presetTyp}');">
												${result.prjFnm }
											</td>
											<td colspan="2" class="txt_center">
												<a href="javascript:deletePreset('${result.presetId}');">
													<img src="${imagePath}/admin/btn/btn_delete.gif" class="cursorPointer"/>
												</a>
											</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						<div class="btn_area">
			                	<a href="/admin/approval/writePreset.do?presetTyp=D"><img src="${imagePath }/admin/btn/btn_regist.gif" /></a>
		                	</div>
						</div>
 -->		                
		                
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
