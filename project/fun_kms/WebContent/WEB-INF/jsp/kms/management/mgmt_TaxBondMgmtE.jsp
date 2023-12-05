<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
						<li class="stitle">세금계산서 채권관리 정보 변경</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>
				<!-- S: section -->
				<div class="section01">
	           		<p class="th_stitle">채권관리 정보</p>
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col100" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="txt_center bG" rowspan="2">관련프로젝트</td>
		                    	<td class="td_last pL10">※ 다수의 프로젝트를 지정하는 경우 (여러 프로젝트의 매출에 대해 세금계산서를 1건으로 발행하는 경우), 총 공급가액을 각 프로젝트별로 배분해 주시기 바랍니다.</td>
		                    </tr>
		                    <tr>
		                    	<td class="td_last pL10"><input type="text" class="input01 span_17"/> <input type="image" src="../../images/btn/btn_tree.gif" class="search_btn02"/> <span class="pL20"></span>금액(원) <input type="text" class="input01 span_6" /><br/>
		                    	<input type="text" class="input01 span_17"/> <input type="image" src="../../images/btn/btn_tree.gif" class="search_btn02"/> <span class="pL20"></span>금액(원) <input type="text" class="input01 span_6" /> <input type="image" src="../../images/btn/btn_delete04.gif" class="search_btn02" /><br/>
		                    	<input type="text" class="input01 span_17"/> <input type="image" src="../../images/btn/btn_tree.gif" class="search_btn02"/> <span class="pL20"></span>금액(원) <input type="text" class="input01 span_6" /> <input type="image" src="../../images/btn/btn_delete04.gif" class="search_btn02" /><br/>
		                    	<input type="image" src="../../images/btn/btn_add03.gif" class="search_btn02" /> <span class="T11"> 여러 프로젝트의 매출에 대해 세금계산서를 1건으로 발행하는 경우에만 추가해 주세요.</span></td>
	                    	</tr>                			               
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
           		 	
					
					<p class="th_stitle">계산서 발행 내역</p>
					<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col class="col100" />
	                    	<col width="px" />
                    	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="txt_center bG">제목</td>
		                    	<td class="td_last pL10" colspan="5">세금계산서 발행 요청합니다.</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">요청자</td>
		                    	<td class="txt_center">조영한</td>
		                    	<td class="txt_center bG">요청일시</td>
		                    	<td class="txt_center">2011.08.16 18:19</td>
		                    	<td class="txt_center bG">진행상태</td>
		                    	<td class="td_last pL10">발행완료(박진주 2011.10.11 09:90)</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">공급자(*)</td>
		                    	<td class="td_last pL10" colspan="5">도전하는사람들</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG" rowspan="3">공급받는자</td>
		                    	<td class="td_last pL10" colspan="5">상호 : 주식회사 새하컴즈 <span class="pL30"></span> 등록번호 : 113-86-35153</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="td_last pL10" colspan="5">주소 : 서울특별시 구로구 구로동 222-14 에이스하이엔드타워 2차 2002호</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="td_last pL10" colspan="5">대표자 : 서장열<span class="pL30"></span> 업태 : 서비스<span class="pL30"></span> 업종 : 소프트웨어개발</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">수신자</td>
		                    	<td colspan="5" class="td_last pL10">E-mail : bill@saeha.com<span class="pL30"></span> 담당자 : 윤정아 <span class="pL30"></span> 연락처 : 010-1234-5678</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">발행일</td>
		                    	<td colspan="5" class="td_last pL10">2011.10.11</td>
	                    	</tr>  
	                    	<tr>
		                    	<td class="txt_center bG" rowspan="2">금액</td>
		                    	<td class="td_last pL10" colspan="5">500,000원(VAT 별도) - 세팅비 <br/>
		                    		160,000원(VAT 별도) - 임대서비스
		                    	</td>
	                    	</tr>
	                    	<tr>
	                    	    <td class="pL10" colspan="3">공급가액 : 660,000원 / 세액 : 66,000원 / 합계 : 726,000원</td>
	                    	    <td class="txt_center bG">청구/영수 구분</td>
	                    	    <td class="td_last pL10"><label><input type="radio" class="radio" /> 청구</label> <label><input type="radio" class="radio" /> 영수</label></td>
	                    	</tr>              			               
	                    	<tr>
		                    	<td class="txt_center bG">계약내용</td>
		                    	<td class="td_last pL10" colspan="5">신청내용입니다.</td>
	                    	</tr>                  			               
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					<!-- 버튼 시작 -->
           		    <div class="btn_area">
                		<a href="#"><img src="../../images/btn/btn_regist.gif"/></a> <a href="#"><img src="../../images/btn/btn_cancel.gif"/></a>
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
