<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>

function search(val){
	
	if ("${user.isAdmin}"!='Y') {
		if (document.searchVO.searchCardId.value == '' && document.searchVO.searchUserNm.value == '') {
			alert('검색 조건을 입력하지 않았습니다.');
			return false;
		}
	}
	
	var form = $('#searchVO');
	if(typeof(val) !="undefined")
		form.find('[name=searchYear]').val(parseInt(form.find('[name=searchYear]').val()) + val);
	else
		;
		form.submit();
};

$(document).ready(function(){
	var form = $('#searchVO');
	$('#searchB').click(function(){
		//search();
	});

	$('#deleteB').click(function(){
		//$('input[type=checkbox][name=check]').clone().appendTo(form);
		form.attr('action','/admin/approval/deleteCardSpend.do');
		form.submit();
	});

	$('#checkAll').change(function(){
		if($(this).attr("checked"))
			$('input[name=checkList]').attr("checked",true);
		else
			$('input[name=checkList]').attr("checked",false);
	});

	document.getElementById('countTop').innerHTML =  document.getElementById('countBottom').innerHTML;
});
var openedLayerName;
var openLayerBool = "Y";
function hideLayer() {
	$('#'+openedLayerName).dialog( "close" );
}
function fixLayer() {
	openedLayerName = "";
}
function showLayer(layerName, obj) {
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 28 - scrolled ;	

	hideLayer();	
	openedLayerName = layerName;

	if(openLayerBool=="N"){
		return;
	}
	
	$('#'+layerName).dialog( {	
		height: 147
		,width: 249
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		//,beforeClose: function(event, ui) { alert(1);}     
	});
}
function toggleOpenLayerBool(){
	if(openLayerBool=="Y"){
		openLayerBool = "N";
		document.getElementById('btnToggleOpenLayer').value = "마우스오버 켜기";
	} else if(openLayerBool=="N"){
		openLayerBool = "Y";
		document.getElementById('btnToggleOpenLayer').value = "마우스오버 끄기";
	}
}
function approvalW(templtId){
	document.frm.templtId.value = templtId;
	document.frm.action = "${rootPath}/approval/approvalW.do";	
	document.frm.submit();
}

//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.top_search input[name=searchUserNm]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
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
							<li class="stitle">법인카드 미상신 내역</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
					<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
		    		<form:hidden path="searchYear" />
					<!-- 상단 검색창 시작 -->
					<fieldset>
					<legend>상단 검색</legend>	                   
	                    <div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>									
									<td class="search_right">
<!--										<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="cursorPointer" id="searchYearPrev" onclick="search(-1);"/>-->
<!--			                			${searchVO.searchYear}년 -->
<!--										<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="cursorPointer" id="searchYearNext" onclick="search(1);"/>										-->
										<label>카드번호</label> 
										<form:input path="searchCardId" cssClass="input01 span_5"  />
										<label>사용자</label> 
										<form:input path="searchUserNm" id="searchUserNm" cssClass="input01 span_6 userNameAutoHead"/> 
										<img id="usrTree" src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('searchUserNm',1,cutUsrGenName);" class="cursorPointer">
