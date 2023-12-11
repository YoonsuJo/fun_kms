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
		<%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">결재문서 양식 선택</li>
							<li class="navi">홈 > 전자결재 > 기안하기 > 새로 작성하기</li>
						</ul>
					</div>
					
					<span class="stxt">
						전자결재 양식을 선택하여 새로운 결재문서를 작성할 수 있습니다.<br/><br/>
						[결재선 지정]<br/>
						- 검토자 : 결재건을 검토해야 할 사람으로 합니다. 반려권을 갖습니다.<br/>
						- 협조자 : 결재건을 협조해야 할 사람으로 합니다. 반려권을 갖습니다.<br/>
						- 전결자 : 결재건에 대하여 최종 결정을 하는 사람입니다.<br/>
						- 참조자 : 결재건에 대하여 의사결정에는 참여하진 않지만 해당 내용을 알아야 할 사람입니다.<br/>
					</span>
	
					<!-- S: section -->
					<div class="section01">
						
						<p class="th_stitle mB10">결재문서 양식</p>
						<!-- 게시판 시작  -->
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>공지사항 보기</caption>
		                    <colgroup><col class="col250" /><col width="px" /></colgroup>
		                    <thead>
		                    	<tr>
		                    		<th>양식명</th>
		                    		<th class="td_last">설명</th>
		                    	</tr>
		                    </thead>
		                    <tbody>
		                    <c:forEach var="result" items="${appTypList}" varStatus="status">
		                    	<tr>
			                    	<td class="td_ico">
			                    		<ul>
			                    			<li>
			                    				<a href="/approval/approvalW.do?templtId=${result.templtId }">
			                    					<c:choose>
			                    						<c:when test="${result.docIcon==''}">
			                    							<img src="${imagePath}/approval/ico_general.gif" />	
			                    						</c:when>
			                    						<c:otherwise>
			                    							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
																<c:param name="param_atchFileId" value="${result.docIcon}" />
															</c:import>
			                    						
			                    						</c:otherwise>
			                    					
			                    					</c:choose>
			                    				</a>
			                    			</li>
			                    			<li class="pT15 pL10"><a href="/approval/approvalW.do?templtId=${result.templtId }">${result.docSj }</a></li>
			                    		</ul>
			                    	</td>
			                    	<td class="td_last pL10"><print:textarea text="${result.docCt }	"/> </td>
		                    	</tr>
		                    
		                    </c:forEach>
		                    		                    			                    			                    	
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
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>
