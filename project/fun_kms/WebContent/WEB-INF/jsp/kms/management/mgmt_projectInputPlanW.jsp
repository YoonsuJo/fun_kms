<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../include/ajax_inc.jsp"%>
<form name="writeFrm" action="${rootPath}/management/insertPrjInputPlan.do">
<input type="hidden" name="searchYear" value="${searchVO.searchYear}" />
<input type="hidden" name="searchMonth" value="${searchVO.searchMonth}" />
<input type="hidden" name="searchPrjId" value="${searchVO.searchPrjId}" />
<input type="hidden" name="searchPrjNm" value="${searchVO.searchPrjNm}" />
<input type="hidden" name="searchOrgId" value="${searchVO.searchOrgId}" />
<input type="hidden" name="searchOrgNm" value="${searchVO.searchOrgNm}" />
<input type="hidden" name="prjId" id="prjId2" />
<p class="th_stitle">추가</p>
<div class="boardWrite02">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
		<caption>공지사항 보기</caption>
		<colgroup>
			<col class="col90" />
			<col width="px" />
		</colgroup>
		<tbody>
			<tr>
			 	<td class="title">이름</td>
			 	<td class="pL10">
			 		<input type="text" name="userNm" id="userNm" class="input01 span_29 userNamesAuto userValidateCheck"/>
			 		<img src="${imagePath}/btn/btn_tree.gif" onclick="usrGen('userNm',0);"/>
			 	</td>
			</tr>
			<tr>
			 	<td class="title">프로젝트</td>
			 	<td class="pL10">
			 		<input type="text" name="prjNm" id="prjNm2" class="input01 span_12" onfocus="prjGen('prjNm2','prjId2',1);"/>
			 		<img src="${imagePath}/btn/btn_tree.gif" onclick="prjGen('prjNm2','prjId2',1);"/>
			 	</td>
			</tr>     
			<tr>
			 	<td class="title">투입률</td>
			 	<td class="pL10"><input type="text" name="inputPercent" id="inputPercent" class="input01 span_4" onfocus="numGen('inputPercent', 1, 100, 10)"/> %</td>
			</tr>     
			<tr>
			 	<td class="title">투입기간</td>
			 	<td class="pL10">
			 		<input type="text" name="inputSdt" class="input01 span_4 calGen" /> ~
			 		<input type="text" name="inputEdt" class="input01 span_4 calGen" />
			 	</td>
			</tr>                   			                    			                    	
		</tbody>
	</table>
</div>
</form>

<div class="btn_area02 mT20">
	<a href="javascript:write();"><img src="${imagePath}/btn/btn_regist.gif"/></a>
	<a href="javascript:hideLayer();"><img src="${imagePath}/btn/btn_close.gif"/></a>
</div>
