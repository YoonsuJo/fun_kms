<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<%@ include file="../../../include/ajax_inc.jsp"%>
<script>

$(document).ready(function(){
	var form = $('#specificVO');

	$('[name=stDt],[name=period]').change(function(){
		if($('[name=stDt]').val().length==8)
		{ 
			initialize();
		}
	});
	
	function initialize(){
		var period = $('[name=period]:checked').val();
		$.post('/ajax/salary/selectUserHolSalaryInfo.do',{stDt : form.find('[name=stDt]').val(), userNo : "${user.no}", period : period},function(data){
			data =  JSON.parse(data);
			$('#holidayLayer .salaryYear').html(data.year);
			$('#holidayLayer .salaryMonth').html(data.month);
			$('#holidayLayer .userSalary').html(jsAddComma(data.userSalary));
			$('#holidayLayer .rankSalary').html(jsAddComma(data.rankSalary));
			$('#holidayLayer .posSalary').html(jsAddComma(data.posSalary));
			$('#holidayLayer .rankNm').html(data.rankNm);
			$('#holidayLayer .posNm').html(data.posNm);
			form.find('.maxSalary').html(jsAddComma(data.maxSalary));
		});
	};	

	initialize();

	$('#holidayLayerB,#holidayLayer').mouseover(function(){
		$('#holidayLayer').show();			
	}).mouseout(function(){
		$('#holidayLayer').hide();			
	});
});

</script>
<p class="th_stitle2 mB10">휴일근무내역</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
      <caption>공지사항 보기</caption>
      <colgroup><col class="col120" /><col width="px" /><col class="col120" /><col width="px" /></colgroup>
      <tbody>
      	<tr>
       	<td class="title">프로젝트</td>
       	<td class="pL10" colspan="3">
       		<form:input path="prjNm" cssClass="span_12" readonly="true" onclick="prjGen('prjNm','prjId',1);"/>
       		<form:hidden path="prjId" />
       		<img src="${imagePath}/btn/btn_tree.gif" class="cursorPointer" onclick="prjGen('prjNm','prjId',1);">
      		</td>
      	</tr>
      	<tr>
       	<td class="title">근무일수</td>
       	<td class="pL10">
       		<form:radiobutton path="period" value="1.0"/> 1일
       		<form:radiobutton path="period" value="0.5"/> 0.5일
      	</td>
      	<td class="title">휴일근무수당</td>
       	<td class="pL10"><span class="maxSalary"></span>원 
       			<img src="${imagePath}/btn/btn_question.gif" class="cursorPointer" id="holidayLayerB">
      		</td>
      	</tr>
      	<tr>
       	<td class="title">시작</td>
       	<td class="pL10" colspan="3">
       		날짜 : <form:input path="stDt" cssClass="span_5 calGen" /> <span class="pL7"></span>
       		시간 : <form:input path="stTm" cssClass="span_2" /> <span class="T11">(예: 09:00)</span>
      		</td>
      	</tr>
      	<tr>
      		<td class="title">종료</td>
       	<td class="pL10" colspan="3">
       		날짜 : <form:input path="edDt" cssClass="span_5 calGen" /> <span class="pL7"></span>
       		시간 : <form:input path="edTm" cssClass="span_2" /> <span class="T11">(예: 18:00)</span>
      		</td>
      	</tr>
      </tbody>
      </table>
</div>

<!-- 휴일근무수당 레이어  -->
<div class="Holiday hidden" id="holidayLayer">
	<dl>
		<dt>휴일근무수당 지급기준</dt>
		<dd><span class="txtB_grey">${user.userNm }</span> 님의 
			<span class="txt_blue"> 
			<span class="salaryYear"></span>년 
			<span class="salaryMonth"></span>월</span>
			<ul>
				<li class="Lt txt_left">개인별 기준금액 </li>
				<li class="Lt txt_left">직급 기준 (<span class="rankNm"></span>)</li>
				<li class="Lt txt_left">보직 기준 (<span class="posNm"></span>)</li>
			</ul>
			<ul>
				<li class="Rt txt_left">: <span class="userSalary">0</span>원</li>
				<li class="Rt txt_left">: <span class="rankSalary">0</span>원</li>
				<li class="Rt txt_left">:  <span class="posSalary">0</span>원</li>
			</ul>
		</dd>
		<dd class="cmt">개인별, 직급별, 보직별 기준금액 중 가장 큰 금액을 적용합니다.</dd>
	</dl>
</div>
<!--// 휴일근무수당 레이어  -->
