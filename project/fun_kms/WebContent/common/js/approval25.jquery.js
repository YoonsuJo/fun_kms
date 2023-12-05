

(function( $ ){
	
	var globalData = {
			sPrjId : '',
			pPrjId : '',
			stDt : '',
			edDt : ''
			
	};
	
	var classes={
			
	};
	
	var isInPeriod = function(year, month)
	{
		if(month<10)
			month = "0" + month.toString();
		var ym = year.toString() + month.toString();
		var stYm = globalData.stDt.toString().substring(0, 6);
		var edYm = globalData.edDt.toString().substring(0, 6);
		if(stYm<= ym && edYm >=ym)
			return true;
		else
			return false;
		
	}
	
	var totalSales;
	var TotalSales = function(target)
	{
		var obj = this;
		var totalSales = this;
	    var target = $(target);
	    
		this.getData= function(){
			var objects ={};
			$.extend(true, objects, globalData);
			//object들 수정.
			
			objects.userInputObj = new Array();
			var trList = $('.LaborUserListTable').find('tr');
			for (var i = 0; i < trList.length; i++) {
				var tr = $(trList[i]);
				objects.userInputObj[i] = {
						userId : tr.find('[name=inputId]').val(),
						stDt : tr.find('[name=stDt]').val(),
						edDt : tr.find('[name=edDt]').val(),
						inputPercent : tr.find('[name=inputPercent]').val()
				};
			}
			
			//table, td  해제
			$.each(objects.prjLaborObj,function(key,val){
				//valid하지 않은 year 삭제
				if(!val["_valid"])
					delete objects.prjLaborObj[key];
				else
				{
					delete val["table"];
					for(var i =1 ; i<=12; i++)
					{
						//그 달의 값이 invalid일 경우 값을 0으로 바꿔줌.
						var monthValid = val[i]["_valid"]; 
						$.each(val[i]["user"],function(key,val){
							if(!monthValid)
								val["ratio"] = 0;
							delete val["td"];
						});
					}
				}
			});
			
			//table, td 해제
			$.each(objects.prjExpenseObj,function(key,val){
				//valid하지 않은 year삭제
				if(!val["_valid"])
					delete objects.prjExpenseObj[key];
				else {
					delete val["table"];
					for(var i =1 ; i<=12; i++) {
						//그 달의 값이 invalid일 경우 값을 0으로 바꿔줌.
						var monthValid = val[i]["_valid"]; 
						if(!monthValid)
							val[i]["cost"] = 0;
						//td빼기
						delete val[i]["td"];
					}
				}
			});
		
			return objects;
			
		};
		
	   //Write...
		this.init = function (options)
		{
			$('#beforeSettingD').show();
			 if ( options ) { 
					$.extend( globalData, options );
			 }
			globalData.stYear = parseYear(globalData.stDt);
	 		globalData.edYear = parseYear(globalData.edDt);
	 		globalData.stMonth = parseMonth(globalData.stDt);
	 		globalData.edMonth = parseMonth(globalData.edDt);
	 		classes.purchaseOut= new PurchaseOut($('#salesDocWriteD #purchaseOutD').get()[0]);
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborD').get()[0]);
			classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));
			
			//unique성을 보장하기 위해 변수 전달
			classes.prjLabor.init('prjLaborObj');
			classes.prjExpense.init('prjExpenseObj');
			classes.purchaseOut.init();

			globalData.userInputObj = new Array();
			globalData.purchaseOutObj = new Array();
			
			classes.totalSummingUp.updateView();
		};
		
		//RU, RW
		this.modifyDoc = function (options)
		{
			$('#beforeSettingD').show();
			
			//저장된 변수 값 저장.
			if ( options ) { 
				 $.extend( globalData, options.globalData );
				
			}
			globalData.stYear = parseYear(globalData.stDt);
			globalData.stMonth = parseMonth(globalData.stDt);
			globalData.edYear = parseYear(globalData.edDt);	
			globalData.edMonth = parseMonth(globalData.edDt);
			
				
			
			target.find("[name$=sPrjNm]").val("[" + globalData.sPrjCd + "] "+globalData.sPrjNm);
	    	target.find("[name$=sPrjId]").val(globalData.sPrjId);
	    	target.find("[name$=pPrjNm]").val("[" + globalData.pPrjCd + "] "+globalData.pPrjNm);
	    	target.find("[name$=pPrjId]").val(globalData.pPrjId);
	    	target.find("[name$=stDt]").val(globalData.stDt);
	    	target.find("[name$=salesDoc\\.edDt]").val(globalData.edDt);
	    	
	    	classes.purchaseOut= new PurchaseOut($('#salesDocWriteD #purchaseOutD').get()[0]);
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborD').get()[0]);
			classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));

			classes.purchaseOut.init();

			classes.purchaseOut.updateDoc();
			classes.prjLabor.updateDoc('prjLaborObj');
			classes.prjExpense.updateDoc('prjExpenseObj');
			

			classes.totalSummingUp.updateView();
		};
		
		//문서 작성 중 년월,금액 등  변경 처리
		this.modify = function (options)
		{
			//4변수는 그냥 저장.
			globalData.sPrjId = options.sPrjId;
			globalData.pPrjId = options.pPrjId;
			globalData.salesSj =options.salesSj;
			globalData.decideYn=options.decideYn;
			//년월이 바뀔 경우
			if(options.stDt.toString().substring(0, 6) != globalData.stDt.toString().substring(0, 6) ||options.edDt.toString().substring(0, 6) != globalData.edDt.toString().substring(0, 6) )
			{
				var stDtYm = options.stDt.toString().substring(0,6);
				var edDtYm=options.edDt.toString().substring(0,6);
				
				var bfStDt = globalData.stDt;
				var bfStYear = globalData.stYear;
				var bfStMonth = globalData.stMonth;
				var bfEdDt = globalData.edDt;
				var bfEdYear = globalData.edYear;
				var bfEdMonth = globalData.edMonth;
				globalData.stDt =options.stDt;
				globalData.edDt =options.edDt;
				globalData.stYear = parseYear(options.stDt);
		 		globalData.edYear = parseYear(options.edDt);
		 		globalData.stMonth = parseMonth(options.stDt);
		 		globalData.edMonth = parseMonth(options.edDt);
		 		
		 		// 사외매입 유효성 검사
		 		var check = true;
				$.each(globalData.purchaseOutObj,function(key,val){
					if(getYm(val.year,val.month)<stDtYm) {
						alert("사외매입 매입시작일이 계약시작일보다 먼저입니다. 올바른 값을 입력하여 주십시오.");
						target.find('input[name=salesDoc\\.stDt]').val(globalData.stDt);
						target.find('input[name=salesDoc\\.stDt]').focus();
						check = false;
						return false;
					} else if(getYm(val.year,val.month)>edDtYm) {
						alert("사외매입 매입종료일이 계약종료일보다 먼저입니다. 올바른 값을 입력하여 주십시오.");
						target.find('input[name=salesDoc\\.edDt]').val(globalData.edDt);
						target.find('input[name=salesDoc\\.edDt]').focus();
						check = false;
						return false;
					}
				});
				if(!check)
					return;

		 		// 인건비 판관비 부분 수정.
		 		var searchYear = bfStYear < globalData.stYear ? bfStYear : globalData.stYear;
		 		var endYear = bfEdYear > globalData.edYear ? bfEdYear : globalData.edYear;
		 		for (; searchYear<=endYear; searchYear++)
		 		{
					classes.prjLabor.changeYear(searchYear);
					classes.prjExpense.changeYear(searchYear);
		 		}
		 		classes.totalSummingUp.reInit();
		 		
			}
			//날짜만 바뀌었을 경우
			else if(options.stDt.toString().substring(0, 8) != globalData.stDt.toString().substring(0, 8) ||options.edDt.toString().substring(0, 8) != globalData.edDt.toString().substring(0, 8) )
			{
				var bfStDt = globalData.stDt;
				var bfEdDt = globalData.edDt;
				globalData.stDt = options.stDt;
				globalData.edDt = options.edDt;
				// 인력투입리스트 수정
		 		classes.prjLabor.changeOverDate(bfStDt, bfEdDt);
		 		$('.updateUserInputList').val("false");
		 		$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
			}
			else{
				globalData.stDt =options.stDt;
				globalData.edDt =options.edDt;
			}
		};
		
		//문서 보기
		this.view = function(options)
		{
			if ( options ) { 
				$.extend( globalData, options.globalData );
				classes.purchaseOut= new PurchaseOut($('#salesDocViewD #purchaseOutD').get()[0]);
				classes.prjLabor = new Labor($('#salesDocViewD #prjLaborD').get()[0]);
				classes.prjExpense = new Expense($('#salesDocViewD #prjExpenseD').get()[0]);
				classes.totalSummingUp = new TotalSummingUp($('#salesDocViewD #totalSummingUpD').get([0]));
				classes.purchaseOut.updateView();
				classes.prjExpense.updateView("prjExpenseObj");
				classes.prjLabor.updateView("prjLaborObj");
				target.find(".salesDoc\\.pPrjNm").html("<a href=\"/cooperation/selectProjectV.do?prjId=" + globalData.pPrjId + "\" target=\"_blank\">" + "[" + globalData.pPrjCd + "] "+globalData.pPrjNm + "</a>");
				target.find(".salesDoc\\.sPrjNm").html("<a href=\"/cooperation/selectProjectV.do?prjId=" + globalData.sPrjId + "\" target=\"_blank\">" + "[" + globalData.sPrjCd + "] "+globalData.sPrjNm + "</a>");
		    	target.find(".salesDoc\\.stDt").html(globalData.stDt);
		    	target.find(".salesDoc\\.edDt").html(globalData.edDt);
				classes.totalSummingUp.updateView();
			}
		}
		
		this.validate = function() {

			if (globalData.sPrjId == null || globalData.sPrjId == "") {
				alert("매입 프로젝트를 입력하십시오.");
				prjGen(
						$('#salesDocWriteD input[name=salesDoc\\.sPrjNm]'),
						$('#salesDocWriteD input[name=salesDoc\\.sPrjId]'),
						1,
						null,
						updateDoc
				);
				return false;
			}
			if (globalData.pPrjId == null || globalData.pPrjId == "") {
				alert("매출 프로젝트를 입력하십시오.");
				prjGen(
						$('#salesDocWriteD input[name=salesDoc\\.pPrjNm]'),
						$('#salesDocWriteD input[name=salesDoc\\.pPrjId]'),
						1,
						null,
						updateDoc
						);
				return false;
			}
			
			if (globalData.stDt == null || globalData.stDt == ""
					|| globalData.stDt.length != 8) {
				alert("매출 시작일을 입력하십시오.");
				alert(globalData.stDt.length);
				target.find('input[name=salesDoc\\.stDt]').focus();
				return false;
			}
			
			if (globalData.edDt == null || globalData.edDt == ""
				|| globalData.edDt.length != 8) {
				alert("매출 종료일을 입력하십시오.");
				target.find('input[name=salesDoc\\.edDt]').focus();
				return false;
			}
			
			//purchaseOut validate check
			var purchaseOutBool = true;
			classes.purchaseOut.target.find('tr').each( function(idx, elm) {
				var cost = $(elm).find('[name$=cost]').val();
				if (isNaN(jsDeleteComma(cost))) {
					alert("사외매입 금액을 입력하십시오.");
					$(elm).find('[name$=cost]').focus();
					purchaseOutBool = false;
					return false;
				}
				
				if($(elm).find('[name$=stDt]').val()=="" ||$(elm).find('[name$=stDt]').val().length<6 ){
					alert("사외매입 매입월을 입력하십시오.");
					$(elm).find('[name$=stDt]').focus();
					purchaseOutBool = false;
					return false;
				}
			});
			if (!purchaseOutBool)
				return false;

			//labor validate check
			var check1 = true;
			if($('.updateUserInputList').val() == "false") {
				alert('인건비적용 버튼을 클릭해주세요.');
				$('.applyLaborUserListTableB').focus();
				check1 = false;
			}
			if(!check1)
				return false;

			return true;
		};
		
		
	};
	
	$.fn.totalSales = function(options)
		{
   
        var element = $(this);
        if (element.data('totalSales')) {
			totalSales = element.data('totalSales');
			if (typeof (options) == "object")
				totalSales.modify(options);
			if (options == "getData")
				return totalSales.getData();
			if (options == "validate")
				return totalSales.validate();
		} else {
			totalSales = new TotalSales(this);
			if (options.mode == "W")
				totalSales.init(options);
			else if (options.mode == "V")
				totalSales.view(options);
			else if (options.mode == "M" || options.mode == "RU"|| options.mode == "RW")
				totalSales.modifyDoc(options);
			element.data('totalSales', totalSales);
		}
    
	};
	
	
	
	var Labor = function(target, options)
    {
		if ( options ) { 
	        $.extend( globalData, options );
	        
	   }
	   var tableForm; 
	   $.ajax({
	        url: "/ajax/approval/laborForm.do", 
	        dataType: "html",
	        type: 'POST', //I want a type as POST
	        async: false,
	        success: function(data){
			 tableForm = $(data);}
	   });
	   
	   var updateUserInputList = false;
	   var obj = this;
	   var prjType;
       var target = $(target);
       var userBasicTr = $('<tr>'+ 
			      	'<td class="txt_center laboruserNmTd"></td>'+
			      	'<td class="txt_center userInput month1">-</td>'+
			      	'<td class="txt_center userInput month2">-</td>'+
			      	'<td class="txt_center userInput month3">-</td>'+
			      	'<td class="txt_center userInput month4">-</td>'+
			      	'<td class="txt_center userInput month5">-</td>'+
			      	'<td class="txt_center userInput month6">-</td>'+
			      	'<td class="txt_center userInput month7">-</td>'+
			      	'<td class="txt_center userInput month8">-</td>'+
			      	'<td class="txt_center userInput month9">-</td>'+
			      	'<td class="txt_center userInput month10">-</td>'+
			      	'<td class="txt_center userInput month11">-</td>'+
			      	'<td class="txt_center userInput month12">-</td>'+
			      	'<td class="td_last txt_center userInput">-</td>'+
		     	'</tr>');
       var userListTable = $(
    		   '<div class="boardWrite02 mB20">'+
    		   '<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다." class="LaborUserListTable">'+
    		   '<caption>공지사항 보기</caption>'+
    		   '<colgroup>'+
    				'<col class="col120" />'+
    				'<col class="col120" />'+
    				'<col width="px />'+
    				'<col class="col120" />'+
    				'<col class="col120" />'+
    			'</colgroup>'+
    			'<tbody>'+
    			'</tbody>'+
    			'</table>'+
    			'</div>');
    			//'<img src="' + imagePath + '/btn/btn_add03.gif" class="cursorPointer applyLaborUserListTableB">');
       var userListBasicTr = $('<tr>'+
				'<td class="title userListInputNmTd"></td>'+
				'<td class="title">인력투입 기간</td>'+
				'<td class="pL10" >'+
				'	<input type="text" name="stDt" class="span_3 calGen"  /> ~ <input type="text" name="edDt" class="span_3 calGen"  />'+
				'</td>'+
				'<td class="title">투입률</td>'+
				'<td class="pL10 td_last" >'+
				'	<input type="text" name="inputPercent" class="input01 span_3" onfocus="numGen(\'inputPercent\', 1, 100, 10)" />%'+
				'</td>'+
          	'</tr>');
		  
	   

    	this.init = function(typ) {
    		console.log("labor init start");
    		prjType = typ;
    		globalData[prjType] = new Object();
    		//table 삽입
    		userListTable.appendTo($('#prjLaborD'));
    		target.find('.laborUserAddB').click(obj.insertUserByInputBox);
			target.find('.laborUserTreeB').bind("click",function(){
				usrGen(target.find('.laborUserNm'),2);
			});
			for (var searchYear =globalData.stYear ; searchYear<= globalData.edYear ; searchYear ++ )
			{
				obj.createYear(searchYear);
			}
			target.find('.laborUserAddB').click(obj.insertUserByInputBox);
			target.find('.laborUserTreeB').bind("click",function(){
				usrGen(target.find('.laborUserNm'),2);
			});
			var applyBtn = $('<span class="th_plus03 mT10 mB10"><img src="' + imagePath + '/btn/btn_apply_user_input_2.gif" class="cursorPointer applyLaborUserListTableB"></span>');
			applyBtn.appendTo($('.LaborUserListTable').closest('div'));
			applyBtn.append($('<input type="hidden" name="updateUserInputList" class="updateUserInputList" value="false"/>'));
			applyBtn.click(obj.applyUserInputList);
			applyBtn.hide();
    	};
    	this.updateDoc = function (typ){
    		prjType = typ;
    		target.find('.laborUserAddB').click(obj.insertUserByInputBox);
			target.find('.laborUserTreeB').bind("click",function(){
				usrGen(target.find('.laborUserNm'),2);
			});
			
			userListTable.appendTo(target);
			
    		for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
    		{
    			var dataClone = tableForm.clone();
    			dataClone.addClass("year"+searchYear);
    			dataClone.find(".laborYearTh").html(searchYear + "년도");
    			
    			dataClone.addClass(prjType);
				dataClone.appendTo(target);
				globalData[prjType][searchYear]["table"] = dataClone;
				//다른 테이블에 저장된 user값들을 불러옴.
				var userIdArray = new Array();
				var userNmArray = new Array();
				var i = 0;
				
				//아무 년도 값(현재 삽입된 년도 제외)을 가져와도 됨으로, 첫 번째 년도의 값을 가져온다. 
				for(var firstYear in globalData[prjType]){
					$.each(globalData[prjType][firstYear][1]['user'],function(key,val){
						userIdArray[i] = val.userId;
						userNmArray[i] = val.userNm;
						i++;
					});
					//for문에서 탈출
					break;
				}
				
				//하나라도 저장된 값이 있을시 insert실행
				$.each(userIdArray, function(key,userId)
				{
					userTr =userBasicTr.clone(); 
					userTr.data('userId',userId);
					userTr.appendTo(globalData[prjType][searchYear]["table"].find('tbody'));
					//userTr.find('td:eq(0)').html(userNmArray[key]+ '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
					userTr.find('td:eq(0)').html(userNmArray[key]);
						//name값 저장.
					userTr.find("td").each(function(idx,elm){
						//1번째 td부터.. 12번째 td까지
						if(idx>0  && idx<=12)
						{
							$(this).addClass("year"+searchYear);
							$(this).data("inputName", $(target).attr("id") + "\." +  searchYear + "\." + idx + "\."+ userId );
    						$(this).data("year",searchYear);
    						$(this).data("month",idx);
    						$(this).data("userId",userId);
    						globalData[prjType][searchYear][idx]["user"][userId]['td'] =$(this);
    						//기간에 포함될 시  input box 생성
    						if(isInPeriod(searchYear, idx))
    						{
    							$(this).html('<input type="text" class="span_1" value = "0" disabled="true" />');
    							$(this).find('input').attr("name", $(this).data("inputName"));
    							$(this).find('input').val(globalData[prjType][searchYear][idx]["user"][userId]["ratio"]);
    							obj.calcHorizonSum($(this));
        						obj.calcVerticalSum($(this));
    						}
    						
						}
					});
					
					//del 버튼 활성화
					/*
					userTr.find(".userTrDelB").click(function(){
						var nth = $(this).closest('tr').index();
						//값을 0 으로 초기화ㅏ하고 veticalSum 실행
						$(this).closest('tr').find('input').each(function(idx,elm){
							$(this).val(0);
							obj.calcVerticalSum($(this).parent());
							
						});

						var tr = target.find("tbody").find('tr:eq('+nth+')');
						//data 삭제 
						$.each(globalData[prjType],function(key,val){
							for(var n =1; n<=12 ; n++)
								delete(globalData[prjType][key][n]["user"][tr.data("userId")]);
						});
						classes.totalSummingUp.updatePrjLabor();
						//tr삭제
						tr.remove();
					});
					*/
				});
				
				
    		}
    		target.find('input[type=text]').live("keyup",function(){
    			
    			if ("inputPercent" == $(this).attr('name')) {
    				return;
    			}
    			
				//가로, 세로 통계 계산
				obj.calcHorizonSum($(this).parent());
				obj.calcVerticalSum($(this).parent());
				var year = $(this).parent().data("year");
				var month = $(this).parent().data("month");
				var userId = $(this).parent().data("userId");
				globalData[prjType][year][month]["user"][userId]["ratio"] = jsDeleteComma($(this).val());
				classes.totalSummingUp.updatePrjLabor();
			});
    		
    		if (globalData.userInputObj.length > 0) {
    			var updateUserInputObj = globalData.userInputObj;
    			for (var i = 0; i < updateUserInputObj.length; i++) {
    				var tmp = updateUserInputObj[i];
    				var tr = userListBasicTr.clone();
    				tr.find('[name=inputPercent]').val(tmp.inputPercent);
    				tr.find('[name=stDt]').val(tmp.stDt);
    				tr.find('[name=edDt]').val(tmp.edDt);
    				
    				tr.find(".userListInputNmTd").html(tmp.userNm + '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
    				tr.find(".userListInputNmTd").html(tr.find(".userListInputNmTd").html() + '<input type="hidden" name="inputId"/>'+'<input type="hidden" name="laborUserMix"/>');
    				tr.find('[name=inputId]').val(tmp.userId);
    				tr.find('[name=laborUserMix]').val(tmp.userNm+"("+tmp.userId+")");
    				
    				tr.appendTo(userListTable.find('tbody'));
    				
    				tr.find("input[type=text]").change(function(){
    					$('.updateUserInputList').val("false");
    					$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
    				});
    				
    				tr.find(".userTrDelB").click(function(){
    					var nth = $(this).closest('tr').index();
    					
    					//var tr = target.find("tbody").find('tr:eq('+nth+')');
    					
    					var delUserId = "";
    					var boolDel = true;
    					var idxList = $('.LaborUserListTable').find('tr');
    					for (var j = idxList.length - 1; j >= 0 ; j--) {
    						var delIdx = $(idxList.get(j)).index();
    						if (delIdx == nth) {
    							delUserId = $(idxList.get(j)).find('input[name=inputId]').val();
    							$(idxList.get(j)).remove();
    							idxList = $('.LaborUserListTable').find('tr');
    							for (var k = 0; k < idxList.length; k++) {
    								if (delUserId == $(idxList.get(k)).find('input[name=inputId]').val()) {
    									boolDel = false;
    									break;
    								}
    							}
    							break;
    						}
    					}
    					
    					obj.calcUserInputList();
    					
    					if (boolDel) {
    						//data 삭제 
    						$.each(globalData[prjType],function(key,val){
    							for(var n =1; n<=12 ; n++) {
    								delete(globalData[prjType][key][n]["user"][delUserId]);
    							}
    						});
    						//통계계산 
    						//classes.sales.updateSales();
    						//classes.summingUp.updateLabor();
    						classes.totalSummingUp.updatePrjLabor();
    						//classes.totalSummingUp.updatePPrjLabor();
    						
    						//tr삭제
    						//tr.remove();
    						var txtList = $('.prjLaborObj').find('input[type=text]');
    						for (var j = 0; j < txtList.length; j++) {
    							var delId = $(txtList.get(j)).attr('name');
    							delId = delId.substring(delId.length - delUserId.length, delId.length);
    							if (delId == delUserId) {
    								if ($(txtList.get(j)).closest('tr').length > 0)
    									$(txtList.get(j)).closest('tr').remove();
    							}
    						}
    						
    						obj.calcUserInputList();
    						
    						if ($('.LaborUserListTable').find('tr').length == 0)
    							$('.applyLaborUserListTableB').parent().hide();
    					}
    				});
    			}
    			var applyBtn = $('<span class="th_plus03 mT10 mB10"><img src="' + imagePath + '/btn/btn_apply_user_input.gif" class="cursorPointer applyLaborUserListTableB"></span>');
    			applyBtn.appendTo($('.LaborUserListTable').closest('div'));
    			applyBtn.append($('<input type="hidden" name="updateUserInputList" class="updateUserInputList" value="true"/>'));
    			applyBtn.click(obj.applyUserInputList);
    		}
    	}
    	this.updateView = function (typ){
    		
    		if (globalData.userInputObj.length > 0) {
    			userListTable.appendTo($('#prjLaborD'));
    			$('#prjLaborD').find('.LaborUserListTable').removeClass('LaborUserListTable');
    		}
    		
    		for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
    		{
    			var dataClone = tableForm.clone();
    			dataClone.addClass("year"+searchYear);
    			dataClone.find(".laborYearTh").html(searchYear + "년도");
    			prjType = typ;
    			dataClone.addClass(prjType);
    			dataClone.appendTo(target);
    			globalData[prjType][searchYear]["table"] = dataClone;
    			var userIdArray = new Array();
    			var userNmArray = new Array();
    			var i = 0;
    			
    			//아무 년도 값(현재 삽입된 년도 제외)을 가져와도 되므로, 첫 번째 년도의 값을 가져온다. 
    			for(var firstYear in globalData[prjType]){
    				$.each(globalData[prjType][firstYear][1]['user'],function(key,val){
    					userIdArray[i] = val.userId;
    					userNmArray[i] = val.userNm;
    					//for문에서 탈출
    					i++;
    				});
    				break;
    			}
    			
    			//하나라도 저장된 값이 있을시 insert실행
    			$.each(userIdArray, function(key,userId)
    			{
    				userTr =userBasicTr.clone(); 
    				userTr.appendTo(globalData[prjType][searchYear]["table"].find('tbody'));
    				userTr.find('td:eq(0)').html(userNmArray[key]);
    				//name값 저장.
    				var horizonSum = 0.0;
    				userTr.find("td").each(function(idx,elm){
    					//1번째 td부터.. 12번째 td까지
    					if(idx>0  && idx<=12)
    					{
    						$(this).addClass("year"+searchYear);
    						$(this).data("inputName", $(target).attr("id") + "\." +  searchYear + "\." + idx + "\."+ userIdArray[i] );
    						$(this).data("year",searchYear);
    						$(this).data("month",idx);
    						$(this).data("userId",userIdArray[i]);
    						globalData[prjType][searchYear][idx]["user"][userId]['td'] =$(this);
    						//기간에 포함될 시  input box 생성
    						if(isInPeriod(searchYear, idx))
    						{
    							$(this).html(globalData[prjType][searchYear][idx]["user"][userId]["ratio"]);
    							horizonSum += globalData[prjType][searchYear][idx]["user"][userId]["ratio"];
    						}
    					}
    				});
    				//소계 부분 계산
                	userTr.find('td').last().html(roundXL(horizonSum,1));
    				
    			});
    			
    			//소계 부분 계산
    			var totalSum = 0.0;
    			for(var i = 1; i<=12 ; i++)
                {
    				
    				if(isInPeriod(searchYear, i))
    				{
	                	var verticalSum = 0.0;
	        			var tbody = globalData[prjType][searchYear]["table"].find('tbody')
	        			tbody.find("tr").find("td:eq(" + i + ")" ).each(function(){
	        				verticalSum +=  parseFloat(jsDeleteComma($(this).html()));
	        			});
	        			totalSum += verticalSum; 
	        			tbody.closest('table').find("tfoot tr td:eq(" + i +")").html(roundXL(verticalSum,1));
    				}
        		}	
    			tbody.closest('table').find("tfoot tr td:last").html(roundXL(totalSum,1));
    			
            };
            
            if (globalData.userInputObj.length > 0) {
            	var updateUserInputObj = globalData.userInputObj;
            	for (var i = 0; i < updateUserInputObj.length; i++) {
            		var tmp = updateUserInputObj[i];
            		var tr = userListBasicTr.clone();
            		tr.find('[name=inputPercent]').parent().html(tmp.inputPercent + '%');
            		tr.find('[name=stDt]').parent().html(tmp.stDt + ' ~ ' + tmp.edDt);
            		tr.find(".userListInputNmTd").html(tmp.userNm);
            		tr.appendTo(userListTable.find('tbody'));
            	}
            }
            
    	}
    	//해당 년도 테이블 생성
    	this.createYear = function (year)
    	{
    		var dataClone = tableForm.clone();
			dataClone.addClass("year"+year);
			dataClone.addClass(prjType);
			//년도 변경
			dataClone.find('.laborYearTh').html(year + "년도" );
			//valid한 월에 값 삽입
			//globalData 값 넣어줌.
			globalData[prjType][year] = new Object();
			globalData[prjType][year]["_valid"] = true;
			globalData[prjType][year]["table"] = dataClone;
			for(var i = 1; i <=12 ; i++)
			{
				globalData[prjType][year][i] = new Object();
				globalData[prjType][year][i]["user"] = new Object();
			}
			dataClone.find('.verticalTotal').each(function(idx,elem){
				$(this).addClass("year" + year);
			});
			if(target.find('table').length == 0)
				dataClone.appendTo(target);
			else
			{
				//table 삽입
				bfYear = year-1;
				var bfTable = target.find('table.year'+bfYear);
				if(bfTable.length ==1)
				{
					dataClone.insertAfter(bfTable);
				}
				else
				{
					dataClone.appendTo(target);
				}
				
				
				//다른 테이블에 저장된 user값들을 불러옴.
				var userIdArray = new Array();
				var userNmArray = new Array();
				var i = 0;
				
				//아무 년도 값(현재 삽입된 년도 제외)을 가져와도 됨으로, 첫 번째 년도의 값을 가져온다. 
				for(var firstYear in globalData[prjType]){
					if(firstYear == year)//현재년도 제외
						continue;
					$.each(globalData[prjType][firstYear][1]['user'],function(key,val){
						userIdArray[i] = val.userId;
						userNmArray[i] = val.userNm;
						//for문에서 탈출
						i++;
					});
					break;
				}
				
				//하나라도 저장된 값이 있을시 insert실행
				if(i!=0)
					obj.insertUser(userIdArray, userNmArray, year);
						
				
			}
			
			//합계부분 '-' 를 0으로 바꿔줌.
			for(var i = 1; i <=12 ; i++)
			{
				if(isInPeriod(year,i))
				{
					var yearClass = "year" + year;
					var monthClass = "month" + i;
					target.find('.verticalTotal.'+yearClass+'.'+monthClass).html('0');
				}
			}
		
		};
    	
		this.changeYear = function (year)
		{
			//valid할 경우
			if(year>=globalData.stYear && year <= globalData.edYear)
			{
				obj.validYear(year);
			}
			else
				obj.invalidYear(year);
			$('.updateUserInputList').val("false");
			$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
		}
		//해당년도 보이기
		this.validYear = function(year)
		{
			if(typeof(globalData[prjType][year])=='object')
			{
				if(!globalData[prjType][year]["_valid"])
				{
					var table = globalData[prjType][year]["table"];
					bfYear = year-1;
					var bfTable = target.find('table.year'+bfYear);
					if(bfTable.length ==1)
					{
						table.insertAfter(bfTable);
					}
					else
					{
						table.insertAfter(target.find('p:eq(0)'));
					}
					globalData[prjType][year]["_valid"] = true;
				}
				obj.changeMonth(year);
			}
			else
			{
				obj.createYear(year);
			}
		}
		
		//해당년도 테이블 숨기기
		this.invalidYear = function(year)
		{
			if(typeof(globalData[prjType][year])=='object')
			{
				globalData[prjType][year]["table"].detach();
				globalData[prjType][year]["_valid"] = false;
			}
			else{
				;
			}
		}
		
		//해당 년도 월이 변경 됬을 경우 콜.
		this.changeMonth = function(year)
		{
			stMonth = 1;
			edMonth = 12;
			if(globalData.stYear == year)
				stMonth = globalData.stMonth;
			if(globalData.edYear == year)
				edMonth = globalData.edMonth;
			
			//월을 돌면서 input box값 생성 등을 함.
			for (var i =1; i<=12 ; i++)
			{
				//범위안에 있을 시
				if(i>=stMonth && i <=edMonth)
				{
					//해당월이 이미 valid한지 체크
					if(globalData[prjType][year][i]["_valid"]){
						;
					}
					else{
						globalData[prjType][year][i]["_valid"] = true;
						$.each(globalData[prjType][year][i]["user"],function(key,val){
							var td = $(val["td"]);
							// td.html(('<input type="text" class="span_1" value = "'+ val['ratio']+'"/>'));
							td.html(('<input type="text" class="span_1" value = "0" disabled="true" name="prjLaborD.' + year + '.' + i + '.' + key + '"/>'));
							
							obj.calcVerticalSum(td);
							obj.calcHorizonSum(td);
						});
						
					}
					
				}
				//없을 시
				else
				{
					if(globalData[prjType][year][i]["_valid"]){
						globalData[prjType][year][i]["_valid"] = false;
						$.each(globalData[prjType][year][i]["user"],function(key,val){
							var td = $(val["td"]);
							td.html("-");
							var index = td.index();
							td.closest('table').find('td:eq('+index+')').html('-');
							obj.calcVerticalSum(td);
							obj.calcHorizonSum(td);
						});
					}
					else{
						;
					}
				
				}
							
				   
			}
		}

		this.changeOverDate = function(bfStDt, bfEdDt)
		{
			if (bfStDt < globalData.stDt)
	 			$('.LaborUserListTable').find('[name=stDt]').each(function (){
	 				if ($(this).val() < globalData.stDt)
	 					$(this).val(globalData.stDt);
	 			});
	 		if (bfEdDt > globalData.edDt)
	 			$('.LaborUserListTable').find('[name=edDt]').each(function (){
	 				if ($(this).val() > globalData.edDt)
	 					$(this).val(globalData.edDt);
	 			});
	 		this.applyUserInputList();
		}
		
        this.calcHorizonSum = function(td)
        {
        	var horizonSum = 0.0;
        	td.closest('tr').find("input[type=text]").each(function(){
				horizonSum += parseFloat(jsDeleteComma($(this).val()));
			});
        	$(td).closest('tr').find('td').last().html(roundXL(horizonSum,1));
        };
        
        this.calcVerticalSum = function(td)
        {
        	var verticalSum = 0.0;
			var index = td.index();
			td.closest("tbody").find("tr").find("td:eq(" + index + ") input" ).each(function(){
				verticalSum +=  parseFloat(jsDeleteComma($(this).val()));
			});
			td.closest("table").find("tfoot tr td:eq(" + index +")").html(roundXL(verticalSum,1));
			var totalSum = 0.0;
			$.each(td.closest("table").find("tfoot tr td"),function(idx,elm){
				if(idx==0)
					return true;
				else if(idx==13)
					$(this).html(roundXL(totalSum,1));
				else
				{
					if($(this).html()!="-")
						totalSum += parseFloat($(this).html());
				}
			});
        };
        
        this.applyUserInputList = function()
        {
        	if (obj.validateUserInputList()) {
        		obj.calcUserInputList();
        		$('.updateUserInputList').val("true");
        		$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input.gif");
        	} else {
        		$('.updateUserInputList').val("false");
        		$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
        	}
        }
        
        this.validateUserInputList = function()
        {
        	var trList = $('.LaborUserListTable').find('tr');
        	for (var i = 0; i < trList.length; i++) {
        		var stDt = $(trList.get(i)).find('[name=stDt]').val();
        		var edDt = $(trList.get(i)).find('[name=edDt]').val();
        		var cmpStDt = $('#salesDocWriteT').find('[name$=stDt]').val();
        		var cmpEdDt = $('#salesDocWriteT').find('[name$=edDt]').val();
        		var inputPercent = $(trList.get(i)).find('[name=inputPercent]').val();
        		if (cmpStDt > stDt) {
        			alert('인력 투입 기간의 시작일은 계약 기간의 시작일보다 먼저일 수 없습니다.');
        			$(trList.get(i)).find('[name=stDt]').val("");
        			$(trList.get(i)).find('[name=stDt]').focus();
        			//$('#salesDocWriteT').find('[name$=stDt]').focus();
        			return false;
        		} else if (edDt > cmpEdDt) {
        			alert('인력 투입 기간의 종료일은 계약 기간의 종료일보다 나중일 수 없습니다.');
        			$(trList.get(i)).find('[name=edDt]').val("");
        			$(trList.get(i)).find('[name=edDt]').focus();
        			//$('#salesDocWriteT').find('[name$=edDt]').focus();
        			return false;
        		} else if (stDt > edDt) {
        			alert('인력 투입 기간의 종료일은 인력 투입 기간의 시작일보다 나중일 수 없습니다.');
        			$(trList.get(i)).find('[name=edDt]').val("");
        			$(trList.get(i)).find('[name=edDt]').focus();
        			return false;
        		} else if (inputPercent == "" || isNaN(inputPercent)) {
        			alert('투입률에 잘못된 값이 입력되었습니다.');
        			$(trList.get(i)).find('[name=inputPercent]').focus();
        			return false;
        		}
        	}
        	return true;
        }
        
        this.calcUserInputList = function()
        {
        	if (!obj.validateUserInputList())
        		return;
        	
        	// 1. 투입인력테이블의 MM계산
        	$('.prjLaborObj').find('input').val(0);
        	var trList = $('.LaborUserListTable').find('tr');
        	for (var i = 0; i < trList.length; i++) {
        		var tr = $(trList[i]);
        		
        		var userId = tr.find('[name=inputId]').val();
        		var stDt = tr.find('[name=stDt]').val();
        		var edDt = tr.find('[name=edDt]').val();
        		var inputPercent = tr.find('[name=inputPercent]').val();
        		
        		for (var j = stDt.substr(0, 6); j <= edDt.substr(0, 6);) {
        			var result = 1.0;
        			if (j == stDt.substr(0, 6)) {
        				var dateCount = lastDaySelect(stDt.substr(0, 6));
        				if (stDt.substr(0, 6) == edDt.substr(0, 6))
        					result = parseFloat(parseInt(edDt.substr(6, 2)) - parseInt(stDt.substr(6, 2)) + 1) / dateCount;
        				else
        					result = parseFloat(dateCount - stDt.substr(6, 2) + 1) / dateCount;
        			} else if (j == edDt.substr(0, 6)) {
        				var dateCount = lastDaySelect(edDt.substr(0, 6));
        				result = parseFloat(edDt.substr(6, 2) / dateCount);
        			}
        			result = result * inputPercent / 100;
        			
        			var tmp = parseInt(j.substr(4,2) - 1);
        			var cell = $('.prjLaborObj');
        			cell = cell.find('[name^=prjLaborD]');
        			// cell = cell.find('[name$=' + userId + ']');
        			/*
        			for (var ii = 0; ii < cell.length; ii++) {
        				var tmp = cell.get(ii);
        				if (tmp.attr('name') == '') {
        					cell = $(cell.get(ii));
        					break;
        				}
        			}
        			 * */
        			
        			var t = 0;
        			var month = j.substr(5, 1);
        			if (j.substr(4, 1) != "0")
        				month = j.substr(4, 2);
        			var v1 = "prjLaborD." + j.substr(0, 4) + "." + month + "." + userId;
        			for (var k = 0; k < cell.length; k++) {
        				var v2 = $(cell.get(k)).attr('name');
        				if (v1 == v2) {
        					t = k;
        					break;
        				}
        			}
        			cell = cell.get(t);
        			$(cell).val(parseFloat($(cell).val()) + result);
        			
        			j = (parseInt(j) + 1).toString();
        			if (j.substr(4, 2) == "13")
        				j = (parseInt(j.substr(0, 4)) + 1) + "01";
        		}
        	}
        	
        	// 2. 투입인력테이블 종, 횡 계산
        	$.each($('.prjLaborObj').find('input[type=text]'),function(){
		    	//가로, 세로 통계 계산
				obj.calcHorizonSum($(this).parent());
				obj.calcVerticalSum($(this).parent());
				var year = $(this).parent().data("year");
				var month = $(this).parent().data("month");
				var userId = $(this).parent().data("userId");
				globalData[prjType][year][month]["user"][userId]["ratio"] = jsDeleteComma($(this).val());
				//classes.sales.updateSales();
				//classes.summingUp.updateLabor();
				classes.totalSummingUp.updatePrjLabor();
				//classes.totalSummingUp.updatePPrjLabor();
		    });
        	
        	//수직 합계 재계산
        	var len = $('.prjLaborObj').find('tbody tr:eq(0) td').length;
        	if (len == 0) {
        		;
        	} else {
        		$.each($('.prjLaborObj').find('tbody tr:eq(0) td'),function(idx,elm){
    				if(idx > 0)
    					obj.calcVerticalSum($(this));
    			});
        	}
			
			//통계계산 
			//classes.summingUp.updateLabor();
			//classes.totalSummingUp.updatePPrjLabor();
			classes.totalSummingUp.updatePrjLabor();
        	
        	// 3. 종합테이블 계산
        	//     classes.sales.updateSales();
			//     classes.summingUp.updateLabor();
			//     classes.totalSummingUp.updatePPrjLabor();
			
			$('.updateUserInputList').val("true");
			$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
        };
        
     	this.insertUserByInputBox = function (){
    		console.log("insert User Start");
    		
    		$('.applyLaborUserListTableB').parent().show();
    		
    		var userMixs = target.find('.laborUserNm').val();
    		
    		var userIdArray = makeUserIdArray(userMixs);
    		var userNmArray = makeUserNmArray(userMixs);	
    		target.find('.laborUserNm').val("");
    		obj.insertLaborUserList(userIdArray,userNmArray);
    		
    		var error = checkValidUserMixs(userMixs);
    		if(error["errorCode"]==1)
    		{
    			for(var searchYear = globalData.stYear; searchYear <= globalData.edYear ; searchYear ++)
    			{
    				obj.insertUser(userIdArray,userNmArray,searchYear);
    			}
    		}
    		
    		obj.applyUserInputList();
     	};	
     	
     	this.insertLaborUserList = function(userIdArray,userNmArray){
     		
     		for (var i = 0; i < userIdArray.length ; i++)
			{
     			var userListTr = userListBasicTr.clone();
     			
				// 이름 및 del버튼 추가
				userListTr.find(".userListInputNmTd").html(userNmArray[i] + '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
				
				userListTr.find(".userListInputNmTd").html(userListTr.find(".userListInputNmTd").html() + '<input type="hidden" name="inputId"/>'+'<input type="hidden" name="laborUserMix"/>');
				userListTr.find('[name=inputId]').val(userIdArray[i]);
				userListTr.find('[name=laborUserMix]').val(userNmArray[i]+"("+userIdArray[i]+")");
				
				userListTr.find('[name=stDt]').val($('#salesDocWriteT').find('[name$=stDt]').val());
	     		userListTr.find('[name=edDt]').val($('#salesDocWriteT').find('[name$=edDt]').val());
	     		userListTr.find('[name=inputPercent]').val(100);
	     		
	     		userListTr.appendTo($('.LaborUserListTable').find('tbody'));
	     		
	     		/*
	     		userListTr.find('input[type=text]').live("keyup change",function(){
	     			alert("alert!");
	     			$('.updateUserInputList').val("false");
	     		});
	     		 * */
	     		
	     		userListTr.find("input[type=text]").change(function(){
	     			$('.updateUserInputList').val("false");
	     			$('.updateUserInputList').prev().attr("src", imagePath + "/btn/btn_apply_user_input_2.gif");
	     		});
	     		
	     		userListTr.find(".userTrDelB").click(function(){
					var nth = $(this).closest('tr').index();
					
					//var tr = target.find("tbody").find('tr:eq('+nth+')');
					
					var delUserId = "";
					var boolDel = true;
					var idxList = $('.LaborUserListTable').find('tr');
					for (var j = idxList.length - 1; j >= 0 ; j--) {
						var delIdx = $(idxList.get(j)).index();
						if (delIdx == nth) {
							delUserId = $(idxList.get(j)).find('input[name=inputId]').val();
							$(idxList.get(j)).remove();
							idxList = $('.LaborUserListTable').find('tr');
							for (var k = 0; k < idxList.length; k++) {
								if (delUserId == $(idxList.get(k)).find('input[name=inputId]').val()) {
									boolDel = false;
									break;
								}
							}
							break;
						}
					}

					obj.calcUserInputList();
					
					if (boolDel) {
						//data 삭제 
						$.each(globalData[prjType],function(key,val){
							for(var n =1; n<=12 ; n++) {
								delete(globalData[prjType][key][n]["user"][delUserId]);
							}
						});
						//통계계산 
						//classes.sales.updateSales();
						//classes.summingUp.updateLabor();
						classes.totalSummingUp.updatePrjLabor();
						//classes.totalSummingUp.updatePPrjLabor();
						
						//tr삭제
						//tr.remove();
						var txtList = $('.prjLaborObj').find('input[type=text]');
						for (var j = 0; j < txtList.length; j++) {
							var delId = $(txtList.get(j)).attr('name');
							delId = delId.substring(delId.length - delUserId.length, delId.length);
							if (delId == delUserId) {
								if ($(txtList.get(j)).closest('tr').length > 0)
									$(txtList.get(j)).closest('tr').remove();
							}
						}
						
						obj.calcUserInputList();
						
						if ($('.LaborUserListTable').find('tr').length == 0)
							$('.applyLaborUserListTableB').parent().hide();
					}
				});
			}
     	};
     	
     	this.insertUser = function (userIdArray,userNmArray,searchYear){
     		var userInfo = escape(JSON.stringify({year : searchYear, userIdList : userIdArray}));
			var laborInfo;
			$.ajax({
    	        url: "/ajax/salary/selectUserSalaryYearWeight.do", 
    	        dataType: "html",
    	        type: 'POST', //I want a type as POST
    	        async: false,
    	        data : {userInfo : userInfo },
    	        success: function(data){
    	        	laborInfo = JSON.parse(data);
    	        }
			});
			for (var i = 0; i < userIdArray.length ; i++)
			{
				if(typeof(globalData[prjType][searchYear][1]["user"][userIdArray[i]])!="undefined")
					continue;
				var userTr = userBasicTr.clone();
				// 이름 및 del버튼 추가
				//userTr.find(".laboruserNmTd").html(userNmArray[i] + '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
				userTr.find(".laboruserNmTd").html(userNmArray[i]);
				userTr.data("userNm",userNmArray[i] );
				userTr.data("userId",userIdArray[i] );
				
				//tbody에 tr을 넣어줌 + globalData에 data삽입
				userTr.appendTo(globalData[prjType][searchYear]["table"].find('tbody')).each(function(idx,elm){
					var year = globalData.stYear + idx;
					//name값 저장.
					$(this).find("td").each(function(idx,elm){
						//1번째 td부터.. 12번째 td까지
						if(idx>0  && idx<=12)
						{
							$(this).addClass("year"+searchYear);
    						$(this).data("inputName", $(target).attr("id") + "\." +  searchYear + "\." + idx + "\."+ userIdArray[i] );
    						$(this).data("year",searchYear);
    						$(this).data("month",idx);
    						$(this).data("userId",userIdArray[i]);
    						var labor = 0;
    						if(typeof(laborInfo[userIdArray[i]])!="undefined")
    							labor = laborInfo[userIdArray[i]]["salary"+idx];
    							
    						globalData[prjType][searchYear][idx]["user"][userIdArray[i]] ={
    								userNm : userNmArray[i],
    								labor : parseInt(labor),
    								userId : userIdArray[i],
    								td : $(this),
    								ratio : 1
    						}
    						
    						//기간에 포함될 시  input box 생성
    						if(isInPeriod(searchYear, idx))
    						{
    							globalData[prjType][searchYear][idx]["_valid"] = true;
    							$(this).html('<input type="text" class="span_1" value = "0" disabled="true" name="' + $(this).data("inputName") + '"/>');
    							//$(this).attr("name", $(this).data("inputName"));
    							//globalData[prjType][year][idx][userIdArray[i]]["_valid"] =  true;
    						}
    						else
    							globalData[prjType][searchYear][idx]["_valid"] = false;
    						
						}
						//맨 마지막 td에서는 수평 합계 합산.
						else if(idx==13)
							obj.calcHorizonSum($(this));
					});
					//del 버튼 활성화
					$(this).find(".userTrDelB").click(function(){
    					var nth = $(this).closest('tr').index();
    					//값을 0 으로 초기화ㅏ하고 veticalSum 실행
    					$(this).closest('tr').find('input').each(function(idx,elm){
    						$(this).val(0);
    						obj.calcVerticalSum($(this).parent());
    						
    					});

    					var tr = target.find("tbody").find('tr:eq('+nth+')');
    					//data 삭제 
    					$.each(globalData[prjType],function(key,val){
    						for(var n =1; n<=12 ; n++)
    							delete(globalData[prjType][key][n]["user"][tr.data("userId")]);
    					});
    					//통계계산 
						classes.totalSummingUp.updatePrjLabor();
    					//tr삭제
    					tr.remove();
    				});
					
					
					$(this).find('input[type=text]').live("keyup",function(){
						//가로, 세로 통계 계산
						obj.calcHorizonSum($(this).parent());
						obj.calcVerticalSum($(this).parent());
						var year = $(this).parent().data("year");
						var month = $(this).parent().data("month");
						var userId = $(this).parent().data("userId");
						globalData[prjType][year][month]["user"][userId]["ratio"] = jsDeleteComma($(this).val());
						classes.totalSummingUp.updatePrjLabor();
						
					});
				});
			}
			//수직 합계 재계산
			$.each(globalData[prjType][searchYear]["table"].find('tbody tr:eq(0) td'),function(idx,elm){
				obj.calcVerticalSum($(this));
				
			});
			
			//통계계산 
			classes.totalSummingUp.updatePrjLabor();
			
     	}
       
   };
	
   var Expense = function(target, options)
	{
		
		if ( options ) { 
			$.extend( globalData, options );
		}
		var tableForm; 
		$.ajax({
			url: "/ajax/approval/expenseForm.do", 
			dataType: "html",
			type: 'POST', //I want a type as POST
			async: false,
			success: function(data){
			tableForm = $(data);}
		});
		
		var obj = this;
		var prjType;
		var target = $(target);
		this.init = function(typ) {
			console.log("expense init start");
			prjType = typ;
			globalData[prjType] = new Object();
			//table 삽입
			for (var searchYear =globalData.stYear ; searchYear<= globalData.edYear ; searchYear ++ )
			{
				obj.createYear(searchYear);
			}
		};
		
		this.updateView = function(typ){
			prjType = typ;
			for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
    		{
    			var dataClone = tableForm.clone();
    			dataClone.addClass("year"+searchYear);
    			dataClone.find('.expenseYearTd').html(searchYear + "년도" );
    			dataClone.addClass(prjType);
				dataClone.appendTo(target);
				globalData[prjType][searchYear]["table"] = dataClone;
				var costSum = 0;
				for(var searchMonth = 1; searchMonth<=12;searchMonth++){
					if(isInPeriod(searchYear,searchMonth))
					{
						costSum +=globalData[prjType][searchYear][searchMonth]['cost']; 
						var costPrint = jsAddComma(parseInt(globalData[prjType][searchYear][searchMonth]['cost']/1000));
						dataClone.find('tbody td:eq('+ searchMonth +')').html(costPrint);
					}
				}
				globalData[prjType][searchYear]["table"].find('tbody td:last').html(jsAddComma(parseInt(costSum/1000)));
    		}
		}
		
		this.updateDoc = function(typ){
			prjType = typ;
			for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
			{
				var dataClone = tableForm.clone();
				dataClone.addClass("year"+searchYear);
				dataClone.find('.expenseYearTd').html(searchYear + "년도" );
				dataClone.addClass(prjType);
				dataClone.appendTo(target);
				dataClone.find('td.verticalTotal, td.expenseInput').each(function(idx,elem){
					$(this).addClass("year" + searchYear);
				});
				
				globalData[prjType][searchYear]["table"] = dataClone;
				for(var searchMonth = 1; searchMonth<=12;searchMonth++){
					var yearClass = "year" + searchYear;
					var monthClass = "month" + searchMonth;
					globalData[prjType][searchYear][searchMonth]["td"] = dataClone.find('td.expenseInput.'+yearClass+'.'+monthClass);
					globalData[prjType][searchYear][searchMonth]["td"].data("inputName",$(target).attr("id") + "\." +  searchYear + "\." + searchMonth);
					globalData[prjType][searchYear][searchMonth]["td"].data("year",searchYear);
					globalData[prjType][searchYear][searchMonth]["td"].data("month",searchMonth);
					if(isInPeriod(searchYear,searchMonth))
					{
						var costPrint = jsAddComma(parseInt(globalData[prjType][searchYear][searchMonth]['cost']/1000));
						globalData[prjType][searchYear][searchMonth]["td"].html('<input type="text" class="span_1" value = "0"/>');
						globalData[prjType][searchYear][searchMonth]["td"].find('input').val(costPrint);
					}
				}
				obj.calcHorizonSum(globalData[prjType][searchYear]["table"].find('tbody td:eq(0)'));
			}
			obj.inputLive();
			
		}
		this.createYear = function(year)
		{
			var dataClone = tableForm.clone();
			dataClone.addClass("year"+year);
			dataClone.addClass(prjType);
			//년도 변경
			dataClone.find('.expenseYearTd').html((year) + "년도" );
			
			//globalData 값 넣어줌.
			globalData[prjType][year] = new Object();
			globalData[prjType][year]["_valid"] = true;
			globalData[prjType][year]["table"] = dataClone;
			
			dataClone.find('td.verticalTotal, td.expenseInput').each(function(idx,elem){
				$(this).addClass("year" + year);
			});
			dataClone.appendTo(target);
			if(target.find('table').length == 0)
				dataClone.appendTo(target);
			else
			{
				//table 삽입
				bfYear = year-1;
				var bfTable = target.find('table.year'+bfYear);
				if(bfTable.length ==1)
				{
					dataClone.insertAfter(bfTable);
				}
				else
				{
					dataClone.insertAfter(target.find('p:eq(0)'));
				}
			}
			//합계부분 '-' 를 0으로 바꿔줌.
			for(var i = 1; i <=12 ; i++)
			{
				var yearClass = "year" + year;
				var monthClass = "month" + i;
				globalData[prjType][year][i] = new Object();
				globalData[prjType][year][i]["cost"] = 0;
				globalData[prjType][year][i]["td"] = dataClone.find('td.expenseInput.'+yearClass+'.'+monthClass);
				globalData[prjType][year][i]["td"].data("inputName",$(target).attr("id") + "\." +  year + "\." + i);
				globalData[prjType][year][i]["td"].data("year",year);
				globalData[prjType][year][i]["td"].data("month",i);
				if(isInPeriod(year,i))
				{
					globalData[prjType][year][i]["_valid"]  = true;
					dataClone.find('.verticalTotal.'+yearClass+'.'+monthClass).html('0');
					globalData[prjType][year][i]["td"].html('<input type="text" class="span_1" value = "0"/>');
					/*.each(function(idx,elm){
	   						$(elm).find('input').attr("name", $(elm).data("inputName"));
					});*/
				}
			}
			obj.inputLive();
		}
		
		//해당년도 테이블 숨기기
		this.invalidYear = function(year)
		{
			if(typeof(globalData[prjType][year])=='object')
			{
				globalData[prjType][year]["table"].detach();
				globalData[prjType][year]["_valid"] = false;
			}
			else{
				;
			}
			
		}
		
		//해당년도 보이기
		this.validYear = function(year)
		{
			if(typeof(globalData[prjType][year])=='object')
			{
				if(!globalData[prjType][year]["_valid"])
				{
					var table = globalData[prjType][year]["table"];
					bfYear = year-1;
					var bfTable = target.find('table.year'+bfYear);
					if(bfTable.length ==1)
					{
						table.insertAfter(bfTable);
					}
					else
					{
						table.insertAfter(target.find('p:eq(0)'));
					}
					globalData[prjType][year]["_valid"] = true;
				}
				obj.changeMonth(year);
			}
			else
			{
				obj.createYear(year);
			}
		}
		
		this.changeYear = function (year)
		{
			//valid할 경우
			if(year>=globalData.stYear && year <= globalData.edYear)
			{
				obj.validYear(year);
			}
			else
				obj.invalidYear(year);
		}
		
		//해당 년도 월이 변경 됬을 경우 콜.
		this.changeMonth = function(year)
		{
			stMonth = 1;
			edMonth = 12;
			if(globalData.stYear == year)
				stMonth = globalData.stMonth;
			if(globalData.edYear == year)
				edMonth = globalData.edMonth;
			
			//월을 돌면서 input box값 생성 등을 함.
			for (var i =1; i<=12 ; i++)
			{
				//범위안에 있을 시
				if(i>=stMonth && i <=edMonth)
				{
					//해당월이 이미 valid한지 체크
					if(globalData[prjType][year][i]["_valid"]){
						;
					}
					else{
						globalData[prjType][year][i]["_valid"] = true;
						var td = globalData[prjType][year][i]["td"];
						cost =parseInt(globalData[prjType][year][i]['cost']/1000);
						td.html('<input type="text" class="span_1" value = "'+cost+'"/>');
						td.find('input').attr("name", $(this).data("inputName"));
					}
					
				}
				//없을 시
				else
				{
					
					if(globalData[prjType][year][i]["_valid"]){
						globalData[prjType][year][i]["_valid"] = false;
						var td = globalData[prjType][year][i]["td"];
						td.html("-");
					}
					else{
						;
					}
				}
			}
			obj.calcHorizonSum(globalData[prjType][year][1]["td"]);
		}
		
		this.calcHorizonSum = function(td)
		{
			var horizonSum = 0;
			$(td).closest('tr').find("input[type=text]").each(function(){
				horizonSum += parseFloat(Numeric.rmComma($(this).val()));
			});
			$(td).closest('tr').find('td').last().html(jsAddComma(horizonSum));
		};
		
	/*	this.calcVerticalSum = function(td)
		{
			var verticalSum = 0;
			var index = $(td).index();
			$(td).closest("tbody").find("tr").find("td:eq(" + index + ") input" ).each(function(){
				verticalSum +=  parseFloat(Numeric.rmComma($(this).val()));
			});
			$(td).closest("table").find("tfoot tr td:eq(" + index +")").html(verticalSum);
		};
		*/
		this.inputLive = function (){
			target.find('input[type=text]').live("keyup",function(){
				jsMakeCurrency(this);
				//가로, 세로 통계 계산
				obj.calcHorizonSum($(this).closest('td'));
				/*obj.calcVerticalSum($(this).closest('td'));*/
				var year = $(this).parent().data("year");
				var month = $(this).parent().data("month");
				var userId = $(this).parent().data("userId");
				globalData[prjType][year][month]["cost"] = parseInt(jsDeleteComma($(this).val())) * 1000;
				classes.totalSummingUp.updatePrjExpense();
			
			});
		}
		
	};

	var PurchaseOut = function(target, options)
	{
		var cnt = 0;
		var basicTr = $('<tr>'+
				'<td class="title">금액</td>'+
				'<td class="pL10" >'+
					'<input type="text" name="cost" class="span_6 currency purchaseOutCost"  value="0" /> 원<br/>(부가세별도)'+
				'</td>'+
				'<td class="title">매입월</td>'+
				'<td class="pL10" >'+
					'<input type="text" name="stDt" class="span_3 calGenMonth"  />'+
					'<span class="hidden edDtSpan"> ~'+
					'<input type="text" name="edDt" class="span_3 calGenMonth"  />'+
					'</span>' +
					'<label><input type="checkbox" name="isRepeat"/> 반복</label>'+
				'</td>'+
				'<td class="title">비고</td>'+
				'<td class="pL10" ><input type="text" class="span_6" name="ct" value=""/></td>'+
				'<td class="title">소계</td>'+
				'<td class="pL10 pR5 tar purchaseOutSubSum" ></td>'+
				'<td><img src="'+imagePath+'/btn/btn_minus02.gif" class="cursorPointer purchaseOutDelB"></td>'+
			'</tr>');
		var viewTr = $('<tr>'+
				'<td class="title">금액</td>'+
				'<td class="pL10 pR10 tar">'+
					'<span class="span_6 currency cost purchaseOutCost"></span>원<br>(부가세별도)'+
				'</td>'+
				'<td class="title">매입월</td>'+
				'<td class="pL10" >'+
					'<span class="span_4 stDt"></span>~'+
					'<span class="span_4 edDt"></span>'+
				'</td>'+
				'<td class="title">비고</td>'+
				'<td class="pL10" >'+
					'<span class="span_6 ct"></span></td>'+
				'</td>'+
				'<td class="title">소계</td>'+
				'<td class="pL10 pR10 tar purchaseOutSubSum"></td>'+
			'</tr>');
		var obj= this;
		var target = $(target);
		this.target = target;
		this.init = function() {
			target.find('#purchaseOutAddB').click(function(){
				obj.addWriteTr();
			});
		};

		this.addWriteTr = function (){
			addedTr = basicTr.clone() ; 
			addedTr.appendTo(target.find('tbody')).find("[name]").each(function(idx,elm){
				$(this).attr("name", "purchaseOut\[" +cnt + "\]\." + $(this).attr("name") );
			});

			addedTr.find('.purchaseOutDelB').click(function(){
				$(this).closest('tr').remove();
				calcPurchaseOutSum(target);
				obj.updatePurchaseOut();
				//classes.sales.updateSales(false);
				//classes.summingUp.updatePurchaseOut();
				classes.totalSummingUp.updatePurchaseOut();
			});

			addedTr.find('[name$=isRepeat]').click(function(){
				//var isChecked =$(this).attr("checked");
				var isChecked =$(this).is(":checked");
				var parentTr = $(this).closest("tr");
				if(isChecked) {
					parentTr.find(".edDtSpan").show();
				} else {
					parentTr.find("[name$=edDt]").val(parentTr.find("[name$=stDt]").val());
					calcPurchaseOutSum(target);
					parentTr.find(".edDtSpan").hide();
				}
			});

			addedTr.find('[name$=cost]').bind("keyup",function(){
				jsMakeCurrency(this);
				obj.updatePurchaseOut();
				//classes.sales.updateSales(false);
				//classes.summingUp.updatePurchaseOut();
				classes.totalSummingUp.updatePurchaseOut();
			});
			addedTr.find('[name$=ct]').bind("keyup",function(){
				obj.updatePurchaseOut();
			});

			addedTr.find('[name$=stDt]').bind("keyup change",function(){
				var edDt = $(this).closest('tr').find('[name$=edDt]').val();
				if($(this).val()< globalData.stDt.toString().substring(0, 6))
				{
					alert("매입 시작일은 매출 시작일보다 이전일 수 없습니다.");
					$(this).focus();
					$(this).val("");
					return;
				}
				else if($(this).val()>edDt && edDt.length==6)
				{
					alert("매입 시작일은 매입 종료일보다 이전일 수 없습니다.");
					$(this).focus();
					$(this).val("");
					return;
				}
				obj.updatePurchaseOut();
				//classes.sales.updateSales(false);
				//classes.summingUp.updatePurchaseOut();
				classes.totalSummingUp.updatePurchaseOut();
			});

			addedTr.find('[name$=edDt]').bind("keyup change",function(){
				var stDt = $(this).closest('tr').find('[name$=stDt]').val();
				if($(this).val()>globalData.edDt.toString().substring(0, 6)){
					alert("매입 종료일은 매출 종료일보다 이후일 수 없습니다.");
					$(this).focus();
					$(this).val("");
					return;
				}else if($(this).val()<stDt){
					alert("매입 종료일은 매입 시작일보다 이전일 수 없습니다.");
					$(this).focus();
					$(this).val("");
					return;
				}
				obj.updatePurchaseOut();
				//classes.sales.updateSales(false);
				//classes.summingUp.updatePurchaseOut();
				classes.totalSummingUp.updatePurchaseOut();
			});

			addedTr.find('[name$=isRepeat]').bind("keyup change",function(){
				obj.updatePurchaseOut();
				//classes.sales.updateSales(false);
				//classes.summingUp.updatePurchaseOut();
				classes.totalSummingUp.updatePurchaseOut();
			});
			
			addedTr.find('.purchaseOutCost, [name$=stDt], [name$=edDt]').bind("change keyup", function() {
				calcPurchaseOutSum(target);
			});
			
			function calcPurchaseOutSum(objTarget) {
				var purchaseOutSum = 0;
				objTarget.find('tr').each( function() {
					var cost = parseInt(jsDeleteComma($(this).find('.purchaseOutCost').val()));
					if (isNaN(cost)) cost = 0;
					var stDt = $(this).find('[name$=stDt]').val();
					var edDt = $(this).find('[name$=edDt]').val();
					var year = 0;
					var month = 0;
					if (stDt!='' && edDt!='') {
						year = edDt.substring(0,4) - stDt.substring(0,4);
						month = edDt.substring(4,6) - stDt.substring(4,6);
					}
					var calculatedMonth = (year * 12) + month + 1;
					var subSum = cost * calculatedMonth;
					$(this).find('.purchaseOutSubSum').html(jsAddComma(subSum) + '원<br>(부가세별도)');
					purchaseOutSum += subSum;
				});
				objTarget.find('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
				obj.updatePurchaseOut();
			}
			
			cnt++;
			return addedTr;
		};

		this.updateDoc = function (){
			var identifyNo = -1;
			var purchaseOutSum = 0;
			var costSubSum = 0;
			var cost = 0;
			var stDt = "";
			var edDt ="";
			var tmpStDt = "";
			var tmpEdDt ="";
			var ct ="";
			
			$.each(globalData.purchaseOutObj, function(key,val){

				if(val.identifyNo != identifyNo)
				{
					if(identifyNo ==-1)
					;
					else
					{
						var cloneTr =obj.addWriteTr();
						cloneTr.find('[name$=cost]').val(jsAddComma(cost));
						cloneTr.find('.purchaseOutSubSum').html(jsAddComma(costSubSum) + '원<br>(부가세별도)');
						cloneTr.find('[name$=stDt]').val(stDt);
						cloneTr.find('[name$=edDt]').val(edDt);
						if(stDt!=edDt)
						{
							cloneTr.find(".edDtSpan").show();
							cloneTr.find("[name$=isRepeat]").attr("checked",true);
						}
						cloneTr.find('[name$=ct]').val(ct);
						purchaseOutSum += costSubSum;
						costSubSum = 0;
					}
					cost = 0;
					stDt = "";
					edDt ="";
					ct ="";
				}
				identifyNo = val.identifyNo;
				cost = val.cost;
				costSubSum += cost;
				tmpStDt = getYm(val.year,val.month);
				tmpEdDt = getYm(val.year,val.month);
				if (tmpStDt < stDt || stDt=='') stDt = tmpStDt;		// 최소년월 구하기
				if (tmpEdDt > edDt || edDt=='') edDt = tmpEdDt;		// 최대년월 구하기
				ct = val.ct;
			});	

			if(globalData.purchaseOutObj.length>=1)
			{
				var cloneTr =obj.addWriteTr();
				cloneTr.find('[name$=cost]').val(jsAddComma(cost));
				cloneTr.find('.purchaseOutSubSum').html(jsAddComma(costSubSum) + '원<br>(부가세별도)');
				cloneTr.find('[name$=stDt]').val(stDt);
				cloneTr.find('[name$=edDt]').val(edDt);
				if(stDt!=edDt)
				{
					cloneTr.find(".edDtSpan").show();
					cloneTr.find("[name$=isRepeat]").attr("checked","checked");
				}
				cloneTr.find('[name$=ct]').val(ct);
				purchaseOutSum += costSubSum;
			}
			
			$('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
		};

		this.updatePurchaseOut= function(){
			var purchaseOutObj = new Array();
			var i =0;
			var identifyNo = 0;
			target.find("tr").each(function(){
				if($(this).find('[name$=stDt]').val().length<6)
					return true;
				var tr = $(this);
				var isChecked =tr.find('[name$=isRepeat]').attr("checked");
				//다중 매출일 경우
				if(isChecked=="checked" && tr.find('[name$=stDt]').val().length == 6)
				{
					var stYear =parseInt(tr.find('[name$=stDt]').val().substr(0,4));
					var stMonth =parseInt(tr.find('[name$=stDt]').val().substr(4,1)+"0") +parseInt(tr.find('[name$=stDt]').val().substr(5,1)) ;
					var edYear, edMonth;
					if(tr.find('[name$=edDt]').val().length!=6 || tr.find('[name$=edDt]').val()< tr.find('[name$=stDt]').val())
					{
						edYear = stYear;
						edMonth = stMonth;
					}
					else
					{
						edYear =tr.find('[name$=edDt]').val().substr(0,4);
						edMonth =parseInt(tr.find('[name$=edDt]').val().substr(4,1)+"0") +parseInt(tr.find('[name$=edDt]').val().substr(5,1)) ;
					}
					var cost = jsDeleteComma(tr.find('[name$=cost]').val());
					var ct = tr.find('[name$=ct]').val(); 
					var searchYear = stYear;
					var searchMonth = stMonth;
					while(getYm(searchYear,searchMonth)<= getYm(edYear,edMonth))
					{
						purchaseOutObj[i] =  {
							year : searchYear,
							month : searchMonth,
							cost : parseInt(cost),
							ct : ct,
							identifyNo : identifyNo
						}
						i++;

						searchMonth ++;
						if(searchMonth>12 )
						{
							searchMonth = 1;
							searchYear ++;
						}
					}
				}
				else{
					var stYear =tr.find('[name$=stDt]').val().substr(0,4);
					var stMonth =parseInt(tr.find('[name$=stDt]').val().substr(4,1)+"0") +parseInt(tr.find('[name$=stDt]').val().substr(5,1)) ;
					var cost = jsDeleteComma(tr.find('[name$=cost]').val());
					var ct = tr.find('[name$=ct]').val(); 
					purchaseOutObj[i] =  {
						year : stYear,
						month : stMonth,
						cost : parseInt(cost),
						ct : ct,
						identifyNo : identifyNo
					}
					i++;
				}
				identifyNo++;
			});
			globalData.purchaseOutObj =  purchaseOutObj;
		}

		this.updateView = function(){
			var identifyNo = -1;
			var purchaseOutSum = 0;
			var costSubSum = 0;
			var cost = 0;
			var stDt = "";
			var edDt ="";
			var tmpStDt = "";
			var tmpEdDt ="";
			var ct ="";

			$.each(globalData.purchaseOutObj, function(key,val){
				if(val.identifyNo != identifyNo)
				{
					if(identifyNo ==-1)
					;
					else
					{
						var cloneTr =viewTr.clone();
						cloneTr.find('.cost').html(jsAddComma(cost));
						cloneTr.find('.purchaseOutSubSum').html(jsAddComma(costSubSum) + '원<br>(부가세별도)');
						cloneTr.find('.stDt').html(stDt);
						cloneTr.find('.edDt').html(edDt);
						cloneTr.find('.ct').html(ct);
						cloneTr.appendTo(target.find('tbody'));
						purchaseOutSum += costSubSum;
						costSubSum = 0;
					}
					cost = 0;
					stDt = "";
					edDt ="";
					ct ="";
				}
				identifyNo = val.identifyNo;
				cost = val.cost;
				costSubSum += cost;
				tmpStDt = val.year +"."+ ((val.month<10)?'0':'') + val.month;
				tmpEdDt = val.year +"."+ ((val.month<10)?'0':'') + val.month;
				if (tmpStDt < stDt || stDt=='') stDt = tmpStDt;		// 최소년월 구하기
				if (tmpEdDt > edDt || edDt=='') edDt = tmpEdDt;		// 최대년월 구하기
				ct =val.ct;
			});

			if(globalData.purchaseOutObj.length>=1)
			{
				var cloneTr =viewTr.clone();
				cloneTr.find('.cost').html(jsAddComma(cost));
				cloneTr.find('.purchaseOutSubSum').html(jsAddComma(costSubSum) + '원<br>(부가세별도)');
				cloneTr.find('.stDt').html(stDt);
				cloneTr.find('.edDt').html(edDt);
				cloneTr.find('.ct').html(ct);
				cloneTr.appendTo(target.find('tbody'));
				purchaseOutSum += costSubSum;
			}
			
			$('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
		}
	};
	
	var TotalSummingUp = function(target, options)
	{
		
		var tableForm; 
		$.ajax({
			url: "/ajax/approval/totalSummingUpForm.do?templtId=25", 
			dataType: "html",
			type: 'POST', //I want a type as POST
			async: false,
			success: function(data){
			tableForm = $(data);}
		});
		var purchaseOut = new Object();
		var prjLabor = new Object();
		var prjExpense = new Object();
		var profitOnSales = new Object();
		//합계 계산을 위해
		var purchaseOutSum = new Object();
		var prjLaborSum = new Object();
		var prjExpenseSum = new Object();
		var profitOnSalesSum = new Object();
		var obj = this;
		var target = $(target);
		this.init = function() {
			console.log("total init start");
			//table 삽입
			for (var searchYear =globalData.stYear ; searchYear<= globalData.edYear ; searchYear ++ )
			{
				obj.createYearSummingUp(searchYear);
				//변수 초기화.
				for(var month =1;month<=12 ; month++)
				{
					purchaseOut[getYm(searchYear,month)] = 0;
					prjLabor[getYm(searchYear,month)] = 0;
					prjExpense[getYm(searchYear,month)] = 0;
					profitOnSales[getYm(searchYear,month)] = 0;
				}
				purchaseOutSum[searchYear] = 0;
				prjLaborSum[searchYear] = 0;
				prjExpenseSum[searchYear] = 0;
				profitOnSalesSum[searchYear] = 0;
			}
		};
		
		this.reInit = function (){
			target.html('<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>');
			obj.init();
			obj.updatePurchaseOut(false);
			obj.updatePrjLabor(false);
			obj.updatePrjExpense(false);
			obj.updateProfit();
			
		};
		
		this.updatePurchaseOut = function(calcProfit){
			//초기화 
			target.find('.purchaseOut').each(function(){
				if($(this).html()!="-")
					$(this).html(0);
			});			
			$.each(purchaseOut, function(key,val){
				purchaseOut[key] = 0;
			});			
			$.each(purchaseOutSum, function(key,val){
				purchaseOutSum[key] = 0;
			});
			
			//값을 계속 더해줌
			$.each(globalData.purchaseOutObj, function(key,val){
				var year = val.year;
				var month = val.month;
				purchaseOut[getYm(year,month)] += val.cost;
				purchaseOutSum[year] += val.cost;
				var td =target.find(".year" +year+" .purchaseOut.month"+month); 
				td.html(jsAddComma(roundXL(parseFloat(jsDeleteComma(td.html())) +
					parseFloat(val.cost/1000),0)));
			});
			
			$.each(purchaseOut,function(key,val){
				var year = parseYear(key);
				var month = parseMonth(key);
				if(isInPeriod(year,month))
					target.find(".year" +year+" .purchaseOut.month"+month).html(jsAddComma(roundXL(val/1000,0))); 
			});
			
			$.each(purchaseOutSum, function(year,val){
				target.find(".year" +year + ' .purchaseOut.horizonTotal').html(jsAddComma(roundXL(val/1000,0)));
			});
			
			if(typeof(calcProfit)=="undefined"|| calcProfit ==true)
				obj.updateProfit();
		};
		
		this.updatePrjLabor = function(calcProfit)
		{
			target.find('.prjLabor').each(function(){
				if($(this).html()!="-")
					$(this).html(0);
			});
			$.each(prjLabor, function(key,val){
				prjLabor[key] = 0;
			});
			
			$.each(prjLaborSum, function(key,val){
				prjLaborSum[key] = 0;
			});
			//값을 계속 더해줌
			$.each(globalData.prjLaborObj, function(year,val){
				if(val["_valid"])
				{
					for(var month=1; month<=12; month++)
					{
						if(val[month]["_valid"])
						{
							$.each(val[month]["user"], function(key,val){
								prjLabor[getYm(year,month)] += val["labor"] * val["ratio"];
								prjLaborSum[year] += val["labor"] * val["ratio"];
							});
						}
					}
				}
			});
			if(typeof(calcProfit)=="undefined"|| calcProfit ==true)
				obj.updateProfit();
			
			$.each(prjLabor,function(key,val){
				var year = parseYear(key);
				var month = parseMonth(key);
				if(isInPeriod(year,month))
					target.find(".year" +year+" .prjLabor.month"+month).html(jsAddComma(roundXL(val/1000,0))); 
			});
			
			$.each(prjLaborSum, function(year,val){
				target.find(".year" +year+" .prjLabor.horizonTotal").html(jsAddComma(roundXL(val/1000,0)));
			});
		};
		
				
		this.updatePrjExpense = function(calcProfit)
		{
			target.find('.prjExpense').each(function(){
				if($(this).html()!="-")
					$(this).html(0);
			});
			
			$.each(prjExpense, function(key,val){
				prjExpense[key] = 0;
			});
			
			$.each(prjExpenseSum, function(key,val){
				prjExpenseSum[key] = 0;
			});
			
			//값을 계속 더해줌
			$.each(globalData.prjExpenseObj, function(year,val){
				if(val["_valid"])
				{
					for(var month=1; month<=12; month++)
					{
						if(val[month]["_valid"])
						{
							prjExpense[getYm(year,month)] += val[month]["cost"];
							prjExpenseSum[year] += val[month]["cost"];
						}
					}
				}
			});
			
			$.each(prjExpense,function(key,val){
				var year = parseYear(key);
				var month = parseMonth(key);
				if(isInPeriod(year,month))
					target.find(".year" +year+" .prjExpense.month"+month).html(jsAddComma(roundXL(val/1000,0))); 
			});
			
			
			$.each(prjExpenseSum, function(year,val){
				target.find(".year" +year+" .prjExpense.horizonTotal").html(jsAddComma(roundXL(val/1000,0)));
			});
			
		
			
			if(typeof(calcProfit)=="undefined"|| calcProfit ==true)
				obj.updateProfit();
		};
		
		this.updateProfit = function(){
			target.find('table').each(function(){
				var year = $(this).data("year");
				//합계 초기화
				profitOnSalesSum[year] = 0;
				for(var month=1; month<=12; month++)
				{
					if(isInPeriod(year,month))
					{
						//매출이익
						profitOnSales[getYm(year,month)] = 
								purchaseOut[getYm(year,month)] + 
								prjLabor[getYm(year,month)] +
								prjExpense[getYm(year,month)] ;
						profitOnSalesSum[year] += profitOnSales[getYm(year,month)]; 
						$(this).find(".profitOnSales.month"+month).html(
								jsAddComma(roundXL(profitOnSales[getYm(year,month)]/1000,0)));
						
						
					}
				}
				
				//합계부분
				$(this).find('.profitOnSales.horizonTotal').html(jsAddComma(roundXL(profitOnSalesSum[year]/1000,0)));
				
			});
		};
		
		this.createYearSummingUp = function(year)
		{
		
			var dataClone = tableForm.clone();
			dataClone.addClass("year"+year);
			dataClone.data('year',year);
			//년도 변경
			dataClone.find('.expenseYearTh').html((year) + "년도" );
			for(var i = 1; i<=12; i++)
			{
				if(isInPeriod(year,i))
				{
					dataClone.find('.month'+i).html(0);
				}
			}
			
			dataClone.appendTo(target);
		};
		
		this.updateView = function (){
			this.init();
			this.reInit();
		};
		
	};
	
   
})( jQuery );

	