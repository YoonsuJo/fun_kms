<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFileMod.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/cheditor.js'/>" ></script>
<script type="text/javascript" src="<c:url value='${commonPath}/cheditor/utils/imageUtil.js'/>" ></script>
<script type="text/javascript" src="/common/js/default.js"></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>

<script type="text/javascript" src="${commonPath}/js/jquery.form.js"></script>

<script>
$(function(){
	$('#prjNm').click(function(){
		prjGen('prjNm','prjId',1);
	})
	.focus(function(){
		prjGen('prjNm','prjId',1);
	});
	$('#mngNm').click(function(){
		usrGen('mngNm',1);
	})
	.focus(function(){
		usrGen('mngNm',1);
	});
	$('#imgMng').click(function(){
		usrGen('mngNm',1);
	});
	//변경이력보기
	$('#btn_search').click(function(){
		var installNo = $('#installNo').val();		
		//var popup = window.open("${rootPath}/equipInstall/equipInstallVD.do?installNo="+installNo, "_EQUIPMENT_VIEW_","width=590px,height=620px,scrollbars=no");
		var popup = window.open("${rootPath}/equipInstall/equipInstallVD.do?installNo="+installNo, "_EQUIPMENT_VIEW_","width=590px,height=770px,scrollbars=no");
		popup.focus();
	});
	//수정
	$('#btn_modify').click(function(){
		$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallM.do');
		$('#frm').submit();
	});
	//삭제
	$('#btn_delete').click(function(){
		if(confirm("이 요청을 삭제하시겠습니까?")){
			$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallD.do');
			$('#frm').submit();
		}
	});
	//목록
	$('#btn_back').click(function(){
		$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallL.do');
		$('#frm').submit();
	});
	//작업담당자 체크
	$('#checkMng').click(function(){
		if($('#checkMng').attr('checked') == 'checked'){
			$('#tr_mng').show();
		}else{
			$('#tr_mng').hide();
		}
	});
	$('input:radio[id^="gubunCd_"]').click(function(){
		if($(this).val() == "1"){
			$('#completeMsg').text("작업 예정일");
			$('#checkMng').attr('disabled', false);
			if($('#checkMng').attr('checked') == 'checked'){
				$('#tr_mng').show();
			}
		}
		if($(this).val() == "2"){
			$('#completeMsg').text("완료 예정일");
			$('#checkMng').attr('disabled', false);
			if($('#checkMng').attr('checked') == 'checked'){
				$('#tr_mng').show();
			}
		}
		if($(this).val() == "3"){
			$('#completeMsg').text("완료일");
			$('#checkMng').attr('disabled', false);
			if($('#checkMng').attr('checked') == 'checked'){
				$('#tr_mng').show();
			}
		}
		if($(this).val() == "4"){
			$('#completeMsg').text("재요청일");
			$('#checkMng').attr('disabled', true);
			$('#tr_mng').hide();
		}
	});
/*
	$('#btn_add').click(function(){
		if(parseInt($('#gubunCdCount').val()) == 1){
			alert("추가되어 있습니다.");
			return false;
		}

		var html = '';
		html += '<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." id="tb_'+$('#gubunCdCount').val()+'">';
		html += '<caption>솔루션 장비 납품 설치요청 접수</caption>';
		
		html += '<colgroup>';
		html += 		'<col class="col100" />';
		html += 		'<col class="col100" />';
		html += 		'<col class="col140" />';
		html += 		' <col class="col100" />';
		html += '<col width="px" />';
		html += '</colgroup>';
		
		html += '<thead>';
		html += 		'<tr>';
		html += 			'<th class="write_info">구분</th>';
		html += 			'<th class="write_info2" colspan="2">';

		if($('#gubunCd').val() == 0){
			html += 				'<input type="radio" disabled="disabled"/>접수';
			html += 				'<input type="radio" checked="checked" disabled="disabled"/>완료';
			html += 				'<input type="radio" disabled="disabled"/>재요청';
		}
		if($('#gubunCd').val() == 1){
			html += 				'<input type="radio" disabled="disabled"/>접수';
			html += 				'<input type="radio" checked="checked" disabled="disabled"/>완료';
			html += 				'<input type="radio" disabled="disabled"/>재요청';
		}
		if($('#gubunCd').val() == 2){
			html += 				'<input type="radio" disabled="disabled"/>접수';
			html += 				'<input type="radio" disabled="disabled"/>완료';
			html += 				'<input type="radio" checked="checked" disabled="disabled"/>재요청';
		}
		if($('#gubunCd').val() == 3){
			html += 				'<input type="radio" checked="checked" disabled="disabled"/>접수';
			html += 				'<input type="radio" disabled="disabled"/>완료';
			html += 				'<input type="radio" disabled="disabled"/>재요청';
		}
		
		html += 			'</th>';
		html += 			'<th class="write_info">완료(예정)일</th>';
		html += 			'<th id="th_date" class="write_info2">';

		if($('#gubunCd').val() == 0){
			html += '<input type="text" class="span_5 calGen" id="completeDate" name="completeDate"/>';
		}else if($('#gubunCd').val() == 3){
			html += '<input type="text" class="span_5 calGen" id="completeDate" name="completeDate"/>';
		}else{
			html += 				'${eiVO.completeDate}';
			html += 				'<input type="hidden" name="completeDate" value="${eiVO.completeDate}"/>';
		}
		
		
		html += 			'</th>';
		html += 			'<th class="write_info" rowspan="2">';
		html += 				'<img src="${imagePath}/btn/btn_regist02.gif" class="cursorPointer" onclick="lfn_insertDetail()"/>';
		html += 			'</th>';
		html += 		'</tr>';
		html += 		'<tr>';
		html += 			'<th class="write_info">내용</th>';
		html += 			'<th class="write_info2" colspan="4">';
		html += 				'<textarea rows="5" cols="100" name="content" id="content"></textarea>';
		html += 			'</th>';
		html += 		'</tr>';
		html += 		'<tr>';
		html += 			'<th class="write_info">첨부파일</th>';
		html += 			'<th class="write_info2" colspan="5">';
		html += 				'<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>';
		html += 				'<div id="egovComFileList"></div>';

		html += 				'<span>※ 첨부파일의 최대 용량은 70MB입니다.</span>';
		html += 			'</th>';
		html += 		'</tr>';
		html += '</thead>';
		html += '<tbody>';
		html += '</tbody>';
		html += '</table>';
		
		$('#div_receive').append(html);

		var countData = parseInt($('#gubunCdCount').val())+1;

		$('#gubunCdCount').attr('value', countData);
	});
*/
/*
	$('#completeDate').live('change', function(){
		var html = $('#completeDate').val()+'<input type="hidden" name="completeDate" value="'+$('#completeDate').val()+'"/>';
		$('th[id^="th_date"]').html('');
		$('th[id^="th_date"]').append(html);

	});
*/
});

