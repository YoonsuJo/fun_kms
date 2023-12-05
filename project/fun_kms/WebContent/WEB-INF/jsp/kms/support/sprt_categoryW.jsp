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
						<li class="stitle">재고입고</li>
						<li class="navi">홈 > 경영정보 > 사업실적 > 재고입고</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
           		 	<!-- 출고 게시판 시작  -->
	           		<ul>
						<li class="th_stitle04 mB10" style="clear:both">구분등록</li>
					</ul>
					<div class="boardList04 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>구분등록</caption>
	                   <colgroup>
	                    	<col width="150px" />
	                    	<col width="px" />
                    	</colgroup>
                    	<thead>
                    		<tr>
                    			<th scope="col" colspan="2" class="tal">등록 내용을 체크하세요</th>
                    		</tr>
                    	</thead> 
	                    <tbody>
	                   		<tr>
		                    	<td class="txt_center bc01">카테고리코드</td>
		                    	<td class="pL10">
		                    		<input id="" name="" class="span_7" type="text" value=""/>
		                    		예) 001
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01">카테고리명</td>
		                    	<td class="pL10">
		                    		<input id="" name="" class="span_10" type="text" value=""/>
		                    	</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bc01">하드웨어/소프트웨어</td>
		                    	<td class="pL10">
		                    		<select class="span_7">
			                    			<option>선택하세요</option>
			                    	</select>
		                    	</td>
	                    	</tr>
	                    </tbody>
	                    </table>
					</div>
					<!-- // 출고 게시판 시작  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<img src="../../images/btn/btn_regist.gif" onclick="" class="cursorPointer"/>
                		<img src="../../images/btn/btn_cancel.gif" onclick="" class="cursorPointer"/>
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
