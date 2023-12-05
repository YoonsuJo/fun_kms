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
            <li><a href="mem_pop_AbilityChart04.jsp">관리능력</a></li>
            <li class="over"><a href="mem_pop_AbilityChart05.jsp">태도행동</a></li>
        </ul>
    </div>

 	<div class="chart_con">
    	<div class="chart_tl mT30">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />태도와 행동차원</span>
        </div>
    
		<!-- 게시판 시작  -->
    	<div class="chart_board02">
          <table cellpadding="0" cellspacing="0" summary="태도와 행동차원">
            <caption>태도행동</caption>
            <colgroup>
            <col class="col50" />
            <col class="col50" />
            <col class="col200" />
            <col class="col20" />
            <col width="px" />
            <col class="col50" />
            <col class="col50" />
            <col class="col50" />
            <col class="col50" />
            <col class="col50" />
            <col class="col40" />
            <col class="col40" />
            <col class="col40" />
            </colgroup>
            <thead>
              <tr>
                <th>영역</th>
                <th colspan="2">요소</th>
                <th colspan="2">평정</th>
                <th>매우<br/>일치</th>
                <th>일치<br/>하는편</th>
                <th>보통</th>
                <th>일치<br/>하지<br/>않는편</th>
                <th>전혀<br/>일치<br/>하지<br/>않는편</th>
                <th>본인</th>
                <th>1차</th>
                <th class="">2차</th>
              </tr>
            </thead>
            <tfoot>
                <tr>
                    <td colspan="10" class="txt_center">태도와 행동차원 접수합계 (3)</td>
                    <td class="txt_center"></td>
                    <td class="txt_center"></td>
                    <td class="txt_center "></td>
                </tr>
                <tr>
                	<td colspan="10" class="txt_center">총 합 계 (1) + (2) + (3)</td>
                    <td class="txt_center"></td>
                    <td class="txt_center"></td>
                    <td class="txt_center "></td>
                </tr>
            </tfoot>
            <tbody>
            <!-- 일에 대한 태도와 행동 -->
            <tr>
                <td rowspan="4" class="txt_center T11B bg_f5">일에 대한<br/>태도와 행동</td>
                <td rowspan="2" class="txt_center T11B bg_f5">책임감</td>
                <td rowspan="2" class="pL5 pR5">단위조직에서 행해지는 모든 일들에 자신이 직접적으로 관여되어 있음을 인식하고, 스스로를 비판하고 개선해 나가고자 하는 태도와 행동</td>
				<td class="txt_center">A</td>
                <td class="p3">부서에서 행해지는 모든 일들에서 궁극적인 책임은 자신에게 있음을 행동으로 보여준다.</td>
                <td class="txt_center">3.75</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.25</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>
                <td class="p3">자신이 시작한 일에 대해서는 실무자로서 최종적인 마무리를 짓고자 한다.</td>
                <td class="txt_center">3.75</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.25</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
                <td rowspan="2" class="txt_center T11B bg_f5">성취<br/>지향성</td>
                <td rowspan="2" class="pL5 pR5">현재의 자신과 단위조직의 위치에 만족하지 않고 새롭고 어려운 목표에 끊임없이 도전하여 지속적 발전을 위해 노력하는 것</td>
				<td class="txt_center">A</td>                
                <td class="p3">미래를 위한 끊임없는 변신의 노력을 계속한다.</td>
                <td class="txt_center">3.75</td>
                <td class="txt_center">3.00</td>
                <td class="txt_center">2.25</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>
                <td class="p3">현재의 위치에 만족하지 않으며 끊임없이 자기발전을 위해 노력한다. </td>
                <td class="txt_center">3.75</td>
                <td class="txt_center">3.00</td>

                <td class="txt_center">2.25</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            
            <!-- 사람에 대한 태도와 행동 -->
            <tr>
                <td rowspan="4" class="txt_center T11B bg_f5">사람에 대한<br/>태도와 행동</td>
                <td rowspan="2" class="txt_center T11B bg_f5">공정성</td>
                <td rowspan="2" class="pL5 pR5">사적인 감정이나 편견을 배제하고 객관적, 합리적 기준을 일관성있게 적용하여 부하를 평가하고, 지원하는 것</td>
				<td class="txt_center">A</td>            
                <td class="p3">의사결정과 조직운영의 명확한 준거를 제시하고 일관성있게 이를 실천한다.</td>
                <td class="txt_center">2.50</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>            
                <td class="p3">부하의 실적을 평가할 때,사적인 감정에 근거하기 보다는 실질적인 조직목표달성에 기여한 정도에 따라 평가한다.</td>
                <td class="txt_center">2.50</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
                <td rowspan="2" class="txt_center T11B bg_f5">신뢰<br/>형성</td>
                <td rowspan="2" class="pL5 pR5">스스로 말과 행동의 일관성을 유지하고 부하의 결정이나 판단을 신뢰함으로써 모든 구성원들이 서로 믿고 이해하는 분위기를 형성하는 것</td>
				<td class="txt_center">A</td>            
                <td class="p3">같은 팀원들을 믿고 일을 함께 추진하려고 한다.</td>
                <td class="txt_center">2.50</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>            
                <td class="p3">같은 팀원들간에 믿고 이해하는 분위기를 만든다. </td>
                <td class="txt_center">2.50</td>
                <td class="txt_center">2.00</td>
                <td class="txt_center">1.50</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            
            <!-- 조직에 대한 태도와 행동 -->
            <tr>
                <td rowspan="4" class="txt_center T11B bg_f5">조직에 대한<br/>태도와 행동</td>
                <td rowspan="2" class="txt_center T11B bg_f5">충성심</td>
                <td rowspan="2" class="pL5 pR5">회사에 관련된 모든 일을 자신의 일처럼 여기며 헌신하고자 하는 태도와 행동</td>
				<td class="txt_center">A</td>            
                <td class="p3">회사의 이익에 도움이 되는 일이라면 최선을 다하고자 한다.</td>
                <td class="txt_center">1.25</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center">0.25</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>            
                <td class="p3">회사가 어려울 때일 수록 더 열심히 일하고자 한다.</td>
                <td class="txt_center">1.25</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center">0.25</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
                <td rowspan="2" class="txt_center T11B bg_f5">미래<br/>지향성</td>
                <td rowspan="2" class="pL5 pR5">회사의 영속적인 발전을 위하여 미래의 변화에 관심을 두고 이러한 변화에 대응하기 위한 정보, 지식 및 기술을 갖추어 나가고자 하는 태도와 행동</td>
				<td class="txt_center">A</td>            
                <td class="p3">같은 팀원들이 자신의 일과 관련된 분야에서 지식과 기술이 앞으로 어떻게 변화할 것인가에 대해 관심을 갖도록 강조한다. </td>
                <td class="txt_center">1.25</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center">0.25</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
            </tr>
            <tr>
				<td class="txt_center">B</td>            
                <td class="p3">미래에 이 조직이 어떻게 되어야 할 것인가를 고려하여 행동한다. </td>
                <td class="txt_center">1.25</td>
                <td class="txt_center">1.00</td>
                <td class="txt_center">0.75</td>
                <td class="txt_center">0.50</td>
                <td class="txt_center">0.25</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
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
