<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
 /**
  * @Class Name : EgovUserSelectUpdt.jsp
  * @Description : 사용자상세조회, 수정 JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
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
<link href="<c:url value='/css/egovframework/cmm/uss/umt/button.css' />" rel="stylesheet"  type="text/css">
<title>User Detail, Update, Delete</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/zip/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
	if(confirm("<spring:message code="common.delete.msg" />")){
	    document.userManageVO.checkedIdForDel.value=checkedIds;
	    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
	    document.userManageVO.submit(); 
	}
}
function fnPasswordMove(){
	document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
        document.userManageVO.submit();
    }
}
function fn_egov_inqire_cert() {
	var url = '/uat/uia/EgovGpkiRegist.do';
	var popupwidth = '500';
	var popupheight = '400';
	var title = '인증서';

	Top = (window.screen.height - popupheight) / 3;
	Left = (window.screen.width - popupwidth) / 2;
	if (Top < 0) Top = 0;
	if (Left < 0) Left = 0;
	Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no,	scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
	PopUpWindow = window.open(url, title, Future)
	PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
	var frm = document.userManageVO;
	
	frm.subDn.value = dn;
}
/*
if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
	alert('메인 화면이 변경되거나 없습니다');
	this.close();
} else {
	opener.fn_egov_dn_info_setting(dn);
	this.close();
}
*/
//-->
</script>
</head>
<body>
        <!-- content start -->
        <form:form commandName="userManageVO" action="/uss/umt/user/EgovUserSelectUpdt.do" name="userManageVO" method="post" >
        
        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
        <input name="checkedIdForDel" type="hidden" />
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
        <!-- 우편번호검색 -->
        <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />
        <!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
        <input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />
        
        <table width="717" cellpadding="8" class="table-search" border="0">
            <tr>
            <td width="100%"class="title_left">
            <img src="/images/egovframework/cmm/uss/umt/icon/tit_icon.gif" width="16" height="16" hspace="3" alt=""/>&nbsp;업무사용자 상세조회(수정)</td>
            </tr>
        </table>
        <table width="717" border="0" cellpadding="0" cellspacing="1" class="table-register">
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                사용자아이디<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="emplyrId"/>
                    <form:input path="emplyrId" id="emplyrId" cssClass="txaIpt" size="20" maxlength="20" readonly="true" />
                    <div><form:errors path="emplyrId" cssClass="error"/></div>
                    <form:hidden path="uniqId" />
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >
                사용자이름<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="emplyrNm"/>
                    <form:input path="emplyrNm" id="emplyrNm" cssClass="txaIpt" size="20"  maxlength="60" />
                    <div><form:errors path="emplyrNm" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                비밀번호힌트<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="passwordHint"/>
                    <form:select path="passwordHint" id="passwordHint">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="passwordHint" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                비밀번호정답<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="passwordCnsr"/>
                    <form:input path="passwordCnsr" id="passwordCnsr" cssClass="txaIpt" size="50" maxlength="100" />
                    <div><form:errors path="passwordCnsr" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >소속기관코드&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="insttCode"/>
                    <form:select path="insttCode" id="insttCode">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${insttCode_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="insttCode" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >조직아이디&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="orgnztId"/>
                    <form:select path="orgnztId" id="orgnztId">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="orgnztId" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >직위명&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="ofcpsNm"/>
                    <form:input path="ofcpsNm" id="ofcpsNm" cssClass="txaIpt" size="20" maxlength="50" />
                    <div><form:errors path="ofcpsNm" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >사번&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="emplNo"/>
                    <form:input path="emplNo" id="emplNo" cssClass="txaIpt" size="20" maxlength="20" />
                    <div><form:errors path="emplNo" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >성별구분코드&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="sexdstnCode"/>
                    <form:select path="sexdstnCode" id="sexdstnCode">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${sexdstnCode_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >생일&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="brth"/>
                    <form:input path="brth" id="brth" cssClass="txaIpt" size="20" maxlength="8" />
                    <div><form:errors path="brth" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                집전화번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="areaNo"/>
                    <form:input path="areaNo" id="areaNo" cssClass="txaIpt" size="5" maxlength="5" />
                    - <label for="homemiddleTelno"/><form:input path="homemiddleTelno" id="homemiddleTelno" cssClass="txaIpt" size="5" maxlength="5" />
                    - <label for="homeendTelno"/><form:input path="homeendTelno" id="homeendTelno" cssClass="txaIpt" size="5" maxlength="5" />
                    <div><form:errors path="areaNo" cssClass="error" /></div>
                    <div><form:errors path="homemiddleTelno" cssClass="error" /></div>
                    <div><form:errors path="homeendTelno" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >사무실전화번호&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="offmTelno"/>
                    <form:input path="offmTelno" id="offmTelno" cssClass="txaIpt" size="20" maxlength="15" />
                    <div><form:errors path="offmTelno" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >팩스번호&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="fxnum"/>
                    <form:input path="fxnum" id="fxnum" cssClass="txaIpt" size="20" maxlength="15" />
                    <div><form:errors path="fxnum" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >핸드폰번호&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="moblphonNo"/>
                    <form:input path="moblphonNo" id="moblphonNo" cssClass="txaIpt" size="20" maxlength="15" />
                    <div><form:errors path="moblphonNo" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                이메일주소<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="emailAdres"/>
                    <form:input path="emailAdres" id="emailAdres" cssClass="txaIpt" size="20" maxlength="50" />
                    <div><form:errors path="emailAdres" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                우편번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="zip_view"/>
                    <input name="zip_view" id="zip_view" type="text" size="20" value="<c:out value='${userManageVO.zip}'/>"  maxlength="8" readonly/>
                    <form:hidden path="zip" />
                        <a href="#LINK" onclick="fn_egov_ZipSearch(document.userManageVO, document.userManageVO.zip, document.userManageVO.zip_view, document.userManageVO.homeadres);">
                            <img src="/images/egovframework/cmm/sym/zip/icon_zip_search.gif" alt=""/>(우편번호 검색)
                        </a>
                    <div><form:errors path="zip" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >
                주소<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="homeadres"/>
                    <form:input path="homeadres" id="homeadres" cssClass="txaIpt" size="40" maxlength="100" readonly="true"/>
                    <div><form:errors path="homeadres" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >상세주소&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="detailAdres"/>
                    <form:input path="detailAdres" id="detailAdres" cssClass="txaIpt" size="40" maxlength="50" />
                    <div><form:errors path="detailAdres" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                그룹아이디<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="groupId"/>
                    <form:select path="groupId" id="groupId">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="groupId" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                사용자상태코드<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt=""/>
                </th>
                <td width="80%" nowrap><label for="emplyrSttusCode"/>
                    <form:select path="emplyrSttusCode" id="emplyrSttusCode">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="emplyrSttusCode" cssClass="error"/></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >사용자DN&nbsp;&nbsp;</th>
                <td width="80%" nowrap><label for="subDn"/>
                    <form:input path="subDn" id="subDn" cssClass="txaIpt" size="40" maxlength="100" />
                    &nbsp;<a href="#LINK" onclick="fn_egov_inqire_cert()" style="selector-dummy: expression(this.hideFocus=false);"><img src="<c:url value='/images/egovframework/cop/bbs/icon/search.gif' />"
	     			width="15" height="15" alt="search"/></a>
                    <div><form:errors path="subDn" cssClass="error" /></div>
                </td>
            </tr>
            <form:hidden path="password" />
        </table>
        <table width="717" border="0" cellspacing="0" cellpadding="0">
            <tr> 
                <td height="10"></td>
            </tr>
            <tr> 
                <td align="center">
                <table border="0" cellspacing="0" cellpadding="0" align="center" >
		            <tr> 
		                <!-- 수정 -->
		                <td><span class="button"><input type="submit" value="<spring:message code="button.update" />" onclick="fnUpdate(); return false;" /></span>&nbsp;</td>
		                <!-- 삭제 -->
		                <td><span class="button"><a href="<c:url value='/uss/umt/user/EgovUserDelete.do'/>" onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>'); return false;"><spring:message code="button.delete" /></a></span>&nbsp;</td>
		                <!-- 목록 -->
		                <td><span class="button"><a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a></span>&nbsp;</td>
                        <!-- 암호변경 -->
		                <td><span class="button"><a href="<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>" onclick="fnPasswordMove(); return false;"><spring:message code="button.passwordUpdate" /></a></span>&nbsp;</td>
                        <!-- 취소 -->
		                <td><span class="button"><a href="#LINK" onclick="javascript:document.userManageVO.reset();"><spring:message code="button.reset" /></a></span></td>
		            </tr>
		        </table>
                </td>
            </tr>
        </table>
        
        </form:form>
        <!-- content end -->
</body>
</html>