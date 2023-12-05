<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function modify(id) {
	document.subFrm.scheId.value = id;
	document.subFrm.submit();
}
function search() {	
	document.frm.submit();
}
var year = ${searchVO.scheYear };
function yearMove(pos){	
	document.frm.scheYear.value = year + pos;
	search();
}
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
							<li class="stitle">휴일 관리</li>
						</ul>
					</div>
					
					<span class="stxt">휴일 관리는 휴일를 등록, 수정, 목록조회, 상세조회를 제공합니다.</span>
	
					<!-- S: section -->
					<div class="section01">						
						<form name="frm" method="POST">
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="txt_center">
										<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:yearMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
				                		<span id="userSalaryYearS" class="option_txt">${searchVO.scheYear }년</span>
										<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:yearMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
										<input type="hidden" name="scheYear" value="${searchVO.scheYear}"/>
										
										<select name="scheTyp">
											<option value="">--선택하세요--</option>
											<c:forEach items="${typeList}" var="typ">
												<option value="${typ.code}" <c:if test="${typ.code == searchVO.scheTyp}">selected="selected"</c:if>>${typ.codeNm}</option>
											</c:forEach>
										</select>
										<span class="pL7"></span>
										공휴일명 <input type="text" name="searchKeyword" class="search_txt02" value="${searchVO.searchKeyword}"/>
										<img src="${imagePath}/admin/btn/btn_search02.gif" alt="검색" onclick="search();" style="cursor:pointer;"/>
									</td>
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
						</form>
		                
						<!-- 게시판 시작 -->
						<p class="th_stitle">휴일 목록</p>
						<div class="boardList">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>휴일</caption>
							<colgroup><col class="col5" /><col class="col40" /><col class="col180" /><col width="px" /><col class="col150" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"></th>
								<th scope="col">순번</th>
								<th scope="col">휴일일자</th>
								<th scope="col">휴일명</th>
								<th scope="col">휴일구분</th>
								<th class="th_right"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="c">
									<tr>
										<td class="txt_center" colspan="2">${c.count}</td>
										<td class="txt_center">${result.scheYear}.${result.scheMonth}.${result.scheDate}</td>
										<td class="txt_center"><a href="javascript:modify('${result.scheId}');">${result.scheSj}</a></td>
										<td colspan="2" class="txt_center">${result.scheTypPrint}</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area mT20">
		                	<a href="${rootPath}/admin/holiday/addHolidayView.do"><img src="${imagePath}/admin/btn/btn_regist.gif"/></a>
		                </div>
		                <!-- 버튼 끝 -->	
						
						<form name="subFrm" method="POST" action="${rootPath}/admin/holiday/modifyHoliday.do">
							<input type="hidden" name="scheId" />
						</form>
							
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
