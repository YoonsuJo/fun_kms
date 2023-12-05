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
	function fn_egov_downFile(atchFileId, fileSn){
		window.open("<c:url value='${rootPath}/FileDown.do?atchFileId=" + atchFileId + "&fileSn=" + fileSn + "'/>");
	}	
	
	function fn_egov_deleteFile(obj, atchFileId, fileSn) {
		//alert("FileList.jsp");
		
		if (!confirm('첨부파일을 삭제하시겠습니까?')) return false;
		
		var forms = document.getElementsByTagName("form");
		var form = null;
		
		for (var i = 0; i < forms.length; i++) {			
			if (typeof(forms[i].atchFileId) != "undefined" &&
					typeof(forms[i].fileSn) != "undefined" &&
					typeof(forms[i].fileListCnt) != "undefined") {
				form = forms[i];				
			}
		}
		
		/*
		//form = document.forms[0];
		form.atchFileId.value = atchFileId;		
		form.fileSn.value = fileSn;
		form.action = "<c:url value='${rootPath}/deleteFileInfs.do'/>";
		//form.action = "<c:url value='/cmm/fms/deleteFileInfs.do'/>";
		form.submit();
		*/
		
		$.ajax({
			url: "/deleteFileInfs.do",
			data: {
				atchFileId: atchFileId,
				fileSn: fileSn
			},
			type: "POST",
			async: false,
			//dataType: "json",
			success: function(data) {
				if (data.indexOf("success") > -1){
					$(obj).parent().remove();
					form.fileListCnt.value = form.fileListCnt.value - 1;
					existFileNum = form.fileListCnt.value;
										
					if (existFileNum=="undefined" || existFileNum ==null) {
						existFileNum = 0;
					}
					uploadableFileNum = maxFileNum - existFileNum;
					if (uploadableFileNum<0) {
						uploadableFileNum = 0;
					}
					if (uploadableFileNum != 0) {
						fn_egov_check_file('Y');
						var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), uploadableFileNum , 'write_input');
						multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
					} else {
						fn_egov_check_file('N');
					}
				}				
				else{
					alert("파일 삭제에 실패하였습니다.");
				} 
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("파일 삭제에 실패하였습니다.");
			}
		});
		
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
</script>


      
<!-- <form name="fileForm" action="" method="post" >  -->


<input type="hidden" name="atchFileId" value="${atchFileId}">
<input type="hidden" name="fileSn" >
<input type="hidden" name="fileListCnt" value="${fileListCnt}">
<!-- </form>  -->
<c:forEach var="fileVO" items="${fileList}" varStatus="status">
	<div>
	<c:choose>
		<c:when test="${updateFlag=='Y'}">
			<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<fmt:formatNumber value="${fileVO.fileMg/1024}" pattern=".00"/>&nbsp;KB]
			<c:if test="${forwardMail != 'true'}">
			<img src="<c:url value='${imagePath}/egovframework/cmm/fms/icon/bu5_close.gif'/>" class="cursorPointer"
			width="19" height="18" onClick="fn_egov_deleteFile(this, '<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>');" alt="파일삭제">
			</c:if>			
		</c:when>
		<c:otherwise>
			<a href="javascript:fn_egov_downFile('<c:out value="${fileVO.atchFileId}"/>','<c:out value="${fileVO.fileSn}"/>')" 
			<c:if test="${isComment == 'true'}">style="color:blue; decoration:underline"</c:if>>
			<c:out value="${fileVO.orignlFileNm}"/>&nbsp;[<fmt:formatNumber value="${fileVO.fileMg/1024}" pattern=".00"/>&nbsp;KB]
			</a>
		</c:otherwise>
	</c:choose>
	</div>
</c:forEach>
<c:if test="${fn:length(fileList) == 0 && isComment != 'true'}">
	첨부파일이 없습니다.
</c:if>
