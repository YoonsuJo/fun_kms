<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
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
							<li class="stitle">전자결재 양식설정 등록</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">	
						
						<!-- 게시판 시작  -->
						<div class="boardWrite02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		                    <caption>사원정보보기</caption>
		                    <colgroup><col class="col120" /><col width="px" /><col class="col250" /><col class="col100" /></colgroup>
		                    <tbody>
		                    	<tr> 
			                    	<td class="title">양식코드</td>
			                    	<td class="pL10" colspan="2">자동입력된코드값</td>
			                    	<td class="pic" rowspan="3"><span class="con_btn"><img src="${imagePath}/btn/btn_delete03.gif"/></span></td>
		                    	</tr>
		                    	<tr> 
			                    	<td class="title">양식명</td>
			                    	<td class="pL10" colspan="2"><input type="text" name="title" value="휴가신청서" class="span_22" /></td>
		                    	</tr>
								<tr>
								    <td class="title">아이콘</td>
									<td class="pL10" colspan="2"><input type="text" name="title" value="" class="span_19" /> <img src="${imagePath}/btn/btn_search05.gif"/></td>
 								</tr>
 								<tr>
								    <td class="title">양식설명</td>
									<td class="pL10 pT5 pB5" colspan="3"><textarea name="text" class="span_23 height_35">휴가신청서는 연차, 경조, 보건, 출산휴가 등 회사가 노동법/근로기준법에 근거하여 정한 휴일에 대해 결재를 요청할 수 있는 문서 양식입니다.</textarea></td>
 								</tr>
 								<tr>
								    <td class="title">결재선 기준 설명</td>
									<td class="pL10 pT5 pB5" colspan="3"><textarea name="text" class="span_23 height_80">휴가신청서의 결재선 기준은 다음과 같습니다. 
검토자 : -
전결자 : 팀장 
협조자 : - 
참조자 : 인사담당자(임진혁과장)</textarea></td>
 								</tr>
 								<tr>
								    <td class="title">결재선 자동입력</td>
									<td class="pL10" colspan="3"><input type="radio" name="yes" value="1" checked> 예 <input type="radio" name="no" value="2"> 아니오</td>
 								</tr>
 								<tr>
								    <td rowspan="2" class="title">최종결재자(전결)</td>
									<td class="pL10 pT5 pB5" colspan="2">전결자의 조건을 지정하면 기안자 소속부서 ~ <br/>전결자 하위부서의 장이 검토자로 자동등록됨 (0~N명)</td>
 									<td class="pL10"><img src="${imagePath}/btn/btn_organ.gif"/></td>
 								</tr>
 								<tr>
									<td class="select_list"><input type="radio" name="use" value="1" checked> X레벨 부서의 장을 전결자로 지정<br/>
										<select name="list" class="span_4"><option>1레벨</option></select> 부서
									</td>	
									<td class="select_list" colspan="2">
										<input type="radio" name="use" value="1" checked> 소속부서보다 X단계 위 부서의 장을 전결자로 지정<br/>
										<select name="list" class="span_4"><option>1레벨</option></select> 상위부서 <br/>
										<input type="checkbox" name="checkbox" value="checkbox" /> 단, 최대
										<select name="list" class="span_4"><option>2레벨</option></select> 부서보다 상위부서로 올라가지 않음 
									</td>									
 								</tr>
 								<tr>
								    <td class="title">협조자</td>
									<td class="pL10" colspan="3"><input type="text" name="title" class="span_22" /> 여러명 지정 가능</td>
 								</tr>  
 								<tr>
								    <td class="title">참조자</td>
									<td class="pL10" colspan="3"><input type="text" name="title" class="span_22" /> 여러명 지정 가능</td>
 								</tr> 
 								<tr>
								    <td class="title">처리담당자</td>
									<td class="pL10" colspan="3"><input type="text" name="title" class="span_22" /> 여러명 지정 가능</td>
 								</tr>
 								<tr>
								    <td class="title">사용여부</td>
									<td class="pL10" colspan="3"><input type="radio" name="use" value="1" checked> 사용 <input type="radio" name="unused" value="2"> 사용안함</td>
 								</tr>                      	
		                    </tbody>
		                    </table>
						</div>
						<!-- 게시판 끝  -->
						
						<!-- 버튼 시작 -->
		                <div class="btn_area">
		                	<a href="#"><img src="${imagePath}/btn/btn_regist.gif"/></a><a href="#"><img src="${imagePath}/btn/btn_cancel.gif"/></a>
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
<%@ include file="../include/admin_footer.jsp"%>
</div>
</body>
</html>
