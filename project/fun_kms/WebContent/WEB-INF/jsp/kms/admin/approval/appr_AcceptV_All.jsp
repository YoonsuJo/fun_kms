<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
$(document).ready(function() {

	var queryString = "${queryString}";
	var docIdList = ${docIdList};
	var nth = 0;
	var residualDocCnt = docIdList.length;
	var comleteDocCnt = 0; 
	var postponeDocCnt = 0;

	var form = $('#approvalVO');

	$('#listB').click(function(){
		location.replace("/approval/approvalL.do?" + queryString);
	});


	var loadDocF =function (){
		$('#residualDocCnt').html(residualDocCnt);
		$('#comleteDocCnt').html(comleteDocCnt);
		$('#postponeDocCnt').html(postponeDocCnt);
		if(docIdList.length<=nth)
			$('#appDocContent').html("결재할 문서가 없습니다.");
		else{
			$.post("/approval/approvalV.do?docId=" + docIdList[nth] + "&ajaxMode=1",
					function(data){
				$('#appDocContent').html(data);
				$('#appCommentB').click(commentF);
				$('#appAcceptB').click(acceptF);
				$('#appRejectB').click(rejectF);	
				$('#appPostponeB').click(postponeF);
				$('#eappCt').val("");
				form = $('#approvalVO');	
				//$('#commentWriteDocId').val(docIdList[nth]);
				//$('input:hidden[name=docId]').val(docIdList[0]);
			//	alert($('input:hidden[name=docId]').val());
				});
		}
		window.scrollTo(0,0);
	};
		
	var commentF =	function(){
		
			$.post("/approval/commentAjaxI.do", form.serialize(),
					function(data){
				$('#approvalCommentView').html(data);
				$('#eappCt').val("");
			})};
	var acceptF = function(){
		$('#appPostponeB,#appAcceptB,#appRejectB,#appCommentB').unbind("click");
		
		$.post("/approval/appAccept.do?ajaxMode=1&stat=1", form.serialize(),
				function(data){
			if(data.indexOf("success"))
			{
				nth++;
				residualDocCnt--;
				comleteDocCnt++;
				loadDocF();
			}
			});
		};
	var rejectF = function(){
		$('#appPostponeB,#appAcceptB,#appRejectB,#appCommentB').unbind("click");
				
		$.post("/approval/appAccept.do?ajaxMode=1&stat=2", form.serialize(),
				function(data){
			if(data.indexOf("success"))
			{
				nth++;
				residualDocCnt--;
				comleteDocCnt++;
				loadDocF();
			}
		});
	};

	var postponeF = function(){
		$('#appPostponeB,#appAcceptB,#appRejectB,#appCommentB').unbind("click");
		nth++;
		postponeDocCnt++;
		residualDocCnt--;
		loadDocF();
			
	};
	
	loadDocF();
		
	
		
});

	
	

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
		<%@ include file="left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">일괄결재</li>
							<li class="navi">홈 > 전자결재 > 결재하기 > 결재문서 승인하기</li>
						</ul>
					</div>
					
					<span class="stxt">결재 문서를 순서대로 검토하고 승인합니다.</span>
					<!-- S: section -->
					<div class="section01">
						<div id="appDocContent">
					
						</div>
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	결재완료건수 :<span id="comleteDocCnt">0</span>건, 
		                	보류건수 : <span id="postponeDocCnt">0</span>건, 
		                	남은건수 : <span id="residualDocCnt">0</span>건 
		                	<img class="cursorPointer" id="appPostponeB" src="${imagePath}/btn/btn_skip.gif"/> 
		                	<img src="${imagePath}/btn/btn_print.gif"/> 
		                	<img class="cursorPointer" id="listB" src="${imagePath}/btn/btn_list.gif"/>
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
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>
