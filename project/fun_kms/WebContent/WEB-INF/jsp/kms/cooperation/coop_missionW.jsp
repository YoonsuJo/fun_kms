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
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<validator:javascript formName="Mission" staticJavascript="false" xhtml="true" cdata="false"/>

<script>
function write() {
	document.frm.missionCn.value = myeditor.outputBodyHTML();
	if(nullMissionChk() == true){
    	var missionLv = document.frm.prntMissionLv.value;
    	if(missionLv == ''){ 
        	missionLv = '0';
    	}else{ 
        	missionLv = parseInt(missionLv) + 1;
        	}
	
    	document.frm.missionLv.value = missionLv;	

    	var dueDt = document.frm.dueDt.value;
    	var prntDueDt = document.frm.prntDueDt.value;
    	
    	if(prntDueDt == ''){ 
        	prntDueDt = dueDt;
    	}
    	if(dueDt > prntDueDt){
			alert("상위 미션 완료일"+prntDueDt+"을 초과합니다.");	
    	}else{	
    		document.frm.submit();
    	}
     }
}

function nullMissionChk(){

	if(document.frm.missionNm.value == ""){

		document.frm.prntMissionId.value = "";
		document.frm.prntDueDt.value = "";
		document.frm.prntMissionLv.value = "";

			if(document.frm.prjNm.value == ""){
			alert('미션명을 입력하십시오.');
			return false;
			}
	}
	
	if(document.frm.prjNm.value == ""){
		alert('프로젝트를 입력하십시오.');
		return false;	
	}	

	if(document.frm.leaderMixes.value == ""){
		alert('담당자를 입력하십시오.');
		return false;		
	}

	if(document.frm.dueDt.value == ""){
		alert('완료예정일을 입력하십시오.');
		return false;	
	}


	if(document.frm.missionCn.value == ""){
		alert('미션 내용을 입력하십시오.');
		return false;		
	}
	return true;
}


function cancel() {
	//history.back();	
	location.href="${searchVO.redirectUrl}";
}



