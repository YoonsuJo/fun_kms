<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
							<li class="stitle">양식 재사용해서 기안하기</li>
							<li class="navi">홈 > 전자결재 > 기안하기 > 사용했던 양식</li>
						</ul>
					</div>
					
					<span class="stxt">목록에서 양식을 선택하면 동일한 양식의 기안문서를 새로 작성할 수 있습니다.</span>
	
					<!-- S: section -->
					<div class="section01">
	
						<p class="th_stitle mB10">자주 사용하는 양식 </p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup><col class="col5" /><col class="col90" /><col class="col100" /><col width="px" /><col class="col80" /><col class="col150" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">구분</th>
								<th scope="col">결재상태</th>
								<th scope="col">제목</th>
								<th scope="col">사용횟수</th>
								<th scope="col">최근사용일</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">완료</td>
									<td><a href="appr_FormGeneralW.jsp">자기개발비 상신합니다.</a></td>
									<td class="txt_center">32</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">완료</td>
									<td><a href="appr_FormBreakW.jsp">자기개발비 상신합니다.</a></td>
									<td class="txt_center">32</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">완료</td>
									<td><a href="appr_FormOfficialW.jsp">자기개발비 상신합니다.</a></td>
									<td class="txt_center">32</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">완료</td>
									<td><a href="appr_FormEmployW.jsp">자기개발비 상신합니다.</a></td>
									<td class="txt_center">32</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">완료</td>
									<td>자기개발비 상신합니다.</td>
									<td class="txt_center">32</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>																																
							</tbody>
							</table>
						</div>
	
						<p class="th_stitle mB10">작성중인 문서 양식  <span class="th_plus">더보기</span></p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup><col class="col5" /><col class="col100" /><col class="col100" /><col width="px" /><col class="col150" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">구분</th>
								<th scope="col">결재상태</th>
								<th scope="col">제목</th>
								<th scope="col">저장일시</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>																
							</tbody>
							</table>
						</div>
						
						<p class="th_stitle mB10">최근에 상신한 문서 양식</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>전자결재</caption>
							<colgroup><col class="col5" /><col class="col100" /><col class="col100" /><col width="px" /><col class="col150" /><col class="col5" /></colgroup>
							<thead>
								<tr>
								<th class="th_left"> </th>
								<th scope="col">구분</th>
								<th scope="col">결재상태</th>
								<th scope="col">제목</th>
								<th scope="col">저장일시</th>
								<th class="th_right"> </th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>
								<tr>
									<td class="txt_center" colspan="2">지출결의서</td>
									<td class="txt_center">기안대기</td>
									<td>자기개발비 신청합니다</td>
									<td class="txt_center" colspan="2">2011.08.13 15:23</td>
								</tr>																
							</tbody>
							</table>
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
