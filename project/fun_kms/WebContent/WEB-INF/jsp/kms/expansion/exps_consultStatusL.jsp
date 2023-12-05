<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="BusiContact" staticJavascript="false" xhtml="true" cdata="false"/>
</head>
<script type="text/javascript">
function search(pageNo){
	//document.frm.searchRegDtS.value=document.frm.curRegDtS.value;
	//document.frm.searchRegDtE.value=document.frm.curRegDtE.value;
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}
function statusList(statusNo){
	document.frm.status.value=statusNo;
	document.frm.submit();
}
//상담관리 상세화면 이동
function view(no) {
	document.frm.consult_no.value = no;	
	document.frm.action = "${rootPath}/cooperation/selectConsultManage.do";
	document.frm.submit();
}
function excelDown() {
	document.excelFrm.submit();
}
//열람
function viewState(consultNo) {
	var popup = window.open("/cooperation/selectConsultRecieveList.do?consult_no=" + consultNo,"_POP_STATE_","width=360px,height=415px,scrollbars=yes");
	popup.focus();
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
							<li class="navi">홈 > 업무공유 > 상담관리</li>
						</ul>
					</div>
				<!-- S: section -->
				<div class="section01">
					<!-- 상단 검색창 시작 -->
			   		<form name="frm" method="POST" action="${rootPath}/cooperation/consultStatusList.do" onsubmit="search(1); return false;">
			   		<input type="hidden" name="curRegDtS" id="searchRegDtS" />
			   		<input type="hidden" name="curRegDtE" id="searchRegDtE" />
			   		<input type="hidden" name="status" id="status" value="${searchVO.status }" />
			   		<input type="hidden" name="pageIndex" value="1"/>
			   		<input type="hidden" name="consult_no" />
			   		<input type="hidden" name="excel" value="N" />
					<fieldset>
					<legend>상단 검색</legend>
	                    <div class="scheduleDate mB20">
	                		<ul>
	                		<li class="li_left">
	                			기간
	                			<span class="option_txt"><input type="text" name="searchRegDtS" value="<c:choose><c:when test="${searchVO.searchRegDtS==null }">${curRegDtS}</c:when><c:otherwise>${searchVO.searchRegDtS} </c:otherwise></c:choose>" class="calGen" maxlength="8" style="width:55px;"/></span>~
	                			<span class="option_txt"><input type="text" name="searchRegDtE" value="<c:choose><c:when test="${searchVO.searchRegDtE==null }">${curRegDtE}</c:when><c:otherwise>${searchVO.searchRegDtE} </c:otherwise></c:choose>" class="calGen" maxlength="8" style="width:55px;"/></span>
	                		</li>
	                		<li class="li_right">
								<input type="image" src="/images/btn/btn_search02.gif" alt="검색" onclick="search(1); return false;"/>
	                		</li>
	                		</ul>
						</div>
	                </fieldset>
			   		</form>
	            	<!--// 상단 검색창 끝 -->
	            	<div class="consult_left ptl10">
	            		<span class="fwb">접수 현황</span>
	            		<ul class="pl40 lh24">
	            			<li>일반상담 : <a href="javascript:statusList('1');"><span>${typCnt1 }</span>건</a></li>
	            			<li>영업문의 : <a href="javascript:statusList('2');"><span>${serviceTyp1+serviceTyp2+serviceTyp3+serviceTyp4+serviceTyp5+serviceTyp6 }</span>건</a>
								<ul class="pl20">
									<li> - 멀티뷰 : <a href="javascript:statusList('6');"><span>${serviceTyp1 }</span>건</a></li>
									<li> - 메가미트 : <a href="javascript:statusList('7');"><span>${serviceTyp2 }</span>건</a></li>
									<li> - 스쿨넷 : <a href="javascript:statusList('8');"><span>${serviceTyp3 }</span>건</a></li>
									<li> - KT사내 :<a href="javascript:statusList('9');"><span>${serviceTyp4 }</span>건</a></li>
									<li> - 메신저 : <a href="javascript:statusList('10');"><span>${serviceTyp5 }</span>건</a></li>
									<li> - 코덱 : <a href="javascript:statusList('11');"><span>${serviceTyp6 }</span>건</a></li>
									<li> - 쏘몬 : <a href="javascript:statusList('61');"><span>${serviceTyp7 }</span>건 (총 합계 제외)</a></li>
								</ul>	            			
	            			</li>
	            			<!--상담분류 항목 추가시 여기도 수정-->
	            			<li>화상상담 : <a href="javascript:statusList('4');"><span>${typCnt4 }</span>건</a></li>
	            			<li>장애처리 : <a href="javascript:statusList('3');"><span>${typCnt3 }</span>건</a></li>
	            				<ul class="pl20">
									<li> - 삼성화재 : <a href="javascript:statusList('31');"><span>${cuNmCntSamsung }</span>건</a></li>
								</ul>
<!--	            			<li>유저수변경 : <a href="javascript:statusList('60');"><span>${typCnt6 }</span>건(총 합계 제외)</a></li>-->
	            			<li>기타 : <a href="javascript:statusList('5');"><span>${typCnt5 }</span>건</a></li>	            			
	            			<li>총 합계 : <a href="javascript:statusList('12');"><span>
	            			${typCnt1+ serviceTyp1+serviceTyp2+serviceTyp3+serviceTyp4+serviceTyp5+serviceTyp6 + typCnt3+typCnt4+typCnt5}</span>건</a></li>							
	            		</ul>
	            	</div>
	            	<div class="consult_right ptl10 mB20">
	            		<span class="fwb mT10">처리 현황</span>
	            		<ul class="pl40 lh24">
	            			<li>검색 기간 이전 미종료 건수 : <a href="javascript:statusList('13');"><span>${stateCnt }</span>건</a>
	            				<ul class="pl20">
	            					<li> - 기간 이전 지라 미종료 : <a href="javascript:statusList('14');"><span>${stateJiraCnt }</span>건</a></li>
	            				</ul>
	            			</li>
	            			<li>총 접수 건수 : <a href="javascript:statusList('12');">
	            			<!--상담분류 항목 추가시 여기도 수정-->
	            			<span>${typCnt1+serviceTyp1+serviceTyp2+serviceTyp3+serviceTyp4+serviceTyp5+serviceTyp6 +typCnt3+typCnt4+typCnt5+typCnt6}</span>건</a>	            			
								<ul class="pl20">
									<li> - 종료 :  <a href="javascript:statusList('15');"><span>${stateCnt2 }</span>건</a></li>
									<li> - 미 종료 건수 :  <a href="javascript:statusList('16');"><span>${stateCnt3 }</span>건</a></li>
									<li> - 처리 중 :  <a href="javascript:statusList('17');"><span>${stateCnt4 }</span>건 (미 종료 건수에 포함)</a></li>
									<li> - 처리 완료 : <a href="javascript:statusList('18');"><span>${stateCnt5 }</span>건(미 종료 건수에 포함)</a></li>
								</ul>	            			
	            			</li>
	            			<li>지라 등록 건수 : <a href="javascript:statusList('19');"><span>${jiraCnt }</span>건</a>
								<ul class="pl20">
									<li> - 처리 완료 건수 : <a href="javascript:statusList('20');"><span>${jiraCnt2 }</span>건(완료+종료)</a></li>
									<li> - 미 종료 건수 : <a href="javascript:statusList('21');"><span>${jiraCnt3 }</span>건(종료 외)</a></li>
									<li> - 총 미종료 지라 건수: <a href="javascript:statusList('22');"><span>${jiraCnt4 }</span>건(검색기간 외 포함)</a></li>
								</ul>	            			
	            			</li>
	            			<li>내부이슈 건수 : <a href="javascript:statusList('23');"><span>${issueCnt }</span>건</a>
								<ul class="pl20">
									<li> - 종료 건수 : <a href="javascript:statusList('24');"><span>${issueCnt2 }</span>건</a></li>
									<li> - 미 종료 건수 : <a href="javascript:statusList('25');"><span>${issueCnt3 }</span>건</a></li>
								</ul>	            			
	            			</li>
	            		</ul>
	            	</div>
	           		<ul style="clear:both">
						<li class="th_stitle04 mB10"> ${searchTitle }
						</li>
					</ul>
           		 	<!-- 게시판 시작  -->
					<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." border="0">
	                   <colgroup>
							<col width="30px" />
							<col width="60px" />
							<col width="60px" />
							<col width="30px" />
							<col width="px" />
							<col class="col80" />
							<col class="col50" />
							<col class="col50" />
							<col class="col50" />
							<col class="col40" />
							<col class="col40" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">상담번호</th>
							<th scope="col">구분</th>
							<th scope="col">분류</th>
							<th scope="col">지라</th>
							<th scope="col">문의내용</th>
							<th scope="col">고객사</th>
							<th scope="col">상담원</th>
							<th scope="col">담당자</th>
							<th scope="col">접수<br/>일시</th>
							<th scope="col">처리<br/>상태</th>							
							<th scope="col">열람</th>
							</tr>
						</thead> 
	                    <tbody>
	                    <c:set var="listSize" value="${fn:length(requestScope.resultList)}"/>
							<c:choose>
							<c:when test="${requestScope.resultList != null and listSize != 0}">
	                   		<c:forEach items="${resultList}" var="result" varStatus="c">
	                   		<tr>
		                    	<td class="txt_center">
		                    		<!-- <c:out value="${(paginationInfo.totalRecordCount) - ((searchVO.pageIndex-1) * searchVO.recordCountPerPage + c.count) + 1}"/>  -->
		                    		${result.no}
		                    	</td>
		                    	<td class="txt_center">
		                    		<c:forEach items="${typeList}" var="type" varStatus="c">
										<c:if test="${result.typ == type.code}">${type.codeNm}</c:if>							      								      				
						      		</c:forEach>
								</td>
		                    	<td class="txt_center">
		                    		<c:forEach items="${conList}" var="type" varStatus="c">
										<c:if test="${result.serviceTyp == type.code}">${type.codeNm}</c:if>							      								      				
						      		</c:forEach>
		                    	</td>
		                    	<td class="txt_center">${result.jiraYn}</td>
		                    	<td class="pL5">
<!--		                    		<a href="javascript:view('${result.consultNo}');">-->
		                    		<a href="${rootPath}/cooperation/selectConsultManage.do?consult_no=${result.consultNo}">
	                    				<c:if test="${fn:length(result.qCn) > 40}">
               								${fn:substring(result.qCn, 0, 40)}...
               							</c:if>
               							<c:if test="${fn:length(result.qCn) <= 40}">
               								${result.qCn}
               							</c:if>
		                    			<c:if test="${result.commentCnt > 0}">[${result.commentCnt}]</c:if>
		                    		</a>
		                    	</td>
								<td class="pL5">
									<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">${result.custNm}</div>
								</td>
		                    	<td class="txt_center">${result.userNm}</td>
		                    	<td class="txt_center">
									<div style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap;">
									${fn:substring(result.charged, 0, fn:length(result.charged) - 1)}</div>
								</td>
		                    	<td class="txt_center"><print:date date="${result.regDt}" printType="S"/></td>
		                    	<td class="txt_center">
		                    		<c:forEach items="${stateList}" var="type" varStatus="c">
										<c:if test="${result.state == type.code}">${type.codeNm}</c:if>							      								      				
						      		</c:forEach>
		                    	</td>
		                    	<td class="txt_center"><a href="javascript:viewState('${result.consultNo}')">${result.readStat}</a></td>
	                    	</tr>
	                    	</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="11" class="txt_center">해당 리스트가 없습니다.</td>
							</tr>
						</c:otherwise>
						</c:choose>	
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					<form name="excelFrm" method="POST" action="${rootPath}/cooperation/consultStatusList.do" onsubmit="search(1); return false;">
					<input type="hidden" name="curRegDtS" value="${excelSearchVO.curRegDtS }" />
			   		<input type="hidden" name="curRegDtE" value="${excelSearchVO.curRegDtE }" />
			   		<input type="hidden" name="status" value="${excelSearchVO.status }" />
			   		<input type="hidden" name="pageIndex" value="1"/>
			   		<input type="hidden" name="consultNo" />
			   		<input type="hidden" name="excel" value="Y" />
           			<input type="hidden" name="searchRegDtS" value="<c:choose><c:when test="${excelSearchVO.searchRegDtS==null }">${curRegDtS}</c:when><c:otherwise>${excelSearchVO.searchRegDtS} </c:otherwise></c:choose>" />
           			<input type="hidden" name="searchRegDtE" value="<c:choose><c:when test="${excelSearchVO.searchRegDtE==null }">${curRegDtE}</c:when><c:otherwise>${excelSearchVO.searchRegDtE} </c:otherwise></c:choose>" />
					</form>
					<!-- 버튼 시작 -->
	                <div class="btn_area02">
	                	<a href="javascript:excelDown();"><img src="${imagePath}/btn/btn_excelSave.gif"/></a>
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
