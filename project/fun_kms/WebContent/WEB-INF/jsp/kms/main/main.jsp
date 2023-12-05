<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<link rel="stylesheet" href="${commonPath}/css/main.css" type="text/css" media="all" />
<script>
/*아침인사
if('${user.orgnztId}' == 'ORGAN_00000000000151' || '${user.orgnztId}' == 'ORGAN_0000000000019' || '${user.orgnztId}' == 'ORGAN_00000000000004 ' || '${user.isAdmin}' == 'Y'){
}
*/
	
	/*
	var where = "${user.isInnerNetworkPrint}";
	var date = new Date();
   	var hours = date.getHours();	
   	
   	if(hours > 6 && hours < 18){   	
	    if('${goodmorning.id}' == '' && where == '본사'){
			var popup = window.open("${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000082&param_returnUrl=<c:url value='${rootPath}/statusBoard.do'/>","_GOODMORNING_POP_","width=600px,height=270px,scrollbars=no,resizable=no");
			popup.focus();
		}else if('${goodmorning.readBool}' == 'N' && where == '본사'){
			var popup = window.open("${rootPath}/community/selectBoardArticle.do?bbsId=BBSMSTR_000000000082&nttId=${goodmorning.id}&readBool=${goodmorning.readBool}","_GOODMORNING_POP_","width=600px,height=390px,scrollbars=no,resizable=no");
			popup.focus();
		}
 	}
   	*/

$(document).ready(function() {

	$(".cAlpha").hide();
	$(".popup_div").hide();
	$(".cAlpha2").hide();
	$(".popup_div2").hide();
	$(".main_pop_display").hide();
	
	var where = "${user.isInnerNetworkPrint}";
	var date = new Date();
   	var hours = date.getHours();
   	
   	if(hours >= 6 && hours < 18){
		if('${goodmorning.id}' == '' && where == '본사' ){
			if(hours < 9){
				$(".main_pop_display").show();
				$(".cAlpha2").show();
				$(".popup_div2").show();
		    	
				$(function(){	
					$('.popup_div2').css({top:'50%',left:'50%',margin:'-'+($('.popup_div').height() / 2)+'px 0 0 -'+($('.popup_div').width() / 2)+'px'});
	
					$(".cAlpha2").click(function(){
						$(".main_pop_display").hide();
						$(".cAlpha2").hide();
						$(".popup_div2").hide();
						
					});
					$(".greeting_close").click(function(){
						$(".main_pop_display").hide();
						$(".cAlpha2").hide();
						$(".popup_div2").hide();
						
					});
				});
			}
			//var popup = window.open("${rootPath}/community/addBoardArticle.do?bbsId=BBSMSTR_000000000082&param_returnUrl=<c:url value='${rootPath}/statusBoard.do'/>","_GOODMORNING_POP_","width=600px,height=270px,scrollbars=no,resizable=no");
			//popup.focus();
		} else if ('${goodmorning.readBool}' == 'N' && where == '본사'){
			$(".main_pop_display").show();
			$(".cAlpha").show();
			$(".popup_div").show();
			$('.popup_div').css({top:'50%',left:'50%',margin:'-'+($('.popup_div').height() / 2)+'px 0 0 -'+($('.popup_div').width() / 2)+'px'});
			
			$(function(){
				$(".cAlpha").click(function(){
					$(".main_pop_display").hide();
					$(".cAlpha").hide();
					$(".popup_div").hide();
				});
				$(".greeting_close").click(function(){
					$(".main_pop_display").hide();
					$(".cAlpha").hide();
					$(".popup_div").hide();
				});
			});
		}
 	}
   	
 	// 미투입 인력 메시지
	if ("${noInput}" == "Y") {
		window.setTimeout(function (a, b) {	// [20140703, 김동우] 아침인사 레이어가 뜨기도 전에 메세지창에 떠서, 딜레이처리
			alert("이번 달 나의업무에 등록된 실적이 0시간입니다.\n실적을 등록해주세요.");
		}, 1000);
	}
 	
	//$().jSnow({ flakeColor: ["#ECECEC"], flakeMaxSize: 30, flakes: 100});
});

function replyNote(receiverNo) {
	$(".main_pop_display").hide();
	$(".cAlpha").hide();
	$(".popup_div").hide();
	
	window.open("${rootPath}/community/sendNoteView.do?recieverNo="+receiverNo+"&replyType=goodmo", 
			"_receive_note_", "width=510px,height=500px,scrollbars=no,resizable=no");
}

