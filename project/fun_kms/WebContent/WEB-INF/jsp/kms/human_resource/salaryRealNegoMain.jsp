<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>한마음 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script>
var userYear = ${year}; 
var status = ${memberVO.status};

function cancel() {
	document.subForm.status.value = 1;
	document.subForm.action = "<c:url value='${rootPath}/member/updateMemberSalaryNego.do'/>";
	document.subForm.submit();
}

function hideLayerName(openedLayerName) {
	$('#'+openedLayerName).hide();
}


function agree() {
	/*	var salarySuggest = document.getElementById('salarySuggestTemp').value;
	if(confirm("제안연봉 " + salarySuggest + "원에 동의하시겠습니까?")){
		document.subForm.status.value = 2;
		document.subForm.action = "<c:url value='${rootPath}/member/updateMemberSalaryNego.do'/>";
		document.subForm.submit();
	}
	*/

	var scrolled = $(window).scrollTop();
	var position = $('#agreeNotePosition').offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#meetLayer').hide();
	$('#agreeLayer').css("left",($('#agreeNotePosition').offset().left+46)+"px");
	$('#agreeLayer').css("top",($('#agreeNotePosition').offset().top+28)+"px");	
	$('#agreeLayer').show();
	
	
}

function goAgree(){
		document.subForm.hopeNote.value = document.layerFrm.agreeNote.value;
		document.subForm.status.value = 2;
		document.subForm.action = "<c:url value='${rootPath}/member/updateMemberSalaryNego.do'/>";
		document.subForm.submit();
	
}




function meet() {
/*
	var salaryHope = document.getElementById('salaryHopeTemp').value;
	var status = ${memberVO.status};
	if( status != 3){
		var p = prompt("면담 신청하시려면 희망연봉을 입력해주세요.", "");
		if(p==null || p==''){
			return;
		}
		document.getElementById('salaryHope').value = p;
		document.getElementById('salaryHopeTemp').value = p;
		jsMakeCurrency(document.getElementById('salaryHopeTemp'));
		salaryHope = document.getElementById('salaryHopeTemp').value;
	} 	
	if(confirm("희망연봉 " + salaryHope + "원으로 면담 신청하시겠습니까?")){
		document.subForm.status.value = 3;
		document.subForm.action = "<c:url value='${rootPath}/member/updateMemberSalaryNego.do'/>";
		document.subForm.submit();
	}
	*/	


	var scrolled = $(window).scrollTop();
	var position = $('#meetNotePosition').offset();
	var left = position.left + 0;
	var top = position.top + 10 - scrolled ;
	$('#agreeLayer').hide();
	$('#meetLayer').css("left",($('#meetNotePosition').offset().left+46)+"px");
	$('#meetLayer').css("top",($('#meetNotePosition').offset().top+28)+"px");	
	$('#meetLayer').show();
	
}

function goMeet(){

	var salaryHopeValue = document.layerFrm.salaryHopeValue.value;
	salaryHopeValue = salaryHopeValue.replace(/,/gi,"");
	var status = '${memberVO.status}';
	if(document.layerFrm.meetNote.value == ""){
		alert('사장님께 하고싶은 말을 적어 주십시오.');
	}else if(salaryHopeValue == "" && status != 3) {
		alert('면담 신청하시려면 희망연봉을 입력해주세요.');
	}else{
		document.subForm.salaryHope.value = salaryHopeValue;
		document.subForm.salaryHopeTemp.value = salaryHopeValue;
		document.subForm.hopeNote.value = document.layerFrm.meetNote.value;
		document.subForm.status.value = 3;
		document.subForm.action = "<c:url value='${rootPath}/member/updateMemberSalaryNego.do'/>";
		document.subForm.submit();
		
	}
}


