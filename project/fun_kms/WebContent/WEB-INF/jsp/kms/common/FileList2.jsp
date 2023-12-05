<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
 /**
  * @Class Name : EgovFileList.jsp
  * @Description : 파일 목록화면
  * @Modification Information
  * @
  * @  수정일      수정자            수정내용
  * @ -------        --------    ---------------------------
  * @ 2009.03.26  이삼섭          최초 생성
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.26
  *  @version 1.0 
  *  @see
  *  
  */
%>
<!-- link href="<c:url value='/css/egovframework/cmm/fms/com.css' />" rel="stylesheet" type="text/css"-->
<script type="text/javascript">
	var atchFileId = "${atchFileId}"; 
	var fileSnList= new Array();
	
	
	function fn_egov_deleteFile(elem,fileId, fileSn) {
		alert("FileList2.jsp");
		var forms = document.getElementsByTagName("form");
		var form = null;
		
		for (var i = 0; i < forms.length; i++) {
			if (typeof(forms[i].atchFileId) != "undefined" &&
					typeof(forms[i].fileSn) != "undefined" &&
					typeof(forms[i].fileListCnt) != "undefined") {
				form = forms[i];
			}
		}
		/*해당 파일을 삭제하지 않고, 단순히 span 값만 remove시킴*/
		$(elem).parent().remove();
		fileSnList[fileSn] = null;
		form.reWriteFileInfo.value = "";
		for(var i = 0 ;i <fileSnList.length ; i ++)
		{
			if(fileSnList[i]!=null)
				form.reWriteFileInfo.value +=  fileSnList[i] +",";
		}
	}
	
	function fn_egov_check_file(flag) {
		if (flag=="Y") {
			document.getElementById('file_upload_posbl').style.display = "block";
			document.getElementById('file_upload_imposbl').style.display = "none";			
		} else {
			document.getElementById('file_upload_posbl').style.display = "none";
			document.getElementById('file_upload_imposbl').style.display = "block";
		}
	}

$(document).ready(function(){
	var forms = document.getElementsByTagName("form");
	var form = null;

	for (var i = 0; i < forms.length; i++) {
		if (typeof(forms[i].atchFileId) != "undefined" &&
				typeof(forms[i].fileSn) != "undefined" &&
				typeof(forms[i].fileListCnt) != "undefined") {
			form = forms[i];
		}
	}
	for(var i = 0 ;i <fileSnList.length ; i ++)
	{
		if(fileSnList[i]!=null)
			form.reWriteFileInfo.value +=  fileSnList[i] +",";
	}
});

</script>


      
<!-- <form name="fileForm" action="" method="post" >  -->

<input type="hidden" name="atchFileId" value="${atchFileId}">
<input type="hidden" name="fileSn" >
<input type="hidden" name="fileListCnt" value="${fileListCnt}">
<input type="hidden" name="reWriteFileInfo">
<!-- </form>  -->
<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	<script>
		fileSnList[${fileVO.fileSn}]= ${fileVO.fileSn};
	</script>
	<span>
	<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<fmt:formatNumber value="${fileVO.fileMg/1024}" pattern=".00"/>&nbsp;KB]
	<img src="<c:url value='${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif'/>" 
	width="19" height="18" onClick="fn_egov_deleteFile(this,'${fileVO.atchFileId}','${fileVO.fileSn}');" alt="파일삭제">
	<br/>
		
	</span>
	
</c:forEach>
<script>

</script>
<c:if test="${fn:length(fileList) == 0 && isComment != 'true'}">
	첨부파일이 없습니다.
</c:if>
