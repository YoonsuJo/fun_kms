<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovIdDplctCnfirm.jsp
  * @Description : 아이디중복확인
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.03    조재영          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.23
  *  @version 1.0
  *  @see
  *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ID중복확인</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base target="_self" />
<link rel="stylesheet" href="/css/egovframework/cmm/uss/umt/com.css" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
function fnCheckId(){
	if(fnCheckNotKorean(document.checkForm.checkId.value)){
		document.checkForm.submit();
    }else{
    	alert("한글은 사용할 수 없습니다.");
        return;
    }
}
function fnReturnId(){
	var retVal="";
    if (document.checkForm.usedCnt.value == 0){
	    retVal = document.checkForm.resultId.value;
	    window.returnValue = retVal; 
        window.close();
    }else if (document.checkForm.usedCnt.value == 1){
        alert("이미사용중인 아이디입니다.");
        return;
    }else{
    	alert("먼저 중복확인을 실행하십시오");
        return;
    }
}
function fnClose(){
    var retVal="";
    window.returnValue = retVal; 
    window.close();
}
function fnCheckNotKorean(koreanStr){                  
    for(var i=0;i<koreanStr.length;i++){
        var koreanChar = koreanStr.charCodeAt(i);
        if( !( 0xAC00 <= koreanChar && koreanChar <= 0xD7A3 ) && !( 0x3131 <= koreanChar && koreanChar <= 0x318E ) ) { 
        }else{
            //hangul finding....
            return false;
        }
    }
    return true;
}
-->
</script>
</head>
<body>
    <form name="checkForm" action ="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do'/>">

    <table border="0" cellspacing="0" cellpadding="0" width="300">
        <tr><td height="20" colspan="2"></td></tr>
        <tr>
            <td colspan="2" ><img src="/images/egovframework/cmm/uss/umt/icon/tit_icon.gif" width="16" height="16" hspace="3" align="absmiddle">
            &nbsp;아이디 중복확인</td>
        </tr>
        <tr><td height="20" colspan="2"></td></tr>
        <tr>     
            <td>사용할아이디&nbsp;&nbsp;</td>
            <td>
                <input type="hidden" name="resultId" value="<c:out value="${checkId}"/>" />
	            <input type="hidden" name="usedCnt" value="<c:out value="${usedCnt}"/>" />
	            <input type="text" name="checkId" value="<c:out value="${checkId}"/>" maxlength="20" tabindex="1" />
	        </td>
	    </tr>
	    <tr><td height="10" colspan="2"></td></tr>
	    <tr>     
            <td colspan="2">결과&nbsp;&nbsp;:&nbsp;
                <c:choose>
                <c:when test="${usedCnt eq -1}">
                    &nbsp; 중복확인을 실행하십시오
                </c:when>
                <c:when test="${usedCnt eq 0}">
                    ${checkId} 는 사용가능한 아이디입니다.
                </c:when>
                <c:otherwise>
                    ${checkId} 는 사용할수 없는 아이디입니다.
                </c:otherwise>
                </c:choose>
            </td>
        </tr>
	    <tr><td height="15" colspan="2"></td></tr>
    </table>
    <table border="0" cellspacing="0" cellpadding="0" >
            <tr align="right"> 
                <!-- 중복조회 -->
                <td align="right"><img src="/images/egovframework/cmm/uss/umt/button/bu2_left.gif" width="8" height="20"></td>
                <td onclick="javascript:fnCheckId();" background="/images/egovframework/cmm/uss/umt/button/bu2_bg.gif" class="text_left" nowrap>
                <a href="#"><spring:message code="button.inquire" /></a></td>
                <td align="left"><img src="/images/egovframework/cmm/uss/umt/button/bu2_right.gif" width="8" height="20"></td>
                <td>&nbsp;</td>
                <!-- 사용 -->
                <td align="right"><img src="/images/egovframework/cmm/uss/umt/button/bu2_left.gif" width="8" height="20"></td>
                <td onclick="javascript:fnReturnId();" background="/images/egovframework/cmm/uss/umt/button/bu2_bg.gif" class="text_left" nowrap>
                <a href="#"><spring:message code="button.use" /></a></td>
                <td align="left"><img src="/images/egovframework/cmm/uss/umt/button/bu2_right.gif" width="8" height="20"></td>
                <td>&nbsp;</td>
                <!-- 닫기 -->
                <td align="right"><img src="/images/egovframework/cmm/uss/umt/button/bu2_left.gif" width="8" height="20"></td>
                <td onclick="javascript:fnClose();" background="/images/egovframework/cmm/uss/umt/button/bu2_bg.gif" class="text_left" nowrap>
                <a href="#"><spring:message code="button.close" /></a></td>
                <td align="left"><img src="/images/egovframework/cmm/uss/umt/button/bu2_right.gif" width="8" height="20"></td>
                <td></td>
            </tr>
        </table>

    </form>
    
</body>
</html>