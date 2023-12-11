<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>2012년 능력고과표(팀원용)</title>
<%@ include file="../include/top_inc.jsp"%>
</head>

<body>
<div id="pop_AbChart">
	<div class="tab_chart">
    	<ul>
            <li class="over"><a href="mem_pop_AbilityChart01.jsp">고과표지</a></li>
            <li><a href="mem_pop_AbilityChart02.jsp">평정방식</a></li>
            <li><a href="mem_pop_AbilityChart03.jsp">업무능력</a></li>
            <li><a href="mem_pop_AbilityChart04.jsp">관리능력</a></li>
            <li><a href="mem_pop_AbilityChart05.jsp">태도행동</a></li>
        </ul>
    </div>
    
 	<div class="chart_con">

	    <p class="chart_p">대상기간 | 2023년 01월 ~ 2023년 12월</p>
	    <div class="chart_name">2023년도 능력고과표<br/><span class="T20">(팀원용)</span></div>
	
		<!-- 게시판 시작  -->
    	<div class="chart_tl">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />고과대상자 인적사항</span>           
        </div>
    
    	<div class="chart_board">
          <table cellpadding="0" cellspacing="0" summary="고과자 인적사항">
                <caption>
                고과자 인적사항
                </caption>
                <colgroup>
                <col class="col300" />
                <col width="px" />
                <col class="col300" />
                </colgroup>
                <thead>
                  <tr>
                    <th>소 속</th>
                    <th>직 위</th>
                    <th class="td_last">성 명</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="txt_center td_h50"><input type="text" value="펀네트" name=""/></td>
                    <td class="txt_center td_h50"><input type="text" value="사원" name=""/></td>
                    <td class="txt_center td_h50 td_last"><input type="text" value="홍길동" name=""/></td>
                  </tr>
                </tbody>
              </table>
        </div>
		<!--// 게시판  끝  -->
        
        <!-- 게시판 시작  -->
    	<div class="chart_tl mT50">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />고과자 인적사항 ('고과자 구분'은 해당란에 O표)</span>        </div>
    
    	<div class="chart_board">
          <table cellpadding="0" cellspacing="0" summary="고과자 인적사항">
                <caption>
                고과자 인적사항
                </caption>
                <colgroup>
                <col class="col200" />
                <col class="col200" />
                <col class="col200" />
                <col width="px" />
                </colgroup>
                <thead>
                  <tr>
                    <th>고과자 구분</th>
                    <th>소 속</th>
                    <th>직 위</th>
                    <th class="td_last">성 명</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="txt_center td_h40 bg_f5">1차 고과자</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_left td_last">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="txt_center td_h40 bg_f5">2차 고과자</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_left td_last">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="txt_center td_h40 bg_f5">확 인 자</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_center">&nbsp;</td>
                    <td class="txt_left td_last">&nbsp;</td>
                  </tr>
                </tbody>
              </table>
        </div>
		<!--// 게시판  끝  -->
        
 	</div>
</div>

</body>
</html>