function userSalaryMove(pos){	
	var preYear = userYear;
	userYear = userYear + pos;
	document.subForm.year.value = userYear;
	document.subForm.action = "<c:url value='${rootPath}/member/selectMemberSalaryNego.do'/>";
	document.subForm.submit();
}
//상승률 계산
function calRate(){
	var salaryReal = document.getElementById('salaryReal').value;
	var salaryHope = document.getElementById('salaryHope2').value;
	var salarySuggest = document.getElementById('salarySuggest').value;	
	salaryReal = salaryReal.replace(/,/gi,"");
	salaryHope = salaryHope.replace(/,/gi,"");
	salarySuggest = salarySuggest.replace(/,/gi,"");	
	document.getElementById('salaryHope').value = salaryHope;
	
	jsMakeCurrency(document.getElementById('salaryHope2'));
	document.getElementById('salaryHopeTemp').value = document.getElementById('salaryHope2').value;
	
	var rate = Math.floor((salaryHope - salaryReal)/salaryReal * 10000) / 100;	
	document.getElementById('increaseRate').value = rate + '%';

	var amount = Math.floor(salaryHope - salaryReal);
	document.getElementById('increaseAmount').value = amount;		
	jsMakeCurrency(document.getElementById('increaseAmount'));	
}

$(document).ready(function(){
	calRate();
});
window.onload=function(){
};
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
					<div class="path_navi">
						<ul>
							<li class="stitle">연봉협상</li>
							<li class="navi">홈 > 인사정보 > 연봉협상</li>
						</ul>
					</div>
					
					<span class="stxt">연봉협상 기간 : ${fn:substring(negoStart, 0, 2)+0 }월 ${fn:substring(negoStart, 2, 4)+0 }일에서 
					${fn:substring(negoEnd, 0, 2)+0 }월 ${fn:substring(negoEnd, 2, 4)+0 }일까지 열람 가능
					</span>					
	
					<!-- S: section -->
					<div class="section01">
					
					<!-- 상단 검색창 시작 -->
						<fieldset>
						<legend>상단 검색</legend>
							<div class="top_search07 mB20">
							<table cellpadding="0" cellspacing="0" >
							<caption>상단 검색</caption>
							<colgroup>								
								<col width="*"/>
							</colgroup>
							<tbody>
								<tr>
									<td class="search_left"> 
										<img id="userSalaryMonthBackB" class="cursorPointer pR10 pT2" onclick="javascript:userSalaryMove(-1);"  src="${imagePath}/admin/btn/btn_prev.gif" alt="이전 페이지">
				                		<span id="userSalaryYearS" class="option_txt">${year }년</span>				                		
				                		<c:if test="${year < thisYear }">
										<img id="userSalaryMonthForwardB" class="cursorPointer pL10 pT2" onclick="javascript:userSalaryMove(1);" src="${imagePath}/admin/btn/btn_next.gif" alt="다음 페이지">
										</c:if>
									</td>								
								</tr>
							</tbody>
							</table>
		                    </div>
		                </fieldset>
		                <!-- 상단 검색창 끝 -->
	
						<p class="th_stitle">기본 인사정보 </p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="기본 인사정보">
							<caption>기본 인사정보 </caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
<!--								<col class="col90" />-->
							</colgroup>
							<thead>
								<tr>
									<th scope="col">부서</th>
									<th scope="col">직급</th>
									<th scope="col">이름</th>
									<th scope="col">입사일</th>
									<th scope="col">재직기간</th>								
								</tr>
							</thead>
							<tbody>
								<tr>
<!--									부서-->
									<td class="txt_center">${memberVO.orgnztNm } </td>
<!--									직급-->
									<td class="txt_center">
										${memberVO.rankNm }
<!--										${year - memberVO.promotionYear + 1}년차  -->
									</td>										
<!--									이름-->
									<td class="txt_center">
										<print:user userNo="${memberVO.userNo}" userNm="${memberVO.userNm}"/>
									</td>
<!--									입사일-->
									<td class="txt_center">				
										${fn:substring(memberVO.compinDt,0,4)}년
										${fn:substring(memberVO.compinDt,4,6)*1}월
										${fn:substring(memberVO.compinDt,6,8)*1}일									  
									</td>
