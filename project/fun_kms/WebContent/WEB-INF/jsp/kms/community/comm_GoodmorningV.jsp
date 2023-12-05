<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link type="text/css" href="style.css" rel="stylesheet" charset="utf-8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="print" uri="print" %>
<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%>

<link rel="stylesheet" href="${commonPath}/css/goodmorning_style.css" type="text/css" media="all" />

<script>
function modifyArticle() {
	document.frm.action = "<c:url value='${rootPath}/community/forUpdateBoardArticle.do'/>";
	document.frm.submit();		
}
/*
function open(url) {
	opener.location.href = url;
	self.close();
}
*/
function replyNote(receiverNo) {
	window.open("${rootPath}/community/sendNoteView.do?recieverNo="+receiverNo+"&replyType=goodmo", 
			"_receive_note_", "width=510px,height=500px,scrollbars=no,resizable=no");
	
	//window.open("/cop/clb/insertClubUserBySelf.do?clbId="+clbId+"&cmmntyId="+cmmntyId, "userRegist", "width=320px, height=200px;");
}


</script>


</head>
<body>
<form name="frm" method="post" enctype="multipart/form-data" >
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>"/>
<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>"/>
<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>"/>
<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>"/>
<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>"/>
<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>"/>
<input type="hidden" name="exChk" value="<c:out value='${result.exChk}'/>"/>
</form>
<form name="subForm" method="post">
<input type="hidden" name="receiverNo" value="<c:out value='${writerVO.userNo}'/>" />
</form>

						
<div class="morning">
	<div class="top">한마음 아침인사</div>
	<div class="morning_con">
    	<div class="greeting">
        <p class="greeting_tl">${writerVO.userNm} ${writerVO.rankNm} (<c:out value="${writerVO.orgnztNm}"/>) 
        <c:if test="${user.userNo == writerVO.userNo || user.admin}">
        <span class="modify"><a href="javascript:modifyArticle();"><img src="${imagePath}/btn/btn_write01.gif" alt="수정"/></a></span>
        </c:if>
        </p>
        <span class="greeting_date">[${state.state}/${state.gubun}] ${fn:substring(result.frstRegisterPnttm,10,16)} 작성글</span>
            <div class="greeting_ment">
                <!-- 사진들어갈 자리-->
                <span class="people">   
				<c:choose>
					<c:when test="${empty writerVO.picFileId || writerVO.picFileId == ''}">
						<img src="${imagePath}/inc/img_no_photo.gif" alt="소개사진 없음"/>
					</c:when>
					<c:otherwise>
						<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${writerVO.picFileId}" />
						<c:param name="param_width" value="90" />
						<c:param name="param_height" value="120" />
					</c:import>
					</c:otherwise>
				</c:choose>           					             
                </span>	
                <!-- 사진들어갈 자리-->
                <p class="area">
                <!--  ${fn:replace(result.nttSj, cn, br)} -->
                <print:textarea text="${result.nttSj}"/>
                </p>
            </div>
            
        </div>
        <div class="checklist">
        	<div class="checklist_box">
            	<div class="read">
                    <c:choose>
					<c:when test="${checkList.myTaskFive == '0' && checkList.busiCntctFive == '0' && checkList.acceptFive == '0' &&checkList.referenceFive == '0'}">
						 <!-- 미처리업무가 없을 경우-->
	                    <div class="noread">
	                        5일이상 미열람(미처리) 중인 업무가 없습니다. Perfect~~!!<br/>
	                        오늘도 신속한 업무처리 부탁드립니다~~!!
	                    </div>
	                    <!-- 미처리업무가 없을 경우-->
					</c:when>
					<c:otherwise>
					 	<p class="checklist_tl"><span class="delay_date">5일 </span>이상 미열람(미처리) 중인 업무가 있습니다.</p>
						<div class="read_list">
                        <ul>                      
                            <c:if test="${checkList.myTaskFive != '0'}"> 
                            <li>나의업무<span class="fc_redB">[<a href="javascript:open('${rootPath}/cooperation/selectDayReportMyList.do');">${checkList.myTaskFive}</a>]</span></li>
                            </c:if>
                            <c:if test="${checkList.busiCntctFive != '0'}"> 
                            <li>업무연락<span class="fc_redB">[<a href="javascript:open('${rootPath}/cooperation/selectBusinessContactList.do');">${checkList.busiCntctFive}</a>]</span></li>
                            </c:if>
                            <c:if test="${checkList.acceptFive != '0' || checkList.referenceFive != '0'}">
                            <li>전자결재<span class="fc_redB">[<a href="javascript:open('${rootPath}/approval/approvalL.do?mode=2');">${checkList.acceptFive}</a>,<a href="javascript:open('${rootPath}/approval/approvalL.do?mode=12');">${checkList.referenceFive}</a>]</span></li>                         
                        	</c:if>
                        </ul>
                    	</div>
					</c:otherwise>
				</c:choose>           					          
                </div>
            </div>
        </div>
        <div class="btn_area">
        	<a href="javascript:replyNote('${writerVO.userNo}');" class="btn">답장하기</a>
        	<a href="javascript:self.close();" class="btn"><img src="${imagePath}/btn/btn_close.gif" alt="창닫기" /></a>
        </div>
    </div>
</div>					
</body>
</html>
