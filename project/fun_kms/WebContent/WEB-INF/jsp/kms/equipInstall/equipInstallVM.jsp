<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script>
$(function(){
	$('#mngNm').click(function(){
		usrGen('mngNm',1);
	})
	.focus(function(){
		usrGen('mngNm',1);
	});
	$('#imgMng').click(function(){
		usrGen('mngNm',1);
	});
	$('#btn_close').click(function(){
		self.close();
	});

	$('#btn_modify').click(function(){
		if(confirm("작성된 내용으로 작업내용을 수정 하시겠습니까?")){
			$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallVMP.do');
			$('#frm').submit();
		}
	});
});

function fn_egov_check_file(flag) {
	if (flag=="Y") {
		document.getElementById('file_upload_posbl').style.display = "";
		document.getElementById('file_upload_imposbl').style.display = "none";			
	} else {
		document.getElementById('file_upload_posbl').style.display = "none";
		document.getElementById('file_upload_imposbl').style.display = "";
	}
}
</script>
</head>

<body>
<div id="pop_regist02">
 	<div id="pop_top">
 	   <ul>
			<li><img src="${imagePath}/inc/pop_bullet.gif" /></li>
			<li class="popTitle">설치 작업 내용 수정</li>
		</ul>
 	</div>
 	<div class="pop_con08">
 		
       	<p class="th_stitle">설치 작업 내용 수정</p>
		<div class="boardWrite" id="div_receive">
			<form id="frm" name="frm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="installDetailNo" value="${element.installDetailNo}"/>
			<input type="hidden" name="installNo" value="${element.installNo}"/>
			<input type="hidden" name="returnUrl" value="<c:url value='${rootPath}/equipInstall/equipInstallVM.do?installDetailNo=${element.installDetailNo}'/>"/>
			
			<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	        <caption>솔루션 장비 납품</caption>
                    
			<colgroup>
				<col class="col100" />
				<col width="px" />
				<col class="col110" />
				<col class="col100" />
			</colgroup>
			<thead>
				<tr>
					<th class="write_info">구분</th>
					<th class="write_info2">
						<c:if test="${element.gubunCd == 1}">
						<input type="radio" id="gubunCd_1" name="gubunCd" checked="checked" value="1" disabled="disabled"/><b>접수</b>
						<input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
						<input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
						<input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
						</c:if>
						<c:if test="${element.gubunCd == 2}">
						<input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
						<input type="radio" id="gubunCd_2" name="gubunCd" checked="checked" value="2" disabled="disabled"/><b>작업</b>
						<input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
						<input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
						</c:if>
						<c:if test="${element.gubunCd == 3}">
						<input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
						<input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
						<input type="radio" id="gubunCd_3" name="gubunCd" checked="checked" value="3" disabled="disabled"/><b>완료</b>
						<input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
						</c:if>
						<c:if test="${element.gubunCd == 4}">
						<input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
						<input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
						<input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
						<input type="radio" id="gubunCd_4" name="gubunCd" checked="checked" value="4" disabled="disabled"/><b>재요청</b>
						</c:if>
            		</th>
					<th class="write_info">
			           	<c:if test="${element.gubunCd == '1'}">작업시작 예정일</c:if>
			        	<c:if test="${element.gubunCd == '2'}">완료 예정일</c:if>
			        	<c:if test="${element.gubunCd == '3'}">완료일</c:if>
			        	<c:if test="${element.gubunCd == '4'}">재요청일</c:if>
					</th>
		           	<th class="write_info2">
		           		<c:choose>
		           		<c:when test="${element.gubunCd != '4'}">
		           			<input type="text" class="span_5 calGen" id="completeDate" name="completeDate" value="${element.completeDate}"/>
		           		</c:when>
		           		<c:otherwise>
		           			${element.completeDate}
		           		</c:otherwise>
		           		</c:choose>
		           	</th>
	            </tr>
	            
	            <c:if test="${element.gubunCd != '4'}">
	            <tr id="tr_mng">
					<th class="write_info">작업담당자</th>
					<th class="write_info2" colspan="3">
						<input type="text" name="mngNm" id="mngNm" class="search_txt02" readonly="readonly" value="${element.mngNm}(${element.mngId})"/>
						<img src="/images/btn/btn_tree.gif" class="cursorPointer" id="imgMng"/>
					</th>
				</tr>
				</c:if>
				
	        <tr>
               	<th class="write_info">내용</th>
               	<th class="write_info2" colspan="3">
               		<textarea rows="5" cols="100" name="content" id="content">${element.content}</textarea>
	            </th>
            </tr>
			<tr>
              	<th class="write_info">첨부파일</th>
              	<th class="write_info2" colspan="3">
					<c:if test="${not empty element.atchFileId}">
						<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${element.atchFileId}" />
						</c:import>
					</c:if>	
					<c:if test="${empty element.atchFileId}">
						<input type="hidden" name="fileListCnt" value="0" />
					</c:if>
					<div id="file_upload_posbl"  style="display:none;" >	
						<input type="file" name="file_1" id="egovComFileUploader" class="write_input02"/>
						<div id="egovComFileList"></div>
					</div>
					<div id="file_upload_imposbl"  style="display:none;" >
						<spring:message code="common.imposbl.fileupload" />
					</div>			

					<script type="text/javascript">
					var existFileNum = document.frm.fileListCnt.value;
					var maxFileNum = 3;
					
					if (existFileNum=="undefined" || existFileNum ==null) {
						existFileNum = 0;
					}
					var uploadableFileNum = maxFileNum - existFileNum;
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
					</script>
				</th>
        	</tr>
        </thead>
        <tbody>
        </tbody>
        </table>
        </form>
		</div>
	</div>
	<!-- E: section -->
	<div class="pop_btn_area04">
		<img src="${imagePath}/btn/btn_modify.gif" id="btn_modify" class="cursorPointer"/>
		<img src="${imagePath}/btn/btn_close.gif" id="btn_close" class="cursorPointer"/>
	</div>
</div>
		
</body>
</html>