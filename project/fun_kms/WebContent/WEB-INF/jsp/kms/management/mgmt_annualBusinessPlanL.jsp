<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>

<script>

var id = "";
var nm = "";

<c:forEach items="${orgList}" var="org" varStatus="c">
id += "${org.id},";
nm += "${org.nm},";
</c:forEach>

<c:forEach items="${sectorList}" var="sector" varStatus="c">
<c:if test="${sector.no == searchVO.searchSectorNo}">
var sectorNo = "${sector.no}";
var sectorVal = "${sector.busiSectorVal}";
</c:if>
</c:forEach>

$(document).ready(function(){
	var form =$('#searchVO');
	form.attr('action','/management/selectAnnualBusinessPlan.do');
	function search(){
		form.submit();
	};  
	$('#searchYearPrev').click(function(){
		form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) - 1 );
		search();
	});
	$('#searchYearNext').click(function(){
		form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) + 1 );
		search();
	});

	$('select[name=searchSectorNo]').change(function(){
		search();
	});
	
});

function viewDetail(){
	var form =$('#searchVO');
	form.attr('action','/management/selectBusinessPlanApp.do');
	form.submit();

};
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
						<li class="stitle">연간사업계획</li>
						<li class="navi">홈 > 경영정보 > 사업계획 > 연간사업계획</li>
					</ul>
				</div>
				
				<!-- S: section -->
				<div class="section01">
				
			    	<!-- 상단 검색창 시작 -->
			    	<form:form commandName="searchVO" name="searchVO" id="searchVO" method="post" enctype="multipart/form-data" >
			    	<form:hidden path="searchYear"/>
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li>
		                		<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="cursorPointer" id="searchYearPrev"/>
	                			${searchVO.searchYear}년 
								<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="cursorPointer" id="searchYearNext"/>	
	                		</li>
	                		<li class="li_right">
	                			<span class="option_txt">사업구분 :</span><span class="pL7"></span>
	                			<select name="searchSectorNo">
	                				<c:forEach items="${sectorList}" var="sector">
	                					<option value="${sector.no}" <c:if test="${sector.no == searchVO.searchSectorNo}">selected="selected"</c:if>>${sector.busiSectorNm}</option>	
	                				</c:forEach>
	                			</select>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
	                </form:form>
	            	<!--// 상단 검색창 끝 -->
	            
	           		 	<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 백만원</p>
	           		 	<p class="th_plus01 txtB_Black"><a href="javascript:viewDetail();">사업계획서 보기<a></p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup>
		                    	<col class="col90" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col width="px" />
		                    	<col class="col60" />
	                    	</colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>&nbsp;</th>
		                    		<th class="T11">1월</th>
		                    		<th class="T11">2월</th>
		                    		<th class="T11">3월</th>
		                    		<th class="T11">4월</th>
		                    		<th class="T11">5월</th>
		                    		<th class="T11">6월</th>
		                    		<th class="T11">7월</th>
		                    		<th class="T11">8월</th>
		                    		<th class="T11">9월</th>
		                    		<th class="T11">10월</th>
		                    		<th class="T11">11월</th>
		                    		<th class="T11">12월</th>
		                    		<th class="td_last T11">합계</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    	<tr>
		                    		<td class="txt_center">매출(사외)</td>
		                    		<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.salesOut }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
		                    		<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.salesOut }" divideBy="${divideBy}"/>
		                    		</td> 
			                    	
		                    	</tr>
		                    	<tr>
		                    		<td class="txt_center">매출(사내)</td>
		                    		<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.salesIn }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
		                    		<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.salesIn }" divideBy="${divideBy}"/>
		                    		</td> 
			                    	
		                    	</tr>
		                    	<tr>
			                    	<td class="txt_center">매입(사외)</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.purchaseOut }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.purchaseOut }" divideBy="${divideBy}"/>
		                    		</td> 
		                    	</tr> 
		                    	<tr>
			                    	<td class="txt_center">매입(사내)</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.purchaseIn }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.purchaseIn }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr> 
		                    	<tr>
			                    	<td class="txt_center bG">매출이익</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center bG T11">
		                    				<print:currency cost="${result.salesProfit}" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center bG T11">
		                    			<print:currency cost="${resultSum.salesProfit }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="txt_center">인건비</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.planLabor}" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.planLabor }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr> 
		                    	<tr>
			                    	<td class="txt_center">판관비</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.planExp}" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.planExp }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr> 
		                    	<tr>
			                    	<td class="txt_center">공통비</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center T11">
		                    				<print:currency cost="${result.common }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center T11">
		                    			<print:currency cost="${resultSum.common }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr>
		                    	<tr>
			                    	<td class="txt_center bG">영업이익</td>
			                    	<c:forEach items="${resultList}" var="result" varStatus="status">
		                    			<td class="txt_center bG T11">
		                    				<print:currency cost="${result.busiProfit }" divideBy="${divideBy}"/> 
		                    			</td>
		                    		</c:forEach>
			                    	<td class="td_last txt_center bG T11">
		                    			<print:currency cost="${resultSum.busiProfit }" divideBy="${divideBy}"/>
		                    		</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>	<!--// 게시판 끝  -->
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
