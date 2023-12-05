<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script>
function goBack(){
	history.back();
}

function pushMsgSendView(){
	location.href = "${rootPath}/mobile/pushMsgSendView.do?sabun=${info.no}";
}
</script>
<!-- S:Section Area -->
<c:set value="${result.member}" var="info" />
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>사원조회</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px; margin-left:5px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">목록</a></font></div>
</ul>
<div id="viw">

<!-- S:콘텐츠 들어가는곳 -->
	<ul class="memv_vclip">
		<li class="listG">	
			<span class="thumb">
	           	<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${info.picFileId2}" />
					<c:param name="param_width" value="60" />
					<c:param name="param_height" value="60" />
				</c:import>
				
			</span>
			<span class="cont">
				<span class="tit_txt"><c:out value="${info.userNm}"/></span>
				<span class="txt_sub"><c:out value="${info.orgnztNm}"/></span>
				<span class="txt_date">내선  <c:out value="${info.offmTelnoInner}"/></span>
			</span>					
		<div class="txt_user bgBtn shadowBtn btnmem" style="position:absolute; right:68px; top:36px; width:60px;"><a href="javascript:pushMsgSendView();"><span class=bl_icon><img src="${commonMobilePath}/image/btn_message.png" alt="선택"/></span>메시지</a></div>
		<div class="txt_user bgBtn shadowBtn btnmem" style="position:absolute; right:8px; top:36px; width:50px;"><a href="tel:${fn:replace(info.moblphonNo,'-','')}"><span class=bl_icon><img src="${commonMobilePath}/image/btn_phone.png" alt="선택"/></span>전화</a></div>
		</li>
	</ul>

	<div class="titlewrap">
		<div id="tab_one" class="tabtitle">기본정보</div>
		<div id="tab_two" class="tabtitle">부가정보</div>
		<div id="tab_three" class="tabtitle">좌우명</div>
		<!--Tab이 없는 부분의 경계를 위해 빈 DIV를 만들어 줍니다. -->
		<div class="tabempty"></div>
	</div>
	
	<div class="contentswrap"">
		<div id="tabcontents_one" class="tabcontents">
			<table cellspacing="0" border="1" summary="사원기본정보" class="memtbl">
			<caption></caption>
			<colgroup>
			<col width="100px">
			<col width="*">
			</colgroup>
			<tbody>
			
			<tr>
				<th scope="col">이름</th>
				<td scope="col"><c:out value="${info.userNm}" /> (<c:out value="${info.userId}" />)</td>
			</tr>
			<tr>
				<th scope="col">직급</th>
				<td scope="col"><c:out value="${info.rankNm}" /></td>
			</tr>
			<tr>
				<th scope="col">소속부서</th>
				<td scope="col"><c:out value="${info.orgnztNm}" /></td>
			</tr>			
			<tr>
				<th scope="col">생일</th>
				<td scope="col"><c:out value="${info.brthPrint}" /> (<c:out value="${info.greLunPrint}" />)</td>
			</tr>
			<tr>
				<th scope="col">휴대전화</th>
				<td scope="col"><c:out value="${info.moblphonNo}" /></td>
			</tr>
			<tr>
				<th scope="col">이메일(사내)</th>
				<td scope="col"><c:out value="${info.emailAdres}" /></td>
			</tr>
			<tr>
				<th scope="col">이메일(외부)</th>
				<td scope="col"><c:out value="${info.emailAdres2}" /></td>
			</tr>			
			<tr>
				<th scope="col">집전화</th>
				<td scope="col"><c:out value="${info.homeTelno}" /></td>
			</tr>
			<tr>
				<th scope="col">회사전화</th>
				<td scope="col"><c:out value="${info.offmTelno}" /> (내선 <c:out value="${info.offmTelnoInner}" />)</td>
			</tr>
			<tr>
				<th scope="col">주소</th>
				<td scope="col"><c:out value="${info.homeAdres}" /></td>
			</tr>
			
			</tbody>
			</table>
			
			<br /><br />
		</div>

		<div id="tabcontents_two" class="tabcontents">
			<table cellspacing="0" border="1" summary="부가정보" class="memtbl">
			<caption></caption>
			<colgroup>
			<col width="100px">
			<col width="*">
			</colgroup>
			<tbody>
			<tr>
				<th scope="col">영문이름</th>
				<td scope="col"><c:out value="${info.userEnm}" /></td>
			</tr>
			<tr>
				<th scope="col">ID</th>
				<td scope="col"><c:out value="${info.userId}" /></td>
			</tr>
			<tr>
				<th scope="col">사번</th>
				<td scope="col"><c:out value="${info.sabun}" /></td>
			</tr>			
			<tr>
				<th scope="col">보직</th>
				<td scope="col"><c:out value="${info.positionPrint}" /></td>
			</tr>	
			</tbody>
			</table>
			<br /><br />
		</div>

		<div id="tabcontents_three" class="tabcontents">
		<p><c:out value="${info.abutMePrint}" escapeXml="false"/></p>
		<br /><br />
		</div>
	</div>

<!-- E:콘텐츠 들어가는곳 -->
</div>
<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>