<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
			<!-- 이전 레벨이 높으면 ul 시작 -->
			<!-- 이전 레벨이 낮으면 ul 끝 -->
<script>
var type = '${type}';
$(document).ready(function(){
	//해당 org의 바로 아래 org 의  plus/minus상태에 따라 show/hide 시키는 recursive 함수
	function showChild(li){
		li.show();
		if(li.find(".midMinusB").length>0)
		{
			var prntProjectId = li.find("input[name=projectId]").val();
			var prntProjectLv = parseInt(li.find("input[name=projectLv]").val());
				
			$('#projectListT li').each(function(index){
				var sn = $(this).find("input[name=projectSn]").val(); 
				var projectLv = $(this).find("input[name=projectLv]").val(); 			
				if(sn.indexOf(prntProjectId)>=0 && prntProjectLv  + 1 == parseInt(projectLv))
					showChild($(this));
			});
		}
	}

	// type이 m이면 main, s면 sub project 
	
	//subProject 숨기기
	
	if($('#_prjDiv input[name=_prjTree_searchKeyword]').val() == ''){
		$('#projectListT input[name=type][value=S]').closest('li').hide();
		//기본 3단계 노출
		for(var i=0; i < 3; i++){
			var li = $('#projectListT input[name=projectLv][value='+i+']').closest('li');
			showChild(li);
		}

		for(var i=0; i < 2; i++){
			$('.plusMinus_'+i).removeClass('midPlusB');
			$('.plusMinus_'+i).addClass('midMinusB');
		}
		
	}else{
		$('.plusMinus').removeClass('midPlusB');
		$('.plusMinus').addClass('midMinusB');
	}

	//$('#projectListT li').each(function(){
	//	var prntCnt = $(this).find("input[name=prntCnt]").val();
	//	if(prntCnt == '0'){
	//		$(this).find('.plusMinus').removeClass('midPlusB');
	//		$(this).find('.plusMinus').addClass('midNeutralB');
	//	}	
	//});
	
	
	/*leaf프로젝트 +- 버튼 없애기
	$('#projectListT li').each(function(){
		var projectLv = $(this).find("input[name=projectLv]").val();
		//마지막 tr일 경우
		if($(this).next().length==0) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
		if(projectLv >= $(this).next().find("input[name=projectLv]").val()) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
	});
	*/

	
	//+버튼 처리
	$('#projectListT .midPlusB').live("click",function(){
		var projectId = $(this).closest('li').find("input[name=projectId]").val();
		
		$(this).removeClass('midPlusB');
		$(this).addClass('midMinusB');
		var li = $(this).closest('li');
		
		//$('#projectListT').find("input[name=projectSn][value*="+projectId+"]").closest('li').show();
		showChild(li);
		//.parent().find("input[name=prntProjectId][value="+projectId+"]").parent().show();
	});

	//-버튼 처리
	$('#projectListT .midMinusB').live("click",function(){
		var projectId = $(this).closest('li').find("input[name=projectId]").val();
		$(this).removeClass('midMinusB');
		$(this).addClass('midPlusB');
		$('#projectListT').find("input[name=projectSn][value*="+projectId+"]").closest('li').hide();
		$(this).closest('li').show();
	});
	
	if (type=="T") {
		$('#projectListT .midPlusB').click();
	}
		
});
</script>
<div id="projectListT">  
	<c:forEach items="${resultListTree}" var="result1" varStatus="status" >
		<c:if test="${v_level lt result1.lv and status.count gt 1}">
			<ul>
		</c:if>
		<c:if test="${v_level gt result1.lv  and status.count gt 1}">	
			<c:set var="v_diff" value="${v_level - result1.lv}"/>
			<c:forEach begin="0" end="${v_diff-1}" step="1" >
			<p></p>	</ul>
			</c:forEach>
		</c:if>

		<li>
			<c:if test="${result1.lv == '0'}"><input name="type" type="hidden" value="M"/></c:if>
			<c:if test="${result1.lv != '0'}"><input name="type" type="hidden" value="S"/></c:if>
			<input name="projectSn" type="hidden" value="${result1.sn }"/>
			<input name="projectId" type="hidden" value="${result1.id }"/>
			<input name="projectLv" type="hidden" value="${result1.lv }"/>
			<input name="prntCnt" type="hidden" value="${result1.prntcnt }"/>
		<c:choose>
			<c:when test="${result1.typ=='PRJ'}">
				<c:if test="${result1.prntcnt > 0}">
				<label class="plusMinus midPlusB pL10 plusMinus_${result1.lv}"></label>
				</c:if>
				<img src="${imagePath}/ico/ico_proj.gif" />
				<input type="checkbox" name="v_prj" value="${result1.id}/${result1.nm}/${result1.cd}" >
				<label> <print:project prjCd="${result1.cd}" prjId="${result1.id}" prjNm="${result1.nm}" link="N"/> 
				</label>
			</c:when>
			<c:otherwise >
				<label class="plusMinus midPlusB pL10 plusMinus_${result1.lv}"></label>
				<img src="${imagePath}/ico/ico_folder.gif" />
				<input type="checkbox" name="v_org" value="${result1.id}/${result1.nm}" >
				<label> ${result1.nm}</label>
			</c:otherwise>
		</c:choose>
		<c:set var="v_level" value="${result1.lv}"/>
	</c:forEach>
</div>