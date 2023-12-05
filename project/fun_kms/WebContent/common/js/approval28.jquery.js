

(function( $ ){
	
	var globalData = {
			sPrjId : '',
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
			
			// 필요없는 데이터 삭제
			delete objects.prjExpenseObj;
			//delete objects.prjPlanObj;
			
			console.log(globalData);
			
			//table, td  해제
			$.each(objects.prjLaborObj,function(key,val){
				//valid하지 않은 year삭제
				if(!val["_valid"])
					delete objects.prjLaborObj[key];
				else {
					delete val["table"];
					for(var i =1 ; i<=12; i++) {
						//그 달의 값이 invalid일 경우 값을 0으로 바꿔줌.
						var monthValid = val[i]["_valid"]; 
						if(!monthValid) {
							val[i]["costLabor"] = 0;
							val[i]["costExpense"] = 0;
						}
						//td빼기
						delete val[i]["tdLabor"];
						delete val[i]["tdExpense"];
					}
				}
			});
		
			return objects;
			
		};
		
		//Write...
		this.init = function (options)
		{
			$('#beforeSettingD').show();
			
			// globalData Setting
			if ( options ) { 
				$.extend( globalData, options );
			}
			globalData.stYear = parseYear(globalData.stDt);
			globalData.edYear = parseYear(globalData.edDt);
			globalData.stMonth = parseMonth(globalData.stDt);
			globalData.edMonth = parseMonth(globalData.edDt);
			
			// 프로젝트에 할당된 인건비, 수행경비 예산 가져옴
			$.ajax({
				url: "/ajax/approval/selectProjectPlan.do",
				dataType: "json",
				data: {
					prjId: globalData.sPrjId,
					stDt: globalData.stDt,
					edDt: globalData.edDt,
					templtId: 28
				},
				type: "POST",
				async: false,
				success: function(data) {
					console.log(data);
					globalData.prjPlanObj = data;
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
		  	 	}
			});
			
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborExpenseD').get()[0]);
			//classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));
			
			//unique성을 보장하기 위해 변수 전달
			classes.prjLabor.init('prjLaborObj');
			//classes.prjExpense.init('prjExpenseObj');
			classes.totalSummingUp.updateView();
			
		};
		
		//RU, RW
		this.modifyDoc = function (options)
		{
			$('#beforeSettingD').show();
			
			//저장된 변수 값 저장.
			if ( options ) { 
				$.extend( globalData, options.globalData );
				globalData.mode = options.mode;
			}
			globalData.stYear = parseYear(globalData.stDt);
			globalData.stMonth = parseMonth(globalData.stDt);
			globalData.edYear = parseYear(globalData.edDt);	
			globalData.edMonth = parseMonth(globalData.edDt);
			
			
			target.find("[name$=sPrjNm]").val("[" + globalData.sPrjCd + "] "+globalData.sPrjNm);
			target.find("[name$=sPrjId]").val(globalData.sPrjId);
			target.find("[name$=stDt]").val(globalData.stDt);
			target.find("[name$=salesDoc\\.edDt]").val(globalData.edDt);
				
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborExpenseD').get()[0]);
			//classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));
			
			classes.prjLabor.updateDoc('prjLaborObj');
			//classes.prjExpense.updateDoc('prjExpenseObj');
			classes.totalSummingUp.updateView();
		};
		
		//문서 작성 중 년월,금액 등  변경 처리
		this.modify = function (options)
		{
			if (options.sPrjId.toString() != globalData.sPrjId.toString()) {
				obj.init(options);
			}
			
			// 변수 1개는 그냥 저장
			globalData.sPrjId = options.sPrjId;
			
			//년월이 바뀔 경우
			if( options.stDt.toString().substring(0, 6) != globalData.stDt.toString().substring(0, 6) 
				|| options.edDt.toString().substring(0, 6) != globalData.edDt.toString().substring(0, 6))
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
				
				// 프로젝트에 할당된 인건비, 수행경비 예산 가져옴
				$.ajax({
					url: "/ajax/approval/selectProjectPlan.do",
					dataType: "json",
					data: {
						prjId: globalData.sPrjId,
						stDt: globalData.stDt,
						edDt: globalData.edDt,
						templtId: 28
					},
					type: "POST",
					async: false,
					success: function(data) {
						console.log(data);
						globalData.prjPlanObj = data;
					},
					error: function(xhr, testStatus, errorThrown) {
						alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
			  	 	}
				});
				
				// 인건비 수행경비 부분 수정.
				var searchYear = bfStYear < globalData.stYear ? bfStYear : globalData.stYear;
				var endYear = bfEdYear > globalData.edYear ? bfEdYear : globalData.edYear;
				for (; searchYear<=endYear; searchYear++)
				{
					classes.prjLabor.changeYear(searchYear);
					//classes.prjExpense.changeYear(searchYear);
				}
				classes.totalSummingUp.reInit();
			} else {
				globalData.stDt =options.stDt;
				globalData.edDt =options.edDt;
			}
		};
		
		//문서 보기
		this.view = function(options)
		{
			if ( options ) { 
						$.extend( globalData, options.globalData );
				classes.prjLabor = new Labor($('#salesDocViewD #prjLaborExpenseD').get()[0]);
				//classes.prjExpense = new Expense($('#salesDocViewD #prjExpenseD').get()[0]);
				classes.totalSummingUp = new TotalSummingUp($('#salesDocViewD #totalSummingUpD').get([0]));
				//classes.prjExpense.updateView("prjExpenseObj");
				classes.prjLabor.updateView("prjLaborObj");
				target.find(".salesDoc\\.sPrjNm").html("<a href=\"/cooperation/selectProjectV.do?prjId=" + globalData.sPrjId + "\" target=\"_blank\">" + "[" + globalData.sPrjCd + "] "+globalData.sPrjNm + "</a>");
					target.find(".salesDoc\\.stDt").html(globalData.stDt);
					target.find(".salesDoc\\.edDt").html(globalData.edDt);
				classes.totalSummingUp.updateView();
			}
		}
		
		this.validate = function() {
			
			if (globalData.stDt == null || globalData.stDt == ""
					|| globalData.stDt.length != 8) {
				alert("시작일을 입력하십시오.");
				target.find('input[name=salesDoc\\.stDt]').focus();
				return false;
			}
			
			if (globalData.edDt == null || globalData.edDt == ""
				|| globalData.edDt.length != 8) {
				alert("종료일을 입력하십시오.");
				target.find('input[name=salesDoc\\.edDt]').focus();
				return false;
			}
			
			if (globalData.sPrjId == null || globalData.sPrjId == "") {
				alert("이관대상 프로젝트를 입력하십시오.");
				prjGen(
						$('#salesDocWriteD input[name=salesDoc\\.sPrjNm]'),
						$('#salesDocWriteD input[name=salesDoc\\.sPrjId]'),
						1,
						null,
						updateDoc
				);
				return false;
			}
			
			// 인건비 이관매출 합계
			if ( $('.laborInput.horizonWholeTotal').first().html() != 0 ) {
				alert("인건비 이관매출의 합계가 0이 아닙니다.");
				return false;
			}
			
			// 수행경비 이관매출 합계
			if ( $('.expenseInput.horizonWholeTotal').first().html() != 0 ) {
				alert("수행경비 이관매출의 합계가 0이 아닙니다.");
				return false;
			}
			
			// 선택한 프로젝트에 현재 결재진행 중인 매출이관 보고서가 있는지 체크
			var result = true;
			var ajax_result = false;
			$.ajax({
				url: "/ajax/selectProjectInfoProgress.do",
				data: {
					prjId: globalData.sPrjId
				},
				type: "POST",
				async: false,
				dataType: "json",
				success: function(data) {
					if (data.cnt > 0) {
						alert('동일한 프로젝트로 결재진행 중인 매출이관보고서가 있습니다.\n'
								+ '먼저 상신한 매출이관보고서가 전결 승인완료 된 이후\n'
								+ '신규 매출이관보고서를 상신하시기 바랍니다.');
						ajax_result = false;
					} else {
						ajax_result = true;
					}
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
		  	 	}
			});
			result = result && ajax_result;
			
			// 선택한 프로젝트에 마지막에 결재 완료된 매출이관 보고서 승인일자확인와 오늘과 비교한 값 확인
			$.ajax({
				url: "/ajax/getTransApprovalDateDiff.do",
				data: {
					prjId: globalData.sPrjId
				},
				type: "POST",
				async: false,
				dataType: "json",
				success: function(data) {
					console.log(data.cmp_date);
					// 값이 0이면 오늘 전결 승인 완료된 매출이관 보고서가 있다는 의미
					if (data.cmp_date == 0) {
						alert('동일한 프로젝트로 금일 전결 승인 완료된 매출이관보고서가 있습니다.\n'
								+ '매출이관보고서는 전결 승인 완료일 다음날부터 기안 가능합니다.\n'
								+ '금일은 기안이 불가하므로 명일 기안올려주시기 바랍니다.\n'
								+ '(이유 : 전결 승인 완료일 다음날 비용집계가 되기 때문)');
						ajax_result = false;
					} else {
						ajax_result = true;
					}
				},
				error: function(xhr, testStatus, errorThrown) {
					alert("프로젝트에 대한 데이터를 가져오는데 실패하였습니다.");
		  	 	}
			});
			result = result && ajax_result;
			
			return result;
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
	
	var Labor = function(target, options) {
		if ( options ) { 
			$.extend( globalData, options );
		}
		var tableForm; 
		$.ajax({
			url: "/ajax/approval/laborForm.do?templtId=28", 
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

		this.init = function(typ) {
			console.log("labor init start");
			prjType = typ;
			globalData[prjType] = new Object();
			
			// hmtl 초기화
			target.html('<p class="th_stitle2 mB10">매출이관 인건비 및 수행경비<span class="th_plus02">[단위 : 천원]</span></p>');
			
			//table 삽입
			for (var searchYear =globalData.stYear ; searchYear<= globalData.edYear ; searchYear ++ )
			{
				obj.createYear(searchYear);
			}
			obj.calcTotalSum();
		};
		this.updateDoc = function (typ){

			prjType = typ;
			for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
			{
				var dataClone = tableForm.clone();
				dataClone.addClass("year"+searchYear);
				dataClone.find('.laborExpenseYearTh').html(searchYear + "년도" );
				dataClone.addClass(prjType);
				dataClone.appendTo(target);
				dataClone.find('td.laborExist, td.laborInput, td.laborSum, td.expenseExist, td.expenseInput, td.expenseSum').each(function(idx,elem){
					$(this).addClass("year" + searchYear);
				});
				
				globalData[prjType][searchYear]["table"] = dataClone;
				
				for(var searchMonth = 1; searchMonth<=12;searchMonth++){
					var yearClass = "year" + searchYear;
					var monthClass = "month" + searchMonth;
					
					globalData[prjType][searchYear][searchMonth]["tdLabor"] = dataClone.find('td.laborInput.'+yearClass+'.'+monthClass);
					globalData[prjType][searchYear][searchMonth]["tdLabor"].data("inputName",$(target).attr("id") + "labor" + "\." +  searchYear + "\." + searchMonth);
					globalData[prjType][searchYear][searchMonth]["tdLabor"].data("year",searchYear);
					globalData[prjType][searchYear][searchMonth]["tdLabor"].data("month",searchMonth);
					
					globalData[prjType][searchYear][searchMonth]["tdExpense"] = dataClone.find('td.expenseInput.'+yearClass+'.'+monthClass);
					globalData[prjType][searchYear][searchMonth]["tdExpense"].data("inputName",$(target).attr("id") + "expense" + "\." +  searchYear + "\." + searchMonth);
					globalData[prjType][searchYear][searchMonth]["tdExpense"].data("year",searchYear);
					globalData[prjType][searchYear][searchMonth]["tdExpense"].data("month",searchMonth);
	
					if(isInPeriod(searchYear,searchMonth))
					{
						//var yearClass = "year" + year;
						//var monthClass = "month" + i;
						globalData[prjType][searchYear][searchMonth]["_valid"]  = true;
						dataClone.find('.laborExist.'+yearClass+'.'+monthClass).html(jsAddComma(parseInt(globalData["prjPlanObj"][searchYear][searchMonth]["planLabor"]/1000)));
						dataClone.find('.expenseExist.'+yearClass+'.'+monthClass).html(jsAddComma(parseInt(globalData["prjPlanObj"][searchYear][searchMonth]["planExpense"]/1000)));
						dataClone.find('.laborSum.'+yearClass+'.'+monthClass).html('0');
						dataClone.find('.expenseSum.'+yearClass+'.'+monthClass).html('0');
						
						var tdLabor = globalData[prjType][searchYear][searchMonth]["tdLabor"];
						var tdExpense = globalData[prjType][searchYear][searchMonth]["tdExpense"];
						
						var costLaborPrint = jsAddComma(parseInt(globalData[prjType][searchYear][searchMonth]['costLabor']/1000));
						tdLabor.html('<input type="text" class="span_1" value = "0"/>');
						tdLabor.find('input').val(costLaborPrint);
						
						var costExpensePrint = jsAddComma(parseInt(globalData[prjType][searchYear][searchMonth]['costExpense']/1000));
						tdExpense.html('<input type="text" class="span_1" value = "0"/>');
						tdExpense.find('input').val(costExpensePrint);
						
						//globalData[prjType][searchYear][searchMonth]["tdLabor"].html('<input type="text" class="span_1" value = "0"/>');
						//globalData[prjType][searchYear][searchMonth]["tdExpense"].html('<input type="text" class="span_1" value = "0"/>');
						
						obj.calcHorizonSumPlan(tdLabor);
						obj.calcHorizonSum(tdLabor);
						obj.calcVerticalSum(tdLabor);
						
						obj.calcHorizonSumPlan(tdExpense);
						obj.calcHorizonSum(tdExpense);
						obj.calcVerticalSum(tdExpense);
					}
				}
			}
			obj.calcTotalSum();
			obj.inputLive();

		};
		
		this.updateView = function (typ){
			
			prjType = typ;
			for(var searchYear = globalData.stYear; searchYear<=globalData.edYear; searchYear++)
			{
				var dataClone = tableForm.clone();
				dataClone.addClass("year"+searchYear);
				dataClone.find('.laborExpenseYearTh').html(searchYear + "년도" );
				dataClone.addClass(prjType);
				dataClone.appendTo(target);
				globalData[prjType][searchYear]["table"] = dataClone;
				var planLaborSum = 0;
				var planExpenseSum = 0;
				var costLaborSum = 0;
				var costExpenseSum = 0;
				for(var searchMonth = 1; searchMonth<=12;searchMonth++){
					if(isInPeriod(searchYear,searchMonth))
					{
						var planLabor = globalData["prjPlanObj"][searchYear][searchMonth]['planLabor'];
						var costLabor = globalData[prjType][searchYear][searchMonth]['costLabor'];
						var verLaborSum = planLabor + costLabor;
						
						planLaborSum += planLabor;
						costLaborSum += costLabor;
						dataClone.find('tbody td.laborExist.month'+ searchMonth).html(jsAddComma(parseInt(planLabor/1000)));
						dataClone.find('tbody td.laborInput.month'+ searchMonth).html(jsAddComma(parseInt(costLabor/1000)));
						dataClone.find('tbody td.laborSum.month'+ searchMonth).html(jsAddComma(parseInt(verLaborSum/1000)));
						
						var planExpense = globalData["prjPlanObj"][searchYear][searchMonth]['planExpense'];
						var costExpense = globalData[prjType][searchYear][searchMonth]['costExpense']; 
						var verExpenseSum = planExpense + costExpense;
						
						planExpenseSum += planExpense;
						costExpenseSum += costExpense;
						dataClone.find('tbody td.expenseExist.month'+ searchMonth).html(jsAddComma(parseInt(planExpense/1000)));
						dataClone.find('tbody td.expenseInput.month'+ searchMonth).html(jsAddComma(parseInt(costExpense/1000)));
						dataClone.find('tbody td.expenseSum.month'+ searchMonth).html(jsAddComma(parseInt(verExpenseSum/1000)));
					}
				}
				// 합계
				globalData[prjType][searchYear]["table"].find('tbody td.laborExist.horizonTotal').html(jsAddComma(parseInt(planLaborSum/1000)));
				globalData[prjType][searchYear]["table"].find('tbody td.laborInput.horizonTotal').html(jsAddComma(parseInt(costLaborSum/1000)));
				globalData[prjType][searchYear]["table"].find('tbody td.laborSum.horizonTotal').html(jsAddComma(parseInt((planLaborSum+costLaborSum)/1000)));
				
				globalData[prjType][searchYear]["table"].find('tbody td.expenseExist.horizonTotal').html(jsAddComma(parseInt(planExpenseSum/1000)));
				globalData[prjType][searchYear]["table"].find('tbody td.expenseInput.horizonTotal').html(jsAddComma(parseInt(costExpenseSum/1000)));
				globalData[prjType][searchYear]["table"].find('tbody td.expenseSum.horizonTotal').html(jsAddComma(parseInt((planExpenseSum+costExpenseSum)/1000)));
			}
			
			obj.calcTotalSum();
		};

		//해당 년도 테이블 생성
		this.createYear = function (year)
		{
			var dataClone = tableForm.clone();
			dataClone.addClass("year"+year);
			dataClone.addClass(prjType);
			//년도 변경
			dataClone.find('.laborExpenseYearTh').html(year + "년도" );
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
			dataClone.find('td.laborExist, td.laborInput, td.laborSum, td.expenseExist, td.expenseInput, td.expenseSum').each(function(idx,elem){
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
					dataClone.appendTo(target);
				}
				
			}
			
			//합계부분 '-' 를 0으로 바꿔줌.
			console.log(globalData);
			for(var i = 1; i <=12 ; i++)
			{
				var yearClass = "year" + year;
				var monthClass = "month" + i;
				globalData[prjType][year][i] = new Object();
				globalData[prjType][year][i]["costLabor"] = 0;
				globalData[prjType][year][i]["costExpense"] = 0;
				
				globalData[prjType][year][i]["tdLabor"] = dataClone.find('td.laborInput.'+yearClass+'.'+monthClass);
				globalData[prjType][year][i]["tdLabor"].data("inputName",$(target).attr("id") + "labor" + "\." +  year + "\." + i);
				globalData[prjType][year][i]["tdLabor"].data("year",year);
				globalData[prjType][year][i]["tdLabor"].data("month",i);
				
				globalData[prjType][year][i]["tdExpense"] = dataClone.find('td.expenseInput.'+yearClass+'.'+monthClass);
				globalData[prjType][year][i]["tdExpense"].data("inputName",$(target).attr("id") + "expense" + "\." +  year + "\." + i);
				globalData[prjType][year][i]["tdExpense"].data("year",year);
				globalData[prjType][year][i]["tdExpense"].data("month",i);

				if(isInPeriod(year,i))
				{
					//var yearClass = "year" + year;
					//var monthClass = "month" + i;
					globalData[prjType][year][i]["_valid"]  = true;
					dataClone.find('.laborExist.'+yearClass+'.'+monthClass).html(jsAddComma(parseInt(globalData["prjPlanObj"][year][i]["planLabor"]/1000)));
					dataClone.find('.expenseExist.'+yearClass+'.'+monthClass).html(jsAddComma(parseInt(globalData["prjPlanObj"][year][i]["planExpense"]/1000)));
					dataClone.find('.laborSum.'+yearClass+'.'+monthClass).html('0');
					dataClone.find('.expenseSum.'+yearClass+'.'+monthClass).html('0');
					
					var tdLabor = globalData[prjType][year][i]["tdLabor"];
					var tdExpense = globalData[prjType][year][i]["tdExpense"];
					
					globalData[prjType][year][i]["tdLabor"].html('<input type="text" class="span_1" value = "0"/>');
					globalData[prjType][year][i]["tdExpense"].html('<input type="text" class="span_1" value = "0"/>');
					
					obj.calcHorizonSumPlan(tdLabor);
					obj.calcHorizonSum(tdLabor);
					obj.calcVerticalSum(tdLabor);
					
					obj.calcHorizonSumPlan(tdExpense);
					obj.calcHorizonSum(tdExpense);
					obj.calcVerticalSum(tdExpense);
				}
			}
			obj.calcTotalSum();
			obj.inputLive();
		
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
			
		};
		
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
		};
		
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
				var yearClass = "year" + year;
				var monthClass = "month" + i;
				
				//범위안에 있을 시
				if(i>=stMonth && i <=edMonth)
				{
					//해당월이 이미 valid한지 체크
					
					/*
					if(globalData[prjType][year][i]["_valid"]){
						;
					}
					else{
					*/
						globalData[prjType][year][i]["_valid"] = true;
						
						// 인건비 이관매출 초기화
						var tdLabor = globalData[prjType][year][i]["tdLabor"];
						var tdLaborCost = parseInt(globalData[prjType][year][i]['costLabor']/1000);
						tdLabor.html('<input type="text" class="span_1" value = "'+tdLaborCost+'"/>');
						tdLabor.find('input').attr("name", $(this).data("inputName"));
						
						// 수행경비 이관매출 초기화
						var tdExpense = globalData[prjType][year][i]["tdExpense"];
						var tdExpenseCost = parseInt(globalData[prjType][year][i]['costExpense']/1000);
						tdExpense.html('<input type="text" class="span_1" value = "'+tdExpenseCost+'"/>');
						tdExpense.find('input').attr("name", $(this).data("inputName"));
						
						// 예산
						var planLabor = parseInt(globalData["prjPlanObj"][year][i]["planLabor"]/1000);
						var planExpense = parseInt(globalData["prjPlanObj"][year][i]["planExpense"]/1000);
						if (globalData.mode == "RW") {	// 수정기한 인 경우, 기존매출 - 이관매출 처리해준다.
							planLabor -= tdLaborCost;
							planExpense -= - tdExpenseCost;
						}
						tdLabor.parent().parent().find('.laborExist.'+yearClass+'.'+monthClass).html(jsAddComma(planLabor));
						tdLabor.parent().parent().find('.expenseExist.'+yearClass+'.'+monthClass).html(jsAddComma(planExpense));
						
						// 소계 초기화
						//tdLabor.parent().parent().find('.laborSum.'+yearClass+'.'+monthClass).html('0');
						//tdLabor.parent().parent().find('.expenseSum.'+yearClass+'.'+monthClass).html('0');
						
						obj.calcHorizonSumPlan(tdLabor);
						obj.calcHorizonSum(tdLabor);
						obj.calcVerticalSum(tdLabor);
						
						obj.calcHorizonSumPlan(tdExpense);
						obj.calcHorizonSum(tdExpense);
						obj.calcVerticalSum(tdExpense);
					//}
				}
				//없을 시
				else
				{
					if(globalData[prjType][year][i]["_valid"]){
						globalData[prjType][year][i]["_valid"] = false;
						
						var tdLabor = globalData[prjType][year][i]["tdLabor"];
						tdLabor.html("-");
						tdLabor.parent().parent().find('.laborExist.'+yearClass+'.'+monthClass).html('-');
						tdLabor.parent().parent().find('.laborSum.'+yearClass+'.'+monthClass).html('-');
						
						obj.calcHorizonSumPlan(tdLabor);
						obj.calcHorizonSum(tdLabor);
						obj.calcVerticalSum(tdLabor);
						
						var tdExpense = globalData[prjType][year][i]["tdExpense"];
						tdExpense.html("-");
						tdExpense.parent().parent().find('.expenseExist.'+yearClass+'.'+monthClass).html('-');
						tdExpense.parent().parent().find('.expenseSum.'+yearClass+'.'+monthClass).html('-');
						
						obj.calcHorizonSumPlan(tdExpense);
						obj.calcHorizonSum(tdExpense);
						obj.calcVerticalSum(tdExpense);
						
					}
					else{
						;
					}
				}
			}
			
			obj.calcTotalSum();
			
		};

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
		};
		
		this.calcHorizonSumPlan = function(td)
		{
			var horizonSum = 0.0;
			td.closest('tr').prev().find("td.plan").each(function(){
				var plan = jsDeleteComma($(this).text());
				if (isNaN(plan)) plan = 0;
				horizonSum += parseFloat(plan);
			});
			$(td).closest('tr').prev().find('td').last().prev().html(jsAddComma(parseInt(horizonSum)));
			$(td).closest('tr').prev().find('td').last().html(jsAddComma(parseInt(horizonSum)));
		};
		
		this.calcHorizonSum = function(td)
		{
			var horizonSum = 0.0;
			td.closest('tr').find("input[type=text]").each(function(){
				horizonSum += parseFloat(Numeric.rmComma($(this).val()));
			});
			$(td).closest('tr').find('td').last().prev().html(jsAddComma(parseInt(horizonSum)));
			$(td).closest('tr').find('td').last().html(jsAddComma(parseInt(horizonSum)));
		};
		
		this.calcVerticalSum = function(td)
		{
			var verticalSum = 0.0;
			var index = td.index();
			
			var existValue = jsDeleteComma(td.closest("tr").prev().find("td:eq(" + (index + 1) + ")" ).text().replace('-', '0'));	// 첫번째 TD는 rowspan으로 인해 index + 1
			var inputValue = Numeric.rmComma(td.closest("tr").find("td:eq(" + index + ") input" ).val());
			if (isNaN(inputValue)) {
				verticalSum = '-';
				td.closest("tr").next().find("td:eq(" + index + ")" ).html(verticalSum);
			} else {
				verticalSum = parseFloat(existValue) + parseFloat(inputValue);
				td.closest("tr").next().find("td:eq(" + index + ")" ).html(jsAddComma(parseInt(verticalSum)));
			}
			
			var totalSum = 0.0;
			$.each(td.closest("tr").next().find("td"),function(idx,elm){
				if(idx==0)
					return true;
				else if(idx==13 || idx==14)
					$(this).html(jsAddComma(parseInt(totalSum)));
				else
				{
					if($(this).html()!="-")
						totalSum += parseFloat(jsDeleteComma($(this).html()));
				}
			});
		};
		
		this.calcTotalSum = function() {
			// 총합계 계산 시작
			
			// 인건비
			var laborSumTotal = 0.0;
			var laborExistTotal = 0.0;
			$.each($('#prjLaborExpenseD').find('.laborExist.horizonTotal'), function(idx,elm) {
				laborExistTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			laborSumTotal += laborExistTotal;	// 소계
			$('#prjLaborExpenseD').find('.laborExist.horizonWholeTotal').html(jsAddComma(parseInt(laborExistTotal)));
			
			var laborInputTotal = 0.0;
			$.each($('#prjLaborExpenseD').find('.laborInput.horizonTotal'), function(idx,elm) {
				laborInputTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			laborSumTotal += laborInputTotal;	// 소계
			$('#prjLaborExpenseD').find('.laborInput.horizonWholeTotal').html(jsAddComma(parseInt(laborInputTotal)));
			
			$('#prjLaborExpenseD').find('.laborSum.horizonWholeTotal').html(jsAddComma(parseInt(laborSumTotal)));
			
			
			// 수행경비
			var expenseSumTotal = 0.0;
			var expenseExistTotal = 0.0;
			$.each($('#prjLaborExpenseD').find('.expenseExist.horizonTotal'), function(idx,elm) {
				expenseExistTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			expenseSumTotal += expenseExistTotal;	// 소계
			$('#prjLaborExpenseD').find('.expenseExist.horizonWholeTotal').html(jsAddComma(parseInt(expenseExistTotal)));
			
			var expenseInputTotal = 0.0;
			$.each($('#prjLaborExpenseD').find('.expenseInput.horizonTotal'), function(idx,elm) {
				expenseInputTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			expenseSumTotal += expenseInputTotal;	// 소계
			$('#prjLaborExpenseD').find('.expenseInput.horizonWholeTotal').html(jsAddComma(parseInt(expenseInputTotal)));
			
			$('#prjLaborExpenseD').find('.expenseSum.horizonWholeTotal').html(jsAddComma(parseInt(expenseSumTotal)));
			
			// 총합계 계산 끝
		};
		
		this.inputLive = function (){
			target.find('input[type=text]').live("keyup",function(){
				jsMakeCurrency(this);
				//가로, 세로 통계 계산
				obj.calcHorizonSum($(this).closest('td'));
				obj.calcVerticalSum($(this).closest('td'));
				obj.calcTotalSum();
				
				var year = $(this).parent().data("year");
				var month = $(this).parent().data("month");
				
				if ($(this).parent().attr('class').indexOf('laborInput') >= 0)
					globalData[prjType][year][month]["costLabor"] = parseInt(jsDeleteComma($(this).val())) * 1000;
				else
					globalData[prjType][year][month]["costExpense"] = parseInt(jsDeleteComma($(this).val())) * 1000;
				classes.totalSummingUp.updatePrjLabor();
				classes.totalSummingUp.updatePrjExpense();
			});
		};
	};

	var TotalSummingUp = function(target, options)
	{
		var tableForm; 
		$.ajax({
			url: "/ajax/approval/totalSummingUpForm.do?templtId=28", 
			dataType: "html",
			type: 'POST', //I want a type as POST
			async: false,
			success: function(data){
			tableForm = $(data);}
		});
		var prjLabor = new Object();
		var prjExpense = new Object();
		var profitOnSales = new Object();
		//합계 계산을 위해
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
					prjLabor[getYm(searchYear,month)] = 0;
					prjExpense[getYm(searchYear,month)] = 0;
					profitOnSales[getYm(searchYear,month)] = 0;
				}
				prjLaborSum[searchYear] = 0;
				prjExpenseSum[searchYear] = 0;
				profitOnSalesSum[searchYear] = 0;
			}
		};
		
		this.reInit = function (){
			target.html('<p class="th_stitle2 mB10">종합 <span class="th_plus02">[단위 : 천원]</span></p>');
			obj.init();
			obj.updatePrjLabor(false);
			obj.updatePrjExpense(false);
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
							prjLabor[getYm(year,month)] += val[month]["costLabor"] + globalData["prjPlanObj"][year][month]["planLabor"];
							prjLaborSum[year] += parseInt(prjLabor[getYm(year,month)]/1000) * 1000;
						}
					}
				}
			});
			
			$.each(prjLabor,function(key,val){
				var year = parseYear(key);
				var month = parseMonth(key);
				if(isInPeriod(year,month))
					target.find(".year" +year+" .prjLabor.month"+month).html(jsAddComma(parseInt(val/1000))); 
			});
			
			// 합계 계산
			$.each(prjLaborSum, function(year,val){
				target.find(".year" +year+" .prjLabor.horizonTotal").html(jsAddComma(parseInt(val/1000)));
			});
			
			// 총합계 계산
			var laborTotal = 0.0;
			$.each($('#totalSummingUpD').find('.prjLabor.horizonTotal'), function(idx,elm) {
				laborTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			$('#totalSummingUpD').find('.prjLabor.horizonWholeTotal').html(jsAddComma(parseInt(laborTotal)));
			
			var laborExpenseSumTotal = 0.0;
			$.each($('#totalSummingUpD').find('.profitOnSales.horizonTotal'), function(idx,elm) {
				laborExpenseSumTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			$('#prjLaborExpenseD').find('.profitOnSales.horizonWholeTotal').html(jsAddComma(parseInt(laborExpenseSumTotal)));
			
			
			if(typeof(calcProfit)=="undefined"|| calcProfit ==true)
				obj.updateProfit();
			
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
			$.each(globalData.prjLaborObj, function(year,val){
				if(val["_valid"])
				{
					for(var month=1; month<=12; month++)
					{
						if(val[month]["_valid"])
						{
							prjExpense[getYm(year,month)] += val[month]["costExpense"] + globalData["prjPlanObj"][year][month]["planExpense"];
							prjExpenseSum[year] += parseInt(prjExpense[getYm(year,month)]/1000) * 1000;
						}
					}
				}
			});
			
			$.each(prjExpense,function(key,val){
				var year = parseYear(key);
				var month = parseMonth(key);
				if(isInPeriod(year,month))
					target.find(".year" +year+" .prjExpense.month"+month).html(jsAddComma(parseInt(val/1000))); 
			});
			
			// 합계 계산
			$.each(prjExpenseSum, function(year,val){
				target.find(".year" +year+" .prjExpense.horizonTotal").html(jsAddComma(parseInt(val/1000)));
			});
			
			// 총합계 계산
			var expenseTotal = 0.0;
			$.each($('#totalSummingUpD').find('.prjExpense.horizonTotal'), function(idx,elm) {
				expenseTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			$('#totalSummingUpD').find('.prjExpense.horizonWholeTotal').html(jsAddComma(parseInt(expenseTotal)));
			
			var laborExpenseSumTotal = 0.0;
			$.each($('#totalSummingUpD').find('.profitOnSales.horizonTotal'), function(idx,elm) {
				laborExpenseSumTotal += parseFloat(jsDeleteComma($(this).html()));
			});
			$('#prjLaborExpenseD').find('.profitOnSales.horizonWholeTotal').html(jsAddComma(parseInt(laborExpenseSumTotal)));
			
			
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
								prjLabor[getYm(year,month)] +
								prjExpense[getYm(year,month)] ;
						profitOnSalesSum[year] += profitOnSales[getYm(year,month)]; 
						$(this).find(".profitOnSales.month"+month).html(
								jsAddComma(parseInt(profitOnSales[getYm(year,month)]/1000)));
						
						
					}
				}
				
				// 소계 합계
				$(this).find('.profitOnSales.horizonTotal').html(jsAddComma(parseInt(profitOnSalesSum[year]/1000)));
				
				// 소계 총합계
				var laborTotal = parseFloat(jsDeleteComma($(this).find('.prjLabor.horizonWholeTotal').html()));
				var expenseTotal = parseFloat(jsDeleteComma($(this).find('.prjExpense.horizonWholeTotal').html()));
				$(this).find('.profitOnSales.horizonWholeTotal').html(jsAddComma(laborTotal+expenseTotal));
				
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
