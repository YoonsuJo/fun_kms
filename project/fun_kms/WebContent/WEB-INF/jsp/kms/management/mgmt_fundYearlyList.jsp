<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>

<validator:javascript formName="taxPublish" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>
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
						<li class="stitle">연간보고</li>
						<li class="navi">홈 > 경영정보 > 사업실적 > 연간보고</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
	           		<ul>
						<li class="th_stitle04 mB10">연간보고</li>
						<li class="th_navi04">
							년도
							<select>
								<option>2012년</option>
							</select>
							&nbsp;[단위:천원]</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>연간보고</caption>
	                   <colgroup>
	                    	<col width="px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
	                    	<col width="50px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col">구분</th>
                    			<th scope="col">1월</th>
                    			<th scope="col">2월</th>
                    			<th scope="col">3월</th>
                    			<th scope="col">4월</th>
                    			<th scope="col">5월</th>
                    			<th scope="col">6월</th>
                    			<th scope="col">7월</th>
                    			<th scope="col">8월</th>
                    			<th scope="col">9월</th>
                    			<th scope="col">10월</th>
                    			<th scope="col">11월</th>
                    			<th scope="col">12월</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center bc01">누적현금흐름</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01">수&nbsp;입</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01">지&nbsp;출</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01">자금수지</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
		                    	<td class="txt_center">198,000</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->

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