function getInfo(type, num) {
	if(type == 'prj' && num == ""){
		if(document.frm.prntMissionNm.value == ""){
			//alert("프로젝트 선택 시 최상위 미션으로 추가 됩니다.\n(상위 미션은 선택하지 않습니다.)");
			missionPrjGen('prjNm','prjId','prntMissionNm',1);
		}else{
		    //if(confirm("프로젝트 선택 시 최상위 미션으로 추가 됩니다.\n(입력된 상위 미션은 삭제됩니다.)") == true){    
			    missionPrjGen('prjNm','prjId','prntMissionNm',1);
		    	//}
			}
	}else if(type == 'prj' && num == '1'){
			missionPrjGen_del('prjNm','prjId','prntMissionNm',1);
	}else if(type == 'mission' && num == ""){
		if(document.frm.prjId.value == ""){
			missionGen('','','prntMissionNm','prntMissionId','prntDueDt','prntMissionLv','prjId','prjNm',1);
		}else{
		    //if(confirm("상위 미션 추가시 프로젝트는 상위 미션의 프로젝트로 변경 됩니다.") == true){    
			missionGen(document.frm.prjId.value,document.frm.prjNm.value,'prntMissionNm','prntMissionId','prntDueDt','prntMissionLv','prjId','prjNm',1);
		    //}
		}
	}else if(type == 'mission' && num == "1"){
		if(document.frm.prjId.value == ""){
			missionGen_del('','','prntMissionNm','prntMissionId','prntDueDt','prntMissionLv','prjId','prjNm',1);
		}else{
		    //if(confirm("상위 미션 추가시 프로젝트는 상위 미션의 프로젝트로 변경 됩니다.") == true){    
		    missionGen_del(document.frm.prjId.value,document.frm.prjNm.value,'prntMissionNm','prntMissionId','prntDueDt','prntMissionLv','prjId','prjNm',1);
		    //}
		}
	}
		//alert("document.getElementById('prjNm').value : " + document.getElementById("prjNm").value);
		//alert("document.getElementById('prjId').value : " + document.getElementById("prjId").value);
}
function prj_del(){
	document.getElementById("prjNm").value = "";
	document.getElementById("prjId").value = "";
	document.getElementById("prjNm").value = "";
	document.getElementById("prjId").value = "";
	document.getElementById("prntMissionNm").value = "";
	document.getElementById("prntMissionId").value = "";
	document.getElementById("prntDueDt").value = "";
	document.getElementById("prntMissionLv").value = "";
	document.getElementById("PrjDel").style.visibility = "hidden";
	document.getElementById("prntMissionDel").style.visibility = "hidden";
}
window.onload = function(){
	document.getElementById("PrjDel").style.visibility = "hidden";
	document.getElementById("prntMissionDel").style.visibility = "hidden";
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
							<li class="stitle">미션 추가</li>
							<li class="navi">홈 > 업무공유 > Mission Clear > 미션</li>
						</ul>
					</div>
					
	
					<!-- S: section -->
					<div class="section01">

						<!-- 게시판 시작  -->
						<form:form name="frm" commandName="Mission" action="${rootPath}/cooperation/insertMission.do" enctype="multipart/form-data">
			    		<input type="hidden"  name="type" id="type" value="W"/>	
			    		<input type="hidden"  name="missionLv" id="missionLv" value=""/>		
			    	    <input type="hidden" name="redirectUrl" value="${searchVO.redirectUrl}"/>	         
			    		<div class="boardWrite">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>미션 추가</caption>
		                    <colgroup>
			                    <col class="col100" />
			                    <col width="px" />
		                    </colgroup>
		                    <thead>
		                    	<tr>
			                        <th class="write_info">미션명 (*)</th>
			                        <th class="write_info2"><input type="text" name="missionNm" class="write_input" /></th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">프로젝트 (*)</th>
			                    	<th class="write_info2" id='prjNmDiv'>
			                    		<input type="text" class="span_12" name="prjNm" id="prjNm" readonly="readonly" onclick="getInfo('prj','1')"/>
			                    		<input type="hidden" class="span_12" name="prjId" id="prjId" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" id="selectpPrjNm" class="cursorPointer" onclick="getInfo('prj','1')"/>
			                    		<img src="${imagePath}/btn/btn_delete.gif" id='PrjDel' onclick="prj_del()"/>
			                    	</th>
		                        </tr>		         
		                        <tr>
			                    	<th class="write_info">상위 미션</th>
			                    	<th class="write_info2" id='prntMissionNmDiv'>
			                    		<input type="text" class="span_12" name="prntMissionNm" id="prntMissionNm" readonly="readonly" onclick="getInfo('mission','1')"/>
			                    		<input type="hidden" class="span_12" name="prntMissionId" id="prntMissionId" />
			                    		<input type="hidden" class="span_12" name="prntDueDt" id="prntDueDt" />
			                    		<input type="hidden" class="span_12" name="prntMissionLv" id="prntMissionLv" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="getInfo('mission','1')"/>
			                    		<img src="${imagePath}/btn/btn_delete.gif" id='prntMissionDel' onclick="prj_del()"/><br/>
			                    		※ [상위 미션]을 선택하지 않을 경우 최상위 미션(1레벨)으로 등록됩니다.
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">담당자 (*)</th>
			                    	<th class="write_info2">
			                    		<input type="text" class="span_12 userNamesAuto userValidateCheck" name="leaderMixes" id="leaderMixes" value="${userInfo }" />
			                    		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('leaderMixes',0)"/>
			                    	</th>
		                        </tr>
		                        <tr>
			                    	<th class="write_info">완료예정일 (*)</th>
			                    	<th class="write_info2">
			                    		<input type="text" name="dueDt" id="dueDt" class="span_6 calGen" value="${today }" />		                    		
			                    	</th>
		                    	</tr>
		                        <tr>
			                    	<th class="write_info">첨부파일</th>
			                    	<th class="write_info2">
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
		                    	<tr>
			                    	<td colspan="2">
			                    		<textarea rows="9" cols="100" name="missionCn" id="missionCn"></textarea>
			                    		<script type="text/javascript" language="javascript">
											var myeditor = new cheditor();
											myeditor.config.editorHeight = '400px';
											myeditor.config.editorWidth = '100%';
											myeditor.inputForm = 'missionCn';
											myeditor.run();
										</script>
			                    	</td>
		                    	</tr>
		                    </tbody>
		                    </table>
						</div>
						</form:form>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area02">
		                	<a href="javascript:write();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
		                	<a href="javascript:cancel();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>		                    	
		                </div>
		                <!-- 버튼 끝 -->
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
