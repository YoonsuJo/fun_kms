<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function save() {

	if(!fn_validation()){
		return;
	}
	
	document.frm.action = "${rootPath}/license/licenseModify.do";
	document.frm.submit();
}
function del() {
	if(confirm("삭제하시겠습니까?")){
		document.frm.action = "${rootPath}/license/licenseDel.do";
		document.frm.submit();
	}
}

function del2(licenseId, historyId){
	if(confirm("삭제하시겠습니까?")){
		document.frm.licenseId.value = licenseId;
		document.frm.historyId.value = historyId;
		document.frm.action = "${rootPath}/license/licenseDel.do";
		document.frm.submit();
	}
}

function fn_validation(){

	if(document.all.companyName.value.length == 0){
		alert("회사명을 입력해 주시기 바랍니다.");
		document.all.companyName.focus();
		return false;
	}
	if(document.all.person.value.length == 0){
		alert("업체 담당자를 입력해 주시기 바랍니다.");
		document.all.person.focus();
		return false;
	}
	if(document.all.phone.value.length == 0){
		alert("연락처를 입력해 주시기 바랍니다.");
		document.all.phone.focus();
		return false;
	}

	return true;
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
		
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">라이선스 수정</li>
							<li class="navi">홈 > 업무공유 > 정보공유 > 라이선스 수정</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						
						<!-- 게시판 시작 -->
						<form name="frm" method="POST">
							<input type="hidden" name="page" value="${searchVO.page}">
							<input type="hidden" name="licenseId" value="${result.licenseId}">
							<input type="hidden" name="searchCompanyName" value="${searchVO.searchCompanyName}"/>
							<input type="hidden" name="searchExpireDateStart" value="${searchVO.searchExpireDateStart}"/>
							<input type="hidden" name="searchExpireDateEnd" value="${searchVO.searchExpireDateEnd}"/>
							<input type="hidden" name="searchProduct" value="${searchVO.searchProduct}"/>
						<p class="th_stitle">라이선스 수정</p>
						<c:if test="${result2.historyId == null}">
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>라이선스 수정</caption>
			                    <colgroup>
				                    <col class="col180" />
				                    <col width="px" />
				                    <col class="col120" />
				                    <col width="px" />
			                    </colgroup>
			                    <tbody>
			                    
			                    	<tr>
				                    	<td class="title">제품선택</td>
				                    	<td class="pL10" colspan="3">${result.licenseView.product}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">회사명</td>
				                    	<td class="pL10" colspan="3"><input type="text" class="span_16" name="companyName" value="${result.companyName}"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">업체담당자</td>
				                    	<td class="pL10"><input type="text" class="span_9" name="person" value="${result.person}"/></td>
				                    	<td class="title">연락처</td>
				                    	<td class="pL10"><input type="text" style="width: 159px" name="phone" value="${result.phone}"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">발급자</td>
				                    	<td class="pL10">${result.regUserName}</td>
				                    	<td class="title">발급일시</td>
				                    	<td class="pL10"><fmt:formatDate value="${result.licenseView.regDateTime}" pattern="yyyy-MM-dd"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">설치서버 IP</td>
				                    	<td class="pL10" colspan="3">${result.licenseView.serverIpAddr}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">설치서버 MAC Address</td>
				                    	<td class="pL10" colspan="3">${result.licenseView.serverMacAddr}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">접속제한수</td>
				                    	<td class="pL10" colspan="3">최대 ${result.licenseView.maxUserLimit} 명 / 계약 ${result.licenseView.maxUser} 명</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">대상단말</td>
				                    	<td class="pL10" colspan="3">
				                    		<c:forEach items="${result.licenseView.clientList}" var="client"  varStatus="cnt">
				                    			<c:if test="${client == 'pc'}">
				                    			PC
				                    			</c:if>
				                    			<c:if test="${client == 'mobile'}">
				                    			모바일
				                    			</c:if>
				                    			<c:if test="${client == 'codec'}">
				                    			H/W 코덱
				                    			</c:if>
				                    			<c:if test="${!cnt.last}">, </c:if>
				                    		</c:forEach>
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">제공기능</td>
				                    	<td class="pL10" colspan="3">
				                    		
				                    		<c:forEach items="${result.licenseView.functionList}" var="function"  varStatus="cnt">
				                    			<c:if test="${function == 'video'}">
				                    			영상회의
				                    			</c:if>
				                    			<c:if test="${function == 'document'}">
				                    			문서공유
				                    			</c:if>
				                    			<c:if test="${function == 'media'}">
				                    			미디어공유
				                    			</c:if>
				                    			<c:if test="${function == 'seminar'}">
				                    			화면공유
				                    			</c:if>
				                    			<c:if test="${!cnt.last}">, </c:if>
				                    		</c:forEach>
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">만료일</td>
				                    	<td class="pL10" colspan="3">
				                    		<c:if test="${result.licenseView.expireDate eq '99999999'}">
												무한																			
											</c:if>	
											<c:if test="${result.licenseView.expireDate ne '99999999'}">
												<c:out value="${fn:substring(result.licenseView.expireDate, 0, 4)}-${fn:substring(result.licenseView.expireDate, 4, 6)}-${fn:substring(result.licenseView.expireDate, 6, 8)}"/>																		
											</c:if>	
				                    		
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">메모</td>
				                    	<c:if test="${result.memo == 'null'}">
				                    		<td class="pL10 pT5 pB5" colspan="3">
				                    			<textarea class="span_16 height_35" name="memo"></textarea>
				                    		</td>
				                    	</c:if>
				                    	<c:if test="${result.memo != 'null'}">
				                    		<td class="pL10 pT5 pB5" colspan="3">
				                    			<textarea class="span_16 height_35" name="memo">${result.memo}</textarea>
				                    		</td>
				                    	</c:if>
			                    	</tr>
			                    </tbody>
			                    </table>
							</div>
						</c:if>
	                    <c:if test="${result2.historyId != null}">
	                   		<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>라이선스 수정</caption>
			                    <colgroup>
				                    <col class="col180" />
				                    <col width="px" />
				                    <col class="col120" />
				                    <col width="px" />
			                    </colgroup>
			                    <tbody>
			                    
			                    	<tr>
				                    	<td class="title">제품선택</td>
				                    	<td class="pL10" colspan="3">${result2.license.licenseView.product}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">회사명</td>
				                    	<td class="pL10" colspan="3"><input type="text" class="span_16" name="companyName" value="${result2.license.companyName}"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">업체담당자</td>
				                    	<td class="pL10"><input type="text" class="span_9" name="person" value="${result2.license.person}"/></td>
				                    	<td class="title">연락처</td>
				                    	<td class="pL10"><input type="text" style="width: 159px" name="phone" value="${result2.license.phone}"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">발급자</td>
				                    	<td class="pL10">${result2.license.regUserName}</td>
				                    	<td class="title">발급일시</td>
				                    	<td class="pL10"><fmt:formatDate value="${result2.regDateTime}" pattern="yyyy-MM-dd"/></td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">설치서버 IP</td>
				                    	<td class="pL10" colspan="3">${result2.license.licenseView.serverIpAddr}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">설치서버 MAC Address</td>
				                    	<td class="pL10" colspan="3">${result2.license.licenseView.serverMacAddr}</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">접속제한수</td>
				                    	<td class="pL10" colspan="3">최대 ${result2.license.licenseView.maxUserLimit}명 / 계약 ${result2.license.licenseView.maxUser} 명</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">대상단말</td>
				                    	<td class="pL10" colspan="3">
				                    		<c:forEach items="${result2.license.licenseView.clientList}" var="client" varStatus="cnt">
				                    			<c:if test="${client == 'pc'}">
				                    			PC
				                    			</c:if>
				                    			<c:if test="${client == 'mobile'}">
				                    			모바일
				                    			</c:if>
				                    			<c:if test="${client == 'codec'}">
				                    			H/W 코덱
				                    			</c:if>
				                    			<c:if test="${!cnt.last}">, </c:if>
				                    		</c:forEach>
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">제공기능</td>
				                    	<td class="pL10" colspan="3">
				                    		<c:forEach items="${result2.license.licenseView.functionList}" var="function" varStatus="cnt">
				                    			<c:if test="${function == 'video'}">
				                    			영상회의
				                    			</c:if>
				                    			<c:if test="${function == 'document'}">
				                    			문서공유
				                    			</c:if>
				                    			<c:if test="${function == 'media'}">
				                    			미디어공유
				                    			</c:if>
				                    			<c:if test="${function == 'seminar'}">
				                    			화면공유
				                    			</c:if>
				                    			<c:if test="${!cnt.last}">, </c:if>
				                    		</c:forEach>
				                    		
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">만료일</td>
				                    	<td class="pL10" colspan="3">
				                    		<c:if test="${result2.license.licenseView.expireDate eq '99999999'}">
												무한																			
											</c:if>	
											<c:if test="${result2.license.licenseView.expireDate ne '99999999'}">
												<c:out value="${fn:substring(result2.license.licenseView.expireDate, 0, 4)}-${fn:substring(result2.license.licenseView.expireDate, 4, 6)}-${fn:substring(result2.license.licenseView.expireDate, 6, 8)}"/>																			
											</c:if>	
				                    		
				                    	</td>
			                    	</tr>
			                    	<tr>
				                    	<td class="title">메모</td>
				                    	<c:if test="${result2.license.memo == 'null'}">
				                    		<td class="pL10 pT5 pB5" colspan="3">
				                    			<textarea class="span_16 height_35" name="memo"></textarea>
				                    		</td>
				                    	</c:if>
				                    	<c:if test="${result2.license.memo != 'null'}">
				                    		<td class="pL10 pT5 pB5" colspan="3">
				                    			<textarea class="span_16 height_35" name="memo">${result2.license.memo}</textarea>
				                    		</td>
				                    	</c:if>
			                    	</tr>
			                    </tbody>
			                    </table>
							</div>
	                    </c:if>	
						</form>
						<!--// 게시판 끝-->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02 pB20">
		                	<ul>
		                		<li class="right">
		                		<!-- 
		                		
		                			<c:if test="${user.userId == result.regUserId || user.admin}">
			                			<c:if test="${result2.historyId == null}">
			                				<a href="javascript:del();"><img src="${imagePath}/btn/btn_delete.gif"/></a>
			                			</c:if>
			                			<c:if test="${result2.historyId != null}">
			                				<a href="javascript:del2('${result.licenseId}', '${result2.historyId}');"><img src="${imagePath}/btn/btn_delete.gif"/></a>
			                			</c:if>
		                			</c:if>
		                		
		                		 -->
		                			
		                			<a href="javascript:save();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                		</li>
		                	</ul>
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
