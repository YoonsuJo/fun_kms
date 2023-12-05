<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/top_inc.jsp"%>

			                <dl>
								<dt>이동할 게시판</dt>
								<dd>
									<select name="bbsIdTo" class="span_9">
										<c:forEach items="${resultList}" var="result">
											<option value="${result.bbsId}" <c:if test="${result.bbsId == bbsIdFrom}">selected="selected"</c:if>>${result.bbsNm}</option>
										</c:forEach>
									</select>
									<a href="javascript:moveBBS();"><img src="${imagePath}/btn/btn_move.gif"/></a>
								</dd>
							</dl>