function register() {
	var nttSj = document.board.nttSj.value;
	
	if(nttSj == ""){
		alert("아침 인사를 입력해 주세요.");
		return;
	}else{
		document.board.action = "<c:url value='${rootPath}/community/insertBoardArticle.do'/>";
		document.board.submit();
	}
}

function noticeShow(num) {
	for (var i=1; i<=3; i++) {
		if (i == num) {
			document.getElementById("n_img_" + i).src = "${imagePath}/main/menu1_" + i + "_on.gif";
			document.getElementById("notice" + i).style.display = "";
		}
		else {
			document.getElementById("n_img_" + i).src = "${imagePath}/main/menu1_" + i + "_off.gif";
			document.getElementById("notice" + i).style.display = "none";
		}
	}
}
function communityShow(num) {
	for (var i=1; i<=4; i++) {
		if (i == num) {
			document.getElementById("c_img_" + i).src = "${imagePath}/main/menu2_" + i + "_on.gif";
			document.getElementById("community" + i).style.display = "";
		}
		else {
			document.getElementById("c_img_" + i).src = "${imagePath}/main/menu2_" + i + "_off.gif";
			document.getElementById("community" + i).style.display = "none";
		}
	}
}
function eventShow(num) {
	for (var i=1; i<=2; i++) {
		if (i == num) {
			document.getElementById("e_txt_" + i).className = "txtOB";
			document.getElementById("event" + i).style.display = "";
		}
		else {
			document.getElementById("e_txt_" + i).className = "";
			document.getElementById("event" + i).style.display = "none";
		}
	}
}
function view(nttId,bbsId,readBool,path) {
	document.mailFrm.nttId.value = nttId;
	document.mailFrm.bbsId.value = bbsId;
	document.mailFrm.readBool.value = readBool;
	document.mailFrm.action = "${rootPath}/" + path + "/selectBoardArticle.do";
	document.mailFrm.submit();
}
</script>
</head>

<body onload="initTopMenu();">
<form name="goodmorningFrm" method="POST">
	<input type="hidden" name="nttId"/>
	<input type="hidden" name="bbsId"/>
	<input type="hidden" name="readBool"/>
</form>

<form name="frm" method="post" enctype="multipart/form-data" >
	<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
	<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>"/>
	<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>"/>
	<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>"/>
	<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>"/>
	<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>"/>
	<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>"/>
	<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>"/>
	<input type="hidden" name="exChk" value="<c:out value='${result.exChk}'/>"/>
