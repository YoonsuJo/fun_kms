<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
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
						<li class="stitle">세금계산서 신청 현황</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>	
				
				<!-- S: section -->
				<div class="section01">
				
				    <!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>
	                   <div class="top_search05 mB20">
							<table cellpadding="0" cellspacing="0">
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td class="pT5">
			               	 			처리상태 : <label><input type="checkbox" class="check" checked/> 미발행 </label> <label><input type="checkbox" class="check" /> 발행완료 </label> <label><input type="checkbox" class="check" /> 취소 </label><span class="pL5"></span> 
									</td>
									<td width="75" rowspan="3" class="search_right"><input type="image" src="../../images/btn/btn_search02.gif" class="search_btn02" alt="검색"/></td>
								</tr>
								<tr>
									<td class="pT5">
										<label><input type="checkbox" class="check"/> 요청제목 </label><input type="text"  name="" class="input01 span_10"/>
			               	 			<label><input type="checkbox" class="check" checked/> 요청자 </label><input type="text"  name="" class="input01 span_6"/> <input type="image" src="../../images/btn/btn_tree.gif" class="search_btn02" /><span class="pL5"></span>									
			               	 		</td>
								</tr>
								<tr>
									<td colspan="2" class="pT5">
										<label><input type="checkbox" class="check" checked/> 발행예정일이 일주일 이상 남은 건은 표시하지 않음 </label><span class="pL10"></span>
										<label><input type="checkbox" class="check"/> 업체명 </label> <input type="text"  name="" class="input01 span_10"/> 
									</td>
								</tr>
							</tbody>
							</table>
						</div>
	                </fieldset>
	            <!-- 상단 검색창 끝 -->
					
					<div class="boardList04 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup><col class="col5" /><col class="col40" /><col width="px" /><col class="col90" /><col class="col100" /><col class="col60" /><col class="col60" /><col class="col60" /><col class="col60" /><col class="col5" /></colgroup>
						<thead>
							<tr>
							<th class="th_left"> </th>
							<th scope="col">번호</th>
							<th scope="col">요청제목</th>
							<th scope="col">업체명</th>
							<th scope="col">총금액<br/>(VAT포함)</th>
							<th scope="col">발행<br/>예정일</th>
							<th scope="col">요청자</th>
							<th scope="col">요청일시</th>
							<th scope="col">상태</th>
							<th class="th_right"> </th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
							<tr>
								<td class="txt_center" colspan="2">1</td>
								<td class="txt_red">KT 세금계산서 8월분 발행요청합니다.</td>
								<td class="txt_center">KT</td>
								<td class="txt_center">12,345,678</td>
								<td class="txt_center">2011.00.31</td>
								<td class="txt_center">조영한</td>
								<td class="txt_center">2011.00.31 14:30:35</td>
								<td class="txt_center" colspan="2"><span class="txt_blue">미발행</span></td>
							</tr>
						</tbody>
						</table>
					</div>
					
					<!-- 하단 숫자 시작 -->
					<div class="paginate">
	                		<a href="#"><img src="../images/btn/btn_first.gif" alt="처음페이지" /></a>
	                		<a href="#" class="pR10"><img src="../images/btn/btn_prev.gif" alt="이전 페이지"></a>
	                		 1 2 3 4 5 6 7 8 9 10
							<a href="#" class="pL10"><img src="../images/btn/btn_next.gif" alt="다음 페이지"></a>
	                		<a href="#"><img src="../images/btn/btn_end.gif" alt="마지막 페이지"></a>
					</div>
					<!-- 하단 숫자 끝 -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		  <img src="../../images/btn/btn_publishRqst.gif"/>
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
