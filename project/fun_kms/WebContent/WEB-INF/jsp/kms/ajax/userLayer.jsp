<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
    		<!-- 이전 레벨이 높으면 ul 시작 -->
            <!-- 이전 레벨이 낮으면 ul 끝 -->

<!-- 사용자  -->
	<dl>
		<dt>${memberVO.orgnztNmFull}</dt>
		<dd>
			<ul class="User_Info">
				<li>
					<p>${memberVO.userNm} ${memberVO.rankNm}
					<c:if test="${not empty memberVO.offmTelnoInner}" > (${memberVO.offmTelnoInner})</c:if></p>
					<p class="tal_color">${memberVO.moblphonNo}</p>
					<p class="mT2">
						<span class="mR5">
							<c:if test="${not empty memberVO.picFileId && memberVO.picFileId != ''}">
								<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${memberVO.picFileId}" />
									<c:param name="param_width" value="60" />
									<c:param name="param_height" value="75" />
								</c:import>
							</c:if>
						</span>
						<span>
							<c:if test="${not empty memberVO.picFileId2 && memberVO.picFileId2 != ''}">
								<c:import url="/selectImageFileInfs.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" value="${memberVO.picFileId2}" />
									<c:param name="param_width" value="60" />
									<c:param name="param_height" value="75" />
								</c:import>
							</c:if>
						</span>
					</p>
				</li>
			</ul>
			<ul class="option">
				<li><a href="${rootPath }/member/selectMember.do?no=${memberVO.userNo }" target="_blank">상세정보</a></li>
				<li><a href="#" onclick="window.open('${rootPath}/community/sendNoteView.do?recieverNo=${memberVO.userNo}', '_POP_NOTE_WRITE_', 'top=0px, left=0px, width=500px, height=415px, scrollbars=yes')">
				쪽지보내기</a></li>
				<li><a href="${rootPath }/community/sendMailView.do?recieverNo=${memberVO.userNo}" target="_blank">메일보내기</a></li>
<!--				<li><a href="javascript:alert('준비중입니다.');">SMS 전송</a></li>-->
<!--				<li>내선 ${memberVO.offmTelnoInner}</li>-->
<!--				<li class="Last_li">${memberVO.moblphonNo}</li>				-->
<!--				<li class="Last_li"><a href="javascript:alert('준비중입니다.');">SMS 전송</a></li>-->
				<li class="Last_li">SMS 전송</a></li>
			</ul>
		</dd>
	</dl>