function lfn_insertDetail(){
	var gubunCd = '${eiVO.gubunCd}';
	
	if($('#completeDate').val() == ""){
		if(gubunCd != '3'){
			alert("날짜는 필수 입력값 입니다.");
			$('#completeDate').focus();
			return false;
		}
	}
	if($('#content').val() == ''){
		alert("내용은 필수 입력값 입니다.");
		$('#content').focus();
		return false;
	}
	if(confirm("작업 내용을 저장 하시겠습니까?")){
		/*
		$('#gubunCd').attr('value', parseInt($('#gubunCd').val())+1);
		if($('#gubunCd').val() == 4){	//재요청이라면
			$('#gubunCd').attr('value', 1);
			$('#gubunNum').attr('value', parseInt($('#gubunNum').val())+1);
		}
		*/
		//줄바꿈 처리
		/*
		$('#content').attr('value', function(){
			return $('#content').val().replace(/\n/g, "<br>");
		});
		*/		
		                           		
		$('#frmDetail').attr('action', '${rootPath}/equipInstall/equipmentRP.do');
		$('#frmDetail').submit();
		/*
		$.ajax({
			url : '${rootPath}/equipInstall/equipmentRP.do',
				data : {
							"gubunCd" : gubunCd,
							"installNo" : $('#installNo').val(),
							"gubunNum" : $('#gubunNum').val(),
							"completeDate" : $('#completeDate').val(),
							"content" : $('#content').val()
					   },
				dataType : 'json',
				type : 'post',
				enctype: 'multipart/form-data',
				encoding : 'multipart/form-data',
				success : function(data){
							if(data.result=="Y"){
								alert("설치 작업을 등록하였습니다.");
								if(data.returnEiVO2.gubunCd == "0"){
									$('#gubun').html('');
									$('#gubun').html('<span class="txtB_red">요청중</span>');
								}
								if(data.returnEiVO2.gubunCd == "1"){
									$('#gubun').html('');
									$('#gubun').html('<span class="txtB_green">처리중</span>');
								}
								if(data.returnEiVO2.gubunCd == "2"){
									$('#gubun').html('');
									$('#gubun').html('<span class="txtB_blue">완료</span>');
								}
								if(data.returnEiVO2.gubunCd == "3"){
									$('#gubun').html('');
									$('#gubun').html('<span class="txtB_orange">재요청</span>');
								}
								
							}else{
								alert("설치 작업 내용 입력을 실패하였습니다.");
							}
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("설치 작업 내용 입력을 실패하였습니다.");
		  	 	}
		});
	*/
	/*
	$('#frmDetail').ajaxForm({
		url : '${rootPath}/equipInstall/equipmentRP.do',
		data : {
				"gubunCd" : gubunCd,
				"installNo" : 9,
				"gubunNum" : 1,
				"completeDate" : $('#completeDate').val(),
				"content" : $('#content').val()
		   		},
		dataType : 'json',
		type : 'post',
		enctype: 'multipart/form-data',
		encoding : 'multipart/form-data',
		success : function(data){
				alert(12);
				alert(data.result);
		},

		error: function(xhr, testStatus, errorThrown) {
				alert(33);
		}
	});
		*/
		/*
	var option = {
				url : '${rootPath}/equipInstall/equipmentRP.do',
				data : {
						"gubunCd" : gubunCd,
						"installNo" : $('#installNo').val(),
						"gubunNum" : $('#gubunNum').val(),
						"completeDate" : $('#completeDate').val(),
						"content" : $('#content').val()
				   		},
				dataType : 'json',
				type : 'post',
				enctype: 'multipart/form-data',
				encoding : 'multipart/form-data',
				success : function(data){
							alert(12);
							alert(data.result);
						},
		
				error: function(xhr, testStatus, errorThrown) {
							alert(33);
						}
				};
	
		*/
	}
}
//설치 작업 내용 삭제
function lfn_delete_detail(detailNo){
	if(confirm("내용을 삭제 하시겠습니까?\n삭제 후엔 이전 단계로 돌아갑니다.")){
		//$('#gubunNum').attr('value', gnum);
		//$('#frmDetail').attr('action', '${rootPath}/equipInstall/equipmentDetailDP.do?installDetailNo='+detailNo+'&gubunCd='+gcode+'&gubunNum='+gnum);
		$('#frmDetail').attr('action', '${rootPath}/equipInstall/equipmentDetailDP.do?installDetailNo='+detailNo);
		$('#frmDetail').submit();
	}
}
//설치 작업 내용 수정
function lfn_modify_detail(detailNo){
	var popup = window.open("${rootPath}/equipInstall/equipInstallVM.do?installDetailNo="+detailNo, "_EQUIPMENT_VIEW2_","width=580px,height=620px,scrollbars=no");
	popup.focus();
}
/*
function lfn_detail_chgList(detailNo, gubunCd){
	var popup = window.open("${rootPath}/equipInstall/equipInstallVD2.do?installDetailNo="+detailNo+"&gubunCd="+gubunCd, "_EQUIPMENT_VIEW3_","width=580px,height=600px,scrollbars=yes");
	popup.focus();
}
*/
function lfn_popPrj(prjCode){
	var popup = window.open("${rootPath}/cooperation/selectProjectV.do?prjId="+prjCode, "_PRJ_VIEW_","width="+screen.width+"px,height="+screen.height+"px,scrollbars=yes");
	popup.focus();
}
</script>
</head>
<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">솔루션 장비 납품 설치요청 상세정보</li>
							<li class="navi">홈 > 솔루션 납품 > 솔루션 장비 납품 설치요청 상세정보</li>
						</ul>
					</div>
					
					<!-- S: section -->
					<div class="section01">
						<p class="th_stitle mB10">설치 요청</p>
						
						
						<!-- 게시판 시작  -->
						<form name="frm" id="frm" method="post">
						<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
						<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
						<input type="hidden" name="searchSubject" value="${searchVO.searchSubject}"/>
						<input type="hidden" name="searchUserId" value="${searchVO.searchUserId}"/>
						<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>
						<input type="hidden" name="searchGubun" value="${searchVO.searchGubun}"/>
						
						<input type="hidden" id="installNo" name="installNo" value="${eiVO.installNo}"/>
						<input type="hidden" id="masterGubun" value="${eiVO.gubunCd}"/>
						

						
						<div class="boardView">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>솔루션 장비 납품 설치요청 등록</caption>
		                    
		                    <colgroup>
			                    <col class="col100" />
			                    <col class="col100" />
			                    <col class="col100" />
			                    <col class="px" />
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    
		                    <thead>
		                    	<tr>
			                        <th class="write_info">제목</th>
			                        <th class="write_info2" colspan="5">${eiVO.subject}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">상태</th>
			                    	<th class="write_info2" id="gubun">
			                    	<c:choose>
										<c:when test="${eiVO.delYn == 'N'}">
					                    	<c:if test="${eiVO.gubunCd == '0'}"><span class="txtB_red">요청</span></c:if>
					                    	<c:if test="${eiVO.gubunCd == '1'}"><span class="txtB_yellow">접수</span></c:if>
					                    	<c:if test="${eiVO.gubunCd == '2'}"><span class="txtB_green">처리중</span></c:if>
					                    	<c:if test="${eiVO.gubunCd == '3'}"><span class="txtB_blue">완료</span></c:if>
					                    	<c:if test="${eiVO.gubunCd == '4'}"><span class="txtB_orange">재요청</span></c:if>
					                    </c:when>
					                    <c:otherwise>
					                    	<span class="txtB_grey">삭제</span>
					                    </c:otherwise>
				                    </c:choose>
			                    	</th>
			                    	<th class="write_info">최초 요청자</th>
			                    	<th class="write_info2"><span class="cursorPointer" onclick="openUsrLayer('${eiVO.userNo}',this);">${eiVO.userId}</span></th>
			                    	<th class="write_info">최초 요청일시</th>
			                    	<th class="write_info2">
			                    		${fn:substring(fn:replace(eiVO.instDate, '-', '.'), 0, 16)}
			                    	</th>
		                        </tr>
		                        
		                        <c:if test="${eiVO.gubunCd != '0'}">
			                        <tr>
				                    	<th class="write_info">
				                    		<c:if test="${eiVO.gubunCd == '1'}">작업담당자</c:if>
					                    	<c:if test="${eiVO.gubunCd == '2'}">작업담당자</c:if>
					                    	<c:if test="${eiVO.gubunCd == '3'}">작업담당자</c:if>
					                    	<c:if test="${eiVO.gubunCd == '4'}">요청자</c:if>
				                    	</th>
				                    	<th class="write_info2"><span class="cursorPointer" onclick="openUsrLayer('${eiVO.mngNo}',this);">${eiVO.mngId}</span></th>
				                    	<th class="write_info">
				                    		<c:if test="${eiVO.gubunCd == '1'}">작업시작 예정일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '2'}">완료 예정일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '3'}">완료일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '4'}">재요청일</c:if>
				                    	</th>
				                    	<th class="write_info2">
				                    		<c:if test="${!empty eiVO.completeDate}">
				                    			<c:if test="${eiVO.gubunCd != '4'}">
				                    			${fn:substring(eiVO.completeDate, '0', '4')}.${fn:substring(eiVO.completeDate, '4', '6')}.${fn:substring(eiVO.completeDate, '6', '8')}
				                    			</c:if>
				                    			<c:if test="${eiVO.gubunCd == '4'}">
				                    			${fn:substring(fn:replace(eiVO.regDate, '-', '.'), 0, 10)}
				                    			</c:if>
				                    		</c:if>
				                    	</th>
				                    	<th class="write_info">등록일시</th>
				                    	<th class="write_info2">
				                    		${fn:substring(fn:replace(eiVO.regDate, '-', '.'), 0, 16)}
				                    	</th>
			                        </tr>
		                        </c:if>
		                        
		                        <tr>
			                    	<th class="write_info">프로젝트</th>
			                    	<th class="write_info2" colspan="5" title="${eiVO.prjNm}">
			                    	<a href="#" onclick="lfn_popPrj('${eiVO.projectCode}')">
			                    		[${eiVO.prjId}] ${eiVO.prjNm}
			                    	</a></th>
		                        </tr>
		                        <tr>
		                        	<th class="write_info">납품솔루션</th>
			                    	<th class="write_info2" colspan="5">${eiVO.solutionNm}</th>
			                    	
		                        </tr>
		                        <tr>
		                        	<th class="write_info">고객사</th>
			                    	<th class="write_info2" colspan="5">${eiVO.customer}</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">요청 내용</th>
			                    	<th class="write_info2" colspan="5">
			                    		${eiVO.content}
			                    	</th>
		                        </tr>
		                    </thead>
		                    <tfoot>
								<tr>
									<td class="write_info">첨부파일</td>
									<td class="write_info2" colspan="5">
										<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${eiVO.atchFileId}" />
										</c:import>
									</td>
								</tr>
							</tfoot>
		                    <tbody>
		                    </tbody>
		                    </table>
						</div>
						</form>
						<!--// 게시판 끝  -->
						<br>
						<!-- 버튼 시작 -->
		                <div class="btn_area04">
		               		<img src="${imagePath}/btn/btn_chgHistoryView.gif" class="cursorPointer" id="btn_search"/>
		               		<c:if test="${eiVO.delYn != 'Y'}">
		                	<img src="${imagePath}/btn/btn_modify.gif" class="cursorPointer" id="btn_modify"/>
		                	<c:if test="${sessionId == eiVO.instId || isAdmin == 'Y'}">
		                	<img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" id="btn_delete"/>
		                	</c:if>
		                	</c:if>
		                	<img src="${imagePath}/btn/btn_list.gif" class="cursorPointer" id="btn_back"/>
		                </div>
		                <!-- 버튼 끝 -->
		                		                
		                <br><br>
		                
		                <c:if test="${eiVO.delYn == 'N'}">
		                	<div class="th_stitle mB10">
		                		설치 작업
		                		<div class="btn_area02" style="width:150px;float:right;">
		                		<!-- 작업추가 따로 없이 맨 아래에 코멘트 형식으로 폼을 남겨두기로 함 2013.04.04
		                			<input type="button" id="btn_add" value="작업추가"/>
		                			<img src="${imagePath}/btn/btn_add.gif" class="cursorPointer"/>
		                			<input type="hidden" id="gubunCdCount" value="0"/>
		                		 -->
		                		</div>
		                	</div>
	                	</c:if>
		                
						<form name="frmDetail" id="frmDetail" method="post" enctype="multipart/form-data">	
							<input type="hidden" id="installNo" name="installNo" value="${eiVO.installNo}"/>
						<!-- 게시판 시작  -->
						<div class="boardWrite" id="div_receive">
							<c:forEach items="${detailList}" var="element" varStatus="index">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>솔루션 장비 납품 설치요청 접수</caption>
			                    
			                    <colgroup>
				                    <col class="col100" />
				                    <col class="px" />
				                    <col class="col100" />
				                    <col class="col100" />
				                    <col class="col100" />
				                    <col class="col110" />
				                    <col class="col100" />
				                    <col width="80px" />
			                    </colgroup>
			                    <thead>
			                    	<tr>
				                        <th class="write_info">구분</th>
				                        <th class="write_info2" colspan="4">
				                        	<c:choose>
				                        	<c:when test="${element.gubunCd == '1'}">
					                        <input type="radio" disabled="disabled" checked="checked"/><b>접수</b>
					                        <input type="radio" disabled="disabled"/>작업
					                        <input type="radio" disabled="disabled"/>완료
					                        <input type="radio" disabled="disabled"/>재요청
					                        </c:when>
					                        <c:when test="${element.gubunCd == '2'}">
					                        <input type="radio" disabled="disabled"/>접수
					                        <input type="radio" disabled="disabled" checked="checked"/><b>작업</b>
					                        <input type="radio" disabled="disabled"/>완료
					                        <input type="radio" disabled="disabled"/>재요청
					                        </c:when>
					                        <c:when test="${element.gubunCd == '3'}">
					                        <input type="radio" disabled="disabled"/>접수
					                        <input type="radio" disabled="disabled"/>작업
					                        <input type="radio" disabled="disabled"checked="checked" /><b>완료</b>
					                        <input type="radio" disabled="disabled"/>재요청
					                        </c:when>
					                        <c:when test="${element.gubunCd == '4'}">
					                        <input type="radio" disabled="disabled"/>접수
					                        <input type="radio" disabled="disabled"/>작업
					                        <input type="radio" disabled="disabled"/>완료
					                        <input type="radio" disabled="disabled" checked="checked"/><b>재요청</b>
					                        </c:when>
					                        </c:choose>
				                        </th>
				                        <th class="write_info">
				                        	<c:choose>
				                        	<c:when test="${element.gubunCd == '1'}">
				                        		작업시작 예정일
				                        	</c:when>
				                        	<c:when test="${element.gubunCd == '2'}">
				                        		완료 예정일
					                        </c:when>
					                        <c:when test="${element.gubunCd == '3'}">
				                        		완료일
					                        </c:when>
					                        <c:when test="${element.gubunCd == '4'}">
					                        	재요청일
					                        </c:when>
					                        </c:choose>
				                        </th>
				                    	<th class="write_info2">
				                    		<c:choose>
				                        	<c:when test="${element.gubunCd == '4'}">
				                    			${fn:substring(fn:replace(element.regDate, '-', '.'), 0, 10)}
				                    		</c:when>
				                    		<c:otherwise>
				                    			${fn:substring(element.completeDate, '0', '4')}.${fn:substring(element.completeDate, '4', '6')}.${fn:substring(element.completeDate, '6', '8')}
				                    		</c:otherwise>
				                    		</c:choose>
				                    	</th>
				                    	<th class="write_info" rowspan="4">
				                    		<!-- 수정 및 변동 내역 보지 않음 2013.04.04 -->
				                    		<c:if test="${sessionId == element.regId || isAdmin == 'Y'}">
				                    		<img src="${imagePath}/btn/btn_plus02.gif" class="cursorPointer"
				                    			 onclick="lfn_modify_detail('${element.installDetailNo}');"/>
				                    		<img src="${imagePath}/btn/btn_minus02.gif" class="cursorPointer"
				                    			 onclick="lfn_delete_detail('${element.installDetailNo}');"/>
				                    		</c:if>
				                    	</th>
			                        </tr>
			                        <tr>
			                        	<th class="write_info">
			                        		<c:choose>
				                        	<c:when test="${element.gubunCd == '4'}">
				                    			요청자
				                    		</c:when>
				                    		<c:otherwise>
				                    			작업담당자
				                    		</c:otherwise>
				                    		</c:choose>
			                        	</th>
				                    	<th class="write_info2" colspan="2">
				                    		<span class="cursorPointer" onclick="openUsrLayer('${element.mngNo}',this);">${element.mngNm}</span>
				                    	</th>
				                    	<th class="write_info">등록자</th>
				                    	<th class="write_info2">
				                    		<span class="cursorPointer" onclick="openUsrLayer('${element.regNo}',this);">${element.regNm}</span>
				                    	</th>
				                    	<th class="write_info">등록일시</th>
				                    	<th class="write_info2">
				                    		${fn:substring(fn:replace(element.regDate, '-', '.'), 0, 16)}
				                    	</th>
			                        </tr>
			                        <tr>
				                    	<th class="write_info">내용</th>
				                    	<th class="write_info2" colspan="6" id="replaceContent">
				                    		${element.content}
				                    	</th>
			                        </tr>
			                        <tr>
				                    	<th class="write_info">첨부파일</th>
				                    	<th class="write_info2" colspan="6">
											<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
												<c:param name="param_atchFileId" value="${element.atchFileId}" />
											</c:import>
										</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    </tbody>
			                    </table>
			                    <br>
							</c:forEach>
							
							<c:if test="${eiVO.delYn == 'N'}">
			                    <table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." id="tb_${eiVO.gubunCd}">
			                    <caption>솔루션 장비 납품 설치요청 접수</caption>
			                    
			                    <colgroup>
				                    <col class="col100" />
				                    <col class="px" />
				                    <col class="col100" />
				                    <col class="col110" />
				                    <col class="col100" />
				                    <col width="80px" />
			                    </colgroup>
			                    <thead>
			                    	<tr>
				                        <th class="write_info">구분</th>
				                        <th class="write_info2"
				                        	<c:if test="${eiVO.gubunCd != '3'}">colspan="2"</c:if>
				                        	<c:if test="${eiVO.gubunCd == '3'}">colspan="4"</c:if>
				                        >
				                        	<c:if test="${eiVO.gubunCd == 0}">
					                        <input type="radio" id="gubunCd_1" name="gubunCd" checked="checked" value="1"/>접수
					                        <input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
					                        <input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
					                        <input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
					                        </c:if>
					                        <c:if test="${eiVO.gubunCd == 1}">
					                        <input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
					                        <input type="radio" id="gubunCd_2" name="gubunCd" checked="checked" value="2"/>작업
					                        <input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
					                        <input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
					                        </c:if>
					                        <c:if test="${eiVO.gubunCd == 2}">
					                        <input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
					                        <input type="radio" id="gubunCd_2" name="gubunCd" value="2"/>작업
					                        <input type="radio" id="gubunCd_3" name="gubunCd" checked="checked" value="3"/>완료
					                        <input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
					                        </c:if>
					                        <c:if test="${eiVO.gubunCd == 3}">
					                        <input type="radio" id="gubunCd_1" name="gubunCd" value="1" disabled="disabled"/>접수
					                        <input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
					                        <input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
					                        <input type="radio" id="gubunCd_4" name="gubunCd" checked="checked" value="4"/>재요청
					                        </c:if>
					                        <c:if test="${eiVO.gubunCd == 4}">
					                        <input type="radio" id="gubunCd_1" name="gubunCd" checked="checked" value="1"/>접수
					                        <input type="radio" id="gubunCd_2" name="gubunCd" value="2" disabled="disabled"/>작업
					                        <input type="radio" id="gubunCd_3" name="gubunCd" value="3" disabled="disabled"/>완료
					                        <input type="radio" id="gubunCd_4" name="gubunCd" value="4" disabled="disabled"/>재요청
					                        </c:if>