<!--									재직기간	-->
									<td class="txt_center">
										<c:if test="${memberVO.workYearIn > 0}">${memberVO.workYearIn}년</c:if>${memberVO.workMonthIn}개월
									</td>
								</tr>								
							</tbody>
							</table>
						</div>
	
						<p class="th_stitle">차년도 제시 연봉</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="연봉정보">
							<caption>차년도 제시 연봉</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">년도</th>
								<th scope="col">기존연봉</th>
								<th scope="col">제시연봉</th>
								<th scope="col">인상금액</th>
								<th scope="col">상승률</th>
								<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${year == memberVO.year}">
									<tr>
	<!--									년도-->
										<td class="txt_center">${year+1 } </td>
	<!--									기존연봉-->
										<td class="txt_center">
											<print:currency cost='${memberVO.salaryReal }'/>
										</td>	
	<!--									제시연봉-->
										<td class="txt_center">
	<!--									<a href="${rootPath}/member/selectEmpContract.do?year=${year }&userNo=${memberVO.userNo}">-->
											<print:currency cost='${memberVO.salarySuggest }'/>
	<!--									</a>-->
										</td>										
	<!--									인상금액-->
										<td class="txt_center">
											<print:currency cost='${memberVO.increaseAmount }'/>
										</td>
	<!--									상승률-->
										<td class="txt_center">				
											${memberVO.increaseRate }%	
										</td>									
	<!--									상태	-->
										<td class="txt_center">
											<c:forEach items="${statusCode}" var="status">					 
												<c:if test="${status.code == memberVO.status}">
													<input type="text" name="statusStr${memberVO.userNo }" id="statusStr${memberVO.userNo }" 
													class="read_input" maxlength="12" readonly="readonly" 
													value="${status.codeNm }" />
												</c:if>					
											</c:forEach>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${year != memberVO.year}">
									<tr>
										<td class="txt_center" colspan="6">데이터 없음 </td>
									</tr>								
								</c:if>		
													
								<c:if test="${showSalaryHope == 'Y' && memberVO.status == 3 }">
									<tr>
										<td class="txt_center"></td>
										<td class="txt_center">희망연봉</td>
										<td class="txt_center">		
											<input type="text" name="salaryHope2" id="salaryHope2" class="write_input10" maxlength="12"
											onkeyup="calRate();inputjsMakeCurrency(this);" onKeyPress="onlyNumber();"
											value="<print:currency cost='${memberVO.salaryHope }'/>"  />						
										</td>										
	<!--									인상금액-->
										<td class="txt_center">
											<input type="text" name="increaseAmount" id="increaseAmount" class="read_input2" maxlength="12" readonly="readonly" 
											value="<print:currency cost="${memberVO.salaryHope - memberVO.salaryReal}"/>" /><br>
										</td>
	<!--									상승률-->
										<td class="txt_center">		
										<input type="text" name="increaseRate" id="increaseRate" class="read_input2" maxlength="12" readonly="readonly" 
											value="${(memberVO.salaryHope - memberVO.salaryReal) / memberVO.salaryReal * 100}%" />
										</td>		
										<td class="txt_center"></td>
									</tr>
								</c:if>
								
								<tr>
			                    	<td class="txt_center txt_red2">특약사항</td>
			                    	<td colspan="5" id="mailCn" class="H300 T11"><c:if test="${memberVO.noteYn == 'Y'}"><c:out value="${memberVO.note}" escapeXml="false"/></c:if>
			                    	<c:if test="${memberVO.noteYn == 'N'}">없음</c:if></td>
		                    	</tr>

								<tr>
			                    	<td class="txt_center txt_red2">사장님께<br/>하고 싶은 말</td>
			                    	<td colspan="5" id="mailCn" class="H300 T11">
			                    	<c:choose>
				                    	<c:when test="${memberVO.hopeNote != '' && memberVO.hopeNote != null}">
				                    		<c:out value="${memberVO.hopeNote}" escapeXml="false"/>
				                    	</c:when>
				                    	<c:otherwise>
				                    		없음
				                    	</c:otherwise>
			                    	</c:choose>
			                    	</td>
		                    	</tr>
		                    	
								
							</tbody>
							</table>
						</div>
						
						
						
						<p class="th_stitle">최근 5년간 연봉정보</p>
						<div class="boardList mB20">
							<table cellpadding="0" cellspacing="0" summary="연봉정보">
							<caption>연봉정보</caption>
							<colgroup>
								<col width="px" />
								<col width="px" />
								<col width="px" />
								<col width="px" />
							</colgroup>
							<thead>
								<tr>
								<th scope="col">년도</th>
								<th scope="col">연봉</th>
								<th scope="col">인상금액</th>
								<th scope="col">상승률</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result">
									<tr>
