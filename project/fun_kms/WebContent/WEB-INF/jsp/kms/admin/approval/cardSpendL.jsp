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
		search();
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
	
	var searchStatus = '${searchVO.searchStatusStr}';
	bindSearchChkData('searchStatus', searchStatus);

	document.getElementById('countTop').innerHTML =  document.getElementById('countBottom').innerHTML;
});

//checkbox 검색데이터들을 바인딩시킨다.
function bindSearchChkData(name, data) {
	if (data=="") return;
	
	var dataList = data.split(',');
	for (var i=0; i<dataList.length; i++) {
		$('input[name='+name+'][value='+dataList[i]+']').attr('checked', true);
		//$('input[name='+name+'][value='+dataList[i]+']').click();
	}
}

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
//자르기(usrGen 으로 데이터 가져왔을때, 사용자명만 잘라내기)
function cutUsrGenName() {
	var searchKeyword = $('.search_right input[name=searchUserNm]');
	var val = searchKeyword.val();
	val = val.substring(0, val.indexOf('('));
	searchKeyword.val(val);
}
</script>
</head>

<body>
<div id="admin_wrap">
	<!-- S: container -->
	<div id="admin_container">
		<ul class="admin_container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="admin_contents">
		<%@ include file="../left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">법인카드 사용내역 관리
							<c:if test="${searchVO.searchAll == 'Y'}">(사용내역 전체)</c:if>
							<c:if test="${searchVO.searchAll != 'Y'}">(전자결재 미상신)</c:if>							
							</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<form:form commandName="searchVO" id="searchVO" name="searchVO" method="post" enctype="multipart/form-data" >
						<form:hidden path="searchYear" />
					<div class="section01">	
						
						<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
											 
							<div class="top_search mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<tbody>
								<tr>
									<td>
										<img src="${imagePath}/btn/btn_prev.gif" alt="이전 페이지" class="pL10 cursorPointer" id="searchYearPrev" onclick="search(-1);"/>
														${searchVO.searchYear}년 
										<img src="${imagePath}/btn/btn_next.gif" alt="다음 페이지" class="pL10 cursorPointer" id="searchYearNext" onclick="search(1);"/>								
										<c:forEach begin="1" end="12" varStatus="status">
											<form:radiobutton path="searchMonth" label="${status.count}월" value="${status.count}" onclick="search()"/>
											&nbsp;
										</c:forEach>
									</td>
								</tr>
								<tr>
									<td class="search_right">
										<!-- 
										<label><span class="">전체 사용내역</span>
										<input type="checkbox" name="searchAll" class="cursorPointer check" value="Y" onclick="search()"
										 -->
										<label><input type="checkbox" name="searchStatus" class="cursorPointer check" value="3" />미상신&nbsp;</label>
										<label><input type="checkbox" name="searchStatus" class="cursorPointer check" value="1" />결재중&nbsp;</label>
										<label><input type="checkbox" name="searchStatus" class="cursorPointer check" value="2" />완료&nbsp;</label>
										<label>카드번호</label> 
										<form:input path="searchCardId" cssClass="input01 span_5"  />
										<label>사용자</label>
										<form:input path="searchUserNm" cssClass="input01 span_10 userNamesAuto" />
										<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm', 0);">
										<input type="image" src="${imagePath}/btn/btn_search02.gif" class="search_btn02 cursorPointer" alt="검색" id="searchB"/>
										<!-- <input type="image" src="${imagePath}/btn/btn_allview.gif" class="search_btn02 cursorPointer" alt="전체보기" id="showAllB"/> -->
									</td>
								</tr>
							</tbody>
							</table>
						</div>
									
						</fieldset>
						<!--// 상단 검색창 끝 -->
						소유자 마우스오버 : 카드 상세정보 조회 / 가맹점 마우스오버 : 가맹점 상세정보 조회 / 클릭 : 상세정보창 고정<br/>	
						<span id="countTop">하단 버튼 좌측에 데이터 개수, 합계 계산한 데이터를 페이지 로드 후에 이곳에 복사</span> 
									
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
									<col class="col70" />
									<col width="px" />
								</colgroup>
								<thead>
									<tr>
									<th><label><input type="checkbox" class="check" id="checkAll"/></label></th>	                    		
										<th>소유자</th>
										<th>회사</th>
										<th>상태</th>
										<th>상신일자</th>
										<th>승인일자</th>
										<th>승인시간</th>
										<th>승인금액</th>
										<th class="td_last">가맹점명</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="count" value="0"/>
									<c:set var="countStatus1" value="0"/><!-- 결재중 -->
									<c:set var="countStatus2" value="0"/><!-- 완료 -->
									<c:set var="countStatus3" value="0"/><!-- 미상신 -->
									<c:set var="sumSpend" value="0"/>
									<c:forEach items="${resultList}" var="result">
										<!-- 합계 계산 -->
										<c:set var="count" value="${count + 1}"/>
										<c:choose>
											<c:when test="${result.status == 1}"><c:set var="countStatus1" value="${countStatus1 + 1}"/></c:when>
											<c:when test="${result.status == 2}"><c:set var="countStatus2" value="${countStatus2 + 1}"/></c:when>
											<c:when test="${result.status == 3}"><c:set var="countStatus3" value="${countStatus3 + 1}"/></c:when>
										</c:choose>
										<c:set var="sumSpend" value="${sumSpend + result.approvedSpend}"/>
										
										<!-- 데이터 출력 -->
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

												<c:choose>
													<c:when test="${result.status == 1}">결재중</c:when>
													<c:when test="${result.status == 2}">완료</c:when>
													<c:when test="${result.status == 3}">미상신</c:when>
												</c:choose>
											</td>
											<td class="txt_center"><print:date date="${result.docDt}"/></td>
											<td class="txt_center"><print:date date="${result.approvalDt}"/></td>
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
										<td class="txt_center" colspan="6">합계</td>
										<td class="txt_center td_last" colspan="3"><print:currency cost="${sumSpend}"/></td>	
									</tr>
								</tfoot>
							</table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 추가정보 레이어  -->
						<c:forEach items="${resultList}" var="result">					
							<div id="cardLayer${result.cardSpendNo }" style="display:none; z-index:5; ">
								소유자 : <print:user userNo="${result.userNo}" userNm="${result.userNm}"/> <br/>
								카드번호 : ${result.cardId} <br/>
								승인번호 : ${result.approvalNo} <br/>
	<!--									CARD_SPEND 번호 : ${result.cardSpendNo }-->
							</div>								
							<div id="storeLayer${result.cardSpendNo }" style="display:none; z-index:5">
								가맹점명 : ${result.storeBusinessNm} <br/>
								업종 : ${result.storeBusinessTyp} <br/>
								주소 : ${result.storeAddress1} ${result.storeAddress2 }<br/>
								전화번호 : ${result.storePhoneNumber}
							</div>
						</c:forEach>
						<!-- 추가정보 레이어  끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<span id="countBottom">${searchVO.searchYear }년 ${searchVO.searchMonth }월 /
								총 ${count } 건 / 미상신 : ${countStatus3} 건 / 결재중 : ${countStatus1} 건 / 완료 : ${countStatus2} 건 / 합계 <print:currency cost="${sumSpend}"/> 원
							</span>
							<input type="button" id="btnToggleOpenLayer" value="마우스오버 끄기" onclick="javascript:toggleOpenLayerBool();"/>
							<a href="/admin/approval/writeCardSpendExcel.do">
								<img src="${imagePath}/btn/btn_excelSave.gif"/>
							</a>
							<img src="${imagePath}/btn/btn_delete.gif" class="cursorPointer" id="deleteB"/>
						</div>
						<!-- 버튼 끝 -->

					</div>
					<!-- E: section -->	
					</form:form>
				</div>
				<!-- E: center -->
			</div>	
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
