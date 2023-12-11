<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="ConsultClient" staticJavascript="false"	xhtml="true" cdata="false" />
</head>
<script type="text/javascript">

//수정 취소 - 고객사관리 뷰 화면으로 이동
function cancelArticle() {
	
	document.frm.action = "<c:url value='${rootPath}/cooperation/selectClientList.do'/>";
	document.frm.submit();		
}
//고객사관리 정보 인서트
function insertArticle() {
	if (!validateConsultClient(document.frm)) {
		return;
	}
	if(confirm("등록하시겠습니까?")){
		document.frm.action = "<c:url value='${rootPath}/cooperation/insertClient.do'/>";
		document.frm.submit();
	}			
}
//고객사관리 정보 인서트
function moveConsultArticle() {
	if (!validateConsultClient(document.frm)) {
		return;
	}
	if(confirm("등록하시겠습니까?")){
		document.frm.directConsult.value = 'Y';
		document.frm.action = "<c:url value='${rootPath}/cooperation/insertClient.do'/>";
		document.frm.submit();
	}
}

</script>
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
							<li class="stitle">업무공유</li>
							<li class="navi">홈 > 업무공유 > 고객사관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle">고객사관리</p>
						
						<!-- 고객사관리 게시판 시작  -->
						<form:form commandName="ConsultClient" name="frm" method="post" >
						<input type="hidden" name="no"/>
						<input type="hidden" name="directConsult" value="N"/>
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>고객사관리 상세보기</caption>
		                  
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                    	<th class="write_info">고객사</th>
			                    	<th class="write_info2" colspan="3"><input type="text" name="custNm" value="" class="span_22" /></th>
		                    	</tr>
		                    	<tr>
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2" colspan="3"><input type="text" name="custManager" value="" class="span_22" /></th>
		                    	</tr>
		                    	<tr>
			                    	<th class="write_info">연락처</th>
			                    	<th class="write_info2" colspan="3"><input type="text" name="custTelno" value="" class="span_22" /></th>
		                    	</tr>
		                    	<tr>
			                    	<th class="write_info">유형</th>
			                    	<th class="write_info2" colspan="3">			                    		
			                    		<select name="typ" class="select01">
											<option value="">전체</option>
											<c:forEach items="${rankList}" var="rank">
												<option value="${rank.code}">
													<c:out value="${rank.codeNm}"/>
												</option>
											</c:forEach>
										</select>			                    		
			                    	</th>
		                    	</tr>
		                    	<tr>
			                    	<th class="write_info">서버정보</th>
			                    	<th class="write_info2" colspan="3">
			                    	
			                    	
			                    	최초탑재일 : <input type="text" name="loadDt" value="" class="calGen" maxlength="8" style="width:55px;"/><br/><br/>
			                    	 서버&nbsp;IP&nbsp;&nbsp; : <input type="text" name="ip1" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	서버&nbsp;IP2&nbsp; : <input type="text" name="ip2" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	서버&nbsp;IP3&nbsp; : <input type="text" name="ip3" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	서버&nbsp;IP4&nbsp; : <input type="text" name="ip4" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	서버&nbsp;IP5&nbsp; : <input type="text" name="ip5" value="" class="span_10" /><br/><br/>
			                    	DB&nbsp;IP&nbsp;&nbsp;&nbsp;: <input type="text" name="db1" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	DB&nbsp;IP2&nbsp;: <input type="text" name="db2" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	DB&nbsp;IP3&nbsp;: <input type="text" name="db3" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	DB&nbsp;IP4&nbsp;: <input type="text" name="db4" value="" class="span_10" /><br/><div style="height:5px"></div>
			                    	DB&nbsp;IP5&nbsp;: <input type="text" name="db5" value="" class="span_10" /><br/><br/>
			                    	
			                    	<!-- 여기부터 살릴것
			                    	최초탑재일 : <input type="text" name="searchDate" value="" class="calGen" maxlength="8" style="width:55px;"/><br/>
			                    	서버IP : <input type="text" name="ip1_1" value="${result.ip1}" class="span_2" />.<input type="text" name="ip1_2" value="${result.ip1}" class="span_2" />.<input type="text" name="ip1_3" value="${result.ip1}" class="span_2" /><br/>
			                    	서버IP2 : <input type="text" name="ip2_1" value="${result.ip2}" class="span_2" />.<input type="text" name="ip2_2" value="${result.ip2}" class="span_2" />.<input type="text" name="ip2" value="${result.ip2}" class="span_2" /><br/>
			                    	서버IP3 : <input type="text" name="ip3" value="${result.ip3}" class="span_2" />.<input type="text" name="ip3_" value="${result.ip3}" class="span_2" />.<input type="text" name="ip3" value="${result.ip2}" class="span_2" /><br/>
			                    	서버IP4 : <input type="text" name="ip4" value="${result.ip4}" class="span_2" />.<input type="text" name="ip4_2" value="${result.ip4}" class="span_2" />.<input type="text" name="ip4" value="${result.ip2}" class="span_2" /><br/>
			                    	서버IP5 : <input type="text" name="ip5" value="${result.ip5}" class="span_2" />.<input type="text" name="ip5_2" value="${result.ip5}" class="span_2" />.<input type="text" name="ip5" value="${result.ip2}" class="span_2" /><br/>
			                    	DB IP : <input type="text" name="db1" value="${result.db1}" class="span_2" />.<input type="text" name="db1" value="${result.db1}" class="span_2" />.<input type="text" name="custNm" value="${result.db1}" class="span_2" /><br/>
			                    	DB IP2 : <input type="text" name="db2" value="${result.db2}" class="span_2" />.<input type="text" name="custNm" value="${result.db2}" class="span_2" />.<input type="text" name="custNm" value="${result.db2}" class="span_2" /><br/>
			                    	DB IP3 : <input type="text" name="db3" value="${result.db3}" class="span_2" />.<input type="text" name="custNm" value="${result.db3}" class="span_2" />.<input type="text" name="custNm" value="${result.db3}" class="span_2" /><br/>
			                    	DB IP4 : <input type="text" name="db4" value="${result.db4}" class="span_2" />.<input type="text" name="custNm" value="${result.db4}" class="span_2" />.<input type="text" name="custNm" value="${result.db4}" class="span_2" /><br/>
			                    	DB IP5 : <input type="text" name="db5" value="${result.db5}" class="span_2" />.<input type="text" name="custNm"  value="${result.db5}"class="span_2" />.<input type="text" name="custNm" value="${result.db5}" class="span_2" /><br/><br/>
			                    	 -->
			                    	
			                    	원격접속정보 : <textarea name="remoteInfo" value="" class="span_25 height_150"></textarea>
			                    	
			                    	
			                    	</th>
		                    	</tr>
		                    	<tr>
			                    	<th class="write_info">기타정보</th>
			                    	<th class="write_info2" colspan="3"><textarea name="etcInfo" value="" class="span_25 height_200"></textarea></th>
			                    	
		                    	</tr>
		                        
		                    </thead>                  
							
		                   </table>
						</div>					
						
						
						</form:form>
						<!--//고객사관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:moveConsultArticle()"><img src="${imagePath}/btn/btn_goConsul.gif"/></a><!--바로상담하기  -->
		                	<a href="javascript:insertArticle()"><img src="${imagePath}/btn/btn_regist.gif"/></a><!--등록하기  -->
		                	<a href="javascript:cancelArticle();"><img src="${imagePath}/btn/btn_list.gif"/></a><!--취소하기(목록) -->
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
