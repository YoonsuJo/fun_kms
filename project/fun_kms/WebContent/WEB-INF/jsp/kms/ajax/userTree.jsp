<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="../include/ajax_inc.jsp"%>
<script>
$(document).ready(function(){
	//해당 org의 바로 아래 org 의  plus/minus상태에 따라 show/hide 시키는 recursive 함수
	function showChild(li){
		li.show();
		if(li.find(".midMinusB").length>0)
		{
			var prntOrgId = li.find("input[name=orgId]").val();
			var prntOrgLv = parseInt(li.find("input[name=orgLv]").val());
				
			$('#userListT li').each(function(index){
				var sn = $(this).find("input[name=orgSn]").val(); 
				var orgLv = $(this).find("input[name=orgLv]").val(); 			
				if(sn.indexOf(prntOrgId)>=0 && prntOrgLv  + 1 == parseInt(orgLv))
					showChild($(this));
			});
		}
	}

	// type이 m이면 main, s면 sub project 
	
	if($('#_usrDiv input[name=_usrTree_searchCondition]:checked').val() == '2'){
		//subProject 숨기기
		$('#userListT input[name=type][value=S]').closest('li').hide();
		/*기본 3단계 노출*/
		for(var i=0; i < 3; i++){
			var li = $('#userListT input[name=orgLv][value='+i+']').closest('li');
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

	
	$('#userListT li').each(function(){
		var orgId = $(this).find("input[name=orgId]").val();
			if(orgId == 'ORGAN_00000000000004' || orgId == 'ORGAN_00000000000005'){
			$(this).find('.plusMinus').removeClass('midMinusB');
			$(this).find('.plusMinus').addClass('midPlusB');
			var orgLv = $(this).find("input[name=orgLv]").val();
			if(orgLv == '3'){
				$(this).closest('li').hide();
			}
		}	
	});
	
	/*leaf프로젝트 +- 버튼 없애기
	$('#userListT li').each(function(){
		var orgLv = $(this).find("input[name=orgLv]").val();
		//마지막 tr일 경우
		if($(this).next().length==0) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
		if(orgLv >= $(this).next().find("input[name=orgLv]").val()) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
	});
	*/
	
	//+버튼 처리
	$('#userListT .midPlusB').live('click', function(){
		var orgId = $(this).closest('li').find("input[name=orgId]").val();
		
		$(this).removeClass('midPlusB');
		$(this).addClass('midMinusB');
		var li = $(this).closest('li');
		
		//$('#userListT').find("input[name=orgSn][value*="+orgId+"]").closest('li').show();
		showChild(li);
		//.parent().find("input[name=prntOrgId][value="+orgId+"]").parent().show();
	});

	//-버튼 처리
	$('#userListT .midMinusB').live('click', function(){
		var orgId = $(this).closest('li').find("input[name=orgId]").val();
		$(this).removeClass('midMinusB');
		$(this).addClass('midPlusB');
		$('#userListT').find("input[name=orgSn][value*="+orgId+"]").closest('li').hide();
		$(this).closest('li').show();
	});

	/////////////////////////////////////////////////////////////////////

	//해당 org의 바로 아래 org 의  plus/minus상태에 따라 show/hide 시키는 recursive 함수
	function showChildSec(li){
		li.show();
		if(li.find(".midMinusB").length>0)
		{
			var prntOrgId = li.find("input[name=orgId]").val();
			var prntOrgLv = parseInt(li.find("input[name=orgLv]").val());
				
			$('#userListTSec li').each(function(index){
				var sn = $(this).find("input[name=orgSn]").val(); 
				var orgLv = $(this).find("input[name=orgLv]").val(); 			
				if(sn.indexOf(prntOrgId)>=0 && prntOrgLv  + 1 == parseInt(orgLv))
					showChildSec($(this));
			});
		}
	}

	// type이 m이면 main, s면 sub project 
	
	if($('#_usrDiv input[name=_usrTree_searchCondition]:checked').val() == '2'){
		//subProject 숨기기
		$('#userListTSec input[name=type][value=S]').closest('li').hide();
		/*기본 3단계 노출*/
		for(var i=0; i < 3; i++){
			var li = $('#userListTSec input[name=orgLv][value='+i+']').closest('li');
			showChildSec(li);
		}

		for(var i=0; i < 2; i++){
			$('.plusMinus_'+i).removeClass('midPlusB');
			$('.plusMinus_'+i).addClass('midMinusB');		
		}
		
	}else{
		$('.plusMinus').removeClass('midPlusB');
		$('.plusMinus').addClass('midMinusB');	
	}

	
	$('#userListTSec li').each(function(){
		var orgId = $(this).find("input[name=orgId]").val();
			if(orgId == 'ORGAN_00000000000004' || orgId == 'ORGAN_00000000000005'){
			$(this).find('.plusMinus').removeClass('midMinusB');
			$(this).find('.plusMinus').addClass('midPlusB');
			var orgLv = $(this).find("input[name=orgLv]").val();
			if(orgLv == '3'){
				$(this).closest('li').hide();
			}
		}	
	});
	
	/*leaf프로젝트 +- 버튼 없애기
	$('#userListTSec li').each(function(){
		var orgLv = $(this).find("input[name=orgLv]").val();
		//마지막 tr일 경우
		if($(this).next().length==0) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
		if(orgLv >= $(this).next().find("input[name=orgLv]").val()) {
			$(this).find('.plusMinus').removeClass('midPlusB');
			$(this).find('.plusMinus').addClass('midNeutralB');
		}
	});
	*/
	
	//+버튼 처리
	$('#userListTSec .midPlusB').live('click', function(){
		var orgId = $(this).closest('li').find("input[name=orgId]").val();
		
		$(this).removeClass('midPlusB');
		$(this).addClass('midMinusB');
		var li = $(this).closest('li');
		
		//$('#userListTSec').find("input[name=orgSn][value*="+orgId+"]").closest('li').show();
		showChildSec(li);
		//.parent().find("input[name=prntOrgId][value="+orgId+"]").parent().show();
	});

	//-버튼 처리
	$('#userListTSec .midMinusB').live('click', function(){
		var orgId = $(this).closest('li').find("input[name=orgId]").val();
		$(this).removeClass('midMinusB');
		$(this).addClass('midPlusB');
		$('#userListTSec').find("input[name=orgSn][value*="+orgId+"]").closest('li').hide();
		$(this).closest('li').show();
	});

	/////////////////////////////////////////////////////////////////////
		
});
</script>

<div id="userListT">    	
 <c:forEach items="${resultListTree}" var="result1" varStatus="status" >
	<c:if test="${result1.orgnztNm != '퇴직자그룹'}">			
		<c:if test="${v_level lt result1.orgLv and status.count gt 1}">
				<ul>
		</c:if>
			<c:if test="${v_level gt result1.orgLv and status.count gt 1}">	
				<c:set var="v_diff" value="${v_level - result1.orgLv}"/>
				<c:forEach begin="0" end="${v_diff-1}" step="1" >
						</ul>
				</c:forEach>   
		</c:if>				
						
		<li>
			<c:if test="${result1.orgLv == '0'}"><input name="type" type="hidden" value="M"/></c:if>
			<c:if test="${result1.orgLv != '0'}"><input name="type" type="hidden" value="S"/></c:if>
			<input name="orgSn" type="hidden" value="${result1.sn }"/>
			<input name="orgId" type="hidden" value="${result1.orgnztId }"/>
			<input name="orgLv" type="hidden" value="${result1.orgLv }"/>
			<input name="prntOrgId" type="hidden" value="${result1.orgUp }"/>		
		<c:choose>
			<c:when test="${not empty result1.no}">
				<img src="${imagePath}/ico/ico_peo.gif">
				<input type="checkbox" name="v_usr" value="${result1.no}/${result1.userNm}/${result1.userId}" >
				<label> ${result1.userNm}</label>	
			</c:when>
			<c:otherwise>					
			
				<label class="plusMinus midPlusB pL10 plusMinus_${result1.orgLv}"></label>
				<img src="${imagePath}/ico/ico_folder.gif">
				<input type="checkbox" name="v_org" value="org">
				<label class="txtB_Black">${result1.orgnztNm}</label>					
			</c:otherwise>
		</c:choose>

			 <c:set var="v_level" value="${result1.orgLv}"/>	 
	</c:if>
 </c:forEach>
</div>

<div id="userListTSec">    	
 <c:forEach items="${resultListTreeSec}" var="result1" varStatus="status" >
	<c:if test="${result1.orgnztNm != '퇴직자그룹'}">			
		<c:if test="${v_level lt result1.orgLv and status.count gt 1}">
				<ul>
		</c:if>
			<c:if test="${v_level gt result1.orgLv and status.count gt 1}">	
				<c:set var="v_diff" value="${v_level - result1.orgLv}"/>
				<c:forEach begin="0" end="${v_diff-1}" step="1" >
						</ul>
				</c:forEach>   
		</c:if>				
						
		<li>
			<c:if test="${result1.orgLv == '0'}"><input name="type" type="hidden" value="M"/></c:if>
			<c:if test="${result1.orgLv != '0'}"><input name="type" type="hidden" value="S"/></c:if>
			<input name="orgSn" type="hidden" value="${result1.sn }"/>
			<input name="orgId" type="hidden" value="${result1.orgnztId }"/>
			<input name="orgLv" type="hidden" value="${result1.orgLv }"/>
			<input name="prntOrgId" type="hidden" value="${result1.orgUp }"/>		
		<c:choose>
			<c:when test="${not empty result1.no}">
				<img src="${imagePath}/ico/ico_peo.gif">
				<input type="checkbox" name="v_usr" value="${result1.no}/${result1.userNm}/${result1.userId}" >
				<label> ${result1.userNm}</label>	
			</c:when>
			<c:otherwise>					
			
				<label class="plusMinus midPlusB pL10 plusMinus_${result1.orgLv}"></label>
				<img src="${imagePath}/ico/ico_folder.gif">
				<input type="checkbox" name="v_org" value="org">
				<label class="txtB_Black">${result1.orgnztNm}</label>					
			</c:otherwise>
		</c:choose>

			 <c:set var="v_level" value="${result1.orgLv}"/>	 
	</c:if>
 </c:forEach>
</div>