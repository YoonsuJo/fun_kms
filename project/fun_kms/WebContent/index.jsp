<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%
 /**
  * @Class Name : EgovLoginUsr.jsp
  * @Description : Login 인증 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.03    박지욱          최초 생성
  *
  *  @author 공통서비스 개발팀 박지욱
  *  @since 2009.03.03
  *  @version 1.0
  *  @see
  *  
  *  Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/egovframework/cmm/uat/uia/com.css" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/common.css" />
<title>MOPAS 로그인</title>
<script>

function checkLogin(userSe) {
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.rdoSlctUsr[0].checked = true;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "GNR";
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = true;
        document.loginForm.rdoSlctUsr[2].checked = false;
        document.loginForm.userSe.value = "ENT";    
    // 업무사용자    
    } else if (userSe == "USR") {
        document.loginForm.rdoSlctUsr[0].checked = false;
        document.loginForm.rdoSlctUsr[1].checked = false;
        document.loginForm.rdoSlctUsr[2].checked = true;
        document.loginForm.userSe.value = "USR";
    }
}

function actionLogin() {

 	var userSe = document.loginForm.userSe.value;
	
    if (document.loginForm.userId.value =="") {
        alert("아이디를 입력하세요");
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
    } else {


    	//location.href = "${rootPath}/actionLogin.do?userId="+ id + "&password=" + pass;

    	
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/actionLogin.do'/>";
    // 관리자
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/actionLogin.do'/>";    
    }    	
    	

        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}

function actionCrtfctLogin() {
    document.defaultForm.action="<c:url value='/uat/uia/actionCrtfctLogin.action'/>";
    document.defaultForm.submit();
}

function goFindId() {
    document.defaultForm.action="<c:url value='/uat/uia/egovIdPasswordSearch.do'/>";
    document.defaultForm.submit();
}

function goRegiUsr() {
    var userSe = document.loginForm.userSe.value;
    // 일반회원
    if (userSe == "GNR") {
        document.loginForm.action="<c:url value='/uss/umt/cmm/EgovStplatCnfirmMber.do'/>";
        document.loginForm.submit();
    // 기업회원
    } else if (userSe == "ENT") {
        document.loginForm.action="<c:url value='/uss/umt/cmm/EgovStplatCnfirmEntrprs.do'/>";
        document.loginForm.submit();
    // 업무사용자    
    } else if (userSe == "USR") {
        alert("업무사용자는 별도의 회원가입이 필요하지 않습니다.");
    }
}

function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.userId.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.userId.value = getCookie("saveid")) != "");
}

function fnInit() {
    var message = document.loginForm.message.value;
    if (message != "") {
        alert(message);
    }
    
    getid(document.loginForm);
    // 포커스
    //document.loginForm.rdoSlctUsr.focus();
}

//임시 로그인 소스

function login() {

 	var no =document.loginForm.loginsel.selectedIndex;
	switch(no){
	case 0:
		document.loginForm.userId.value ="";
	    document.loginForm.password.value ="";
		break;	
	case 1:
		document.loginForm.userId.value ="adolys";
	    document.loginForm.password.value ="aa";
		break;
	case 2:
		document.loginForm.userId.value ="blindblue";
	    document.loginForm.password.value ="bb";
		break;
	case 3:
		document.loginForm.userId.value ="aa";
	    document.loginForm.password.value ="a";
		break;
	case 4:
		document.loginForm.userId.value ="bb";
	    document.loginForm.password.value ="b";
		break;		
	}

}

</script>
</head>
<body >
<!-- 
    <div id="gnb">
    <div id="top_logo"><img src="/images/egovframework/main_top.gif" alt="egovframe" /></div>
    </div>-->

<table width="700" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center">
        <c:import url="/uss/ion/lsi/getLoginScrinImageResult.do" charEncoding="utf-8">
            <c:param name="atchFileId" value="${loginScrinImage.imageFile}" />
        </c:import> 
    </td>
  </tr>  
</table>

  <table width="700" >
    <tr>
      <td width="350" height="250">
          <!--일반로그인 테이블 시작-->
          <form name="loginForm" action ="<c:url value='/uat/uia/actionLogin.do'/>" method="post">
			<div style="visibility:hidden;display:none;">
			<input name="iptSubmit1" type="submit" value="전송" title="전송">
			</div>                  
            <input type="hidden" name="message" value="${message}">
            <table width="303" border="0" cellspacing="8" cellpadding="0">
              <tr>
                <td width="303" height="210" valign="top" style="background:url(/images/egovframework/cmm/uat/uia/login_bg03.jpg) no-repeat;">
                    <table width="303" border="0" align="center" cellpadding="0" cellspacing="0">
                      <tr>
                        <td height="70">&nbsp;</td>
                      </tr>
                      <tr>
                        <td>
                            <table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px; background-repeat:no-repeat;">                    
                              <tr>
                                <td width="30"></td>
                                <td  nowrap><input name="rdoSlctUsr" type=radio value=radio checked onClick="checkLogin('GNR');" style="border:0;background:#ffffff;" tabindex="1">일반</td>
                                <td  nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="checkLogin('ENT');" style="border:0;background:#ffffff;" tabindex="2">관리자</td>
								<td  nowrap><input name="rdoSlctUsr" type=radio value=radio unchecked onClick="checkLogin('USR');" style="border:0;background:#ffffff;" tabindex="2">업무</td>                                
                              </tr>
                              <tr>
                                <td height="1">&nbsp;</td>
                              </tr>
                            </table>
                            <table border="0" cellpadding="0" cellspacing="0" style="width:250px;margin-left:20px;">
                              <tr>
                                <td>
                                    <table width="250" border="0" cellpadding="0" cellspacing="0">
                                      <tr>
                                        <td class="required_text" nowrap><label for="id">아이디&nbsp;&nbsp;</td>
                                        <td><input type="text" name="userId" id="id" style="height: 16px; width: 85px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px; ime-mode: disabled;" tabindex="4" maxlength="10"/></label></td>
                                        <td/>
                                      </tr>
                                      <tr>
                                        <td class="required_text" nowrap>><label for="password">비밀번호&nbsp;&nbsp;</td>
                                        <td><input type="password" name="password" id="password" style="height: 16px; width: 85px; border: 1px solid #CCCCCC; margin: 0px; padding: 0px; ime-mode: disabled;" maxlength="12" tabindex="5" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }"/></label></td>
                                        <td class="title"><label for="checkId"><input type="checkbox" name="checkId" class="check2" onClick="javascript:saveid(document.loginForm);" id="checkId" tabindex="6"/>ID저장</label></td>
                                      </tr>
                                    </table>
                                </td>
                              </tr>
                              <tr>
                                <td height="25">&nbsp;</td>
                              </tr>
                              <tr>
                                <td>
                                    <table border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_left.gif" width="8" height="20" alt="login"></td>
                                        <td background="/images/egovframework/cmm/uat/uia/bu2_bg.gif" class="text_left" nowrap><center><a href="#LINK" onClick="actionLogin()">로그인</a></center></td>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_right.gif" width="8" height="20" alt="login"></td>
                                        <td>&nbsp;</td>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_left.gif" width="8" height="20" alt="member_join"></td>
                                        <td background="/images/egovframework/cmm/uat/uia/bu2_bg.gif" class="text_left" nowrap><center><a href="#LINK" onClick="goRegiUsr();">회원가입</a></center></td>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_right.gif" width="8" height="20" alt="member_join"></td>
                                        <td>&nbsp;</td>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_left.gif" width="8" height="20" alt="id_search"></td>
                                        <td background="/images/egovframework/cmm/uat/uia/bu2_bg.gif" class="text_left" nowrap><center><a href="#LINK" onClick="goFindId();">아이디/비밀번호찾기</a></center></td>
                                        <td><img src="/images/egovframework/cmm/uat/uia/bu2_right.gif" width="8" height="20" alt="id_search"></td>
                                      </tr>
                                    </table>
                                    <select name="loginsel" onchange="login();">
                                    	<option value="0">--임시로그인--</option>
                                    	<option value="1">adolys</option>
                                    	<option value="2">blindblue</option>
                                    	<option value="3">aa</option>
                                    	<option value="4">bb</option>
                                    </select>
                                </td>
                              </tr>
                            </table>
                        </td>
                      </tr>
                      <tr>
                        <td height="2">&nbsp;</td>
                      </tr>
                    </table>
                </td>
              </tr>
            </table>
            <input name="userSe" type="hidden" value="GNR"/>
            <input name="j_username" type="hidden"/>
        </form>
        <!--일반로그인 테이블 끝-->
      </td>
    </tr>
  </table>
<!-- bottom -->
</body>
</html>