</form>

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
					<!-- S: section -->
					<div class="section">
					
						<!-- S: Left -->
	                    <div class="main_left">
							<!-- S: 텝게시판 01 -->
							<div class="board_group">
								<ul class="board_tab">
									<p class="sec_title mB10">알립니다</p>
									<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000033" onmouseover="noticeShow(3);"><img id="n_img_3" src="${imagePath}/main/menu1_3_off.gif" alt="알림공지" /></a></li>
									<li><a href="${rootPath}/support/selectBoardList.do?bbsId=BBSMSTR_000000000031" onmouseover="noticeShow(2);"><img id="n_img_2" src="${imagePath}/main/menu1_2_off.gif" alt="공지사항" /></a></li>
									<li><img id="n_img_1" src="${imagePath}/main/menu1_1_on.gif" alt="미열람" onmouseover="noticeShow(1);"/></li>
								</ul>
                                <!-- 미열람 시작-->
								<ul class="list01" id="notice1">
									<c:if test="${empty sprtUnread}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${sprtUnread}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','support');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--미열람끝-->
								<!--공지사항 시작-->
								<ul class="list01" id="notice2" style="display:none;">
									<c:if test="${empty notice}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${notice}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','support');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--공지사항 끝-->
                                 <!--알림공지 시작-->
								<ul class="list01" id="notice3" style="display:none;">
									<c:if test="${empty noticeNotice}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${noticeNotice}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','support');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
                                 <!--알림공지 끝-->
							</div>
	                        <!-- E:  텝게시판 01 -->
                            <!-- 신규입사자 -->
							<div class="newPR">
								<div class="newP">
									<ul class="newP_box">
										<li class="box_left"><img src="${imagePath}/main/Oleft.gif" /></li>
										<li class="box_center">
											<ul class="sec_title02">
												<li class="mtitle02">신규입사자 </li>
												<li class="main_plus"><a href="${rootPath}/member/selectMemberList.do?orderBy=new"><img src="${imagePath}/main/plus_orange.gif"/></a></li>
											</ul>
											<div class="newP_list">
												<c:forEach items="${newMember}" var="nM">
													<ul class="list_bunch">
														<li class="group">${nM.compinDtPrint}</li>
														<li class="photo">
															<a href="${rootPath}/member/selectMemberMain.do?no=${nM.no}">
												    			<c:choose>
				                    								<c:when test="${empty nM.picFileId || nM.picFileId == ''}">
				                    									<c:choose>
						                    								<c:when test="${empty nM.picFileId2 || nM.picFileId2 == ''}">
						                    									<img src="${imagePath}/main/noimg.gif" alt="${nM.userNm}">
						                    								</c:when>
						                    								<c:otherwise>
						                    									<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
																					<c:param name="param_atchFileId" value="${nM.picFileId2}" />
																					<c:param name="param_width" value="94" />
																					<c:param name="param_height" value="125" />
																				</c:import>
						                    								</c:otherwise>
						                    							</c:choose>
				                    								</c:when>
				                    								<c:otherwise>
				                    									<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
																			<c:param name="param_atchFileId" value="${nM.picFileId}" />
																			<c:param name="param_width" value="94" />
																			<c:param name="param_height" value="125" />
																		</c:import>
				                    								</c:otherwise>
				                    							</c:choose>
															</a>
														</li>
														<li class="T11">${nM.orgnztNm}</li>
														<li class="name"><print:user userNo="${nM.userNo}" userNm="${nM.userNm}"/> <c:out value="${nM.rankNm}" /></li>
													</ul>
												</c:forEach>
											</div>
										</li>	
										<li class="box_right"><img src="${imagePath}/main/Oright.gif" /></li>
									</ul>	
								</div>
							</div>
							<!-- // 신규입사자 끝 -->
							
							<div class="mainList02">
								<p class="sec_title mB10">채용현황 <span class="th_plus"><a href="${rootPath}/support/selectRecruitList.do">더보기</a></span></p>
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
									<caption>채용현황</caption>
									<colgroup><col class="col5" /><col width="px" /><col width="px" /><col class="col5" /></colgroup>
									<thead>
										<tr>
											<th scope="col" class="th_left"></th>
											<th scope="col">채용부서</th>
											<th scope="col">담당업무</th>
											<th scope="col" class="th_right"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${jobgList}" var="job">
											<tr>
												<td colspan="2" class="txt_b pL5" >${job.orgnztNm }</td>
												<td class="pL5" colspan="2"><a href="${rootPath}/support/selectRecruitArticle.do?docId=${job.docId}">${job.mngTsk}</a></td>
											</tr>
										</c:forEach>
										<c:if test="${empty jobgList}">
											<tr>
												<td colspan="4" class="txt_center">채용요청건이 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
							<div>
								<ul class="board_bottomImg" >
									<li class="box_left"><img src="${imagePath}/main/tdB_left.gif" /></li>
									<li class="box_right"><img src="${imagePath}/main/tdB_right.gif" /></li>
								</ul>
							</div>
							
						</div>
                        <!-- E: Left -->
                        
                        <!-- S: Right -->
						<div class="main_right">
							<!-- S: 텝게시판 02 -->
							<div class="board_group02">
								<ul class="board_tab">
									<p class="sec_title mB10">최근게시물</p>
									<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000030" onmouseover="communityShow(4);"><img id="c_img_4" src="${imagePath}/main/menu2_4_off.gif" alt="경조사" /></a></li>
									<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000029" onmouseover="communityShow(3);"><img id="c_img_3" src="${imagePath}/main/menu2_3_off.gif" alt="토론" /></a></li>
									<li><a href="${rootPath}/community/selectBoardList.do?bbsId=BBSMSTR_000000000001" onmouseover="communityShow(2);"><img id="c_img_2" src="${imagePath}/main/menu2_2_off.gif" alt="자유게시판" /></a></li>
									<li><a href="${rootPath}/community/selectUnreadBoardList.do" onmouseover="communityShow(1);"><img id="c_img_1" src="${imagePath}/main/menu2_1_on.gif" alt="미열람" /></a></li>
								</ul>
								<!-- 미열람 시작-->
								<ul class="list01" id="community1">
									<c:if test="${empty commUnread}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${commUnread}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','community');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--미열람끝-->
								<!--자유게시판 시작-->
								<ul class="list01" id="community2" style="display:none;">
									<c:if test="${empty free}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${free}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','community');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--자유게시판 끝-->
								<!--토론 시작-->
								<ul class="list01" id="community3" style="display:none;">
									<c:if test="${empty discuss}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${discuss}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','community');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--토론 끝-->
								<!--경조사 시작-->
								<ul class="list01" id="community4" style="display:none;">
									<c:if test="${empty schedule}">
										<li>게시물이 없습니다.</li>
									</c:if>
									<c:forEach items="${schedule}" var="l">
										<li>
											<a href="javascript:view('<c:out value="${l.nttId}"/>','<c:out value="${l.bbsId}"/>','<c:out value="${l.readBool}"/>','community');"
												<c:if test="${l.readBool != 'Y'}">class="ared"</c:if>>${l.nttSjShort} <span class="txt_reply">[<c:out value="${l.commentCount}"/>]</span></a>
											<span class="board_name"><print:user userNo="${l.frstRegisterId}" userNm="${l.ntcrNm}"/></span>
											<span class="date"><c:out value="${l.frstRegisterPnttm}"/></span>
										</li>
									</c:forEach>
								</ul>
								<!--경조사 끝-->
							</div>
							<!-- E:  텝게시판 02 -->
							<div class="cRightBg">
								<div class="cRightTopBg">
									<!-- 기념일 -->
									<div class="">
										<ul class="sec_title02">
											<li class="mtitle">기념일</li>
										</ul>
										<div class="Lcon" style="text-align:left !important;">
											<span id="e_txt_1" class="txtOB" onmouseover="eventShow(1)" style="cursor:pointer" 
											onclick="location.href='${rootPath}/member/selectMemberList.do?orderBy=birth'">생일</span>
											|
											<span id="e_txt_2" onmouseover="eventShow(2)" style="cursor:pointer" 
											onclick="location.href='${rootPath}/member/selectMemberList.do?orderBy=enter'">입사일</span>
											<div class="mainList">
												<table cellpadding="0" cellspacing="0" summary="기념일" id="event1">
													<colgroup><col class="col20"><col class="col40"><col width="px"></colgroup>
													<tbody>
														<c:forEach items="${birth}" var="brth">
															<tr>
																<td><img src="${imagePath}/main/icon_birth.gif"/></td>
																<td><print:user userNo="${brth.no}" userNm="${brth.userNm}"/></td>
																<td>${brth.brthPrint}(${brth.greLunPrint})</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
												<table cellpadding="0" cellspacing="0" summary="입사일" id="event2" style="display:none;">
													<colgroup><col class="col20"><col class="col40"><col width="px"></colgroup>
													<tbody>
														<c:forEach items="${enter}" var="entr">
															<tr>
																<td><img src="${imagePath}/main/icon_birth.gif"/></td>
																<td><print:user userNo="${entr.no}" userNm="${entr.userNm}"/></td>
																<td>${entr.compinDtPrint}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
												
										</div>
									</div>
									<!--// 기념일 -->
									
									<!-- 랭킹보기 -->
									<%-- <div class="cRightR">
										<ul class="sec_title02">
											<li class="mtitle">한마음지수 랭킹</li>
											<li class="main_plus02"><a href="javascript:openLink('${rootPath }/main/rankList.do', 'Y', 'POP_RANK', '946', '864');"><img src="${imagePath}/main/plus_blue02.gif"/></a></li>
										</ul>
										<div class="Rcon">
											<p class="txtOB">나의업무 및 게임 외</p>
											<div class="mainList">
												<table cellpadding="0" cellspacing="0" summary="나의업무">
												<colgroup><col class="col20"><col class="col30"><col class="col40"><col width="px"></colgroup>
												<tbody>
													<c:forEach items="${totalList}" var="score">
														<c:if test="${score.on == '1'}">
															<tr>
																<td><img src="${imagePath}/main/icon_lank.gif"/></td>
																<td>${score.rank}위</td>
																<td><print:user userNo="${score.userNo}" userNm="${score.userNm}"/></td>
																<td>${score.totalPoint}</td>
															</tr>
														</c:if>
													</c:forEach>
												</tbody>
												</table>
											</div>
										</div>
									</div> --%>
									<!--// 랭킹보기 -->
								</div>
								<div class="mainList03">
									<p class="sec_title mB10">수주현황 <span class="th_plus"><a href="${rootPath}/management/contractL.do?searchTyp=W">더보기</a></span></p>
									<table cellpadding="0" cellspacing="0" summary="각 게시물의 번호,제목,작성자,등록일,첨부,조회를 볼수 있고 제목 링크를 통해서 게시물 상세 내용으로 이동합니다.">
										<caption>수주현황</caption>
										<colgroup>
											<col class="col5" />
											<col class="col80" />
											<col width="px" />
											<col class="col100" />
											<col class="col5" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col" class="th_left"> </th>
												<th scope="col" >계약일</th>
												<th scope="col">계약명</th>
												<th scope="col">부서</th>
												<th scope="col" class="th_right"> </th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty cntgList}">
												<tr>
													<td colspan="5" class="txt_center">수주내역이 없습니다.</td>
												</tr>
											</c:if>
											<c:forEach items="${cntgList}" var="cnt">
												<tr>
													<td colspan="2" class="txt_b pL5 txt_center" >
														<c:choose>
														<c:when test="${cnt.contractDate != ''}">
															<print:date date='${cnt.contractDate}' printType='S' />
														</c:when>
														<c:otherwise>
															&nbsp;
														</c:otherwise>
														</c:choose>
													</td>

				 
													<td class=""><a href="${rootPath}/management/contractV.do?contractNo=${cnt.contractNo }">
														 <c:set var="length" value="${fn:length(cnt.sj)}"/>
														 <c:if test="${length > 12}">
														 ${fn:substring(cnt.sj,0,12)}..
														 </c:if>
														 <c:if test="${length <= 12}">
														 ${cnt.sj}
														 </c:if>
													</a></td>
													<td colspan="2" class="pL5">
													 <c:set var="length" value="${fn:length(cnt.orgnztNm)}"/>
													 <c:if test="${length > 7}">
													 ${fn:substring(cnt.orgnztNm,0,7)}..
													 </c:if>
													 <c:if test="${length <= 7}">
													 ${cnt.orgnztNm}
													 </c:if>													
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div>
									<ul class="board_bottomImg02" >
										<li class="box_left"><img src="${imagePath}/main/tdB_left.gif" /></li>
										<li class="box_right"><img src="${imagePath}/main/tdB_right.gif" /></li>
									</ul>
								</div>
							</div>
                      		
							<form name="mailFrm" method="POST">
								<input type="hidden" name="nttId"/>
								<input type="hidden" name="bbsId"/>
								<input type="hidden" name="readBool"/>
							</form>
						</div>
						<!-- E: Right -->
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

