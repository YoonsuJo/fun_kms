<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function(){
	$("#recruitB").click(function(){
		//작성페이지로 이동
		
	});


	$("#searchB").click(search);

	$('#approvalVO input[type=text]').keyup( function(event){
	    if (event.keyCode == 13)
	      search(1);   
	});


});
function view(docId)
{
	var form = $('#approvalVO');
	form.attr("action", "/support/selectRecruitArticle.do?docId="+docId);
	form.submit();	
}

function search(page)
{
	var form = $('#approvalVO');
	if(!isNaN(page))
		$("#approvalVO > input[name='pageIndex']").val(page);
	form.attr("action", "/support/selectRecruitList.do");
	form.submit();
	
}

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.bot_search input[name=searchWriterNm]');
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
						<li class="stitle">채용현황</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 채용요청</li>
					</ul>
				</div>	
				
				<!-- S: section -->
				<div class="section01">
					<form:form commandName="approvalVO" name="approvalVO" method="post" enctype="multipart/form-data" >
					<input name="pageIndex" type="hidden" value="<c:out value='${approvalVO.pageIndex}'/>"/>
				
					    <!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
		                    <div class="bot_search mB10">
								<ul>
									<li class="option_txt">
									처리상태 : 
										<form:checkbox path="completeDocYn" value="N"/> 승인대기<span class="pL7"></span>
										<form:checkbox path="searchHandleStatL"   value="0"/> 채용중<span class="pL7"></span>
										<form:checkbox path="searchHandleStatL"  value="1" /> 채용완료<span class="pL7"></span>
										<form:checkbox path="searchHandleStatL"  value="2" /> 취소<span class="pL7"></span>
									</li>
									<li class="search_box">
										제목 : 
										<form:input  path="searchSubject" cssClass="search_txt02 span_4"/>
										<span class="pL7"></span>요청자 :
										<form:input path="searchWriterNm" id="searchWriterNm" cssClass="search_txt02 span_4 userNameAutoHead"/>
										<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchWriterNm',1,cutUsrGenName);" class="cursorPointer">
									</li>
									<li>
										<img id="searchB" class="cursorPointer" src="${imagePath }/btn/btn_search02.gif" alt="검색"/>
									</li>
	                        	</ul>
		                    </div>
		                </fieldset>
		          	  <!-- 상단 검색창 끝 -->
	            
						
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="col40" />
								<col width="px" />
								<col class="col120" />
								<col class="col120" />
								<col class="col90" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">번호</th>
								<th scope="col">요청제목</th>
								<th scope="col">요청자</th>
								<th scope="col">요청일시</th>
								<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
	
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td class="txt_center"><c:out value="${(approvalVO.pageIndex-1) * approvalVO.pageSize + status.count}"/></td>
										<td>
											<c:choose>
												<c:when test="${((result.docStat == 'APP004') || (result.docStat == 'APP005')) && (result.newAt == '1')}">
													<a href="javascript:view('${result.docId}');">
														<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
															${result.subject}
														</span>
													</a>
												</c:when>
												<c:when test="${result.writerNo == user.no || user.admin}">
													<a href="javascript:view('${result.docId}');">
														<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
															${result.subject}
														</span>
													</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:alert('승인대기 문서는 요청자, 채용담당자 및 관리자만 열람 가능합니다.');">
														<span <c:if test="${empty result.srchDt }"> class="txt_red"</c:if>>
															${result.subject}
														</span>
													</a>
												</c:otherwise>
											</c:choose>
										</td>
										<td class="txt_center"><print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/></td>
										<td class="txt_center">${result.writeDtLong}</td>
										<td class="txt_center">
											<c:choose>
												<c:when test="${((result.docStat == 'APP004') || (result.docStat == 'APP005')) && (result.newAt == '1')}">
													<c:choose>
														<c:when test="${result.handleStat == 0}">
															<span class="txt_blue">채용중</span>
														</c:when>
														<c:when test="${result.handleStat == 1}">
															채용완료
														</c:when>
														<c:otherwise>
															취  소
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="txt_blue">승인대기</span>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								 </c:forEach>	
							</tbody>
							</table>
						</div>
						
						<!-- 페이징 시작 -->
						<div class="paginate">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />	
						</div>	
						<!-- 페이징 끝 -->
						
						<!-- 버튼 시작 -->
	           		    <div class="btn_area">
	                		  <a href="${rootPaht }/approval/approvalW.do?templtId=4"><img id="recruitB" src="${imagePath}/btn/btn_recruit.gif"/></a>
	               	    </div>
	                 	<!-- 버튼 끝 -->
                 	</form:form>
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