<!--										년도-->
										<td class="txt_center">${result.year } </td>
<!--										연봉-->
										<td class="txt_center">
											<print:currency cost='${result.salaryReal }'/>
										</td>										
<!--										인상금액-->
										<td class="txt_center">
											<c:if test="${result.salaryNext != 0}">
												<print:currency cost='${result.increaseAmount }'/>
											</c:if>
										</td>
<!--										상승률-->
										<td class="txt_center">
											<c:if test="${result.salaryNext != 0}">			
												${result.increaseRate }%			
											</c:if>				  
										</td>
									</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						
						<form name="subForm" method="post" action="<c:url value='${rootPath}/community/selectMail.do'/>">
							<input type="hidden" name="userNo" id="userNo" value="${memberVO.userNo }"/>
							<input type="hidden" name="year" id="year" value="${year }"/>
							<input type="hidden" name="salaryReal" id="salaryReal" value="${memberVO.salaryReal }"/>
							<input type="hidden" name="salaryHope" id="salaryHope" value="${memberVO.salaryHope }"/>
							<input type="hidden" name="salaryHopeTemp" id="salaryHopeTemp" value="<print:currency cost='${memberVO.salaryHope }'/> " />
							<input type="hidden" name="salarySuggest"  id="salarySuggest"  value="${memberVO.salarySuggest }"/>
							<input type="hidden" name="salarySuggestTemp" id="salarySuggestTemp" value="<print:currency cost='${memberVO.salarySuggest }'/> " />
							<input type="hidden" name="carCost" id="carCost" value="${memberVO.carCost }"/>
							<input type="hidden" name="mealCost" id="mealCost" value="${memberVO.mealCost }"/>
							<input type="hidden" name="status" id="status" value="${memberVO.status }"/>
							<input type="hidden" name="note" id="note" value="${memberVO.note }"/>
							<input type="hidden" name="hopeNote" id="hopeNote" value="${memberVO.hopeNote }"/>
						</form>	
						
						<!-- 버튼 시작 -->
						<c:if test="${showSalaryHope == 'Y' }">							
		           		    <div class="btn_area">
		           		    <c:if test="${user.isSalaryadmin == 'Y' || (user.isNegoYn == 'Y' && memberVO.status != '2') }"> 
		           		    	<a href="javascript:agree();" id="agreeNotePosition"><img src="${imagePath}/btn/btn_agree.gif"/></a>
		                		<a href="javascript:meet();" id="meetNotePosition"><img src="${imagePath}/btn/btn_meet.gif"/></a>
<!--		                		<a href="javascript:cancel();"><img src="${imagePath}/btn/btn_cancel.gif"/></a>	-->
							</c:if>
		               	    </div>	                 	
	                 	</c:if>
	                 	<!-- 버튼 끝 -->
	                 	
	                 	* 동의 : 제시 연봉에 동의할 경우 선택합니다. <br/>
						* 면담 : 제시 연봉에 동의하지 않을 경우 '면담' 버튼 선택 후 '희망연봉'을 입력합니다.<br/>
<!--						* 연봉협상 기간동안 동의 면담 상태간 이동은 자유롭습니다.-->
	                 	
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



