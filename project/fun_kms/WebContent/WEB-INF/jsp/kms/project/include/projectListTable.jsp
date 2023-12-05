<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="../../include/ajax_inc.jsp"%>

<script>

///$(document).ready(a,{key1 : 1});
$(document).ready(function(){
	//해당 prj의 바로 아래 prj 의  plus/minus상태에 따라 show/hide 시키는 recursive 함수
	function showChild(tr)
	{
		tr.show();
		if(tr.find(".midMinusB").length>0)
		{
			var prntPrjId = tr.find("input[name=prjId]").val();
			var prntPrjLv = parseInt(tr.find("input[name=prjLv]").val());
			tr.nextAll().each(function(index){
				var sn = $(this).find("input[name=prjSn]").val(); 
				var prjLv = $(this).find("input[name=prjLv]").val(); 
				if(sn.indexOf(prntPrjId)>=0 && prntPrjLv  + 1 == parseInt(prjLv))
					showChild($(this));
			});
		}
	}
	if("${treeMode}"=="Y")
	{
		// type이 m이면 main, s면 sub project 
		
		//subProject 숨기기
		$('#projectListT input[name=type][value=S]').closest('tr').hide();
		//leaf프로젝트 +- 버튼 없애기//
		$('#projectListT tr').each(function(){
			var prjLv = $(this).find("input[name=prjLv]").val();
			//마지막 tr일 경우
			if($(this).next().length==0) {
				$(this).find('.plusMinus').removeClass('midPlusB');
				$(this).find('.plusMinus').addClass('midNeutralB');
			}
			if(prjLv >= $(this).next().find("input[name=prjLv]").val()) {
				$(this).find('.plusMinus').removeClass('midPlusB');
				$(this).find('.plusMinus').addClass('midNeutralB');
			}
		});
		
		//+버튼 처리
		$('#projectListT .midPlusB').live("click",function(){
			var prjId = $(this).closest('tr').find("input[name=prjId]").val();
			$(this).removeClass('midPlusB');
			$(this).addClass('midMinusB');
			var tr = $(this).closest('tr');
			showChild(tr);
			//.parent().find("input[name=prntPrjId][value="+prjId+"]").parent().show();
		});
	
		//-버튼 처리
		$('#projectListT .midMinusB').live("click",function(){
			var prjId = $(this).closest('tr').find("input[name=prjId]").val();
			$(this).removeClass('midMinusB');
			$(this).addClass('midPlusB');
			$('#projectListT').find("input[name=prjSn][value*="+prjId+"]").closest('tr').hide();
			$(this).closest('tr').show();
		});
	}
});

</script>
<table id="projectListT" cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
    <caption>프로젝트 현황</caption>
    <colgroup>
	    <col class="col120" />
	    <col width="px"/>
	    <col class="col70" />
	    <col class="col50" />
	    <col class="col50" />
	    <col class="col70" />
	    <col class="col110" />
    </colgroup>
    <thead>
    	<tr>
    		<th>주관부서</th>
    		<th>프로젝트</th>
    		<th>PL</th>
    		<th>상태</th>
    		<th>구분</th>
    		<th>종료일</th>
    		<th class="td_last">누적수익</th>
    	</tr>
    </thead>
    <tbody>
    
    	<c:forEach items="${resultList}" varStatus="status" var="result">
    	
     	<tr>
     		<td class="hidden">
		     	<input name="type" type="hidden" value="${result.type }"/>
		     	<input name="prntPrjId" type="hidden" value="${result.prntPrjId }"/>
		     	<input name="prjId" type="hidden" value="${result.prjId }"/>
		     	<input name="prjSn" type="hidden" value="${result.prjSn }"/>
		     	<input name="prjLv" type="hidden" value="${result.prjLv }"/>
		    </td>
				<td class="txt_center">${result.orgnztNm }
			</td>
			<td class="pL10 align_m">
				<c:if test="${treeMode=='Y'}">
		      		<c:forEach begin="1" end="${result.prjLv}">
		      			&nbsp;&nbsp;&nbsp;
		      		</c:forEach>
		      		<span class="plusMinus midPlusB pL10"></span>
	      		</c:if>	      		
	      		<a class="cursorPointer" onclick="viewProject('${result.prjId }');">
	      			<span class="txtS_grey">[${result.prjCd }]</span>
	      			<c:if test="${result.prjType == 'E'}">
	      				<img src="${imagePath }/ico/ico_folder2.gif" style="padding-top:2px;"/>
	      			</c:if>
	      			<span class="txtB_grey">${result.prjNm}</span>
	      		</a>
				<a href="javascript:modifyProject('${result.prjId}');"><img class="align_m" src="${imagePath}/btn/btn_plus02.gif"/></a>
	      	</td>
	      	<td class="txt_center"><print:user userNo="${result.leaderNo}" userNm="${result.leaderNm}"/></td>
	      	<td class="txt_center">${result.statNm }</td>
	      	<td class="txt_center">
				<c:choose>
            		<c:when test="${result.prjType == 'P'}">수행</c:when>
            		<c:when test="${result.prjType == 'S'}">영업</c:when>
            		<c:when test="${result.prjType == 'B'}">사업</c:when>
            		<c:when test="${result.prjType == 'M'}">경영</c:when>
            		<c:when test="${result.prjType == 'E'}">폴더</c:when>
            		<c:otherwise></c:otherwise>
           		</c:choose>
	      	</td>
<%-- 	      	<td class="txt_center">${fn:substring(result.compDueDt,0,4)}-${fn:substring(result.compDueDt,4,6)}-${fn:substring(result.compDueDt,6,8)}</td> --%>
	      	<td class="txt_center">${fn:substring(result.compDueDt,0,4)}.${fn:substring(result.compDueDt,4,6)}.${fn:substring(result.compDueDt,6,8)}</td>
	      	<td class="td_last txt_right pR5">${result.busiProfAcc}</td>
     	</tr>	   
    	</c:forEach>                 			                    			                    	
    </tbody>
    </table>