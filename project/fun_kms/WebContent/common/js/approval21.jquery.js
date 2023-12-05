
( function($) {

	var globalData = {
		salesSj : '',
		sPrjId : '',
		stDt : '',
		stDtLongString : '',
		colDueDt : '',
		colDueDtLongString : '',
		cost : 0,
		decideYn : "Y",
		yearCnt : 0
	};

	var classes = {

	};

	var getPurchaseOutCostGenenral = function() {
		var sum = 0;
		$.each(globalData.purchaseOutObj, function(key, val) {
			sum += parseInt(val['cost']);
		});
		return sum;
	};
	var getPurchaseInCostGenenral = function() {
		var sum = 0;
		$.each(globalData.purchaseInGeneralObj, function(key, val) {
			sum += parseInt(val['cost']);
		});
		return sum;
	};

	var generalSales;
	var GenenralSales = function(target) {
		var obj = this;
		var generalSales = this;
		var target = $(target);

		this.getData = function() {
			var objects = {};
			$.extend(true, objects, globalData);
			return objects;

		};
		this.validate = function() {
			if (globalData.decideYn == null || globalData.decideYn == "") {
				alert("구분을 입력하십시오.");
				return false;
			}
			
			if (globalData.stDt == null || globalData.stDt == ""
				|| globalData.stDt.length != 8) {
				alert("매출일을 입력하십시오.");
				target.find('input[name=salesDoc\\.stDt]').focus();
				return false;
			}
			
			if (globalData.colDueDt == null || globalData.colDueDt == ""
				|| globalData.colDueDt.length != 8) {
				alert("최종수금예정일을 입력하십시오.");
				target.find('input[name=salesDoc\\.colDueDt]').focus();
				return false;
			}
			
			if (globalData.salesSj == null || globalData.salesSj == "") {
				alert("매출명을 입력하십시오.");
				target.find('input[name=salesDoc\\.salesSj]').focus();
				return false;
			}

			if (globalData.sPrjId == null || globalData.sPrjId == "") {
				alert("프로젝트를 입력하십시오.");
				target.find('input[name=salesDoc\\.sPrjNm]').focus();
				return false;
			}
			if (globalData.cost == null || globalData.cost == 0) {
				alert("매출액를 입력하십시오.");
				target.find('input[name=salesDoc\\.cost]').focus();
				return false;
			}

			var purchaseOutBool = true;
			classes.purchaseOut.target.find('tr').each( function(idx, elm) {
				var cost = $(elm).find('[name$=cost]').val();
				if (isNaN(jsDeleteComma(cost))) {
					alert("사외매입 금액을 입력하십시오.");
					$(elm).find('[name$=cost]').focus();
					purchaseOutBool = false;
					return false;
				}
			});
			if (!purchaseOutBool)
				return false;

			var purchaseInBool = true;
			classes.purchaseInGeneral.target.find('tr').each(
					function(idx, elm) {
						var cost = $(elm).find('[name$=cost]').val();
						if (isNaN(jsDeleteComma(cost)) || cost == 0) {
							alert("사내매입 금액을 입력하십시오.");
							$(elm).find('[name$=cost]').focus();
							purchaseInBool = false;
							return false;
						}
						var prjNm = $(elm).find('[name$=pPrjNm]');
						if (prjNm.val() == null || prjNm.val() == "") {
							alert("사내매입 프로젝트 코드를 입력하십시오.");
							prjNm.focus();
							purchaseInBool = false;
							return false;
						}
					});
			if (!purchaseInBool)
				return false;

			var expenseBool = true;
			classes.expense.target.find('tr').each( function(idx, elm) {
				var cost = $(elm).find('[name$=cost]').val();
				if (cost=="" || isNaN(jsDeleteComma(cost))) {
					alert("판관비 금액을 입력하십시오.");
					$(elm).find('[name$=cost]').focus();
					expenseBool = false;
					return false;
				}
			});
			if (!expenseBool)
				return false;

			return true;
		};
		this.init = function(options) {
			if (options) {
				$.extend(globalData, options);
			}
			$('#beforeSettingD').show();
			globalData.stYear = parseInt(globalData.stDt.substr(0, 4));
			globalData.stMonth = parseInt(globalData.stDt.substr(4, 1) + "0")
					+ parseInt(globalData.stDt.substr(5, 1));
			
			// 각각의 변수들을 다 초기화 시킴
			classes.sales = new Sales($('#salesDocWriteD').get( [ 0 ]));
			classes.purchaseOut = new PurchaseOut(
					$('#purchaseOutWriteD').get()[0]);
			classes.purchaseInGeneral = new PurchaseInGeneral($(
					'#purchaseInGeneralWriteD').get()[0]);
			classes.expense = new Expense($('#expenseWriteD').get( [ 0 ]));
			classes.summingUp = new SummingUp($('#summingUpWriteD').get( [ 0 ]));
			classes.sales.init();

			classes.purchaseOut.init();
			classes.purchaseInGeneral.init();
			classes.expense.init();

			globalData.salesObj = new Array();
			globalData.purchaseOutObj = new Array();
			globalData.purchaseInGeneralObj = new Array();
			globalData.expenseObj = new Array();
			classes.sales.update();
		};

		this.modify = function(options) {
			if (options) {
				$.extend(globalData, options);
			}
			
			globalData.stYear = parseInt(globalData.stDt.substr(0, 4));
			globalData.stMonth = parseInt(globalData.stDt.substr(4, 1) + "0")
					+ parseInt(globalData.stDt.substr(5, 1));
			classes.sales.update();
			classes.purchaseInGeneral.updatePercent();
		}

		this.view = function(options) {
			if (options) {
				$.extend(globalData, options.globalData);
				classes.sales = new Sales($('#salesDocViewD').get( [ 0 ]));
				classes.purchaseOut = new PurchaseOut($('#purchaseOutViewD')
						.get()[0]);
				classes.purchaseInGeneral = new PurchaseInGeneral($(
						'#purchaseInGeneralViewD').get()[0]);
				classes.expense = new Expense($('#expenseViewD').get( [ 0 ]));
				classes.sales.updateView();
				classes.purchaseOut.updateView();
				classes.purchaseInGeneral.updateView();
				classes.expense.updateView();
				classes.summingUp = new SummingUp($('#summingUpViewD').get(
						[ 0 ]));
				classes.summingUp.updateSales();
				classes.summingUp.updatePurchaseIn();
				classes.summingUp.updatePurchaseOut();
				classes.summingUp.updateExpense();
			}
		}
		
		this.modifyDoc = function(options) {
			if (options) {
				$.extend(globalData, options.globalData);
			}
			$('#beforeSettingD').show();
			//globalData.stDt = globalData.salesDt;
			var stDtString = globalData.stDt.toString();
			globalData.stYear = parseInt(stDtString.substr(0, 4));
			globalData.stMonth = parseInt(stDtString.substr(4, 1) + "0")
					+ parseInt(stDtString.substr(5, 1));
			classes.sales = new Sales($('#salesDocWriteD').get( [ 0 ]));
			classes.purchaseOut = new PurchaseOut($('#purchaseOutWriteD')
					.get()[0]);
			classes.purchaseInGeneral = new PurchaseInGeneral($(
					'#purchaseInGeneralWriteD').get()[0]);
			classes.expense = new Expense($('#expenseWriteD').get( [ 0 ]));
			classes.summingUp = new SummingUp($('#summingUpWriteD').get(
					[ 0 ]));
			classes.sales.init();
			classes.sales.updateDoc();
			classes.purchaseOut.init();
			classes.purchaseOut.updateDoc();
			classes.purchaseInGeneral.init();
			classes.purchaseInGeneral.updateDoc();
			classes.expense.init();
			classes.expense.updateDoc();
			classes.summingUp.updateSales();
			classes.summingUp.updatePurchaseIn();
			classes.summingUp.updatePurchaseOut();
			classes.summingUp.updateExpense();
		}
	};

	$.fn.generalSales = function(options) {

		var element = $(this);
		if (element.data('generalSales')) {
			generalSales = element.data('generalSales');
			if (typeof (options) == "object")
				generalSales.modify(options);
			if (options == "getData")
				return generalSales.getData();
			if (options == "validate")
				return generalSales.validate();
		} else {
			generalSales = new GenenralSales(this);
			if (options.mode == "W")
				generalSales.init(options);
			else if (options.mode == "V")
				generalSales.view(options);
			else if (options.mode == "M" || options.mode == "RU")
				generalSales.modifyDoc(options);
			else if (options.mode == "RW")
				generalSales.modifyDoc(options);
			element.data('generalSales', generalSales);
		}

	};

	var Sales = function(target, options) {
		var obj = this;
		var target = $(target);
		this.init = function() {
		};
		this.update = function() {
			var salesObj = new Array();
			var nth = 0;
			salesObj[nth] = {
				year : globalData.stYear,
				month : globalData.stMonth,
				cost : globalData.cost,
				ct : globalData.salesSj
			};
			globalData.salesObj = salesObj;
			classes.summingUp.updateSales();
		};

		this.updateView = function() { //sales
			target.find(".salesDoc\\.salesSj").html(globalData.salesSj);
			target.find(".salesDoc\\.sPrjNm").html(
					"<a href=\"/cooperation/selectProjectV.do?prjId=" + globalData.sPrjId + "\" target=\"_blank\">" +
					"[" + globalData.sPrjCd + "] " + globalData.sPrjNm + "</a>");
			target.find(".salesDoc\\.cost").html(jsAddComma(globalData.cost));
			target.find(".salesDoc\\.stDt").html(globalData.stDt);
			target.find(".salesDoc\\.stDtLongString").html(
				globalData.stDt.substr(0, 4) + "." + globalData.stDt.substr(4, 2) + "." + globalData.stDt.substr(6, 2)
			);
			target.find(".salesDoc\\.colDueDt").html(globalData.colDueDt);
			if (globalData.colDueDt != null && globalData.colDueDt != "") {
				target.find(".salesDoc\\.colDueDtLongString").html(
						globalData.colDueDt.substr(0, 4) + "." + globalData.colDueDt.substr(4, 2) + "." + globalData.colDueDt.substr(6, 2)
					);
			}
			//target.find(".salesDoc\\.stDtLongString").html(globalData.stDtLongString);
			var decideYnPrint;
			if (globalData.decideYn == 'N')
				decideYnPrint = '예상';
			else
				decideYnPrint = '확정';
			target.find(".salesDoc\\.decideYn").html(decideYnPrint);
		}
		this.updateDoc = function() {
			target.find("[name=salesDoc\\.salesSj]").val(globalData.salesSj);
			target.find("[name=salesDoc\\.sPrjNm]").val(
					"[" + globalData.sPrjCd + "] " + globalData.sPrjNm);
			target.find("[name=salesDoc\\.sPrjId]").val(globalData.sPrjId);
			target.find("[name=salesDoc\\.cost]").val(
					jsAddComma(globalData.cost));
			target.find("[name=salesDoc\\.stDt]").val(globalData.stDt);
			target.find("[name=salesDoc\\.colDueDt]").val(globalData.colDueDt);
			if (globalData.decideYn == 'N')
				target.find("[name=salesDoc\\.decideYn]").not(":checked").attr("checked","checked");
			else
				target.find("[name=salesDoc\\.decideYn]:checked").attr("checked","checked");
		}
	};
	var Expense = function(target, options) {
		var obj = this;
		var target = $(target);
		this.target = target;
		this.init = function() {
			target.find("input[name$=cost]").keyup( function() {
				jsMakeCurrency(this);
				obj.update();
			});
			target.find("input[name$=ct]").keyup( function() {
				obj.update();
			});
		};		
		this.update = function() {
			var expenseObj = new Array();
			var nth = 0;
			var cost = jsDeleteComma($(target).find('[name$=cost]').val());
			var ct = $(target).find('[name$=ct]').val();
			expenseObj[nth] = {
				year : globalData.stYear,
				month : globalData.stMonth,
				cost : parseInt(cost),
				ct : ct
			};
			globalData.expenseObj = expenseObj;
			classes.summingUp.updateExpense();
		};
		this.updateView = function() { //expense
			$.each(globalData.expenseObj, function(key, val) {
				var tr = target.find('tbody');
				if(val.cost>0){
					tr.find('.cost').html(jsAddComma(val.cost)+"원");
				}					
				tr.find('.ct').html(val.ct);
			});
		};
		this.updateDoc = function() {
			$.each(globalData.expenseObj, function(key, val) {
				var tr = target.find('tbody');
				tr.find('[name$=cost]').val(jsAddComma(val.cost));
				tr.find('[name$=ct]').val(val.ct);
			});

		};

	};

	var PurchaseOut = function(target, options) {

		var cnt = 0;
		var basicTr = $('<tr>'
				+ '<td class="title">금액</td>'
				+ '<td class="pL10" >'
				+ '<input type="text" name="cost" class="w70 txt_right pR5 currency purchaseOutCost"  value="0" /> 원'
				+ '</td>'
				+ '<td class="title">비고</td>'
				+ '<td class="pL10" ><input type="text" class="w500 pL5" name="purchaseOutCt" value=""/></td>'
				+ '<td><img src="'
				+ imagePath
				+ '/btn/btn_delete04.gif" class="cursorPointer purchaseOutDelB"></td>'
				+ '</tr>');
		var viewTr = $('<tr>'
				+ '<td class="title">금액</td>'
				+ '<td class="pR10 txt_right" >'
				+ '<span class="span_6 cost"></span>원'
				+ '</td>'
				+ '<td class="title">비고</td>'
				+ '<td class="pL10" colspan="2"><span class="span_11 ct"></span></td>'
				+ '</tr>');
		var obj = this;
		var target = $(target);
		this.target = $(target);
		this.addWriteTr = function() {
			var addedTr = basicTr.clone();
			addedTr.appendTo(target.find('tbody')).find("[name]").each(
					function(idx, elm) {
						$(this).attr(
								"name",
								"purchaseOut\[" + cnt + "\]\."
										+ $(this).attr("name"));
					});

			addedTr.find('.purchaseOutDelB').click( function() {
				$(this).closest('tr').remove();
				obj.update();
			});
			addedTr.find('[name$=cost]').keyup( function() {
				jsMakeCurrency(this);
				obj.update();				
			});			
			addedTr.find('[name$=purchaseOutCt]').bind("change keyup", function() {
				obj.update();
			});
			
			addedTr.find('.purchaseOutCost').bind("change keyup", function() {
				var purchaseOutSum = 0;
				target.find(".purchaseOutCost").each( function() {
					purchaseOutSum += parseInt(jsDeleteComma(this.value));
				});
				target.find('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
				obj.update();
			});
			
			cnt++;
			return addedTr;
		}
		
		this.init = function() {
			target.find('#purchaseOutAddB').click(obj.addWriteTr);
		};

		this.update = function() {
			var purchaseOutObj = new Array();
			var i = 0;
			target.find("tr").each( function() {
				var tr = $(this);
				var cost = jsDeleteComma(tr.find('[name$=cost]').val());
				var ct = tr.find('[name$=purchaseOutCt]').val();
				purchaseOutObj[i] = {
					year : globalData.stYear,
					month : globalData.stMonth,
					cost : parseInt(cost),
					ct : ct
				}
				i++;
			});
			globalData.purchaseOutObj = purchaseOutObj
			//사나매입의 %값을 변경해 줌;
			classes.purchaseInGeneral.updatePercent();
			classes.summingUp.updatePurchaseOut();
		}

		this.updateView = function() { //PurchaseOut
			var purchaseOutSum = 0;
			$.each(globalData.purchaseOutObj, function(key, val) {
				var tr = viewTr.clone();
				purchaseOutSum += val.cost;
				tr.find('.cost').html(jsAddComma(val.cost));
				tr.find('.purchaseOutCt').html(val.ct); //write
				tr.find('.ct').html(val.ct); //view
				tr.appendTo(target.find("tbody"));
			});
			$('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
		};

		this.updateDoc = function() {
			var purchaseOutSum = 0;
			$.each(globalData.purchaseOutObj, function(key, val) {
				var tr = obj.addWriteTr();
				purchaseOutSum += val.cost;
				tr.find('[name$=cost]').val(jsAddComma(val.cost));
				tr.find('[name$=purchaseOutCt]').val(val.ct); //write
				tr.find('[name$=ct]').val(val.ct); //view
			});
			$('.purchaseOutSum').text('총 금액 : ' + jsAddComma(purchaseOutSum) + '원 (부가세별도)');
		};
	};

	var PurchaseInGeneral = function(target, options) {
		var obj = this;
		var target = $(target);
		this.target = target;
		var cnt = 0;
		var basicTr = $('<tr>'
				+ '<td class="title" rowspan="2">금액</td>'
				+ '<td class="pL10" >'
				+ '	<input type="text" name="cost" class="span_4 currency purchaseInCost" value="0"/> 원'
				+ '	((매출-사외매입)×<input type="text" name="percent" class="span_1" />%)'
				+ '</td>'
				+ '<td class="title">프로젝트</td>'
				+ '<td class="pL10" >'
				+ '	<input type="text" name="pPrjNm" class="w200" readonly/>'
				+ '	<input type="hidden" name="pPrjId" />'
				+ '	<img src="'
				+ imagePath
				+ '/btn/btn_tree.gif" class="cursorPointer prjTreeGenB">'
				+ '</td>'
				+ '<td class="title">비고</td>'
				+ '<td class="pL10" ><input type="text" name="purchaseInCt" class="w200" /></td>'
				+ '	<td><img src="' + imagePath
				+ '/btn/btn_delete04.gif" class="purchaseInGeneralDelB"></td>'
				+ '</tr>');
		var viewTr = $('<tr>'
				+ '<td class="title">금액</td>'
				+ '<td class="pR10 txt_right" >'
				+ '	<span  class="cost"></span>원'
//				+ '	((매출-사외매입)×<span  class="percent"></span>%)'
				+ '</td>'
				+ '<td class="title">프로젝트</td>'
				+ '<td class="pL10" >'
				+ '	<span class="w200 pPrjNm"></span>'
				+ '</td>'
				+ '<td class="title">비고</td>'
				+ '<td colspan="2" class="pL10" ><span class="w200 ct"></span></td>'
				+ '</tr>');
		this.addWriteTr = function() {
			addedTr = basicTr.clone();
			addedTr.appendTo(target.find('tbody')).find("[name]").each(
					function(idx, elm) {
						$(this).attr(
								"name",
								"purchaseInGeneral\[" + cnt + "\]\."
										+ $(this).attr("name"));

					});
			addedTr.find('.purchaseInGeneralDelB').click( function() {
				$(this).closest('tr').remove();
				obj.update();
			});
			addedTr.find('[name$=purchaseInCt]').bind("change keyup", function() {
				obj.update();
			});
			addedTr.find('[name$=cost]').bind(
					"keyup change",
					function() {
						jsMakeCurrency(this);
						var purchaseOutSum = getPurchaseOutCostGenenral();
						var percent = jsDeleteComma($(this).val()) * 100
								/ (globalData.cost - purchaseOutSum);
						$(this).closest('tr').find('[name$=percent]')
								.val(roundXL(percent, 1));
						
						var purchaseInSum = 0;
						target.find(".purchaseInCost").each( function() {
							purchaseInSum += parseInt(jsDeleteComma(this.value));
						});
						target.find('.purchaseInSum').text('총 금액 : ' + jsAddComma(purchaseInSum) + '원');
						
						obj.update();
					});

			addedTr.find('[name$=percent]').bind(
					"keyup change",
					function() {
						var purchaseOutSum = getPurchaseOutCostGenenral();
						var cost = parseInt($(this).val()
								* (globalData.cost - purchaseOutSum) / 100);
						$(this).closest('tr').find('[name$=cost]').val(jsAddComma(cost));
						obj.update();
					});
			addedTr.find('.prjTreeGenB, [name$=pPrjNm]').click(
					function() {
						prjGen($(this).closest('tr').find('[name$=pPrjNm]'), $(
								this).closest('tr').find('[name$=pPrjId]'), 1,
								null, obj.update);
					});

			cnt++;
			return addedTr;
		}
		this.init = function() {
			target.find('#purchaseInGeneralAddB').click( function() {
				var addedTr = obj.addWriteTr();
			});			
		};
		
		this.update = function() {
			var purchaseInGeneralObj = new Array();
			var i = 0;
			target.find("tr").each( function() {

				var tr = $(this);
				var cost = jsDeleteComma(tr.find('[name$=cost]').val());
				var ct = tr.find('[name$=purchaseInCt]').val();
				var pPrjId = tr.find('[name$=pPrjId]').val();
				purchaseInGeneralObj[i] = {
					year : globalData.stYear,
					month : globalData.stMonth,
					cost : parseInt(cost),
					ct : ct,
					pPrjId : pPrjId
				};
				i++;
			});
			globalData.purchaseInGeneralObj = purchaseInGeneralObj;
			classes.summingUp.updatePurchaseIn();
		}		
		this.updatePercent = function(){
			var purchaseOutSum = getPurchaseOutCostGenenral();
			target.find("tr").each( function() {
				var tr = $(this);
				var cost = jsDeleteComma(tr.find('[name$=cost]').val());
				var percent = cost * 100
						/ (globalData.cost - purchaseOutSum);
				tr.find("[name$=percent]").val(roundXL(percent, 1));
			});
		};		
		this.updateView = function() { //PurchaseInGeneral
			var purchaseInSum = 0;
			$.each(globalData.purchaseInGeneralObj, function(key, val) {
				var tr = viewTr.clone();
				purchaseInSum += val.cost;
				tr.find('.cost').html(jsAddComma(val.cost));
				tr.find('.purchaseInCt').html(val.ct); //write
				tr.find('.ct').html(val.ct); //view
				tr.find(".pPrjNm").html("<a href=\"/cooperation/selectProjectV.do?prjId=" + val.pPrjId + "\" target=\"_blank\">" + "[" + val.pPrjCd + "] " + val.pPrjNm + "</a>");
				tr.appendTo(target.find("tbody"));
				var purchaseOutSum = getPurchaseOutCostGenenral();
				var percent = val.cost * 100
						/ (globalData.cost - purchaseOutSum);
				tr.find(".percent").html(roundXL(percent, 1));
			});
			$('.purchaseInSum').text('총 금액 : ' + jsAddComma(purchaseInSum) + '원');
		};
		this.updateDoc = function() {
			var purchaseInSum = 0;
			$.each(globalData.purchaseInGeneralObj, function(key, val) {
				var tr = obj.addWriteTr();
				purchaseInSum += val.cost;
				tr.find('[name$=cost]').val(jsAddComma(val.cost));
				tr.find('[name$=purchaseInCt]').val(val.ct); //write
				tr.find('[name$=ct]').val(val.ct); //view
				tr.find("[name$=pPrjNm]").val(
						"[" + val.pPrjCd + "] " + val.pPrjNm);
				tr.find("[name$=pPrjId]").val(val.pPrjId);
				var purchaseOutSum = getPurchaseOutCostGenenral();
				var percent = val.cost * 100
						/ (globalData.cost - purchaseOutSum);
				tr.find("[name$=percent]").val(roundXL(percent, 1));
			});
			$('.purchaseInSum').text('총 금액 : ' + jsAddComma(purchaseInSum) + '원');
		};
	};

	var SummingUp = function(target, options) {
		var obj = this;
		var target = $(target);
		var sales = 0;
		var purchaseOut = 0;
		var purchaseIn = 0;
		var profitOnSales = 0;
		var expense = 0;
		var divideBy = 1;
		this.updateSales = function() {
			sales = 0;

			$.each(globalData.salesObj, function(key, val) {
				sales += val["cost"];
			});
			target.find('.salesSum').html(jsAddComma(sales / divideBy));
			obj.updateProfit();
		};

		this.updateExpense = function() {
			expense = 0;
			$.each(globalData.expenseObj, function(key, val) {
				expense += val["cost"];
			});
			target.find('.expenseSum').html(jsAddComma(expense / divideBy));
			obj.updateProfit();
		};
		this.updatePurchaseOut = function() {
			purchaseOut = 0;
			purchaseOut = getPurchaseOutCostGenenral()
			target.find('.purchaseOutSum').html(
					jsAddComma(purchaseOut / divideBy));
			obj.updateProfit();
		};
		this.updatePurchaseIn = function() {
			purchaseIn = 0;
			purchaseIn = getPurchaseInCostGenenral();
			// jsAddComma(cost)
			target.find('.purchaseInSum').html(
					jsAddComma(purchaseIn / divideBy));
			obj.updateProfit();
		};

		this.updateProfit = function() {
			profitOnSales = sales - purchaseOut - purchaseIn;
			var profitOnSalesPercent = 0;
			var operatingProfitPercent = 0;
			target.find('.profitOnSales').html(
					jsAddComma(profitOnSales / divideBy));
			if (profitOnSales > 0)
				profitOnSalesPercent = parseFloat(profitOnSales * 100)
						/ parseFloat(sales);
			target.find('.profitOnSalesPercent').html(
					roundXL(profitOnSalesPercent, 1));
			operatingProfit = profitOnSales - expense;
			target.find('.operatingProfit').html(
					jsAddComma(operatingProfit / divideBy));
			if (operatingProfit > 0)
				operatingProfitPercent = parseFloat(operatingProfit * 100)
						/ parseFloat(sales);
			target.find('.operatingProfitPercent').html(
					roundXL(operatingProfitPercent, 1));
		};

	};

})(jQuery);
