

(function( $ ){
	
	var globalData = {
			prjId : '',
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
				else
				{
					delete val["table"];
					for(var i =1 ; i<=12; i++)
					{
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
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborD').get()[0]);
			classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));
			
			//unique성을 보장하기 위해 변수 전달
			classes.prjLabor.init('prjLaborObj');
			classes.prjExpense.init('prjExpenseObj');
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
			
				
			
			target.find("[name$=prjNm]").val("[" + globalData.prjCd + "] "+globalData.prjNm);
	    	target.find("[name$=prjId]").val(globalData.prjId);
	    	target.find("[name$=stDt]").val(globalData.stDt);
	    	target.find("[name$=salesDoc\\.edDt]").val(globalData.edDt);
	    	
			classes.prjLabor = new Labor($('#salesDocWriteD #prjLaborD').get()[0]);
			classes.prjExpense = new Expense($('#salesDocWriteD #prjExpenseD').get()[0]);
			classes.totalSummingUp = new TotalSummingUp($('#salesDocWriteD #totalSummingUpD').get([0]));
			
			classes.prjLabor.updateDoc('prjLaborObj');
			classes.prjExpense.updateDoc('prjExpenseObj');
			classes.totalSummingUp.updateView();
		};
		
		//문서 작성 중 년월,금액 등  변경 처리
		this.modify = function (options)
		{
			//4변수는 그냥 저장.
			globalData.prjId = options.prjId;
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
		};
		
		//문서 보기
		this.view = function(options)
		{
			if ( options ) { 
		        $.extend( globalData, options.globalData );
				classes.prjLabor = new Labor($('#salesDocViewD #prjLaborD').get()[0]);
				classes.prjExpense = new Expense($('#salesDocViewD #prjExpenseD').get()[0]);
				classes.totalSummingUp = new TotalSummingUp($('#salesDocViewD #totalSummingUpD').get([0]));
				classes.prjExpense.updateView("prjExpenseObj");
				classes.prjLabor.updateView("prjLaborObj");
				target.find(".salesDoc\\.prjNm").html("<a href=\"/cooperation/selectProjectV.do?prjId=" + globalData.prjId + "\" target=\"_blank\">" + "[" + globalData.prjCd + "] "+globalData.prjNm + "</a>");
		    	target.find(".salesDoc\\.stDt").html(globalData.stDt);
		    	target.find(".salesDoc\\.edDt").html(globalData.edDt);
				classes.totalSummingUp.updateView();
			}
		}
		
		this.validate = function() {

			if (globalData.prjId == null || globalData.prjId == "") {
				alert("프로젝트를 입력하십시오.");
				prjGen(
						$('#salesDocWriteD input[name=salesDoc\\.prjNm]'),
						$('#salesDocWriteD input[name=salesDoc\\.prjId]'),
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
		  
	   

    	this.init = function(typ) {
    		console.log("labor init start");
    		prjType = typ;
    		globalData[prjType] = new Object();
    		//table 삽입
			for (var searchYear =globalData.stYear ; searchYear<= globalData.edYear ; searchYear ++ )
			{
				obj.createYear(searchYear);
			}
			target.find('.laborUserAddB').click(obj.insertUserByInputBox);
			target.find('.laborUserTreeB').bind("click",function(){
				usrGen(target.find('.laborUserNm'),2);
			});
			
    	};
    	this.updateDoc = function (typ){
    		prjType = typ;
    		target.find('.laborUserAddB').click(obj.insertUserByInputBox);
			target.find('.laborUserTreeB').bind("click",function(){
				usrGen(target.find('.laborUserNm'),2);
			});
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
					userTr.find('td:eq(0)').html(userNmArray[key]+ '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
						//name값 저장.
					userTr.find("td").each(function(idx,elm){
						//1번째 td부터.. 12번째 td까지
						if(idx>0  && idx<=12)
						{
							$(this).addClass("year"+searchYear);
    						$(this).data("inputName", $(target).attr("id") + "\." +  searchYear + "\." + idx + "\."+ userIdArray[i] );
    						$(this).data("year",searchYear);
    						$(this).data("month",idx);
    						$(this).data("userId",userId);
    						globalData[prjType][searchYear][idx]["user"][userId]['td'] =$(this);
    						//기간에 포함될 시  input box 생성
    						if(isInPeriod(searchYear, idx))
    						{
    							$(this).html('<input type="text" class="span_1" value = "0"/>');
    							$(this).find('input').attr("name", $(this).data("inputName"));
    							$(this).find('input').val(globalData[prjType][searchYear][idx]["user"][userId]["ratio"]);
    							obj.calcHorizonSum($(this));
        						obj.calcVerticalSum($(this));
    						}
    						
						}
					});
					
					//del 버튼 활성화
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
				});
				
				
    		}
    		target.find('input[type=text]').live("keyup",function(){
				//가로, 세로 통계 계산
				obj.calcHorizonSum($(this).parent());
				obj.calcVerticalSum($(this).parent());
				var year = $(this).parent().data("year");
				var month = $(this).parent().data("month");
				var userId = $(this).parent().data("userId");
				globalData[prjType][year][month]["user"][userId]["ratio"] = jsDeleteComma($(this).val());
				classes.totalSummingUp.updatePrjLabor();
			});
    		
    		
    	}
    	this.updateView = function (typ){
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
    			
    			//아무 년도 값(현재 삽입된 년도 제외)을 가져와도 됨으로, 첫 번째 년도의 값을 가져온다. 
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
					dataClone.insertAfter(target.find('p:eq(0)'));
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
							td.html(('<input type="text" class="span_1" value = "'+ val['ratio']+'"/>'));
							td.find('input').attr("name", $(this).data("inputName"));
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
						});
					}
					else{
						;
					}
				
				}
							
				   
			}
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
        
     	this.insertUserByInputBox = function (){
    		console.log("insert User Start");
    		
    		var userMixs = target.find('.laborUserNm').val();
    		
    		var error = checkValidUserMixs(userMixs);
    		if(error["errorCode"]==1)
    		{
    			var userIdArray = makeUserIdArray(userMixs);
    			var userNmArray = makeUserNmArray(userMixs);	
    			target.find('.laborUserNm').val("");
    			for(var searchYear = globalData.stYear; searchYear <= globalData.edYear ; searchYear ++)
    			{
    				obj.insertUser(userIdArray,userNmArray,searchYear);
    				
    			}
    			
    			
    			
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
				userTr.find(".laboruserNmTd").html(userNmArray[i] + '<img src="'+ imagePath +'/btn/btn_minus02.gif" class="cursorPointer userTrDelB"/>');
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
    							$(this).html('<input type="text" class="span_1" value = "1"/>');
    							$(this).find('input').attr("name", $(this).data("inputName"));
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
   
   
	var TotalSummingUp = function(target, options)
	{
		
		var tableForm; 
		$.ajax({
			url: "/ajax/approval/totalSummingUpForm.do?templtId=24", 
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

	