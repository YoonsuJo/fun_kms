<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
   	<c:choose>
   	<c:when test="${link == null}"><span class="${color}">${message}</span></c:when>
   	<c:otherwise><a href="${link}"><span class="txtB_red">${message}</span></a></c:otherwise>
   	</c:choose>
<!-- admin_style.css-->
<!--style.css-->
<!--.search_txt{border:2px solid #2852a0;width:370px;height:24px;}-->
<!--.txt_blue {color:#2278c5;}-->
<!--.txt_blue2 {color:#009ede;}-->
<!--.txt_blue3 {color:#0e71c7;font-size:11px;}-->
<!--.txt_blue4 {color:#c0f7ff;font-size:11px;font-weight:normal;}-->
<!--.txt_red {color:#cb1035;}-->
<!--.txt_red2 {color:#cb1035;font-size:11px;}-->
<!--.txt_grey {color:#404040;font-size:11px;}-->
<!--.txt_grey2 {color:#999999;}-->
<!--.txt_greyU {color:#c9c9c9;text-decoration:line-through;}-->
<!--.txtB_blue {color:#038da7;font-weight:bold;}-->
<!--.txtB_blue2 {color:#0e71c7;font-weight:bold;}-->
<!--.txtB_red {color:#c50000;font-weight:bold;}-->
<!--.txtB_red2 {color:#c50000;font-weight:bold; font-size:14px;}-->
<!--.txtB_orange {color:#fe6000;font-weight:bold;}-->
<!--.txtB_green {color:#39a404;font-weight:bold;}-->
<!--.txtB_green2 {color:#5f987a;font-weight:bold;}-->
<!--.txtB_grey {color:#555555;font-weight:bold;}-->
<!--.txtB_Black {color:#222222;font-weight:bold;}-->
<!--.txtB_Black2 {color:#222222;font-weight:bold; font-size:14px;}-->
<!---->
<!--.txtS_blue{color:#016ce3;}-->
<!--.txtS_red{color:#ff0000;}-->
<!--.txtS_yellow{color:#868107;}-->
<!--.txtS_yellow2{color:#ca7303;}-->
<!--.txtS_green{color:#3b7c88;}-->