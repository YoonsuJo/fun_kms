<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../include/ajax_inc.jsp"%>

<p class="th_stitle2 mB10">기안내용</p>
<div class="boardWrite02 mB20">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup><col class="col120" /><col width="px" /></colgroup>
                <tbody>
                	<tr>
                 	<td class="title">내용</td>
                 	<td class="pL10"><print:textarea text="${commonDoc.content}"/> </td>
                	</tr>
                	<tr>
                 	<td class="title">첨부파일</td>
                 	
                 	
			
						<td class="pL10">
							<c:import url="${rootPath}/selectFileInfs.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${commonDoc.atchFileId}" />
							</c:import>
						</td>
                	</tr>
                </tbody>
                </table>
</div>