<!--					                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
					                        <br/>
					                        <label>
					                        	<input type="checkbox" id="checkMng" class="check" <c:if test="${eiVO.gubunCd == '3'}">disabled="disabled"</c:if> /> 작업담당자 선택
					                        </label>
					                        <input type="hidden" name="pageIndex" value="${eiVO.pageIndex}"/>
				                        </th>
				                        <c:if test="${eiVO.gubunCd != '3'}">
				                        <th class="write_info" id="completeMsg">
					                        <c:if test="${eiVO.gubunCd == '0'}">작업시작 예정일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '1'}">완료 예정일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '2'}">완료일</c:if>
					                    	<c:if test="${eiVO.gubunCd == '4'}">작업시작 예정일</c:if>
				                        </th>
				                    	<th class="write_info2" id="th_complete">
				                    		<input type="text" class="span_5 calGen" id="completeDate" name="completeDate"/>
				                    	</th>
				                    	</c:if>
				                    	<th class="write_info" colspan="4" rowspan="3">
				                    		<img src="${imagePath}/btn/btn_regist02.gif" class="cursorPointer" onclick="lfn_insertDetail('1')"/>
				                    	</th>
			                        </tr>
			                        <tr id="tr_mng" style="display:none">
			                        	<th class="write_info">작업담당자</th>
				                    	<th class="write_info2" colspan="4">
				                    		<input type="text" name="mngNm" id="mngNm" class="search_txt02" readonly="readonly"/>
											<img src="/images/btn/btn_tree.gif" class="cursorPointer" id="imgMng"/>
				                    	</th>
			                        </tr>
			                        <tr>
				                    	<th class="write_info">내용</th>
				                    	<th class="write_info2" colspan="4">
				                    		<textarea rows="6" cols="85" class="textarea height_90" name="content" id="content"></textarea>
				                    	</th>
			                        </tr>
			                        <tr>
				                    	<th class="write_info">첨부파일</th>
				                    	<th class="write_info2" colspan="5">
											<input name="file_1" id="egovComFileUploader" type="file" class="write_input"/>
											<div id="egovComFileList"></div>
											<script type="text/javascript">
												var maxFileNum = 3;
												var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum , 'write_input');
												multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
											</script>
											<span>※ 첨부파일의 최대 용량은 70MB입니다.</span>
										</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                    </tbody>
			                    </table>
			                    </c:if>
						</div>
						</form>
						
						
					</div>
					<!-- E: section -->
				</div>
				<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>