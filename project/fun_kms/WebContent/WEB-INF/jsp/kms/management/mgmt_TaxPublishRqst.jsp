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
						<li class="stitle">세금계산서 발행 신청하기</li>
						<li class="navi">홈 > 업무지원 > 각종신청 > 세금계산서 발행요청</li>
					</ul>
				</div>
				<span class="stxt">(*) 표시가 있는 항목은 필수 입력 항목입니다.</span>
				<!-- S: section -->
				<div class="section01">
	           		<p class="th_stitle">계산서 발행 요청 정보</p>
           		 	<!-- 게시판 시작  -->
					<div class="boardList02 mB20">
						<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	                    <caption>공지사항 보기</caption>
	                    <colgroup>
	                    	<col class="col100" />
	                    	<col width="px" />
	                    	<col class="col100" />
	                    	<col class="col120" />
                    	</colgroup>
	                    <tbody>
	                    	<tr>
		                    	<td class="txt_center bG">제목(*)</td>
		                    	<td class="td_last pL10" colspan="3"><input type="text" class="input01 span_24"/></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">공급자(*)</td>
		                    	<td class="td_last pL10" colspan="3"><select class="select01"><option>도전하는사람들</option></select><span class="pL5"></span> 계산서 발행 법인을 선택해주세요.</td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG" rowspan="4">공급받는자</td>
		                    	<td class="td_last pL10" colspan="3"><span class="T11">고객사정보를 사전에 등록한 경우, 상호를 입력하면 나머지 항목이 자동으로 입력됩니다.<br/>
  								세금계산서 발행 담당자가 공급받는자 정보를 이미 알고있는 경우, 상호(필수) 등 필요한 정보만 입력하셔도 됩니다.</span>
		                    	</td>
	                    	</tr>
	                    	<tr>
	                    		<td class="td_last pL10" colspan="3">상호(*) <input type="text" class="input01 span_8"/><span class="pL10"></span> 등록정보 <input type="text" class="input01 span_8"/></td>
	                    	</tr>
	                    	<tr>
	                    		<td class="td_last pL10" colspan="3">주소 <input type="text" class="input01 span_24"/></td>
	                    	</tr>
	                    	<tr>
	                    		<td class="td_last pL10" colspan="3">대표자 <input type="text" class="input01 span_6"/><span class="pL10"></span> 업태 <input type="text" class="input01 span_6"/> <span class="pL10"></span>업종 <input type="text" class="input01 span_6"/> </td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">수신자</td>
		                    	<td colspan="3" class="td_last pL10">E-mail <input type="text" class="input01 span_6"/><span class="pL10"></span> 담당자 <input type="text" class="input01 span_6"/> <span class="pL10"></span>연락처 <input type="text" class="input01 span_6"/> <input type="image" src="../../images/btn/btn_delete04.gif" class="search_btn02" /></td>
	                    	</tr>
	                    	<tr>
		                    	<td class="txt_center bG">발행일(*)</td>
		                    	<td colspan="3" class="td_last pL10"> <input type="text" class="input01 span_5"/><span class="pL10"></span> <label><input type="checkbox" class="check"/> 반복발행 </label><input type="text" class="input01 span_5"/> 까지 매월 <select><option>1</option></select>일 (매월 말일을 선택하려면 31일 지정)</td>
	                    	</tr>  
	                    	<tr>
		                    	<td class="txt_center bG" rowspan="2">금액(*)</td>
		                    	<td class="td_last pL10" colspan="3"><input type="text" class="input01 span_8"/> 원 <label><input type="checkbox" class="check"/> VAT 포함</label> <span class="pL10"></span>비고 : <input type="text" class="input01 span_10" /> <input type="image" src="../../images/btn/btn_delete04.gif" class="search_btn02" /><br/>
		                    	<input type="text" class="input01 span_8"/> 원 <label><input type="checkbox" class="check"/> VAT 포함</label> <span class="pL10"></span>비고 : <input type="text" class="input01 span_10" /> <input type="image" src="../../images/btn/btn_delete04.gif" class="search_btn02" /><br/>
		                    	<input type="image" src="../../images/btn/btn_add03.gif" class="search_btn02" />
		                    	</td>
	                    	</tr>
	                    	<tr>
	                    	    <td class="pL10">공급가액 : 660,000원 / 세액 : 66,000원 / 합계 : 726,000원</td>
	                    	    <td class="txt_center bG">청구/영수 구분</td>
	                    	    <td class="td_last pL10"><label><input type="radio" class="radio" /> 청구</label> <label><input type="radio" class="radio" /> 영수</label></td>
	                    	</tr>              			               
	                    	<tr>
		                    	<td class="txt_center bG">계약내용</td>
		                    	<td class="td_last pL10" colspan="3"><textarea class="span_24"></textarea></td>
	                    	</tr>                  			               
	                    </tbody>
	                    </table>
					</div>
					<!--// 게시판 끝  -->
					
					<p class="th_stitle">채권관리 정보</p>
					<span class="stxt">이 세금계산서와 관련하여 매출을 보고한(또는 보고 예정인) 프로젝트를 선택해 주시기 바랍니다.</span>
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