<!--										<input type="image" src="${imagePath}/btn/btn_tree.gif" class="search_btn02" />-->
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" id="searchB" onclick="search(); return false;"/>
<!--										<input type="image" src="${imagePath}/btn/btn_allview.gif" class="search_btn02 cursorPointer" alt="전체보기" id="showAllB"/>-->
									</td>
								</tr>
							</tbody>
							</table>
		                </div>
		            
	                </fieldset>
	            	<!--// 상단 검색창 끝 -->
	            	
	            	소유자 마우스오버 : 카드 상세정보 조회 / 클릭 : 상세정보창 고정<br/>	
	            	<span id="countTop">총</span> 
	            	</form:form>
	            	
	            	<form name="frm" action ="<c:url value='${rootPath}/approval/approvalW.do'/>" method="post">
	            	<input type="hidden" name="templtId" value="10"/>
					
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col40" />	                    	
	                    	<col class="col60" />
	                    	<col class="col70" />
	                    	<col class="col70" />
	                    	<col class="col70" />	                    	
	                    	<col class="col70" />
	                    	<col class="col70" />
	                    	<col width="px" />
                    	</colgroup>
	                    <thead>
	                    	<tr>
	                   		<th><label><input type="checkbox" class="check" id="checkAll"/></label></th>	                    		
	                    		<th>소유자</th>
	                    		<th>회사</th>
	                    		<th>카드번호</th>
	                    		<th>승인일자</th>
	                    		<th>승인시간</th>
	                    		<th>승인금액</th>
	                    		<th class="td_last">가맹점명</th>
	                    	</tr>	                    	
	                    </thead>	                    
	                    <tbody>
	                    	<c:set var="count" value="0"/>
	                    	<c:set var="countUploaded" value="0"/>
	                    	<c:set var="countNotUploaded" value="0"/>
	                    	<c:set var="sum" value="0"/>
	                    	<c:forEach items="${resultList}" var="result">
	                    		<c:set var="count" value="${count + 1}"/>
		                    	<c:if test="${result.stat == '상신'}"><c:set var="countUploaded" value="${countUploaded + 1}"/></c:if>
		                    	<c:if test="${result.stat == '미상신'}"><c:set var="countNotUploaded" value="${countNotUploaded + 1}"/></c:if>
		                    	<c:set var="sum" value="${sum + result.approvedSpend }"/>
		                    	<tr>
			                    	<td class="txt_center">
			                    		<label><input type="checkbox" name="checkList" value="${result.cardSpendNo }" class="check"/></label>
			                    	</td>
			                    	<td class="txt_center" onmouseover="showLayer('cardLayer${result.cardSpendNo }',this)"	
			                    		onmouseout="hideLayer()" onclick="fixLayer()">
			                    		${result.userNm }
<!--										<print:user userNo="${result.userNo}" userNm="${result.userNm}"/>-->
									</td>
			                    	<td class="txt_center">${result.companyNmShort } </td>
			                    	<td class="txt_center">
<!--			                    	${result.stat } -->
			                    	${fn:substring(result.cardId,15,19)}</td>
			                    	<td class="txt_center"><print:date date="${result.approvalDt}"/> </td>
			                    	<td class="txt_center">${result.approvalTm }</td>
			                    	<td class="txt_center"><print:currency cost="${result.approvedSpend}"/> 	</td>
			                    	<td class="td_last pL10 pR5" onmouseover="showLayer('storeLayer${result.cardSpendNo }',this)" 
										onmouseout="hideLayer()" onclick="fixLayer()">
										${result.storeBusinessNm} 
									</td>			                    	
		                    	</tr>
	                    	</c:forEach>
	                    </tbody>
	                    <tfoot>
	                    	<tr>
	                    		<td class="txt_center" colspan="5">합계</td>
	                    		<td class="txt_center td_last" colspan="3"><print:currency cost="${sum}"/></td>	
	                    	</tr>
	                    </tfoot>
	                    </table>
					</div>
					</form>					
					<!--// 게시판 끝  -->
					
					<!-- 추가정보 레이어  -->
					<c:forEach items="${resultList}" var="result">					
                   		<div id="cardLayer${result.cardSpendNo }" style="display:none; z-index:5; ">
							소유자 : <print:user userNo="${result.userNo}" userNm="${result.userNm}"/> <br/>
							카드번호 : ${result.cardId} <br/>
							승인번호 : ${result.approvalNo} <br/>
<!--							CARD_SPEND 번호 : ${result.cardSpendNo }-->
						</div>								
						<div id="storeLayer사용안함${result.cardSpendNo }" style="display:none; z-index:5">
							가맹점명 : ${result.storeBusinessNm} <br/>
							업종 : ${result.storeBusinessTyp} <br/>
							주소 : ${result.storeAddress1} ${result.storeAddress2 }<br/>
							전화번호 : ${result.storePhoneNumber}										
						</div>
					</c:forEach>
					<!-- 추가정보 레이어  끝  -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
           		    	<span id="countBottom">
           		    		총 ${count } 건 / 합계 <print:currency cost="${sum}"/> 원
           		    	</span>
           		    	<input type="button" id="btnToggleOpenLayer" value="마우스오버 끄기" onclick="javascript:toggleOpenLayerBool();"/>
           		    	<a href ="javascript:approvalW(10);">
							<img src="${imagePath}/btn/btn_approvalW10.gif"/>
						</a>
						<a href ="javascript:approvalW(13);">
							<img src="${imagePath}/btn/btn_approvalW13.gif"/>
						</a>                		
               	    </div>
                 	<!-- 버튼 끝 -->
		                
					</div>
					<!-- E: section -->	
					
				</div>
				<!-- E: center -->
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
