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
            <li><a href="mem_pop_AbilityChart01.jsp">고과표지</a></li>
            <li class="over"><a href="mem_pop_AbilityChart02.jsp">평정방식</a></li>
            <li><a href="mem_pop_AbilityChart03.jsp">업무능력</a></li>
            <li><a href="mem_pop_AbilityChart04.jsp">관리능력</a></li>
            <li><a href="mem_pop_AbilityChart05.jsp">태도행동</a></li>
        </ul>
    </div>

 	<div class="chart_con">
		<!-- 게시판 시작  -->
            
    	<div class="chart_tl mT30">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />고과대상자 담당업무와 실적</span>
            <p>고과자는 자신의 능력이 공정하게 평가되기를 바라듯이 주관과 편견을 일체 배제하고 피고과자의 능력을 객관적이고 공정하게 평가해야 한다. <br/>각 차원별 평정 방식은 다음과 같다.</p>            
        </div>
    
    	<div class="chart_board">
          <table cellpadding="0" cellspacing="0" summary="고과대상자 담당업무와 실적">
                <caption>
                고과대상자 담당업무와 실적
                </caption>
                <colgroup>
                <col class="col300" />
                <col width="px" />
                <col class="col300" />
                </colgroup>
                <thead>
                  <tr>
                    <th>현부서 발령일</th>
                    <th>고과대상기관 중 담당업무</th>
                    <th class="td_last">담당기간</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="txt_center td_h40"><input type="text" /></td>
                    <td class="txt_center td_h40"><input type="text" /></td>
                    <td class="txt_center td_h40"><input type="text" /></td>
                  </tr>
                </tbody>
              </table>
        </div>
		<!--// 게시판  끝  -->
        
        <!-- 게시판 시작  -->
        <div class="chart_tl mT50">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />평정방식</span>
        </div>
        
    	<div class="chart_board">
          <table cellpadding="0" cellspacing="0" summary="평정방식">
                <caption>
                평정방식
                </caption>
                <colgroup>
                <col class="col200" />
                <col width="px" />
                </colgroup>
                <thead>
                  <tr>
                    <th>차원</th>
                    <th class="td_last">평점방식</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="txt_center bg_f5 td_h50">업무능력차원</td>
                    <td class="txt_left td_last p3">각 요소의 개념을 주의깊게 읽고 5개의 행동사례 중 고과 대상자의 일상적인 업무수행상의 행동과 가장 일치하는 행동사례에 해당하는 점수를 쓰시오.</td>
                  </tr>
                  <tr>
                    <td class="txt_center bg_f5 td_h50">관리능력차원</td>
                    <td class="txt_left td_last p3">각 요소의 개념을 주의깊게 읽고 A(긍정적 행동사례)와 B(부정적 행동사례)의 두가지 행동사례를 비교하여 고과대상자의 일상적인 관리행동이 A와B중에서 어느 쪽에 더 가까운지를 생각하여 그 지점에 해당하는 점수를 쓰시오.</td>
                  </tr>
                  <tr>
                    <td class="txt_center bg_f5 td_h50">태도와 행동 차원</td>
                    <td class="txt_left td_last p3"> 각 요소의 개념을 주의깊게 읽고 각 항목에서 기술하는 내용과 고과대상자의 일상적인 행동이 어느 정도 일치하는지를 생각하여 '매우일치','일치하는 편','보통','일치하지 않는 편','전혀 일치하지 않음' 중에서 해당하는 점수를 쓰시오.</td>
                  </tr>
                </tbody>
              </table>
        </div>
		<!--// 게시판  끝  -->
        
        <div class="chart_btn">
        	<input type="button" value="저장" name="" class="ch_btn"/>
        </div>
        
 	</div>
</div>
</body>
</html>