<!-- popup display -->
<div class="clear main_pop_display" style="position: absolute;top:0;left:0;width:100%;height:100%;z-index:200;display:block;">
	<!-- View -->
	<div class="cAlpha"></div>
	<div class="clear popup_div">
		<div class="greeting_close">
			<img src="${imagePath}/goodmorning/btn_pop_close.png" alt="닫기"/>
		</div>
		<div class="greeting_div">
			<div class="greeting_left">
				<img src="${imagePath}/goodmorning/bg_greeting_ttl.png" alt="한마음아침인사"/>
			</div>
			<div class="greeting_right">
				<div class="greeting_right_z">
					<p class="g_ttl">${writerVO.userNm}
						<span class="g_ttl02">${writerVO.rankNm}</span>
						<span class="g_time">${fn:substring(result.frstRegisterPnttm,10,16)}</span>
					</p>
					<p class="g_blue">${writerVO.orgnztNm}</p>
					<p class="g_con">
						${result.nttSj}
					</p>
				</div>
				<div class="greeting_img">
				<!-- <img src="${imagePath}/goodmorning/test.png" alt="test"/> -->
					<c:choose>
						<c:when test="${empty writerVO.picFileId || writerVO.picFileId == ''}">
							<img src="${imagePath}/inc/img_no_photo.gif" alt="소개사진 없음"/>
						</c:when>
						<c:otherwise>
							<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${writerVO.picFileId}" />
							<c:param name="param_width" value="90" />
							<c:param name="param_height" value="120" />
						</c:import>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<c:choose>
			<c:when test="${checkList.myTaskFive == '0' && checkList.busiCntctFive == '0' && checkList.acceptFive == '0' &&checkList.referenceFive == '0'}">
				<!-- 미열람 업무가 없을때 -->
				<div class="greeting_none" style="display:block">
					5일이상 미열람(미처리) 중인 업무가 없습니다
				</div>
				<!-- //미열람 업무가 없을때 -->
			</c:when>
			<c:otherwise>
				<!-- 미열람 업무가 있을때 -->
				<div class="greeting_block" style="display:block">
					<ul>
						<li class="g_red">
							5일 이상 미열람(미처리) 중인 업무
						</li>
						<li class="g_state03">
							<span>나의<br/>업무</span>
							<span class="gnum"><a href="javascript:open('${rootPath}/cooperation/selectDayReportMyList.do');">${checkList.myTaskFive}</a></span>
						</li>
						<li class="g_state">
							<span>업무<br/>연락</span>
							<span class="gnum"><a href="javascript:open('${rootPath}/cooperation/selectBusinessContactList.do');">${checkList.busiCntctFive}</a></span>
						</li>
						<li class="g_state02">
							<span>전자<br/>결재</span>
							<span class="gnum"><a href="javascript:open('${rootPath}/approval/approvalL.do?mode=2');">${checkList.acceptFive}</a>,<a href="javascript:open('${rootPath}/approval/approvalL.do?mode=12');">${checkList.referenceFive}</a></span>
						</li>
					</ul>
				</div>
				<!-- //미열람 업무가 있을때 -->
			</c:otherwise>
			</c:choose>
		</div>
		<div class="greeting_btn">
			<a href="javascript:replyNote('${writerVO.userNo}');" class="btn"><img src="${imagePath}/goodmorning/btn_greeting_add.png" alt="한마음아침인사"/></a>
		</div>	
	</div>
	
	<!-- Add -->
	<form commandName="commBoard" name="board" method="post" enctype="multipart/form-data" >
	<!-- <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/> -->
	<input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
	<input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
	<input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
	<input type="hidden" name="exDt" value="<c:out value='99991231'/>" />
	<input type="hidden" name="exHm" value="<c:out value='${result.exHm}'/>" />						
	<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
	<input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
	<input type="hidden" name="param_returnUrl" value="<c:out value='main.do'/>" />

