<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<% 
 /**
  * @Class Name : EgovTemplateRegist.jsp
  * @Description : 템플릿 속성 등록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.18   이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.18
  *  @version 1.0
  *  @see
  *   
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/cop/bbs/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/egovframework/cop/bbs/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="templateInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
	function fn_egov_regist_tmplatInfo(){
		if (!validateTemplateInf(document.templateInf)){
			return;
		}
		
		if (confirm('<spring:message code="common.regist.msg" />')) {
			document.templateInf.action = "<c:url value='/cop/com/insertTemplateInf.do'/>";
			document.templateInf.submit();
		}
	}
	
	function fn_egov_select_tmplatInfo(){
		document.templateInf.action = "<c:url value='/cop/com/selectTemplateInfs.do'/>";
		document.templateInf.submit();	
	}

	function fn_egov_selectTmplatType(obj){
		if (obj.value == 'TMPT01') {
			document.getElementById('sometext').innerHTML = "게시판 템플릿은 CSS만 가능합니다.";
		} else if (obj.value == '') {
			document.getElementById('sometext').innerHTML = "";
		} else {
			document.getElementById('sometext').innerHTML = "템플릿은 JSP만 가능합니다.";
		}		
	}

	function fn_egov_previewTmplat() {
		var frm = document.templateInf;
		
		var url = frm.tmplatCours.value;

		var target = "";

		if (frm.tmplatSeCode.value == 'TMPT01') {
			target = "/cop/bbs/previewBoardList.do";
			width = "750";
		} else if (frm.tmplatSeCode.value == 'TMPT02') {
			target = "/cop/cmy/previewCmmntyMainPage.do";
			width = "980";
		} else if (frm.tmplatSeCode.value == 'TMPT03') {
			target = "/cop/cus/previewClubMainPage.do";
			width = "980";
		} else {
			alert('<spring:message code="cop.tmplatCours" /> 지정 후 선택해 주세요.');
		}

		if (target != "") {
			window.open(target + "?searchWrd="+url, "preview", "width=" + width + "px, height=500px;");
		}
	}
</script>
<title>템플릿 등록</title>

<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>


</head>
<body>
<form:form commandName="templateInf" name="templateInf" method="post" >
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />

<div id="border" style="width:730px">
	<table width="100%" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left">
	  	<h1>		
	  		<img src="<c:url value='/images/egovframework/cop/com/icon/tit_icon.gif' />" width="16" height="16" hspace="3" align="absmiddle" alt="">&nbsp;템플릿 정보등록
	  	</h1>
	  </td>
	 </tr>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="table-register">
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="tmplatNm">
	    		<spring:message code="cop.tmplatNm" />
	    	</label>	
	    	<img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required">
	    </th>
	    <td width="80%" nowrap>
	      <input name="tmplatNm" type="text" size="60" value="" maxlength="60" style="width:100%" id="tmplatNm"  title="템플릿명">
	      <br/><form:errors path="tmplatNm" /> 
	    </td>
	  </tr>
	  
	  <tr> 
	    <th height="23" class="required_text" >
	    	<label for="tmplatSeCode">	
	    		<spring:message code="cop.tmplatSeCode" />
	    	</label>	
	    	<img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required">
	    </th>
	    <td>
	   	<select name="tmplatSeCode" class="select" onchange="fn_egov_selectTmplatType(this)" id="tmplatSeCode" title="템플릿구분">
			   <option selected value=''>--선택하세요--</option>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
			</c:forEach>	
		   </select>&nbsp;&nbsp;&nbsp;<span id="sometext"></span>
		   <br/><form:errors path="tmplatSeCode" />
	    </td>
	  </tr> 
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="tmplatCours">	
	    		<spring:message code="cop.tmplatCours" />
	    	</label>	
	    	<img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required">
	    </th>
	    <td width="80%" nowrap>
	      <input name="tmplatCours" type="text" size="60" value="" maxlength="60" style="width:100%" id="tmplatCours"  title="템플릿경로">
	      <br/><form:errors path="tmplatCours" /> 
	    </td>
	  </tr>
	  <tr> 
	    <th width="20%" height="23" class="required_text" nowrap >
	    	<label for="useAt">	
	    		<spring:message code="cop.useAt" />
	    	</label>	
	    	<img src="<c:url value='/images/egovframework/cop/com/icon/required.gif' />" width="15" height="15" alt="required">
	    </th>
	    <td width="80%" nowrap>
	     	Y : <input type="radio" name="useAt" class="radio2" value="Y"  checked>&nbsp;
	     	N : <input type="radio" name="useAt" class="radio2" value="N">
	     	<br/><form:errors path="useAt" />
	    </td>
	  </tr>  
	
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td height="10"></td>
	  </tr>
	</table>

	<!--  
	<div align="center">
	  <span class="button"><input type="submit" value="조회" onclick="fn_egov_regist_tmplatInfo(); return false;"></span>	      
      <span class="button"><input type="button" value="목록" onclick="fn_egov_select_tmplatInfo();" alt="목록"></span>	
      <span class="button"><input type="button" value="미리보기" onclick="fn_egov_previewTmplat();" alt="새창"></span>
	</div>
	-->

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
	    <td>
            <div align="right">
              <span class="button"><input type="submit" value="등록" onclick="fn_egov_regist_tmplatInfo(); return false;"></span>
            </div>
        </td>
	    <td>
	    	&nbsp;
		</td>
	    <td width="5%" align="center">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                    <td><img src="<c:out value='/images/egovframework/cmm/sec/ram/btn/bu2_left.gif'/>" alt="버튼이미지" width="8" height="20"></td>
                    <td class="btnBackground" nowrap><a href="<c:url value='/cop/com/selectTemplateInfs.do'/>" alt="목록" >목록</a></td>
                    <td><img src="<c:out value='/images/egovframework/cmm/sec/ram/btn/bu2_right.gif'/>" alt="버튼이미지" width="8" height="20"></td>
                </tr>
            </table>
        </td>
	    <td>
	    	&nbsp;
		</td>
	    <td>
            <div align="left">
              <span class="button"><input type="button" value="미리보기" onclick="fn_egov_previewTmplat();" alt="새창"></span>
            </div>
        </td>
	  </tr>
	</table>

</div>
</form:form>
</body>
</html>