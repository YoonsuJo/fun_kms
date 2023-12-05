<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../include/ajax_inc.jsp"%>

<p class="th_stitle2 mB10">신청한도</p>
<div class="boardList02 mB20" id="selfdevInfoD">
	<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
                <caption>공지사항 보기</caption>
                <colgroup>
                	<col class="col16" />
                	<col class="col16" />
                	<col class="col16" />
                	<col class="col16" />
               	</colgroup>
                <thead>
                	<tr>
                		<th>전액</th>
                		<th>사용 한도</th>
                		<th>이미 사용한 금액</th>
                		<th class="td_last">신청가능금액</th>
                	</tr>
                </thead>
                  <tbody>
                	<tr>
                 	<td class="txt_center bG">전액</td>
                 	<td class="txt_center"><print:currency cost="${selfdevVO.full }"/> </td>
                 	<td class="txt_center"><print:currency cost="${selfdevVO.fullSpend  }"/></td>
                 	<td class="td_last txt_center fullLeft"><print:currency cost="${selfdevVO.fullLeft}"/></td>
                	</tr> 
                	<tr>
                 	<td class="txt_center bG">반액</td>
                 	<td class="txt_center"><print:currency cost="${selfdevVO.half }"/></td>
                 	<td class="txt_center"><print:currency cost="${selfdevVO.halfSpend }"/></td>
                 	<td class="td_last txt_center halfLeft"><print:currency cost="${selfdevVO.halfLeft }"/></td>
                	</tr>                			                    			                    	
                </tbody>
                </table>
</div>
<%@ include file="./write10.jsp"%>
