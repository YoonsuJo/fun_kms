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
					<!-- s: game&download_section -->
					<div class="gnd_section">
						<!-- s: game -->
						<div class="gnd_left">
							<!-- s: title -->
							<div class="gnd_title">
                               <p class="th_stitle">한마음게임 </p>
							</div>
							<!-- e: title -->
							
							<!-- s: banner  -->
							<div class="banner_box">
								<ul>
								<li><a href="#"><img src="../images/community/game_banner.gif"/></a></li>
								<li class="txt">총 4단계별로 추출된 사진을 보고</br><span class="fc_b">한마음 가족을 맞추는 게임</span>입니다.</br>한마음 게임으로 한마음 한마음지수를 높이세요!</li>
								</ul>
							</div>
							<!-- e: banner -->
						</div>
						<!-- e: game -->
						
						<!-- s: download -->
						<div class="gnd_right">
							<!-- s: title -->
							<div class="gnd_title">
                               <p class="th_stitle">다운로드 </p>
							</div>
							<!-- e: title -->
							
							<!-- s: banner  -->
							<div class="banner_box">
								<ul>
								<li><a href="#"><img src="../images/community/ss_banner.gif"/></a></li>
								<li class="txt"><b>우리는 한마음! 한마음 한뜻으로!!</b><br />한마음 가족을 위한 스크린세이버 입니다. <br />다운로드하시고 많은 이용한 바랍니다.</li>
								</ul>
							</div>
							<!-- e: banner -->
						</div>
						<!-- e: download -->
					</div>
					<!-- e: game&download_section -->

									
                       <!-- s: hughug section -->
                       <div class="hug_section">
                           <!-- s: title -->
                           <div class="hug_title">
                               <div class="th_stitle_left"><span class="hug_bf">허그허그</span><span class="view_btn"><a href="http:naver.com">더보기</a></span></div>
                           </div>
						<!-- e: title -->
						<!-- s: photo list -->
                           <div class="photo_list">
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
                           </div>
						<!-- e: photo list -->
                       </div>
                       <!-- e: hughug section -->
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
