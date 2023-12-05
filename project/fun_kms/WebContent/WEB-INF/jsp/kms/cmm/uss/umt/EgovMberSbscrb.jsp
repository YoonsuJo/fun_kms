<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<%
 /**
  * @Class Name : EgovMberSbscrb.jsp
  * @Description : 일반회원가입신청 JSP  
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.22    조재영          최초 생성
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/egovframework/cmm/uss/umt/com.css" type="text/css">
<title>Mber Sbscrb</title>
<script type="text/javascript" src="<c:url value="/sec/rnc/validator.do"/>"></script>
<validator:javascript formName="mberManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/egovframework/cmm/sym/zip/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnIdCheck(){
    var retVal;
    var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.mberManageVO.mberId.value;
    var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.mberManageVO.mberId.value = retVal;
    }
}
function fnSbscrb(){
	if(validateMberManageVO(document.mberManageVO)){
		if(document.mberManageVO.password.value != document.mberManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.mberManageVO.submit();
    }	
}
-->
</script>
</head>
<body>
        <!-- content start -->
        <form:form commandName="mberManageVO" action="/uss/umt/cmm/EgovMberSbscrb.do" name="mberManageVO"  method="post" >
        
        <!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
        <input name="checkedIdForDel" type="hidden" />
        <!-- 검색조건 유지 -->
        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
        <!-- 우편번호검색 -->
        <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />
        
        <table width="717" cellpadding="8" class="table-search" border="0">
            <tr>
            <td width="100%"class="title_left">
            <img src="/images/egovframework/cmm/uss/umt/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle">&nbsp;일반회원 가입신청</td>
            </tr>
        </table>
        <table width="717" border="0" cellpadding="0" cellspacing="1" class="table-register">
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    일반회원아이디<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="mberId" size="20" cssClass="txaIpt" readonly="true" maxlength="20" />
                    <a href="javascript:fnIdCheck();">
                        <img align="absmiddle" src="/images/egovframework/cmm/uss/umt/icon/search.gif">(중복아이디 검색)
                    </a>
                    <div><form:errors path="mberId" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    일반회원이름<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                <input name="mberNm" type="text" size="20" 
                        value=<c:if test="${not empty mberNm}">"<c:out value="${mberNm}"/>" readonly</c:if>
                              <c:if test="${empty mberNm}">""</c:if>
                        maxlength="60" >
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:password path="password" size="20" maxlength="20" />
                    <div><form:errors path="password" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호확인<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <input name="password2" type="password" size="20" maxlength="20" >
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호힌트<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:select path="passwordHint">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                    <div><form:errors path="passwordHint" cssClass="error"/></div>
                    </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    비밀번호정답<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="passwordCnsr" cssClass="txaIpt" size="50" maxlength="100" />
                    <div><form:errors path="passwordCnsr" cssClass="error"/></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >성별구분코드&nbsp;&nbsp;</th>
                <td width="80%" nowrap>
                    <form:select path="sexdstnCode">
                        <form:option value="" label="--선택하세요--"/>
                        <form:options items="${sexdstnCode_result}" itemValue="code" itemLabel="codeNm"/>
                    </form:select>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    전화번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="areaNo" cssClass="txaIpt" size="5" maxlength="5" />
                    - <form:input path="middleTelno" cssClass="txaIpt" size="5" maxlength="5" />
                    - <form:input path="endTelno" cssClass="txaIpt" size="5" maxlength="5" />
                    <div><form:errors path="areaNo" cssClass="error" /></div>
                    <div><form:errors path="middleTelno" cssClass="error" /></div>
                    <div><form:errors path="endTelno" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >팩스번호&nbsp;&nbsp;</th>
                <td width="80%" nowrap>
                    <form:input path="mberFxnum" cssClass="txaIpt" size="20"  maxlength="15" />
                    <div><form:errors path="mberFxnum" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    핸드폰번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="moblphonNo" cssClass="txaIpt" size="20" maxlength="15" />
                    <div><form:errors path="moblphonNo" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    이메일주소<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="mberEmailAdres" cssClass="txaIpt" size="30" maxlength="50" />
                    <div><form:errors path="mberEmailAdres" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >
                    우편번호<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <input name="zip_view" type="text" size="20" value="<c:out value='${mberManageVO.zip}'/>" maxlength="8" readonly>
                    <form:hidden path="zip" />
                        <a href="javascript:fn_egov_ZipSearch(document.mberManageVO, document.mberManageVO.zip, document.mberManageVO.zip_view, document.mberManageVO.adres);">
                            <img src="/images/egovframework/cmm/sym/zip/icon_zip_search.gif">(우편번호 검색)
                        </a>
                    <div><form:errors path="zip" cssClass="error" /></div>
                </td>
            </tr>
            <tr>
                <th width="20%" height="23" class="required_text" nowrap >
                    주소<img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15">
                </th>
                <td width="80%" nowrap>
                    <form:input path="adres" cssClass="txaIpt" size="70" maxlength="100" readonly="true" />
                    <div><form:errors path="adres" cssClass="error" /></div>
                </td>
            </tr>
            <tr> 
                <th width="20%" height="23" class="required_text" nowrap >상세주소&nbsp;&nbsp;</th>
                <td width="80%" nowrap>
                    <form:input path="detailAdres" cssClass="txaIpt" size="70" maxlength="100" />
                    <div><form:errors path="detailAdres" cssClass="error" /></div>
                </td>
            </tr>
            <form:hidden path="groupId" />
            <form:hidden path="mberSttus" />
        </table>
            
        <table width="717">
            <tr> 
                <td colspan="2" height="10"></td>
            </tr>
            <tr> 
                <td colspan="2" align="center">
                <table border="0" cellspacing="0" cellpadding="0" align="center">
		            <tr> 
		                <!-- 가입신청 -->
		                <td><img src="/images/egovframework/cmm/uss/umt/button/bu2_left.gif" width="8" height="20"></td>
		                <td background="/images/egovframework/cmm/uss/umt/button/bu2_bg.gif" class="text_left" nowrap>
		                <a href="javascript:fnSbscrb()"><spring:message code="button.subscribe" /></a></td>
		                <td><img src="/images/egovframework/cmm/uss/umt/button/bu2_right.gif" width="8" height="20"></td>
		                <td>&nbsp;</td>
		                <!-- 취소 -->
		                <td><img src="/images/egovframework/cmm/uss/umt/button/bu2_left.gif" width="8" height="20"></td>
		                <td background="/images/egovframework/cmm/uss/umt/button/bu2_bg.gif" class="text_left" nowrap>
		                <a href="javascript:document.mberManageVO.reset();"><spring:message code="button.reset" /></a></td>
		                <td><img src="/images/egovframework/cmm/uss/umt/button/bu2_right.gif" width="8" height="20"></td>   
		            </tr>
		        </table>
                </td>
            </tr>
        </table>
        
        </form:form>
        <!-- content end -->
</body>
</html>