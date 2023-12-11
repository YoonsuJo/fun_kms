<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function view(cardId){
	var searchForm = $('#searchVO');
	searchForm.attr("action","/support/selectCardView.do?cardId="+cardId);
	searchForm.submit();
}
$(document).ready(function(){
	function userOrgnztChange(){
		var val = $('[name=searchUserOrgnzt]:checked').val();
		if(val=="user")
		{
			$('#searchOrgnztNm').hide();
			$('#orgTreeB').hide();
			$('#searchUserNm').show();
			$('#usrTreeB').show();
		}
		else
		{
			$('#searchOrgnztNm').show();
			$('#orgTreeB').show();
			$('#searchUserNm').hide();
			$('#usrTreeB').hide();
		}
		
	};
	var searchForm = $('#searchVO');

	$('#searchOrgnztNm, #orgTreeB').click(function(){
		orgGen('searchOrgnztNm','searchOrgnztId',1);
	});
	
	$('#usrTreeB').click(function(){
		usrGen('searchUserNm',1,cutUsrGenName);
	});

	$('[name=searchUserOrgnzt]').change(function(){
		userOrgnztChange();
	 
	});
	
	userOrgnztChange();
});
function modifyCard(cardId){
	var searchForm = $('#searchVO');
	searchForm.attr("action",'/support/modifyCard.do?cardId='+cardId);
	searchForm.submit();
};
function deleteCard(cardId){
	var searchForm = $('#searchVO');
	alert("직접 카드를 선택하셔서 지워주십시오");
};

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.top_search07 input[name=searchUserNm]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
}

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
							<li class="stitle">법인카드 관리</li>
							<li class="navi">홈 > 업무지원 > 자원관리 > 법인카드 관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
						<!-- 상단 검색창 시작 -->
						<form:form commandName="searchVO" name="searchVO" method="post" id="searchVO">
							<fieldset>
							<legend>상단 검색</legend>
		                    <div class="top_search07 mB20">
								<table border="0" cellpadding="0" cellspacing="0" >
								<caption>상단 검색</caption>
								<colgroup>
									<col width="px" />
									<col width="px" />	
									<col class="col80" />
								</colgroup>
								<tbody>
									<tr>
										<td>
				               	 			카드상태 : 
			               	 				<form:checkboxes items="${cardStatList}" path="searchStatList" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;"/>
										</td>
										<td>
											회사구분 : 
												<form:radiobutton path="searchCompanyAll" value="true" label="전체"/>
												<form:radiobutton path="searchCompanyAll" value="false" label="선택"/>
												<form:select items="${companyList}" path="searchCompanyCd" itemLabel="codeNm" itemValue="code" />
										</td>
										<td rowspan="2" class="search_right"> <input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02" alt="검색"/></td>
									</tr>
									<tr>
										<td>
											지급상태 : 
											<label><form:checkbox path="searchProvided" cssClass="check" value="true"/> 지급</label>
											<label><form:checkbox path="searchUnProvided" cssClass="check" value="true"/> 미지급</label>
										</td>
										<td>
											<label><form:radiobutton path="searchUserOrgnzt" value="user"/> 사용자</label> 
											<label><form:radiobutton path="searchUserOrgnzt" value="orgnzt"/>부서</label> 
											<form:input path="searchUserNm" id="searchUserNm" cssClass="input01 span_7 userNameAutoHead"/>
											<form:input path="searchOrgnztNm" cssClass="input01 span_7" readonly="true"/>
											<form:hidden path="searchOrgnztId"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" id="orgTreeB"/>
											<img src="${imagePath}/btn/btn_tree.gif" class="search_btn02 cursorPointer" id="usrTreeB"/>
										</td>
									</tr>
								</tbody>
								</table>
			                    </div>
			                </fieldset>
		                </form:form>
		            	<!--// 상단 검색창 끝 -->
		            	
						<!-- 버튼 시작 -->
		                <div class="btn_area">
			                <c:if test="${user.admin}">
			                	<a href="${rootPath}/support/writeCard.do">
			                		<img src="${imagePath}/btn/btn_regist.gif" />
			                	</a>
			                </c:if>
		                </div>
		                <!-- 버튼 끝 -->					
						
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col120" />
							<col class="col80" />
							<col class="col60" />
							<col class="col90" />
							<col class="col60" />
							<col class="col60" />
							<col class="col60" />
							<col width="px" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">카드번호</th>
							<th scope="col">유효기간</th>
							<th scope="col">한도</th>
							<th scope="col">회사구분</th>
							<th scope="col">카드상태</th>
							<th scope="col">지급상태</th>
							<th scope="col">사용자</th>
							<th scope="col">비고</th>
							<th scope="col">&nbsp;</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList}" var="result" varStatus="status">
								<tr class="cursorPointer">
									<td onclick='view("${result.cardId }");'  class="txt_center">${result.cardId }</td>
									<td onclick='view("${result.cardId }");'  class="txt_center">${result.expiryYear }년 ${result.expiryMonth }월</td>
									<td onclick='view("${result.cardId }");'  class="txt_center"><print:currency cost="${result.limitSpend }"/></td>
									<td onclick='view("${result.cardId }");'  class="txt_center">${result.companyNm}</td>
									<td onclick='view("${result.cardId }");'  class="txt_center">${result.statNm}</td>
									<td onclick='view("${result.cardId }");'  class="txt_center">
										<c:choose>
				                    		<c:when test="${empty result.userId }">
				                    		미지급
				                    		</c:when>
				                    		<c:otherwise>
				                    		지급 
				                    		</c:otherwise>
			                    		</c:choose>
									</td>
									<td onclick='view("${result.cardId }");'  class="txt_center"><print:user userNo="${result.userNo}" userNm="${result.userNm}"/></td>
									<td onclick='view("${result.cardId }");'  class="txt_center">${result.note}</td>
									<td class="txt_center">
										<c:if test="${user.admin}">
											<a href="/support/modifyCard.do?cardId=${result.cardId}">
												<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPoineter" />
											</a>
										</c:if>
									 </td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
						</div>
						<!-- 버튼 시작 -->
		                <div class="btn_area">
			                <c:if test="${user.admin}">
			                	<a href="${rootPath}/support/writeCard.do">
			                		<img src="${imagePath}/btn/btn_regist.gif" />
			                	</a>
			                </c:if>
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
