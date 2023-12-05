<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/BBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>
<script>
function register() {
	if (document.frm.bcCn.value == "") {
		alert("내용을 입력해주세요.");
		return;
	}

	document.frm.submit();					
}

function goBack(){
	history.back();
}
</script>
<div id="showhidden"></div>
<ul class="sectionttl bgTop">
	<li><img src="${commonMobilePath}/image/btn_menuS.png" alt="" id="secbtnA" /></li>
	<li>업무연락등록</li>
	<div class="bgTopBtn shadowBtn bgTopBtnBor" style="width:34px;"><font class="fontShadow"><a href="javascript:goBack();" alt="">뒤로</a></font></div>
</ul>
<!-- S:콘텐츠 들어가는곳 -->

<hr class="hr_e1e1e1" />

<form:form name="frm" commandName="BusiContact" action="${rootPath}/mobile/cooperation/insertBusinessContact.do" enctype="multipart/form-data">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}"/>
<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}"/>
<input type="hidden" name="includeUnderProject" value="${searchVO.includeUnderProject}"/>
<input type="hidden" name="searchCondition" value="${searchVO.searchCondition}"/>
<input type="hidden" name="searchKeyword" value="${searchVO.searchKeyword}"/>
<input type="hidden" name="searchUserNm" value="${searchVO.searchUserNm}"/>

<table cellspacing="0" border="1" summary="" class="office_f">
	<caption></caption>
	<colgroup>
		<col width="80px">
		<col width="*">
		<col width="40px">
	</colgroup>
	<tbody>
		<tr>
			<th scope="col">제목</th>
			<td scope="col" colspan="2">
				<input type="text" style="width:98%" name="bcSj" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="">
			</td>
		</tr>
		<tr>
			<th scope="col">수신자</th>
			<td scope="col" colspan="2">
				<input type="text" class="userNamesAuto userValidateCheck" style="width:98%" name="recUserMixes" id="recUserMixes" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""/>
			</td>
		</tr>
		<tr>
			<th scope="col">참조자</th>
			<td scope="col" colspan="2">
				<input type="text" class="userNamesAuto userValidateCheck" style="width:98%" name="refUserMixes" id="refUserMixes" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder=""/>
			</td>
		</tr>
		<tr>
			<th scope="col">프로젝트</th>
			<td scope="col" colspan="2">
				<input type="text" name="prjNm" id="prjNm" readonly="readonly" style="width:98%" onclick="prjGen('prjNm','prjId',1)" onfocus="prjGen('prjNm','prjId',1)" maxlength="255" autocomplete="off" autocapitalize="off" autocorrect="off" placeholder="">
				<input type="hidden" name="prjId" id="prjId" />
			</td>
		</tr>
		<tr>
			<th scope="col">알림전송</th>
			<td scope="col" colspan="2">
				<ul>
					<li style="float:left;"><input type="checkbox" name="smsYn" value="Y" style="width:18px; height:18px margin-top:10px;" /></li>
					<li style="float:left;margin:8px 0px 0px 10px;"><span style="margin-top:10px;">업무연락이 수신되었음을 SMS로 알림</span></li>
				</ul>
			</td>
		</tr>
		<tr>
			<td scope="col" colspan="3"><textarea rows="9" cols="100" name="bcCn" placeholder="내용을 입력해주세요."style="width:98%" ></textarea></td>
		</tr>
	</tbody>
</table>
</form:form>

<p style="margin:10px 0px 50px 0px">
<a href="javascript:goBack();"><button class="bgBtn shadowBtn btnreply" style="float:left; margin-left:10px; width:50px">취소</button></a>
<a href="javascript:register();"><button class="bgBtn shadowBtn btnreply" id="searchpoppp" style="float:right; margin-right:10px; width:50px">등록</button></a>
</p>


<!-- E:콘텐츠 들어가는곳 -->


<div id="btn_ext"></div>
<div id="paginate"></div>
<!-- E:Section Area -->
<jsp:include page="../include/footer.jsp"></jsp:include>