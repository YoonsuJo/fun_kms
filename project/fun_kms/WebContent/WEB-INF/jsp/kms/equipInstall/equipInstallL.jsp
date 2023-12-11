<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;	
	document.frm.submit();
}

$(function(){
	//검색후 체크박스 선택되있게
	var searchGubun = '${eiVO.searchGubun}';
	var arrGubun = searchGubun.split("/");
	for(i=0; i<arrGubun.length; i++){
		$('input:checkbox[id="check_'+arrGubun[i]+'"]').attr('checked', true);
	}
	
	$('.btn_area img:eq(0)').click(function(){
		$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallW.do');
		$('#frm').submit();
	});

	$('#frm').keyup(function(event){
		if(event.keyCode == 13){
			$('#btn_search').trigger('click');
		}
		if(event.keyCode == 27){
			$('.check').attr('checked', false);
			$('input[name=searchPrjNm]').attr('value', '');  
			$('input[name=searchUserNm]').attr('value', '');
			$('input[name=searchSubject]').attr('value', '');
			$('#searchUserId').attr('value', '');
			$('#searchPrjId').attr('value', '');
			$('#searchGubun').attr('value', '');
			$('#arrGubun').attr('value', '');
		}
	});

	$('#btn_search').click(function(){
		//var result = $('#arrGubun').val();
		var result = '';
		$('input:checkbox[class="check"]:checked').each(function(){
			var obj = $(this).get(0);
			if(result == ''){
				result = obj.value;
			}else{
				result = result+"/"+obj.value;
			}
		});
		$('#searchGubun').attr('value', result);
		$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallL.do');
		$('#frm').submit();
	});
});
function lfn_view(installNo){
	$('#frm').attr('action', '${rootPath}/equipInstall/equipInstallV.do?installNo='+installNo);
	$('#frm').submit();
}

