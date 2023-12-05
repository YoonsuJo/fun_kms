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
            <li class="over"><a href="mem_pop_AbilityChart03.jsp">업무능력</a></li>
            <li><a href="mem_pop_AbilityChart04.jsp">관리능력</a></li>
            <li><a href="mem_pop_AbilityChart05.jsp">태도행동</a></li>
        </ul>
    </div>

 	<div class="chart_con">
    	<div class="chart_tl mT30">
        	<span class="mR5"><img src="../images/inc/pop_tl_circle.gif" />업무능력차원</span>
        </div>
    
		<!-- 게시판 시작  -->
    	<div class="chart_board02">
          <table cellpadding="0" cellspacing="0" summary="업무능력차원">
            <caption>업무능력</caption>
            <colgroup>
            <col class="col50" />
            <col class="col50" />
            <col class="col200" />
            <col class="col40" />
            <col width="px" />
            <col class="col40" />
            <col class="col40" />
            <col class="col40" />
            </colgroup>
            <thead>
              <tr>
                <th>영역</th>
                <th>요소</th>
                <th>개념</th>
                <th>점수</th>
                <th>평정</th>
                <th>본인</th>
                <th>1차</th>
                <th class="">2차</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="5" class="txt_center">업무능력차원 점수 합계</td>
                <td class="txt_center"></td>
                <td class="txt_center"></td>
                <td class="txt_center "></td>
              </tr>
            </tfoot>
            <tbody>
            <!-- 전문지식과 기술 -->
              <tr>
                <td rowspan="5" class="txt_center T11B bg_f5">전문<br/>지식과<br/>기술</td>
                <td rowspan="5" class="txt_center T11B bg_f5">전문<br/>지식과<br/>기술</td>
                <td rowspan="5" class="pL5 pR5">담당업무를 효과적으로 처리하는데 실무자로서 갖추어야할 전문적 지식과 기술 경험의 정도 및 관련정보를 수집, 전달해 줄 수 있는 능력</td>
                <td class="txt_center">20.00</td>
                <td class="p3">담당업무를 수행하는 데 필요한 충분한 지식과 정보, 경험을 갖고 있으며, 실무업무 수행에 적용이 가능하다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">16.00</td>
                <td class="p3">담당업무에 정통하여 실무업무 수행에 지장을 받지 않는다.</td>
              </tr>
              <tr>
                <td class="txt_center">12.00</td>
                <td class="p3">담당업무수행에 필요한 지식과 기술 및 정보를 갖추고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">8.00</td>
                <td class="p3">기본적인 업무상의 지식과 기술을 갖추고 있으나, 실무업무 수행에 다소 지장이 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">4.00</td>
                <td class="p3">기본적인 업무상의 지식과 기술이 부족하다.</td>
              </tr>
              
              <!-- 적성요인 -->
              <!-- 추진력 -->
              <tr>
                <td rowspan="15" class="txt_center T11B bg_f5">적성<br/>요인</td>
                <td rowspan="5" class="txt_center T11B bg_f5">추진력</td>
                <td rowspan="5" class="pL5 pR5">담당업무를 처리하는데 있어서 곤란한 문제가 발생하더라도 끈질기고 적극적인 문제해결 노력을 통해서 어려움과 문제를 극복하고 주어진 업무를 실행하는 능력</td>
                <td class="txt_center">3.35</td>
                <td class="p3">어떠한 상황에서도 담당업무를 끈기있게 실천하여 높은 성과를 낸다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.68</td>
                <td class="p3">대부분의 사항에서 담당업무를 끈기있게 실천하여 해결한다.</td>
              </tr>
              <tr>
                <td class="txt_center">2.01</td>
                <td class="p3">대체로 무난하게 담당업무를 실천하여 해결한다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.34</td>
                <td class="p3">외부의 지시나 압력이 없으면 담당업무의 실천이 어렵다.</td>
              </tr>
              <tr>
                <td class="txt_center">0.67</td>
                <td class="p3">일상생활이 상당히 무기력하며 일의 시작과 끝이 분명하지 않고 항상 외부상황에 끌려다닌다.</td>
              </tr>
              
              <!-- 문제의식 -->
              <tr>
                <td rowspan="5" class="txt_center T11B bg_f5">문제<br/>의식</td>
                <td rowspan="5" class="pL5 pR5"> 일이 진행되어가는 과정에서 문제가 있음을 인식하고 문제를 구체화하는 능력으로서 항상 문제의 본질이나 배경을 생각하고 현재의 일처리 방식이나 직무수행방법에 끊임없이 의문을 제시하며 개선해 나가는 능력</td>
                <td class="txt_center">3.35</td>
                <td class="p3">항상 담당업무의 처리 방식뿐만 아니라 관련분야의 문제점을 파악하고 이를 개선해 나가려고 노력한다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.68</td>
                <td class="p3">대체로 담당업무의 처리 방식뿐만 아니라 관련분야의 문제점을 파악하고 이를 개선해 나가려고 노력한다.</td>
              </tr>
              <tr>
                <td class="txt_center">2.01</td>
                <td class="p3">개선노력이나 실적은 드물지만, 나름대로 담당업무에 대한 문제의식을 갖고 개선하려는 노력을 계속한다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.34</td>
                <td class="p3">담당업무의 문제점을 인식하고는 있으나, 스스로 개선하려는 적극적인 노력은 하지 않는다.</td>
              </tr>
              <tr>
                <td class="txt_center">0.67</td>
                <td class="p3">담당업무의 문제점을 전혀 인식하지 못하고, 기존의 관습이나, 관행에 따라 업무를 처리하려고 한다.</td>
              </tr>
              
              <!-- 상황대응력 -->
              <tr>
                <td rowspan="5" class="txt_center T11B bg_f5">상황<br/>대응력</td>
                <td rowspan="5" class="pL5 pR5">미래를 예측하고 변화하는 상황에 대응하여 사전에 준비함으로서 조직 및 업무구조를 개선하고 변화를 주도하는 능력</td>
                <td class="txt_center">3.35</td>
                <td class="p3">항상 조직내외적인 환경의 변화에 민감하고, 미래를 예측하고자 하며, 이를 자신의 업무에 반영하려고 노력하고, 구체적인 변화를 만들어 내고 있다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.68</td>
                <td class="p3">조직내외적 환경변화에 관심을 갖고, 미리 준비하여 효과적으로 대처하려고 노력하고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">2.01</td>
                <td class="p3">자신의 업무상의 환경변화에는 관심이 있으나, 이를 구체화, 체계화 시키는 데에는 약간의 어려움이 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.34</td>
                <td class="p3">상황의 변화에 관심은 있으나 현상을 유지하고 주어진 일을 무난하게 처리하는 데 우선적인 노력을 기울이고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">0.67</td>
                <td class="p3">관련 업무상의 환경변화에도 관심이 없으며 상사가 지시한 일상적인 일의 처리에도 급급해한다.</td>
              </tr>
              
              <!-- 정보수집과 활용 -->
              <tr>
                <td rowspan="15" class="bg_f5" >&nbsp;</td>
                <td rowspan="5" class="txt_center T11B bg_f5">정보<br/>수집과<br/>활용</td>
                <td rowspan="5" class="pL5 pR5">일이나 행동 및 그와 관련되는 정보들을 일정한 순서에 따라 지속적이며 체계적으로 수립하고 정돈하며 이를 업무에 활용하는 능력</td>
                <td class="txt_center">3.35</td>
                <td class="p3">항상 다양한 정보를 수집, 분석, 정리하여 유용한 자료로 구체화시켜놓고 있으며, 조직내에서 유능한 정보자료 전문가로 기능하고 있다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.68</td>
                <td class="p3">조직적이지는 못하지만 업무수행에 필요한 정보와 자료를 적극적으로 수집하여 분석정리하고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">2.01</td>
                <td class="p3">업무관련 정보를 수집하여 업무에 활용코자 하나, 적극적으로 다양한 정보를 활용하는 경우는 드물다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.34</td>
                <td class="p3">정보자료에 관심은 있으나 필요한 정보를 선택.분류하는 능력이 부족하다.</td>
              </tr>
              <tr>
                <td class="txt_center">0.67</td>
                <td class="p3">자신의 일과 관련된 정보에 무관심하여 수집.분석 활용 능력도 지극히 미흡하다.</td>
              </tr>
              
              <!-- 교섭설득력 -->
              <tr>
                <td rowspan="5" class="txt_center T11B bg_f5">교섭<br/>설득력</td>
                <td rowspan="5" class="pL5 pR5"> 업무와 관련된 당사자와 교섭, 절충하여 바라는 의도와 목표를 달성할 수 있도록 상대방에게 영향력을 행사하는 능력으로서 자신의 의도를 정확하게 상대방에게 전달하고 실현시키도록 상대를 납득, 이해시키는 능력</td>
                <td class="txt_center">3.30</td>
                <td class="p3">어떤 상대라도 능숙하게 교섭절충하여 자신이 의도한 바를 실현시키며 항상 기대이상의 성과를 얻는다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.64</td>
                <td class="p3">정확하게 자신의 의도를 상대에게 전달하고 이해시킬 수 있으며 자신이 의도한 바 대로 실현되는 경우가 많다. </td>
              </tr>
              <tr>
                <td class="txt_center">1.98</td>
                <td class="p3">자신의 생각이나 의도를 상대에게 비교적 정확하게 전달할 수 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.32</td>
                <td class="p3">자신의 생각이나 의도를 상대에게 충분히 전달하지 못하여 가끔씩은 오해를 사거나 손해를 보는 경우가 있다. </td>
              </tr>
              <tr>
                <td class="txt_center">0.66</td>
                <td class="p3">자신의 생각이나 감정을 제대로 표현하지 못하고 상대에게 끌려다니는 경우가 많다.</td>
              </tr>
              
              <!-- 이해력 -->
              <tr>
                <td rowspan="5" class="txt_center T11B bg_f5">이해력</td>
                <td rowspan="5" class="pL5 pR5">업무의 여러가지 조건과 방침 혹은 대화와 지시의 내용을 정확히 파악하고 업무처리에 임해서 적절한 방법을 취하고 다각적인 관점에서 현상을 측정하며 문제해결에 다방면의 조건을 예상할 수있는 능력</td>
                <td class="txt_center">3.30</td>
                <td class="p3">조직의 방침이나 지시사항,상황의 의미를 정확하게 파악하고, 별도의 지시가 없더라도 필요한 일은 항상 앞서서 스스로 처리해 두고 있다.</td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center"></td>
                <td rowspan="5" class="txt_center "></td>
              </tr>
              <tr>
                <td class="txt_center">2.64</td>
                <td class="p3">방침이나 지시사항에 대한 합리적인 판단과 적절한 결론을 내리고 있다. 거의 대부분의 일은 자신이 스스로 처리하고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.98</td>
                <td class="p3">대체로 상사의 지시나 방침을 이해하고 있으며 일상업무의 경우 지장없이 적절한 조처를 취할 수 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">1.32</td>
                <td class="p3">업무를 인식시키는데 시간과 설득을 요하며, 수시로 일의 진행과정을 확인할 경우 지장없이 일을 처리해내고 있다.</td>
              </tr>
              <tr>
                <td class="txt_center">0.66</td>
                <td class="p3">업무의 인식 및 상황인식능력이 매우 부족하며, 업무진행에 차질을 초래하는 경우도 많다.</td>
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
