<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<p class="th_stitle2 mB10">휴일근무내역</p>
<script>

$(document).ready(function(){
	var form = $('#specificVO');
	$('#holidayLayerB,#holidayLayer').mouseover(function(){
			$('#holidayLayer').show();			
		}).mouseout(function(){
			$('#holidayLayer').hide();		
		});
	var stDt = "${specificVO.stDt}";
	var period = "${specificVO.period}";
	$.post('/ajax/salary/selectUserHolSalaryInfo.do',{userNo : "${writerNo}", stDt : stDt, period : period},function(data){
		data =  JSON.parse(data);
		$('#holidayLayer .salaryYear').html(data.year);
		$('#holidayLayer .salaryMonth').html(data.month);
		$('#holidayLayer .userSalary').html(jsAddComma(data.userSalary));
		$('#holidayLayer .rankSalary').html(jsAddComma(data.rankSalary));
		$('#holidayLayer .posSalary').html(jsAddComma(data.posSalary));
		$('#holidayLayer .rankNm').html(data.rankNm);
		$('#holidayLayer .posNm').html(data.posNm);
		$('#holidayLayer .userNm').html(data.userNm);
		$('.maxSalary').html(jsAddComma(data.maxSalary));
	});
});

</script>
<div class="boardWrite02 mB20">
<table cellpadding="0" cellspacing="0"
	summary="각 게시물의 상세 내용을 볼 수 있습니다.">
	<caption>공지사항 보기</caption>
	<colgroup>
		<col class="col120" />
		<col width="px" />
		<col class="col120" />
		<col width="px" />
	</colgroup>
	<tbody>
		<tr>
			<td class="title">프로젝트</td>
			<td class="pL10" colspan="3">
				<print:project prjCd="${specificVO.prjCd}" prjId="${specificVO.prjId}" prjNm="${specificVO.prjNm}"/>
			</td>
		</tr>
		<tr>
			<td class="title">근무일수</td>
			<td class="pL10">${specificVO.period } 일</td>
			<td class="title">휴일근무수당</td>
			<td class="pL10">${specificVO.cost } 원 
				<c:if test="${specificVO.exceedManage == 'Y'}">
					<span class="txt_red">(판관비초과)</span>
				</c:if>
				<img src="${imagePath}/btn/btn_question.gif" class="cursorPointer" id="holidayLayerB"/>
			</td>
		</tr>
		<tr>
			<td class="title">시작</td>
			<td class="pL10" colspan="3">날짜 :<print:date date="${specificVO.stDt}"/><span
				class="pL7"></span> 시간 : ${specificVO.stTm }</td>
		</tr>
		<tr>
			<td class="title">종료</td>
			<td class="pL10" colspan="3">날짜 :<print:date date="${specificVO.edDt}"/><span
				class="pL7"></span> 시간 : ${specificVO.edTm }</td>
		</tr>
	</tbody>
</table>
</div>

<!-- 휴일근무수당 레이어  -->
<div class="Holiday hidden" id="holidayLayer">
	<dl>
		<dt>휴일근무수당 지급기준</dt>
		<dd><span class="txtB_grey userNm"></span> 님의 
			<span class="txt_blue"> 
			<span class="salaryYear"></span>년 
			<span class="salaryMonth"></span>월</span>
			<ul>
				<li class="Lt">개인별 기준금액 </li>
				<li class="Lt">직급 기준 (<span class="rankNm"></span>)</li>
				<li class="Lt">보직 기준 (<span class="posNm"></span>)</li>
			</ul>
			<ul>
				<li class="Rt">: <span class="userSalary">0</span>원</li>
				<li class="Rt">: <span class="rankSalary">0</span>원</li>
				<li class="Rt">:  <span class="posSalary">0</span>원</li>
			</ul>
		</dd>
		<dd class="cmt">개인별, 직급별, 보직별 기준금액 중 가장 큰 금액을 적용합니다.</dd>
	</dl>
</div>
<!--// 휴일근무수당 레이어  -->
