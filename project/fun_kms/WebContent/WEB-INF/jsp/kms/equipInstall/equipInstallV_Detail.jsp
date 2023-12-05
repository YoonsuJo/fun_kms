<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallVD.do');
	$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallVD.do?installNo=${eiVO.installNo}');
	document.frm.pageIndex.value = pageNo;
	document.frm.submit();
}

$(function(){
	$('#btn_close').click(function(){
		self.close();
	});
});
function lfn_showContent(historyNo){
	$('#subject').text($('#subject_'+historyNo).val());
	$('#content').html($('#content_'+historyNo).html());
	$('#chgId').html($('#chgId_'+historyNo).html());
	$('#chgDate').text($('#chgDate_'+historyNo).val());
	$('#prjNm').html($('#prjNm_'+historyNo).html());
	$('#solutionNm').text($('#solutionNm_'+historyNo).val());
	$('#customer').text($('#customer_'+historyNo).val());
}
function lfn_popPrj(prjCode){
	var popup = window.open("${rootPath}/cooperation/selectProjectV.do?prjId="+prjCode, "_PRJ_VIEW_","width="+screen.width+"px,height="+screen.height+"px,scrollbars=yes");
	popup.focus();
}
</script>
</head>

<body>
<div id="pop_regist02" style="width:560px; height:720px;">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">설치요청 변경내역</li>
		</ul>
 	</div>
 	<div class="pop_con08" style="width:530px; height:655px;">
 		
       	<p class="th_stitle">변경내역	</p>
		<div class="boardView">
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
            <caption>솔루션 장비 납품 설치요청 등록</caption>
            
            <colgroup>
	            <col class="col70" />
	            <col width="px" />
	            <col class="col80" />
	            <col class="col110" />
	            <col class="col90" />
	            <col class="col80"/>
            </colgroup>
                    
            <thead>
            	<tr>
                	<th class="write_info">제목</th>
                 	<th class="write_info2" colspan="5">${eiVO2.subject}</th>
                </tr>
                <!-- 
                <tr>
             		<th class="write_info">상태</th>
             		<th class="write_info2">
		             	<c:choose>
						<c:when test="${eiVO2.delYn == 'N'}">
			              	<c:if test="${eiVO2.gubunCd == '0'}"><span class="txtB_red">요청</span></c:if>
	                    	<c:if test="${eiVO2.gubunCd == '1'}"><span class="txtB_yellow">접수</span></c:if>
	                    	<c:if test="${eiVO2.gubunCd == '2'}"><span class="txtB_green">처리</span></c:if>
	                    	<c:if test="${eiVO2.gubunCd == '3'}"><span class="txtB_blue">완료</span></c:if>
	                    	<c:if test="${eiVO2.gubunCd == '4'}"><span class="txtB_orange">재요청</span></c:if>
		              	</c:when>
		              	<c:otherwise>
		              		<span class="txtB_grey">삭제</span>
		              	</c:otherwise>
		              	</c:choose>
             		</th>
             		<th class="write_info">최초 요청자</th>
	             	<th class="write_info2">${eiVO2.userId}</th>
	             	<th class="write_info">최초 요청일시</th>
	             	<th class="write_info2">${fn:substring(fn:replace(eiVO2.instDate, '-', '.'), 0, 16)}</th>
                </tr>
                 -->
                <tr>
	             	<th class="write_info">등록자</th>
	             	<th class="write_info2" id="chgId"><span class="cursorPointer" onclick="openUsrLayer('${eiVO2.userNo}',this);">${eiVO2.userId}</span></th>
	             	<th class="write_info">등록일시</th>
	             	<th class="write_info2" id="chgDate"
	             		<c:if test="${empty eiVO2.completeDate}">colspan="3"</c:if>>
	             		${fn:substring(fn:replace(eiVO2.instDate, '-', '.'), 0, 16)}
	             	</th>
	             	<c:if test="${!empty eiVO2.completeDate}">
	             	<th class="write_info">완료(예정)일</th>
	             	<th class="write_info2">
	             		${fn:substring(eiVO2.completeDate, '0', '4')}.${fn:substring(eiVO2.completeDate, '4', '6')}.${fn:substring(eiVO2.completeDate, '6', '8')}
	             	</th>
	             	</c:if>
                </tr>
                <tr>
	             	<th class="write_info">프로젝트</th>
	             	<th class="write_info2" colspan="5" id="prjNm">
	             		<a href="#" onclick="lfn_popPrj('${eiVO2.projectCode}')">
							[${eiVO2.prjId}] ${eiVO2.prjNm}
						</a>
				</th>
                </tr>
                <tr>
                	<th class="write_info">납품솔루션</th>
	             	<th class="write_info2" colspan="5" id="solutionNm">${eiVO2.solutionNm}</th>
                </tr>
                <tr>
                	<th class="write_info">고객사</th>
	             	<th class="write_info2" colspan="5" id="customer">${eiVO2.customer}</th>
                </tr>
                <tr>
	             	<th class="write_info">요청 내용</th>
	             	<th class="write_info2" colspan="5" id="content">
	             		${eiVO2.content}
	             	</th>
	            </tr>
            </thead>
            <tfoot>
				<tr>
					<td class="write_info">첨부파일</td>
					<td class="write_info2" colspan="5">
						<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${eiVO2.atchFileId}" />
						</c:import>
					</td>
				</tr>
			</tfoot>
            <tbody>
            </tbody>
            </table>
