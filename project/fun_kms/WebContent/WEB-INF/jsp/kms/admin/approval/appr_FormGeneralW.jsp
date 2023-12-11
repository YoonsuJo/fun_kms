<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
<script type="text/javascript" src="<c:url value='${commonPath}/js/MultiFile.js'/>" ></script>
<c:if test="${approvalVO.templtId>=20}">
	<script type="text/javascript" src="<c:url value='${commonPath}/js/approval${approvalVO.templtId}.jquery.js'/>" ></script>

</c:if>

<script type="text/javascript" src="<c:url value="${rootPath}/validator.do"/>"></script>

<validator:javascript formName="approvalWrite${approvalVO.templtId}" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='${commonPath}/js/jquery.validate.js'/>" ></script>
</head>

<script>
$(document).ready(function() {
	var templtdId = "${approvalVO.templtId}";
	var reWriteYn= "${approvalVO.reWriteYn}";
	var reWriteTyp = "${approvalVO.reWriteTyp}";	
	var mode = "${mode}";

	// 수정기안시 제목 앞에 [수정기안] 자동 표시
	if(reWriteYn==1) {
		var orgSubject = $('#approvalVO1 input[name=subject]').val();
		var newSubject = "[수정기안] " + orgSubject;
		$('#approvalVO1 input[name=subject]').val(newSubject);
	}
	 
	function validateDoc(){
		 
		var  readerFixedInform ="";
		if($('#approvalVO1 input[name=subject]').val()==null 
				|| $('#approvalVO1 input[name=subject]').val().length<3) {
			alert("제목을 기입해주십시오.");
			return false;
		}
		
		var error = checkValidUserMixs($('#approvalVO1 input[name=deciderMix]').val());
		if(error["errorCode"]!=1) {
			alert("전결자에 유효하지 않은 값이 있습니다. 확인해주십시오.");
			$('#approvalVO1 input[name=deciderMix]').focus();
			return false;
		}
		var error = checkValidUserMixs($('#approvalVO1 input[name=deciderMix]').val());
		if(error["errorCode"]!=1) {
			alert("전결자에 유효하지 않은 값이 있습니다. 확인해주십시오.");
			$('#approvalVO1 input[name=deciderMix]').focus();
			return false;
		}
		var error = checkValidUserMixs($('#approvalVO1 input[name=cooperatorMixs]').val());
		if(error["errorCode"]!=1) {
			alert("협조자에 유효하지 않은 값이 있습니다. 확인해주십시오.");
			$('#approvalVO1 input[name=cooperatorMixs]').focus();
			return false;
		}
		var error = checkValidUserMixs($('#approvalVO1 input[name=reviewerMixs]').val());
		if(error["errorCode"]!=1) {
			alert("검토자에 유효하지 않은 값이 있습니다. 확인해주십시오.");
			$('#approvalVO1 input[name=reviewerMixs]').focus();
			return false;
		}
		var error = checkValidUserMixs($('#approvalVO1 input[name=referencerMixs]').val());
		if(error["errorCode"]!=1) {
			alert("참조자에 유효하지 않은 값이 있습니다. 확인해주십시오.");
			$('#approvalVO1 input[name=referencerMixs]').focus();
			return false;
		}
		
		var deciderMix = makeUserIdArray($('#approvalVO1 input[name=deciderMix]').val());
		var cooperatorMixs = makeUserIdArray($('#approvalVO1 input[name= cooperatorMixs]').val());
		var reviewerMixs = makeUserIdArray($('#approvalVO1 input[name=reviewerMixs]').val());
		var referencerMixs = makeUserIdArray($('#approvalVO1 input[name=referencerMixs]').val());
		if(deciderMix.length==0) {
			alert("전결자를 입력하여 주십시오");
			return false;
		}
		for(var i=0; i<deciderMix.length; i++) {
			for(var j=0; j< cooperatorMixs.length;j++) {
				if(cooperatorMixs[j]==deciderMix[i]) {	
					readerFixedInform +="협조자 " + cooperatorMixs[j] + "가 전결자와의 중복으로 삭제됩니다.\n";
					cooperatorMixs.splice(j,1);
					j++;
				}
			}

			for(var j=0; j< reviewerMixs.length;j++) {
				if(reviewerMixs[j]==deciderMix[i]) {
					readerFixedInform +="검토자 " + reviewerMixs[j] + "가 전결자와의 중복으로 삭제됩니다.\n";
					reviewerMixs.splice(j,1);
					j++;
				}
			}
			for(var j=0; j< referencerMixs.length;j++) {
				if(referencerMixs[j]==deciderMix[i]) {
					readerFixedInform +="참조자 " + referencerMixs[j] + "가 전결자와의 중복으로 삭제됩니다.\n";
					referencerMixs.splice(j,1);
					j++;
				}
			}
		}
		
		for(var i=0;i<cooperatorMixs.length; i++) {
			
			for(var j=0; j< reviewerMixs.length;j++) {
				if(reviewerMixs[j]==cooperatorMixs[i]) {
					readerFixedInform +="검토자 " + reviewerMixs[j] + "가 협조자와의 중복으로 삭제됩니다.\n";
					reviewerMixs.splice(j,1);
					j++;
				}
			}
			for(var j=0; j< referencerMixs.length;j++) {
				if(referencerMixs[j]==cooperatorMixs[i]) {
					readerFixedInform +="참조자 " + referencerMixs[j] + "가 협조자와의 중복으로 삭제됩니다.\n";
					referencerMixs.splice(j,1);
					j++;
				}
			}
		}

		for(var i=0;i<reviewerMixs.length; i++) {

			for(var j=0; j< referencerMixs.length;j++) {
				if(referencerMixs[j]==reviewerMixs[i]) {
					readerFixedInform +="참조자 " + referencerMixs[j] + "가 검토자와의 중복으로 삭제됩니다.\n";
					referencerMixs.splice(j,1);
					j++;
				}
			}
		}
		//validator를 이용한 검증
		if(templtId=="1" || templtId>="10")
			;
		else if(!validateApprovalWrite${approvalVO.templtId}(document.specificVO)) {
			return false;
		}

		//지결서 검증
		if(templtId ==10 || templtId ==11 || templtId ==12 || templtId ==13) {
			var confirm = true;
			$('.expenseWriteD').each(function(idx,elm){
				var typChecked = $(elm).find('[name$=expSpendTyp]:checked');
				if(typChecked.length==0) {
					alert("결재구분을 선택하여주십시오.");
					$(elm).find('[name$=expSpendTyp]:eq(0)').focus();
					confirm = false;
					return false;
				}
				//회사결재일때
				if(typChecked.val()=="CP") {
					if($(elm).find('[name$=alreadyPaid]:checked').length==0) {
						if($(elm).find('[name$=payingDueDate]').val().length!=8) {
							alert("지급요청일을 입력하여주십시오. 선지급 시, 선지급 체크란을 체크하여 주십시오.");
							$(elm).find('[name$=payingDueDate]').focus();
							confirm = false;
							return false;
						}
					}							
				}

				if($(elm).find('[name$=accNm]').val()=="") {
					alert("계정과목을 선택하여 주십시오.");
					accGen($(this).find("input[name$=accNm]"),$(this).find("input[name$=accId]"),parseInt(templtId));
					confirm = false;
					return false;
				}
				
				if($(elm).find('[name$=prjFnm]').val()=="") {
					alert("프로젝트를 선택하여 주십시오.");
					if(templtId !=13) 
						prjGen($(this).find("input[name$=prjFnm]"),$(this).find("input[name$=prjId]"),1);
					else
						prjGen($(this).find("input[name$=prjFnm]"),$(this).find("input[name$=prjId]"),1,null,prjSelect);
					confirm = false;
					return false;
				}
				
				if($(elm).find('[name$=companyCd] >option:selected').length==0) {
					alert("회사구분을 선택하여 주십시오.");
					$(elm).find('[name$=companyCd]').focus();
					confirm = false;
					return false;
				}
				
				if($(elm).find('[name$=expDt]').val().length!=8) {
					alert("지출일자를 입력하여 주십시오.");
					$(elm).find('[name$=expDt]').focus();
					confirm = false;
					return false;
				}
				
				var expSpend = $(elm).find('[name$=expSpend]');
				if(isNaN(jsDeleteComma(expSpend.val()) ) || jsDeleteComma(expSpend.val()) == 0 ) {
					alert("금액을 입력하여 주십시오.");
					$(elm).find('[name$=expSpend]').focus();
					confirm = false;
					return false;
				}
				
			});
			
			if(!confirm)
				return false;
			if(templtId ==11) {
				//자기개발비 초과여부 확인.
				var selfdevLeft = parseInt(jsDeleteComma($('#selfdevInfoD .fullLeft').html())) + 
								parseInt(jsDeleteComma($('#selfdevInfoD .halfLeft').html())); 
				var selfdevSum = 0;
				$('[name$=expSpend]').each(function(){
					selfdevSum += parseInt(jsDeleteComma($(this).val()));
				});
				if(selfdevLeft < selfdevSum) {
					alert("남은 자기개발비를 초과하였습니다. 금액을 확인하여주십시오."); 
					return false;
				}				
			} else if(templtId ==12) {	
				var confirm = true;
				$('.expenseWriteD').each(function(idx,elm){
					var expenseSpendSum =0;
					$(this).find('[name*=expDiningSpend]').each(function(){
						expenseSpendSum  += parseInt(jsDeleteComma($(this).val()));
					});
					
					var expense = jsDeleteComma($(this).closest('.expenseWriteD').find('[name$=expSpend]').val());
					if(expense !=expenseSpendSum) {
						alert("팀장경비 지출금액과 부서별 사용금액의 합이 일치하지 않습니다. " + (idx+1) + "번 째 지출칸을 확인해주십시오."); 
						confirm =  false;
						return false;
					}	

					var confirm2 = true;
					$(this).find('[name*=expDiningOrgnztNm]').each(function() {
						if($(this).val()=="") {
							alert("팀장경비 지출부서를 입력하여 주십시오.");
							orgGen($(this).parent().find("input[name*=expDiningOrgnztNm]"),
									$(this).parent().find("input[name*=expDiningOrgnztId]"),1);
							$(this).focus();
							confirm2 = false;
							return false;
						}
					});
					if(!confirm2) {
						confirm = false;
						return false;
					}
				});
				if(!confirm)
					return false;
			} else if(templtId ==13) {	
				var confirm = true;
				var aaa = new Object();
				$('.expenseWriteD').each(function(idx,elm){
					if($(this).find('[name$=column1]:checked').length==0) {
						alert("매입구분을 선택하여 주십시오");
						$(this).find('[name$=column1]:eq(0)').focus();
						confirm = false;
						return false;
					}
					
					if($(this).find('[name$=column2]').val()=="") {
						alert("관련 매출을 선택하여 주십시오.");
						$(this).find('[name$=column2]').focus();	
						confirm = false;
						return false;
					}

					//사외매입 금액 초과 확인.
					{
						var option = $(this).find('[name$=column2] option:selected');
						var salesDocId = option.val();
						var remainPurchaseOut = option.data('purchaseOutSum') - option.data('alreadyPurchasedSum');
						var expense = parseInt(jsDeleteComma($(this).find('[name$=expSpend]').val()));
						if(aaa[salesDocId] ==null) {
							aaa[salesDocId] = remainPurchaseOut - expense;
						} else {
							aaa[salesDocId] = aaa[salesDocId] - expense;
						}
						if(aaa[salesDocId]<0) {
							alert("잔여 매입한도를 초과하였습니다.");
							$(this).find('[name$=expSpend]').focus();
							confirm = false;
						}
						
					}
				});
				
				if(!confirm)
					return false;
			}
		} //지결서 검증 끝
		else if(templtId ==20) {
			var bool = $('#salesDocWriteD').totalSales("validate");
			if(!bool)
				return false;
		} else if(templtId ==21) {
			var bool = $('#salesDocWriteD').generalSales("validate");
			if(!bool)
				return false;
		} else if(templtId ==22) {
			if($('[name=orgnztNm]').val()=="") {
				alert('부서정보를 기입하여 주십시오.');
				orgGen('orgnztNm','orgnztId',1);
				return false;
			}
			var confirm = true;
			$('input.currency1000').each(function() {
				if(isNaN(jsDeleteComma($(this).val())) || jsDeleteComma($(this).val())=="")
				{
					alert("금액을 숫자 형태로 입력하여 주십시오.");
					$(this).focus();
					confirm = false;
					return false;
				}
			});
			if(!confirm)
				return false;
			if($('[name=salesPrjNm]').val()=="") {
				alert('공통비 부담 프로젝트를 입력하여 주십시오.');
				prjGen('salesPrjNm','salesPrjId',1);
				return false;
			}
			if($('[name=purchasePrjNm]').val()=="") {
				alert('공통비 사용 프로젝트를 입력하여 주십시오.');
				prjGen('purchasePrjNm','purchasePrjId',1);
				return false;
			}
		}		
		else if(templtId ==23) {
			if($('[name=userMix]').val()=="") {
				alert ("사용자에 값이 입력되어있지 않습니다. 수정해주십시오.");
				$('[name=userMix]').focus();
				return false;
			}
			var error = checkValidUserMixs($('[name=userMix]').val());
			if(error["errorCode"]!=1) {
				alert ("사용자에 잘못된 값이 입력되어 있습니다. 수정해주십시오.");
				$('[name=userMix]').focus();
				return false;
			}
			if($('#expenseAllD table').length ==0) {
				alert("기초영업비 예산을 입력하여 주십시오.");
				return false;
			}
			var confirm = true;
			$('#expenseAllD table').each(function(idx,elm) {
				if($(this).find('[name*=prjNm]').val()=="") {
					alert("프로젝트 값을 입력하십시오");
					prjGen($(this).find('[name*=prjNm]'),$(this).find('[name*=prjId]'),1);
					confirm = false;
					return false;
				}

				var confirm2 = true;
				$(this).find('input.currency1000').each(function() {
					if(isNaN(jsDeleteComma($(this).val())) || $(this).val()=="") {
						alert("금액을 입력하십시오.");
						$(this).focus();
						confirm2 = false;
						return false;
					}
				});
				if(!confirm2) {
					confirm = false;
					return false;
				}
			});
			if(!confirm)
				return false;
		}
		else if(templtId ==24) {
			var bool = $('#salesDocWriteD').totalSales("validate");
			if(!bool)
				return false;
		}
		else if(templtId ==25) {
			var bool = $('#salesDocWriteD').totalSales("validate");
			if(!bool)
				return false;
		}
		//validate end...
		
		if(readerFixedInform!="")
			alert(readerFixedInform);
		 	
		$('#approvalVO1 input[name=deciderMix]').val(deciderMix);
		$('#approvalVO1 input[name= cooperatorMixs]').val(cooperatorMixs);
		$('#approvalVO1 input[name=reviewerMixs]').val(reviewerMixs);
		$('#approvalVO1 input[name=referencerMixs]').val(referencerMixs);

		//재기안일 경우 재기안 typ 값을 넣어줌.
		if(reWriteYn=="1") {
			$(':input[name=reWriteTyp]:checked').clone().hide().appendTo('#approvalVO2');
		}	
		
		/*submitting*/
		$('#approvalVO1 :input').not(':submit').clone().hide().appendTo('#approvalVO2');
		//22번 사업계획보고서의 경우도 해당 방법으로 submit
		if(templtId < "10" || templtId == "22" ) {
			$('#specificVO :input').each(function() {
				switch (this.tagName.toLowerCase()) {
					case 'textarea':
					case 'select':
						$(this).clone().val(this.value).hide().appendTo('#approvalVO2');
						break;
					case 'input':
						switch (this.type.toLowerCase()) {
							case 'button':
							case 'reset':
							case 'submit':
							case 'image':
								return true;
							case 'radio':
							case 'checkbox':{
								if (this.checked) 
									$(this).clone().val(this.value).hide().appendTo('#approvalVO2');
								break;
							}
							case 'hidden' :
							case 'text' : {
								var clone =$(this).clone(); 
								clone.val(this.value);
								if(clone.hasClass("currency"))
									 clone.val(jsDeleteComma($(this).val()));
								else if(clone.hasClass("currency1000"))
									 clone.val(jsDeleteComma($(this).val()) * 1000);
								clone.hide().appendTo('#approvalVO2');
								break;
							}
							default:
								break;
						}
						break;
					default:
						break;
				}
			 });
		 }			 
		 //지결서, 영업예산보고서의 경우 데이터를 json format으로 변경후 form 에 넣고 submit
		else if(templtId ==10 || templtId ==11 ||  templtId ==12 || templtId ==13) {
			var expenseVO = $('#specificVO').toObject({mode: 'first'})['expense'];
			console.log(JSON.stringify(expenseVO));
			if($('#approvalVO2').find("input[name=jsonInputString]").length>0)
				$('#approvalVO2').find("input[name=jsonInputString]").val(escape(JSON.stringify(expenseVO)));
			else
			 	$('<input name="jsonInputString" type="input" value="'+ escape(JSON.stringify(expenseVO)) + '"/>').hide().appendTo('#approvalVO2');
			// return;
		}  else if(templtId==20) {
			var abc = $('#salesDocWriteD').totalSales("getData");
			console.log(JSON.stringify(abc));				
			$('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==21) {
			 var abc = $('#salesDocWriteD').generalSales("getData");
			 console.log(JSON.stringify(abc));
			 $('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		} // 22번은 1~9번과 같이 가장 먼저 처리
		else if(templtId ==23) {
			///toObject method에서 ','및 1000 핸들링.
			var budgetVO = $('#specificVO').toObject({mode: 'first'});
			console.log(budgetVO);
			if($('#approvalVO2').find("input[name=jsonInputString]").length>0)
				 $('#approvalVO2').find("input[name=jsonInputString]").val(escape(JSON.stringify(budgetVO)));
			 else
			 	$('<input name="jsonInputString" type="input" value="'+ escape(JSON.stringify(budgetVO)) + '"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==24) {
			var abc = $('#salesDocWriteD').totalSales("getData");
			console.log(JSON.stringify(abc));
			$('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==25) {
			var abc = $('#salesDocWriteD').totalSales("getData");
			console.log(JSON.stringify(abc));
			$('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==26) {			
			var expenseVO = $('#specificVO').toObject({mode: 'first'})['expense'];
			console.log(JSON.stringify(expenseVO));
			if($('#approvalVO2').find("input[name=jsonInputString]").length>0)
				$('#approvalVO2').find("input[name=jsonInputString]").val(escape(JSON.stringify(expenseVO)));
			else
			 	$('<input name="jsonInputString" type="input" value="'+ escape(JSON.stringify(expenseVO)) + '"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==27) {
			var abc = $('#salesDocWriteD').totalSales("getData");
			console.log(JSON.stringify(abc));
			$('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		} else if(templtId==28) {
			var abc = $('#salesDocWriteD').totalSales("getData");
			console.log(JSON.stringify(abc));
			$('<input name="jsonInputString" type="input" value =' +   escape(JSON.stringify(abc)) +'"/>').hide().appendTo('#approvalVO2');
		}
		
		return true;
	};
	
	var maxFileNum = document.approvalVO2.posblAtchFileNumber.value;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );

	var form =$('#approvalVO2');
	var templtId =${approvalVO.templtId};
	
	$('#approvalInsertB').click(function(){
		if(!validateDoc())
			return;
		if(mode=="M")
			//save가 3인경우 저장 문서 업데이트 & 상신.
			form.attr("action", "/approval/approvalI.do?save=3");	
		else
			form.attr("action", "/approval/approvalI.do?save=0");
		form.submit();
			
	});
		 
	$('#approvalSaveB').click(function(){
		if(!validateDoc())
			return;
		
		if(mode=="M")
			//save가 2인경우 저장 문서 업데이트.
			form.attr("action", "/approval/approvalI.do?save=2");	
		else
			form.attr("action", "/approval/approvalI.do?save=1");
		form.submit();
	});
	$('#gobackB').click(function(){
		history.go(-1);
	});

	if(reWriteYn==1)
		reWriteTypChange(reWriteTyp);
	
});
//재기안 관련 함수

function reWriteTypChange(typ) {
	if(typ==1) {
		$('#specificVO').show();
		$('#specificVOView').hide();
	} else {
		$('#specificVO').hide();
		$('#specificVOView').show();
	}
}	
</script>

<body>

<div id="wrap">
	<%@ include file="../common/menu/head.jsp"%>
	<!-- S: container -->
	<div id="container">
		<ul class="container_bg">
			<li class="container_left"></li>
			<li class="container_right"></li>
		</ul>
		<!-- S: contents -->
		<div id="contents">
		<%@ include file="./left.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">${appTyp.docSj}</li>
							<li class="navi">홈 > 전자결재 > 기안하기</li>
						</ul>
					</div>
					
					<span class="stxt">
						<print:textarea text="${appTyp.docCt}"/> 
					</span>
						<!-- S: section -->
						<div class="section01">
							<p class="th_stitle mB10">결재정보</p>
							<!-- 게시판 시작  -->
							 <form:form commandName="approvalVO" id="approvalVO1" name="approvalVO" method="post" enctype="multipart/form-data" >
							 <form:hidden path="templtId" />
							 <form:hidden path="docId" />
							 <input type="hidden" value="${mode}"/>
							 <form:hidden path="parntId" />
							 <form:hidden path="reWriteYn" />
							<div class="boardWrite02 mB20">
								<jsp:include page="${jspPath}/approval/include/commonTopW.jsp"></jsp:include>
							</div>
							</form:form>
							
							<c:if test="${approvalVO.reWriteYn==1}">
								<jsp:include page="${jspPath}/approval/include/reWriteInform.jsp"></jsp:include>
							</c:if>
							
							<p class="th_stitle mB10">세부내용</p>
							<c:if test="${approvalVO.reWriteYn==1}">
								<form:form commandName="specificVO" id="specificVOView" name="specificVOView" method="post" enctype="multipart/form-data" >
									<jsp:include page="${jspPath}/approval/include/view${appTyp.templtId}.jsp"></jsp:include>
								</form:form>
							</c:if>
							
							<form:form commandName="specificVO" id="specificVO" name="specificVO" method="post" enctype="multipart/form-data" >
								<c:if test="${approvalVO.reWriteYn==1}">
								</c:if>
								<jsp:include page="./include/write${appTyp.templtId}.jsp"></jsp:include>
							</form:form>
							
							<p class="th_stitle2 mB10">기안내용</p>
							<form:form commandName="approvalVO" id="approvalVO2" name="approvalVO2" method="post" enctype="multipart/form-data" >
							<form:hidden path="posblAtchFileNumber" />
							<input type="hidden" name="returnUrl" value="${rootPath}/approval/modifySaveDoc.do?templtId=${appTyp.templtId}&docId=${approvalVO.docId}"/>
							<div class="boardWrite02 mB20">
								<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
			                    <caption>공지사항 보기</caption>
			                    <colgroup><col class="col120" /><col width="px" /></colgroup>
			                    <tbody>
			                    	<tr>
				                    	<td class="title">내용</td>
				                    	<td class="pL10 pT10 pB10">
				                    		<form:textarea path="content" cssClass="span_24 height_170" />
				                    	</td>
			                    	</tr>
			                    	 <tr>
									    
										<td class="title">첨부파일</td>
										
										<td class="pL10">
											<c:if test="${not empty approvalVO.atchFileId &&mode=='M' }">
												<c:import url="${rootPath}/selectFileInfsForUpdate.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${approvalVO.atchFileId}" />
												</c:import>
											</c:if>	
											<input name="file_1" id="egovComFileUploader" type="file" class="span_15 input01 " />
										</td>
								        
								        
								        
								    </tr>
								    <tr>
									    <td colspan="2">
			      							<div id="egovComFileList"></div>
			      						</td>
		      						</tr>
			                    	<tr>
				                    	
			                    	</tr>
			                    </tbody>
			                    </table>
							</div>
							</form:form>
							<!--// 게시판 끝  -->
							
							<!-- 버튼 시작 -->
			                <div class="btn_area">
			                
			                
			                <img class="cursorPointer" id="approvalInsertB" src="${imagePath}/btn/btn_report.gif"/>
							<img class="cursorPointer" id="approvalSaveB" src="${imagePath}/btn/btn_save.gif"/> 
							<img class="cursorPointer" id="gobackB" src="${imagePath}/btn/btn_cancel.gif"/>
			                </div>
			                <!-- 버튼 끝 -->
						</div>
						<!-- E: section -->
				</div>
				<!-- E: center -->				
				<%@ include file="../include/right.jsp"%>
			</div>
			<!-- E: centerBg -->
		</div>
		<!-- E: contents -->
	</div>
	<!-- E: container -->
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>
