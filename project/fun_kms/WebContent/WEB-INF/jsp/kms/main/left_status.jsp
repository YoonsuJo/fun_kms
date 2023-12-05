<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<!-- S: left -->
			<div id="left">
				<!--체크리스트-->				
				<div class="left_chk" id="chkList">
					<c:import url="${rootPath}/common/getCheckList.do">
					</c:import>
				</div>
				<ul class="left_bg">
					<li class="left_bg_left"></li>
					<li class="left_bg_right"></li>
				</ul>
				<!-- S: 관련자 부재현황 -->
				<div class="main_state">
					<span class="th_stitle_left mB5">관련자 부재현황</span>
					<span class="btn_area06 mB5">
						<a href="${rootPath}/member/selectAbsenceState.do"><img src="${imagePath}/btn/btn_more.gif"/></a>
					</span>
					<div class="boardList">
						<table cellpadding="0" cellspacing="0" summary="관련자 부재현황 목록입니다.">
						<caption>관련자 부재현황</caption>
						<colgroup>
							<col class="col50" />
							<col width="px" />
						</colgroup>
						<thead>
							<tr>
							<th scope="col">이름</th>
							<th scope="col">부재현황</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${stateList}" var="state">
								<tr>
									<td class="txt_center"><print:user userNm="${state.userNm}" userNo="${state.userNo}" userId="${state.userId}"/></td>
									<td class="txt_center">
										<span class="cursorDefault" onmouseover="javascript:showState(this);" onmouseout="javascript:hideState();" >${state.state}(${state.period})</span>
										<input name="wsInfo" type="hidden" value="<print:textarea text='${state.wsInfo}' />"/>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty stateList}">
								<tr>
									<td class="txt_center" colspan="2">부재자가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
						</table>
					</div>
				</div>
				<!-- E: 관련자 부재현황 -->
				<div class="main_banner">
					<ul>
						<c:forEach items="${banner}" var="ban">
							<li>
								
								<!-- <a href="${ban.linkUrl}" <c:if test="${ban.popYn == 'Y'}">target="_BNR_POP_${ban.bnrId}_"</c:if>> -->
								<a href="javascript:openLink('${ban.linkUrl}', '${ban.popYn}', '${ban.bnrId}', '${ban.popWidth}', '${ban.popHeight}');">
									<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="param_atchFileId" value="${ban.bnrFileId}" />
										<c:param name="param_width" value="190" />
										<c:param name="param_height" value="60" />
									</c:import>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- E: left -->
<script type="text/javascript">
	initTopMenu();//1,2차메뉴롤오버함수할당

	function openLink(linkUrl, popYn, bnrId, popW, popH) {
		if (popYn == 'Y') {
			var target = "_BNR_POP_" + bnrId;

			var option = "";
			if (popW.length > 0 && popH.length > 0)
				option = "width=" + popW + "px,height=" + popH + "px" + ",scrollbars=yes,resizable=yes";

			if(linkUrl.indexOf("222.112.235.135") > -1){
				linkUrl = "http://222.112.235.135/game/startV.jsp?id=${user.userId}&no=${user.no}";
			}	
			
			var popup = window.open(linkUrl, target, option);
			popup.focus();
		}
		else {
			location.replace(linkUrl);
		}
	}
	
</script>