function lfn_popPrj(prjCode){
	//var popup = window.open("${rootPath}/cooperation/selectProjectV.do?prjId="+prjCode, "_PRJ_VIEW_","width="+screen.width+"px,height="+screen.height+"px,scrollbars=yes");
	var popup = window.open("${rootPath}/cooperation/selectProjectV.do?prjId="+prjCode, "_PRJ_VIEW_","width=1200px,height=1000px,scrollbars=yes");
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
							<li class="stitle">솔루션 납품 설치요청 관리</li>
							<li class="navi">홈 > 솔루션 납품 설치요청 관리</li>
						</ul>
					</div>
					<!-- S: section -->
					<div class="section01">
						<!-- 상단 검색창 시작 -->
						<form id="frm" name="frm" method="post">
						<input type="hidden" name="searchUserId" id="searchUserId" value="${eiVO.searchUserId}"/>
						<input type="hidden" name="searchPrjId" id="searchPrjId" value="${eiVO.searchPrjId}"/>
						<input type="hidden" name="searchGubun" id="searchGubun" value="${eiVO.searchGubun}"/>
						<input type="hidden" name="arrGubun" id="arrGubun" value="${eiVO.arrGubun}"/>						
						<input type="hidden" name="pageIndex" value="${eiVO.pageIndex}"/>						
						
		                    <div class="top_search mT20">
								<table cellpadding="0" cellspacing="0" summary="">
								<caption>상단 검색</caption>
								<colgroup>
									<col width="100px"/>
									<col width="px"/>
									<col width="90px"/>
								</colgroup>
								<tbody>
									<tr>
										<td style="text-align:right;">
											프로젝트 선택 : 
										</td>
										<td style="text-align:left;padding-left:5px;">
											<input type="text" class="span_12" name="searchPrjNm" id="searchPrjNm" readonly="readonly" onclick="prjGen('searchPrjNm','searchPrjId',1)" onfocus="prjGen('searchPrjNm','searchPrjId',1)" value="${eiVO.searchPrjNm}"/>
			                    			<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('searchPrjNm','searchPrjId',1)" />
										</td>
										<td rowspan="3" style="text-align:left;">
											<img src="../images/btn/btn_search03.gif" id="btn_search" class="cursorPointer"/>
										</td>
									</tr>
									<tr>
										<td style="text-align:right;">
											담당자 : 
										</td>
										<td style="text-align:left;padding-left:5px;">
											<input type="text" name="searchUserNm" id="searchUserNm" class="search_txt02" value="${eiVO.searchUserNm}"/>
											<!-- 
											<img src="/images/btn/btn_tree.gif" class="cursorPointer" onclick="usrGen('searchUserNm',1);"/>
											 -->
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목 : <input type="text" name="searchSubject" class="search_txt02" value="${eiVO.searchSubject}" maxlength="255" size="25"/>
										</td>
									</tr>
									<tr>
										<td style="text-align:right;">
											처리상태 :
										</td>
										<td style="text-align:left;padding-left:5px;">
											<label><input type="checkbox" class="check" id="check_0" value="0" /> 요청</label>
											<label><input type="checkbox" class="check" id="check_1" value="1" /> 접수</label>
											<label><input type="checkbox" class="check" id="check_2" value="2" /> 처리중</label>
											<label><input type="checkbox" class="check" id="check_3" value="3" /> 완료</label>
											<label><input type="checkbox" class="check" id="check_4" value="4" /> 재요청</label>
										</td>
									</tr>
								</tbody>
								</table>
		                    </div>
		                </form>
		                <!-- 상단 검색창 끝 -->
						
						<div class="boardList mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
						<caption>공지사항</caption>
						<colgroup>
							<col class="col40"/>
							<col class="col90"/>
							<col width="px" />
							<col class="col50" />
							<col class="col60" />
							<col class="col100" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">번호</th>
							<th scope="col">프로젝트코드</th>
							<th scope="col">제목</th>
							<th scope="col">담당자</th>
							<th scope="col">상태</th>
							<th scope="col">변경일시</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${!empty installList}">
							<c:forEach items="${installList}" var="element" varStatus="index">
							<tr>
								<td class="txt_center"><c:out value="${(paginationInfo.totalRecordCount) - ((eiVO.pageIndex-1) * eiVO.recordCountPerPage + index.count) + 1}"/></td>
								<td class="txt_center" title="${element.prjNm}"><a href="#" onclick="lfn_popPrj('${element.projectCode}')">${element.prjId}</a></td>
								<td class="pL10">
<!--									<a onclick="lfn_view('${element.installNo}')" href="#">-->
									<a href="${rootPath}/equipInstall/equipInstallV.do?installNo=${element.installNo}">
									<c:choose>
										<c:when test="${element.readYn == 'N'}"><span class="txt_red">${element.subject}</span></c:when>
										<c:when test="${element.readYn == 'Y'}">${element.subject}</c:when>
										<c:otherwise>${element.subject}</c:otherwise>
									</c:choose>
									</a>
								</td>
								
								<td class="txt_center"><span class="cursorPointer" onclick="openUsrLayer('${element.userNo}',this);">${element.mngNm}</span></td>
								
								<c:choose>
									<c:when test="${element.delYn == 'N'}">
										<c:if test="${element.gubunCd == '0'}"><td class="txt_center"><span class="txtB_red">요청</span></td></c:if>
				                    	<c:if test="${element.gubunCd == '1'}"><td class="txt_center"><span class="txtB_yellow">접수</span></td></c:if>
				                    	<c:if test="${element.gubunCd == '2'}"><td class="txt_center"><span class="txtB_green">처리중</span></td></c:if>
				                    	<c:if test="${element.gubunCd == '3'}"><td class="txt_center"><span class="txtB_blue">완료</span></td></c:if>
				                    	<c:if test="${element.gubunCd == '4'}"><td class="txt_center"><span class="txtB_orange">재요청</span></td></c:if>
									</c:when>
									<c:otherwise>
										<td class="txt_center"><span class="txtB_grey">삭제</span></td>
									</c:otherwise>
								</c:choose>
																
								<td class="txt_center">
									${fn:substring(fn:replace(element.regDate, '-', '.'), 0, 16)}
								</td>
							</tr>
							</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td class="txt_center" colspan="6">
									게시물이 없습니다.
								</td>
							</tr>
							</c:otherwise>
							</c:choose>
							
						</tbody>
						</table>
					</div>
					
					<!-- 페이징 시작 -->
					<div class="paginate">
	                	<ui:pagination paginationInfo="${paginationInfo}" jsFunction="search" type="image"/>
					</div>
					<!-- 페이징 끝 -->
					
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<img src="${imagePath}/btn/btn_regist.gif" class="cursorPointer"/>
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