<!--           	<br><br><br>-->
			<br/>
           	
           	<div class="pop_board mB20">
 			<p class="th_stitle">변동내역</p>
           	<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
			<caption>수정 내역</caption>
			<colgroup>
				<col class="col40"/>
				<col width="px"/>
				<col class="col80"/>
				<col class="col130" />
			</colgroup>
			<thead>
				<tr>
				<th scope="col">번호</th>
				<th scope="col">제목</th>
				<th scope="col">수정자</th>
				<th scope="col">수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				<c:when test="${!empty historyList}">
					<c:forEach items="${historyList}" var="element" varStatus="index">
						<tr>
<!--							<td class="txt_center">${index.count}</td>-->
							<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((eiVO.pageIndex-1) * eiVO.recordCountPerPage + index.count) + 1}"/></td>
							<td class="txt_center">
								<a href="#" onclick="lfn_showContent('${element.historyNo}');">${element.subject}</a></td>
							<td class="txt_center"><span class="cursorPointer" onclick="openUsrLayer('${element.chgNo}',this);">${element.chgId}</span></td>
							<td class="txt_center">
								${fn:substring(fn:replace(element.chgDate, '-', '.'), 0, 16)}
								<input type="hidden" id="subject_${element.historyNo}" value="${element.subject}"/>
								<input type="hidden" id="solutionNm_${element.historyNo}" value="${element.solutionNm}"/>
								<input type="hidden" id="customer_${element.historyNo}" value="${element.customer}"/>
								<c:if test="${!empty element.chgDate}">
								<input type="hidden" id="chgDate_${element.historyNo}" value="${fn:substring(fn:replace(element.chgDate, '-', '.'), 0, 16)}"/>
								</c:if>
								<c:if test="${empty element.chgDate}">
								<input type="hidden" id="chgDate_${element.historyNo}"/>
								</c:if>
								<div id="prjNm_${element.historyNo}" style="display:none"/>
									<a href="#" onclick="lfn_popPrj('${element.projectCode}')">
										[${element.prjId}] ${element.prjNm}
									</a>
								</div>
								<div id="chgId_${element.historyNo}" style="display:none"/><span class="cursorPointer" onclick="openUsrLayer('${element.chgNo}',this);">${element.chgId}</span></div>
								<div id="content_${element.historyNo}" style="display:none">${element.content}</div>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td class="txt_center" colspan="3">
							변동내역이 없습니다.
						</td>
					</tr>
				</c:otherwise>
				</c:choose>
			</tbody>
			</table>
			</div>
			
			<!-- 페이징 시작 -->
			<div class="paginate">
               	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
			</div>
			<!-- 페이징 끝 -->
			
			<form id="frm" name="frm" method="post">		
			<input type="hidden" name="pageIndex" value="${eiVO.pageIndex}"/>				
			</form>
			
		</div>
	</div>
	<!-- E: section -->
	<div class="pop_btn_area04">
		<img src="${imagePath}/btn/btn_close.gif" id="btn_close" class="cursorPointer"/>
	</div>
</div>
		
</body>
</html>