<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
</head>
<script type="text/javascript">
function toggleInfo(obj){
	if($(obj).hasClass('btn_arrow_down')){
		$(obj).removeClass('btn_arrow_down');
		$(obj).addClass('btn_arrow_up');
		$('.toggleInfo').show();
		$(obj).prev().html('간단히');
	}
	else{
		$(obj).removeClass('btn_arrow_up');
		$(obj).addClass('btn_arrow_down');
		$('.toggleInfo').hide();
		$(obj).prev().html('자세히');
	}
}
</script>
<body>

<div id="wrap">
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
	
					<!-- S: section -->
					<div class="section01">
						<form name="frm" method="POST" >
						<p class="th_stitle">상담관리   <span class="txtB_green2">자세히</span> <img class="btn_arrow_down cursorPointer" onclick="javascript:toggleInfo(this);"/></p>
						
						<!-- 상담관리 게시판 시작  -->
						<div class="boardView">
							
							<input type="hidden" name="no"/>
							<input type="hidden" name="consult_no" value="${result.consult_no}"/>
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>상담관리 상세보기</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                    	<th class="write_info">고객사</th>
			                    	<th class="write_info2" colspan="2">${result.cust_nm}&nbsp;</th>
			                    	<th class="write_info">고객명</th>			                    	
			                    	<th class="write_info2" colspan="2">${result.cust_manager}&nbsp;</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">연락처</th>
			                    	<th class="write_info2" colspan="5">${result.cust_telno}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">상담자</th>
			                    	<th class="write_info2"  colspan="2">${result.user_nm}&nbsp;</th>
			                    	<th class="write_info">상담일시</th>			                    	
			                    	<th class="write_info2" colspan="2">${result.reg_dt}&nbsp;</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">담당자</th>
			                    	<th class="write_info2" colspan="5">
				                    	<c:forEach items="${result.chargedList}" var="char" varStatus="c">
			                    			<c:if test="${c.count != 1}">,</c:if>
			                    			<print:user userNo="${char.userNo}" userNm="${char.userNm}"/>(
			                    				<c:choose>
					                    			<c:when test="${empty char.readtime}"><span class="txt_red">미열람</span></c:when>
				                    				<c:otherwise>${char.readtime } <span class="txt_blue">열람</span></c:otherwise>
			                    				</c:choose>
			                    			)
			                    		</c:forEach>
			                    	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">참조자</th>			                    	
			                    	<th class="write_info2" colspan="5">
			                    		<c:forEach items="${result.addList}" var="add" varStatus="c">
			                    			<c:if test="${c.count != 1}">,</c:if>
			                    			<print:user userNo="${add.userNo}" userNm="${add.userNm}"/>(
			                    				<c:choose>
					                    			<c:when test="${empty add.readtime}"><span class="txt_red">미열람</span></c:when>
				                    				<c:otherwise>${add.readtime } <span class="txt_blue">열람</span></c:otherwise>
			                    				</c:choose>
			                    			)
			                    		</c:forEach>
			                    	</th>		                        
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">구분</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.typ == '1'}">멀티</c:if>
										<c:if test="${result.typ == '2'}">메가</c:if>
										<c:if test="${result.typ == '3'}">스쿨</c:if>
										<c:if test="${result.typ == '4'}">KT</c:if>
										<c:if test="${result.typ == '5'}">메신</c:if>
										<c:if test="${result.typ == '6'}">코덱</c:if>
									</th>
		                        	<th class="write_info">상담분류</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.service_typ == '1'}">일반</c:if>
										<c:if test="${result.service_typ == '2'}">영업</c:if>
										<c:if test="${result.service_typ == '3'}">장애</c:if>
										<c:if test="${result.service_typ == '4'}">기타</c:if>
										<c:if test="${result.service_typ == '5'}">화상</c:if>
		                        	</th>
		                        	<th class="write_info">장애항목</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.error_typ == '1'}">로그인</c:if>
										<c:if test="${result.error_typ == '2'}">비디오</c:if>
										<c:if test="${result.error_typ == '3'}">음성</c:if>
										<c:if test="${result.error_typ == '4'}">전자칠판</c:if>
										<c:if test="${result.error_typ == '5'}">기타</c:if>
		                        	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">처리상태</th>
		                        	<th class="write_info2">${result.state}</th>
		                        	<th class="write_info">처리일시</th>
		                        	<th class="write_info2">${result.complete_date} ${result.complete_tm}</th>
		                        	<th class="write_info">상담만족도</th>
		                        	<th class="write_info2">
		                        		<c:if test="${result.satisfaction == '1'}">만족</c:if>
		                        		<c:if test="${result.satisfaction == '2'}">보통</c:if>
		                        		<c:if test="${result.satisfaction == '3'}">불만족</c:if>
		                        		<c:if test="${result.satisfaction == '4'}">매우만족</c:if>
		                        		<c:if test="${result.satisfaction == '5'}">Black</c:if>
		                        	</th>
		                        </tr>
		                        <tr class="toggleInfo" style="display:none;">
		                        	<th class="write_info">지라등록여부</th>
		                        	<th class="write_info2">
		                        	<a href="javascript:updateJira('${result.consult_no}')">${result.jira_yn}</a> 
		                        	<c:if test="${result.jira_code==null}">
		                        	<a href="javascript:updateJira('${result.consult_no}')">지라코드등록</a>
		                        	</c:if>
		                        	<a href="http://jira.saeha.com/browse/${result.jira_code }" target="_blank">${result.jira_code }</a>
		                        	</th>		                        	
		                        	<th class="write_info">내부이슈</th>
		                        	<th class="write_info2">${result.issue_yn}</th>
		                        	<th class="write_info">문자알림</th>
		                        	<th class="write_info2">${result.sms_yn}</th>
		                        </tr>
		                         <tr class="toggleInfo" style="display:none;">
			                    	<th class="write_info">마감예정</th>
			                    	<th class="write_info2" colspan="5">${result.end_date}</th>
		                        </tr>		                        
		                         <tr>
			                    	<th class="write_info">문의내용</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.q_cn}" /></th>
		                        </tr>
		                         <tr>
			                    	<th class="write_info">답변내용</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.a_cn}" /></th>
		                        </tr>
		                         <tr>
			                    	<th class="write_info">특이사항</th>
			                    	<th class="write_info2" colspan="5"><print:textarea text="${result.s_cn}" /></th>
		                        </tr>		                        
		                         <tr>
			                    	<th class="write_info">첨부파일</th>
			                    	<th class="write_info2" colspan="5">
			                    		<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atch_file_id}" />
										</c:import>
									</th>
		                        </tr>
		                    </thead>                  
							
		                   </table>
		                   
						</div>				
							
						</form>
						<!-- 덧글입력부분 임포트S -->
						  
						<div id="commentArea">
							<c:import url="${rootPath}/cooperation/withoutLogin/selectConsultCommentList.do">							
								<c:param name="type" value="body" />
								<c:param name="commentNo" value="${result.no}" />
							</c:import>
						</div>
				        <!-- 덧글입력부분 임포트E -->
						<!--//상담관리 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:history.back()"><img src="${imagePath}/btn/btn_list.gif"/></a><!--목록보기  -->
		                </div>
		                <!-- 버튼 끝 -->
	
					</div>
					<!-- E: section -->
	
				</div>
				<!-- E: center -->				
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
</div>
</body>
</html>