<script>
/* 
* 스크립트 단
*/
function fnChkByte(obj, maxByte){
	var str = obj.value;
	var str_len = str.length;
	
	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";
	
	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		if(escape(one_char).length > 4){
		    rbyte += 2;                                         //한글2Byte
		}else{
		    rbyte++;                                            //영문 등 나머지 1Byte
		}
		
		if(rbyte <= maxByte){
		    rlen = i+1;                                          //return할 문자열 갯수
		}
	}
	
	if(rbyte > maxByte){
	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnChkByte(obj, maxByte);
	}else{
	    document.getElementById('byteInfo').innerText = rbyte;
	}
}

</script>

	<div class="cAlpha2"></div>
	<div class="clear popup_div2">
		<div class="greeting_close">
			<img src="${imagePath}/goodmorning/btn_pop_close.png" alt="닫기"/>
		</div>	
		<div class="greeting_div">
			<div class="greeting_left">
				<img src="${imagePath}/goodmorning/bg_greeting_ttl.png" alt="한마음아침인사"/>
			</div>
			<div class="greeting_right">
				<div class="greeting_right_add">
					<p class="g_add_ttl">오늘의 한마음 첫 출근자입니다.<br/>
한마음 임직원에게 아침인사를 남겨주세요.
					</p>
					<p class="g_add_p">
						<span class="g_add_p01">아침인사는 최대 150자까지 남기실 수 있습니다.</span> 
						<span class="g_count">[ <span id="byteInfo">0</span> / 150 byte ]</span>
					</p>
					<textarea class="g_txt" name="nttSj" id="nttSj" onKeyUp="javascript:fnChkByte(this,'150')"></textarea>
				</div>
			</div>
		</div>
		<div class="greeting_btn02">
			<a href="javascript:register();"><img src="${imagePath}/goodmorning/btn_greeting_add02.png" alt="한마음아침인사"/></a>
		</div>
	</div>
	</form>
</div>
<!-- //popup display -->

</body>
</html>
