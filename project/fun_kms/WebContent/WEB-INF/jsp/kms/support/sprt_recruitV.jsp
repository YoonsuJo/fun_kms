<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

$(document).ready(function() {
	var form = $('#approvalVO');

	$('#appHandleCompB').click(function(){
		form.attr("action", "/support/updateHandle.do?stat=1");
		form.submit();
	});

	$('#appHandleCancleB').click(function(){
		form.attr("action", "/support/updateHandle.do?stat=2");
		form.submit();
	});

	$('#listB').click(function(){
		form.attr("action", "/support/selectRecruitList.do");
		form.submit();
	
	});
});

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
							<li class="stitle">채용 진행 상세정보</li>
							<li class="navi">홈 > 업무지원 > 각종신청 > 채용요청</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
						<p class="th_stitle">진행상태</p>
						<!-- 게시판 시작  -->	
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
							<caption>공지사항</caption>
							<colgroup>
								<col class="px" />
								<col class="px" />
								<col class="px" />
							</colgroup>
								<thead>
									<tr>
									<th scope="col">채용품의</th>
									<th scope="col">승인</th>
									<th scope="col" class="td_last">채용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="txt_center">
											<print:user userNo="${result.writerNo}" userNm="${result.writerNm}"/> (${result.writeDt})
										</td>
										<td class="txt_center">
											<c:choose>
												<c:when test="${result.docStat == 'APP001' || result.docStat == 'APP002' || result.docStat == 'APP003'}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													대기중
													</a>
												</c:when>
												<c:when test="${result.newAt == '1' && (result.docStat == 'APP004' || result.docStat == 'APP005')}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													완료
													</a>
												</c:when>
												<c:otherwise>
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													-
													</a>
												</c:otherwise>
											</c:choose>
										</td>
										<td class="txt_center td_last">
											<c:choose>
												<c:when test="${result.newAt != '1' || (result.docStat != 'APP004' && result.docStat != 'APP005')}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													대기중
													</a>
												</c:when>
												<c:when test="${result.handleStat == '0'}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													진행중
													</a>
												</c:when>
												<c:when test="${result.handleStat == '1'}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													완료
													</a>
												</c:when>
												<c:when test="${result.handleStat == '2'}">
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													취소
													</a>
												</c:when>
												<c:otherwise>
													<a href="/approval/approvalV.do?docId=${result.docId}" target="_blank">
													-
													</a>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</tbody>
							</table>
							<c:if test="${result.writerNo == user.no}">
				                <div class="btn_area02">
				                	<a href="/approval/approvalV.do?docId=${result.docId }"><img src="${imagePath}/btn/btn_approvecheck.gif"/></a>
				                </div>
			                </c:if>
							
						</div>
						<p class="th_stitle pB10">상세정보</p>
						<form:form commandName="specificVO" id="specificVO" name="specificVO" method="post" enctype="multipart/form-data" >
							<p class="th_stitle2 mB10">채용 정보</p>
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
				                <caption>공지사항 보기</caption>
				                <colgroup><col class="col100" /><col width="px" /><col class="col80" /><col class="col170"/><col class="col40"/></colgroup>
				                <tbody>
				                	<tr>
				                 	<td class="title">채용부서</td>
				                 	<td class="pL10">
				                 		<span class="span_8"><print:org orgnztNm="${specificVO.orgnztNm}" orgnztId="${specificVO.orgnztId}"/></span>
				                 	</td>
				                 	<td class="title">담당업무</td>
				                 	<td class="pL10" colspan="2">
				                 		<span class="span_8"> ${specificVO.mngTsk} </span>
				                 	</td>
				                	</tr>
				                	<tr>
				                 	<td class="title">경력</td>
				                 	<td class="pL10">
				                 	
				                 		 <input type="radio" disabled="disabled" name="carCd" value="1"  <c:if test="${specificVO.carCd==1 }"> checked</c:if>> 무관
				                 		 <input type="radio" disabled="disabled" name="carCd" value="2"  <c:if test="${specificVO.carCd==2 }"> checked</c:if>> 신입 
				                 		 <input type="radio" disabled="disabled" name="carCd" value="3"  <c:if test="${specificVO.carCd==3 }"> checked</c:if>> 경력 
				                 		 <span class="span_1">${specificVO.carMinYear}</span>년 ~ 
				                 		 <span class="span_1">${specificVO.carMaxYear}</span> 년
				                 	</td>
				                 	<td class="title">출근희망일</td>
				                 	<td class="pL10" colspan="2">
				                 		<span class="span_8"> ${specificVO.dsdFrWk} </span>
				                 	</td>
				                	</tr>
				              		<tr>
				                 	<td class="title">학력</td>
				                 	<td class="pL10">
				                 		<form:checkboxes disabled="true" items="${educationList}" path="educationList" 
				                 		itemValue="code" itemLabel="codeNm" delimiter="&nbsp;" />
				                 	</td>
				                 	<td class="title">연령</td>
				                 	<td class="pL10" colspan="2">
				                 		<span  class="span_3" >${specificVO.ageMin}</span> ~ 
				                 		<span  class="span_3" >${specificVO.ageMax}</span>
				                 	</td>
				                	</tr>
				                	<tr>
				                 	<td class="title">직급</td>
				                 	<td class="pL10">
										<form:checkboxes disabled="true" items="${rankList}" path="rankIdList" itemValue="code" itemLabel="codeNm" delimiter="&nbsp;" />
				                 		
				                 	</td>
				                 	<td class="title">성별</td>
				                 	<td class="pL10" colspan="2"> 
				                 		<form:radiobuttons disabled="true" items="${gendList}" path="gendCd" itemLabel="codeNm" itemValue="code" delimiter="&nbsp;"/>
				                 	</td>
				                	</tr>
				                	<tr>
				                 	<td class="title">키워드</td>
				                 	<td class="pL10" colspan="4"><span class="span_15"> ${specificVO.keywd} </span></td>
				                	</tr>
				                	<tr>
				                 	<td class="title">기타조건</td>
				                 	<td class="pL10 pT10 pB10" colspan="4">
				                 		<print:textarea text="${specificVO.otrCon}"/>
				                 	</td>
				                	</tr>		                    			                    	
				                </tbody>
				                </table>
							</div>
						</form:form>
						<form:form commandName="approvalVO" name="approvalVO" method="post" enctype="multipart/form-data" >
							<input type="hidden" name="docIdList" value="${result.docId}"/>

						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<img class="cursorPointer" id="listB" src="${imagePath}/btn/btn_list.gif"/>
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
