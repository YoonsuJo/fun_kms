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
            <li><a href="mem_pop_AbilityChart02.jsp">평정방식</a></li>
            <li><a href="mem_pop_AbilityChart03.jsp">업무능력</a></li>
            <li class="over"><a href="mem_pop_AbilityChart04.jsp">관리능력</a></li>
            <li><a href="mem_pop_AbilityChart05.jsp">태도행동</a></li>
        </ul>
    </div>

 	<div class="chart_con">
    	<div class="chart_tl mT30">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />관리능력차원</span>
        </div>
    
		<!-- 게시판 시작  -->
    	<div class="chart_board02">
          <table cellpadding="0" cellspacing="0" summary="관리능력차원">
            <caption>
            관리능력
            </caption>
            <colgroup>
            <col class="col50" />
            <col class="col50" />
            <col width="px" />
            <col class="col150" />
            <col class="col35" />
            <col class="col35" />
            <col class="col35" />
            <col class="col35" />
            <col class="col35" />
            <col class="col150" />
            <col class="col40" />
            <col class="col40" />
            <col class="col40" />
            </colgroup>
            <thead>
              <tr>
                <th>영역</th>
                <th>요소</th>
                <th>개념</th>
                <th colspan="7">평정</th>
                <th>본인</th>
                <th>1차</th>
                <th class="td_last">2차</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="10" class="txt_center">관리능력차원 점수합계 (2)</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
            </tfoot>
            <tbody>
              <!-- 목표설정 -->
              <tr>
                <td rowspan="7" class="bg_f5">&nbsp;</td>
                <td rowspan="4" class="txt_center T11B bg_f5">목표<br/>설정</td>
                <td rowspan="4" class="pL5 pR5">조직의 목표와 해야 할 일을 정확히 알아서, 자신이 담당하고 있는 부서나 팀에서 도전할만하면서도 실천가능한 목표를 구체적이고 명확하게 설정하여, 이를 팀원과 함께 공유하고 목표설정을 할 수 있는 능력</td>
                <td class="txt_center">A</td>
                <td colspan="5">&nbsp;</td>
                <td class="txt_center">B</td>
                <td colspan="3" class="txt_center td_last"></td>
              </tr>
              <tr>
                <td class="p3">구체적이고 명확한 업무목표를 세운다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">추상적이고 애매모호한 목표를 세운다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
              <tr>
                <td class="p3">도전할만 하면서도 현실적인 수준의 목표를 수립한다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">지나치게 쉽거나 또는 지나치게 어려운 수준의 목표를 수립한다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
              <tr>
                <td class="p3">항상 자신과 부서(팀)가 해야할 일의 목적이 어디에 있는가를 명확하게 인식한다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">자신이 해야할 일의 목적을 명확히 인식하지 못한 채 독단적으로 부하에게 업무를 분담한다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
              
              <!-- 계획성 -->
              <tr>
                <td rowspan="3" class="txt_center T11B bg_f5">계획성</td>
                <td rowspan="3" class="pL5 pR5">단위조직의 목표가 마감시한과 예산의 범위내에서 달성될 수 있도록 구체적으로 해야할 일들을 정확하게 파악하고 발생 가능한 사태를 미리 예견하여 융통성있는 계획을 수립하여 그 진행과정을 평가하여 수정보완하는 능력</td>
                <td class="p3">누가 언제 무엇을 해야 할 것인가를 알 수 있는 명확하고 구체적인 계획을 수립한다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">애매하고 추상적인 계획을 수립하여 제대로 실천으로 연결되기 어렵다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
              <tr>
                <td class="p3">구성원들의 의견과 정보를 바탕으로 계획을 수립한다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">자신의 모든 일의 세부적인 계획까지 수립코자 하며 구성원 각자의 의견이나 정보경험이 반영되지 않는다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
              </tr>
              <tr>
                <td class="p3">계획과정에서 일을 위해 요청한 시간과 인적, 물적자원이 실제 현실과 일치한다.</td>
                <td class="txt_center">5.00</td>
                <td class="txt_center">4.00</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.00</td>
                <td class="p3">계획상의 마감시간이 잘 지켜지지 않으며 추가적 인물, 물적 자원을 요청하는 경우가 많다.</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center td_last"></td>
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
