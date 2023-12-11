<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
function search(pageNo) {
	document.frm.pageIndex.value = pageNo;
	document.frm.action = "<c:url value='${rootPath}/community/selectBoardList.do'/>";
	document.frm.submit();	
}

function view(nttId, bbsId, readBool) {
	document.subForm.nttId.value = nttId;
	document.subForm.bbsId.value = bbsId;
	document.subForm.readBool.value = readBool;
	document.subForm.action = "<c:url value='${rootPath}/community/selectBoardArticle.do'/>";
	document.subForm.submit();
}
function selRadio(i) {
	if (i == 2) {
		document.frm.searchWrd.className = "search_txt02 userNameAuto";
	}
	else {
		document.frm.searchWrd.className = "search_txt02";
	}
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
			<div id="center" style="padding-bottom:80px">
			<div class="path_navi_open">
					<ul>
						<li class="stitle">커뮤니티</li>
						<li class="navi">홈 > 커뮤니티 > 커뮤니티현황</li>
					</ul>
				</div>
				
				<span class="stxt">우리는 한마음! 한마음 한뜻으로!! - 2012년 한마음 캠페인 기간</span>
				
				<!-- s: hm_container -->
					<div id="hm_container">
					
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<thead></thead>
							<tbody>
								<tr>
									<td background="../../images/community/title_hughug_bg.gif"><img src="../../images/community/title_hughug_left.gif"></td>
									<td align="center" background="../../images/community/title_hughug_bg.gif"><img src="../../images/community/title_hughug_cont.gif"></td>
									<td><img src="../../images/community/title_hughug_right.gif"></td>
								</tr>
							</tbody>
						</table>
						
						<div class="hm_search">
						
						<form name="frm" action ="<c:url value='${rootPath}/community/selectBoardList.do'/>" method="post">
							<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
							<input type="hidden" name="nttId"  value="0" />
							<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
							<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
						
							<!-- 상단 검색창 시작 -->
							<div class="bot_search_02" style="border:1px solid #d7d7d7;">
								<ul>
									<li class="option_txt">제목<span class="pL7"></span><input type="radio" name="search" value="employee"><span class="pL7"></span>제목+내용<span class="pL7"></span><input type="radio" name="search" value="information" checked>작성자<span class="pL7"></span><input type="radio" name="search" value="information" checked></li>
									<li class="search_box"><input type="text" name="search_txt" class="search_txt02"/></li>
									<li><img src="../images/btn/btn_search02.gif" alt="검색"/></li>
									<p style="padding-bottom:10px;"></p>
									<li class="bs_class">부서&nbsp;<input type="text"  class="input01 span_9"/> <input type="image" src="../../images/btn/btn_tree.gif" class="search_btn02" /></li>
									<li></li>
									<li><select name="approvalForm" style="width:150px;"><option>Since 2012</option><option>Since 2011</option><option>Since 2010</option><option>Since 2009</option></select></li>
								</ul>
							</div>
							<!-- 상단 검색창 끝 -->
							
						</form>
						
						</div>
                        <!-- s: hughug section -->
                        <div class="hug_section pB20">
							<!-- s: photo list -->
                            <div class="photo_list">
                            	<c:forEach items="${resultList}" var="result" varStatus="c">
                            	<ul class="photo_box01<c:if test='${c.count % 4 == 0}'>_last</c:if>">
                                	<li class="img_box">
                                		<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" value="${result.atchFileId}" />
											<c:param name="param_width" value="157" />
											<c:param name="param_height" value="112" />
										</c:import>
                                	</li>
                                    <li>${result.nttSj} <span>[${result.commentCount}]</span></li>
                                    <li class="sub_text"><print:user userNo="${result.frstRegisterId}" userNm="${result.ntcrNm}" userId="${result.ntcrId}" />  <print:date date="${result.frstRegisterPnttm}" />  view ${result.inqireCo}</li>
                                </ul>
                            	</c:forEach>
                            	<ul class="photo_box01">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
                                <ul class="photo_box01">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
                                <ul class="photo_box01">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한&nbsp;2012-07-04&nbsp;view 250</li>
                                </ul>
                                <ul class="photo_box01_last" >
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
								<ul class="photo_box02">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
                                <ul class="photo_box02">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
                                <ul class="photo_box02">
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한&nbsp;2012-07-04&nbsp;view 250</li>
                                </ul>
                                <ul class="photo_box02_last" >
                                	<li class="img_box"></li>
                                    <li>워크샵 사진입니다. <span>[5]</span></li>
                                    <li class="sub_text">이용한  2012-07-04  view 250</li>
                                </ul>
                            </div>
							<!-- e: photo list -->
                        </div>
                        <!-- e: hughug section -->

						<!-- 페이징 시작 -->
						<div class="paginate pT10">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="search" />
						</div>
						<!-- 페이징 끝 -->
						
						<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectBoardArticle.do'/>">
							<input type="hidden" name="bbsId" />
							<input type="hidden" name="nttId" />
							<input type="hidden" name="readBool" />
							<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
							<input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
							<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
						</form>
						
						<!-- 버튼 시작 -->
	           		    <div class="btn_area">
	                		<a href="${rootPath}/community/imageW.do"><img src="${imagePath}/btn/btn_regist.gif"/></a>
	               	    </div>
	                 	<!-- 버튼 끝 -->

                    </div>
					<!-- e: hm_container -->
					
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
