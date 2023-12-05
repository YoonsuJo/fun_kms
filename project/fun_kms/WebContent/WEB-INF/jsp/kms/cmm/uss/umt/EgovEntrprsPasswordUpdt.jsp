<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovEntrprsPasswordUpdt.jsp
  * @Description : 기업회원 암호수정 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.04.02    조재영          최초 생성
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.04.02
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/egovframework/cmm/uss/umt/com.css" type="text/css">
<link rel="stylesheet" href="/css/egovframework/cmm/uss/umt/button.css" type="text/css">
<title>EntrprsMber Password Update</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.passwordChgVO.action = "<c:url value='/uss/umt/entrprs/EgovEntrprsMberManage.do'/>";
    document.passwordChgVO.submit();
}
function fnUpdate(){
    if(validatePasswordChgVO(document.passwordChgVO)){
    	if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.passwordChgVO.submit();
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
//-->
</script>
</head>
<body>
        <!-- content start -->
        <form name="passwordChgVO" method="post" 
              action="<c:url value="${'/uss/umt/entrprs/EgovEntrprsPasswordUpdt.do'}"/>" 
              >
              <!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
        <input name="checkedIdForDel" type="hidden" />
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
        <!-- 우편번호검색 -->
        <input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />
        
        <table width="717" cellpadding="8" class="table-search" border="0">
            <tr>
            <td width="100%"class="title_left">
            <img src="/images/egovframework/cmm/uss/umt/icon/tit_icon.gif" width="16" height="16" hspace="3" alt=""/>&nbsp;기업회원 암호변경</td>
            </tr>
        </table>
        <table width="717" border="0" cellpadding="0" cellspacing="1" class="table-register">
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >
                    기업회원아이디<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap>
                    <label for="entrprsmberId" /><input name="entrprsmberId" id="entrprsmberId" type="text" size="20" value="<c:out value='${entrprsManageVO.entrprsmberId}'/>"  maxlength="20" readonly>
                    <input name="uniqId" id="uniqId" type="hidden" size="20" value="<c:out value='${entrprsManageVO.uniqId}'/>">
                    <input name="userTy" id="userTy" type="hidden" size="20" value="<c:out value='${entrprsManageVO.userTy}'/>">
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    기존 비밀번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="oldPassword" /><input name="oldPassword" id="oldPassword" type="password" size="20" value="" maxlength="100" /></td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="newPassword" /><input name="newPassword" id="newPassword" type="password" size="20" value=""  maxlength="100" /></td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호확인<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="newPassword2" /><input name="newPassword2" id="newPassword2" type="password" size="20" value=""  maxlength="100" /></td>
            </tr>
        </table>
        <table width="717" border="0" cellspacing="0" cellpadding="0">
            <tr> 
                <td height="10"></td>
            </tr>
        </table>
        <table width="717" border="0" cellspacing="0" cellpadding="0">
            <tr> 
                <td>
		        <table border="0" cellspacing="0" cellpadding="0" align="center">
		            <tr> 
                        <!-- 수정 --> 
                        <td><span class="button"><input type="submit" value="<spring:message code="button.update" />" onclick="fnUpdate(); return false;" /></span>&nbsp;</td>
                        <!-- 목록 -->
                        <td><span class="button"><a href="<c:url value='/uss/umt/entrprs/EgovEntrprsMberManage.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a></span>&nbsp;</td>
                        <!-- 취소 -->
                        <td><span class="button"><a href="#LINK" onclick="javascript:document.passwordChgVO.reset();"><spring:message code="button.reset" /></a></span></td>
		            </tr>
		        </table>
		        </td>
            </tr>
        </table>
        </form>
        <!-- content end -->
</body>
</html>