<!-- 레이어 수정 화면 시작 -->
<form name="layerFrm" method="POST">
<div class="simpleMsg_layer ms_layer" id="agreeLayer" style="width:300px;" >
	<ul>
		<li>
			<div id="AText" class="ms_layer_con"> 
				<ul>
					<li class="m_tt txtB_Black mB15">연봉협상</li>
					<li>
					제안연봉 <print:currency cost='${memberVO.salarySuggest }'/> 원에 동의하시겠습니까?
					<br/>사장님께 하고싶은 말이 있으신 분은 
					<br/>아래 '사장님께 하고 싶은말' 작성 후 [동의] 버튼을 
					<br/>클릭해 주세요.
					</li>
				</ul>
			</div>
		</li>
		<li>
		<!-- 게시판 시작  -->
			<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                   <caption>동의</caption>
                   <colgroup>
                   <col width="70px" />
                   <col width="px"/>
                   </colgroup>
                   <tbody>	                    	
                   	<tr>
                    	<td class="title">사장님께<br/>하고싶은 말</td>
                    	<td class="pL10 pT5 pB5"><textarea rows="5" cols="98%" name="agreeNote">${memberVO.hopeNote }</textarea></td>
                   	</tr>
                   </tbody>
                   </table>
              </div>
			<!--// 게시판 끝  -->
		</li>
		<li class="txt_right mT20">
			<input type="button" value="동의" class="btn_gray" onclick="javascript:goAgree();"/>
			<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('agreeLayer');"/>
		</li>
	</ul>	
</div>

<div class="simpleMsg_layer ms_layer" id="meetLayer" style="width:300px;" >
	<ul>
		<li>
			<div id="AText" class="ms_layer_con"> 
				<ul>
					<li class="m_tt txtB_Black mB15">연봉협상</li>
					<li>
					사장님과 면담을 요청하시고 싶으신 분은 
					<br/>아래 '희망연봉'과 '사장님께 하고 싶은 말' 작성 후
					<br/>[면담] 버튼을 클릭해 주세요.
					</li>
				</ul>
			</div>
		</li>
		<li>
		<!-- 게시판 시작  -->
			<div class="boardWrite02 mB20">
				<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                   <caption>면담</caption>
                   <colgroup>
                   <col width="70px" />
                   <col width="px"/>
                   </colgroup>
                   <tbody>
                   	<tr>
                    	<td class="title">희망연봉</td>
   						<!--      
                    	<td class="pL10">					
						<input type="text" name="salaryHopeValue" id="salaryHopeValue" class="write_input04" maxlength="12"
						onkeyup="calRate();inputjsMakeCurrency(this);" onKeyPress="onlyNumber();"
						value="<print:currency cost='${memberVO.salaryHope }'/>"  />					
						</td>
						 -->				 
                    	<td class="pL10">			
						<c:choose>
							<c:when test="${memberVO.salaryHope == '0' }">
								<input type="text" name="salaryHopeValue" id="salaryHopeValue" class="write_input04" maxlength="12"
								onkeyup="onlyNumber();inputjsMakeCurrency(this);" onKeyPress="onlyNumber();"
								value="<print:currency cost='${memberVO.salarySuggest }'/>" />	
							</c:when>
							<c:otherwise>
								<input type="text" name="salaryHopeValue" id="salaryHopeValue" class="write_input04" maxlength="12"
								onkeyup="onlyNumber();inputjsMakeCurrency(this);" onKeyPress="onlyNumber();"
								value="<print:currency cost='${memberVO.salaryHope }'/>" />	
							</c:otherwise>
						</c:choose>
						</td>				
                   	</tr>	                    	
                   	<tr>
                    	<td class="title">사장님께<br/>하고싶은 말</td>
                    	<td class="pL10 pT5 pB5"><textarea rows="5" cols="98%" name="meetNote">${memberVO.hopeNote }</textarea></td>
                   	</tr>
                   </tbody>
                   </table>
              </div>
			<!--// 게시판 끝  -->
		</li>
		<li class="txt_right mT20">
			<input type="button" value="면담" class="btn_gray" onclick="javascript:goMeet();"/>
			<input type="button" value="취소" class="btn_gray" onclick="javascript:hideLayerName('meetLayer');"/>
		</li>
	</ul>	
</div>	
					
</form>	                
 <!-- 레이어 수정 화면 끝 -->
 
</body>
</html>
