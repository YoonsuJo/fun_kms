<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>FUNNET KMS 시스템</title>
<%@ include file="../include/top_inc.jsp"%>
</head>
<script>
function searchTaxPrj(){
	document.bondFrm.prjId.value = '';
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondPrj.do" />';
	document.bondFrm.submit();
}
function popCollection(bondPrjNo){
	document.bondFrm.bondPrjNo.value = bondPrjNo;
	
	var POP_NAME = "_POP_COLLECTION_LIST_";
	var target = document.bondFrm.target;
	document.bondFrm.target = POP_NAME;
	document.bondFrm.action = '<c:url value="${rootPath}/management/collectL.do" />';
	
	var popup = window.open("about:blank", POP_NAME, "width=560px,height=570px;");
	document.bondFrm.submit();
	popup.focus();
	document.bondFrm.target = target;
}
function thisRefresh() {
	document.bondFrm.action = '<c:url value="${rootPath}/management/bondNoPublish.do" />';
	document.bondFrm.submit();
}

function toggleBondManageYn(state, docId) {
	var msg = "이 매출에 대해 채권관리를 ";
	var newState = "N";

	if (state == "Y") {
		msg += "하지 않으시겠습니까?";
		newState = "N"; 
	}
	else {
		msg += "하시겠습니까?";
		newState = "Y";
	}
	
	if (confirm(msg)) {
		var url = '<c:url value="${rootPath}/management/updateSalesBondManageYn.do?bondManageYn=' + newState + '&docId=' + docId + '" />';
		document.bondFrm.action = url;
		document.bondFrm.submit();
	}
}

function showLayer(layerName, docId, obj, type) {
	var prjId = "${searchVO.prjId}";
	
	if (type=='taxList') {
		$.ajax({
			url: "/management/ajax/taxPublishList.do",
			data: {
				prjId: prjId,
				searchMappingFlag : "LIST" 
			},
			type: "POST",
			async: false,
			//dataType: "json",
			success: function(data) {
				$('#bondPrjLayer').html(data);
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("데이터를 가져오는데 실패하였습니다.");
				return false;
			}
		});
		$('#layerDocId').val(docId);
	} else if (type=='taxShow') {
		$.ajax({
			url: "/management/ajax/taxPublishDetail.do",
			data: {
				prjId: prjId,
				docId: docId
			},
			type: "POST",
			async: false,
			//dataType: "json",
			success: function(data) {
				$('#bondPrjLayer').html(data);
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("데이터를 가져오는데 실패하였습니다.");
				return false;
			}
		});
		$('#layerDocId').val(docId);
	} else if (type=='salesShow') {
		$.ajax({
			url: "/management/ajax/salesBond.do",
			data: {
				prjId: prjId,
				bondPrjNo: docId
			},
			type: "POST",
			async: false,
			//dataType: "json",
			success: function(data) {
				$('#bondPrjLayer').html(data);
			},
			error: function(xhr, testStatus, errorThrown) {
				alert("데이터를 가져오는데 실패하였습니다.");
				return false;
			}
		});
	}
	
	// Show layer
	var scrolled = $(window).scrollTop();
	var position = $(obj).offset();
	var left = position.left + 65;
	var top = position.top + 28 - scrolled;
	
	$('#'+layerName).dialog( {
		height: 400
		,width: 800
		,position : [left, top]
		,closeOnEscape: true 
		,resizable: true
		,draggable: true
		//,modal: true
		,autoOpen: true
		//,beforeClose: function(event, ui) { alert(1);}     
	});
}

function addMapping() {
	var prjId = "${searchVO.prjId}";
	$.ajax({
		url: "/management/ajax/taxPublishList.do",
		data: {
			prjId: prjId,
			searchMappingFlag : "LIST_ADD" 
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			$('#bondPrjLayer').html(data);
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("데이터를 가져오는데 실패하였습니다.");
			return false;
		}
	});
}

function saveMapping() {
	var objBondPrjNo = $('input[name=bondPrjNo]:checked'); 
	
	if (objBondPrjNo.length<=0) {
		alert('선택된 세금계산서가 존재하지 않습니다.');
		return false;
	}
	
	var strBondPrjNo = '';
	for(var i=0; i<objBondPrjNo.length; i++) {
		strBondPrjNo += $(objBondPrjNo[i]).val() + ',';
	}
	
	var docId = $('#layerDocId').val();
	$.ajax({
		url: "/management/ajax/insertSalesBond.do",
		data: {
			docId: docId,
			strBondPrjNo: strBondPrjNo
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			if (data.indexOf('success') > -1) {
				alert('정상적으로 저장되었습니다.');
				$('#span_pub_' + docId).text('발행');
				$('#span_pub_' + docId).next().val('보기');
				$('#span_pub_' + docId).next().attr("onclick", "showLayer('bondPrjLayer', '"+docId+"', this, 'taxShow')");
			} else {
				alert("데이터를 저장하는데 실패하였습니다.");
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("데이터를 저장하는데 실패하였습니다.");
			return false;
		}
	});
	
	//document.bondPrjFrm.action = "${rootPath}/management/ajax/insertSalesBond.do";
	//document.bondPrjFrm.submit();
	$('#bondPrjLayer').dialog( "close" );
}

function delMapping() { 
	
	if (!confirm('이 매핑데이터를 삭제하겠습니까?')) {
		return false;
	}
	
	var docId = $('#layerDocId').val();
	$.ajax({
		url: "/management/ajax/deleteSalesBond.do",
		data: {
			docId: docId
		},
		type: "POST",
		async: false,
		//dataType: "json",
		success: function(data) {
			if (data.indexOf('success') > -1) {
				alert('정상적으로 삭제되었습니다.');
				$('#bondPrjLayer').dialog( "close" );
				$('#span_pub_' + docId).text('');
				$('#span_pub_' + docId).next().val('처리');
				$('#span_pub_' + docId).next().attr("onclick", "showLayer('bondPrjLayer', '"+docId+"', this, 'taxList')");
			} else {
				alert("데이터를 삭제하지 못했습니다.");
			}
		},
		error: function(xhr, testStatus, errorThrown) {
			alert("데이터를 처리하는데 실패하였습니다.");
			return false;
		}
	});
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
		<%@ include file="../common/menu/leftMenu.jsp"%>
			<!-- S: centerBg -->
			<div id="center_bg">
				<!-- S: center -->
				<div id="center">
					<div class="path_navi">
						<ul>
							<li class="stitle">세금계산서 미발행 내역</li>
							<li class="navi">홈 > 경영정보 > 매출관리 > 채권관리</li>
						</ul>
					</div>
	
					<!-- S: section -->
					<div class="section01">
					
					<form name="bondFrm" id="bondFrm" method="POST" action="">
						<input type="hidden" name="startDate" value="${searchVO.startDate}"/>
						<input type="hidden" name="endDate" value="${searchVO.endDate}"/>
						<input type="hidden" name="searchOrgId" id="orgId" value="${searchVO.searchOrgId}"/>
						<input type="hidden" name="searchOrgNm" id="orgNm" value="${searchVO.searchOrgNm}"/>
						<input type="hidden" name="bondPrjNo" value="0"/>
						<input type="hidden" name="prjId" value="${searchVO.prjId}"/>
					</form>
					
						<p class="th_stitle">요약</p>
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col width="px" />
								<col class="col100" />
								<col class="col100" />
								<col class="col100" />
							</colgroup>
							<thead>
								<tr>
									<th>프로젝트</th>
									<th>총 매출액<br/>(채권관리금액)</th>
									<th>발행금액</th>
									<th class="td_last">미발행금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="txt_center"><a href="${rootPath}/cooperation/selectProjectV.do?prjId=${resultSum.prjId}">[${resultSum.prjCd}] ${resultSum.prjNm}</a></td>
									<td class="txt_center"><print:currency cost="${resultSum.accSumSales}"/></td>
									<td class="txt_center"><print:currency cost="${resultSum.accSumExpense}"/></td>
									<td class="td_last txt_center"><print:currency cost="${resultSum.accNoPublish}"/></td>
								</tr>
							</tbody>
							</table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="#" onclick="searchTaxPrj();"><img src="../../images/btn/btn_list.gif"/></a>
						</div>
						<!-- 버튼 끝 -->
						
						<p class="th_stitle">상세정보</p>
						
						<!-- 매출보고내역 시작  -->
						<p class="th_stitle2 mT10">매출보고내역</p>
						<p class="th_plus02">단위 : 원</p>
						<div id="salesD">
							<form name="salesFrm" id="salesFrm" method="POST" action="" onsubmit="salesSearch(1); return false;">
							<input type="hidden" name="prjId" value="${searchVO.prjId}"/>
							<!-- 게시판 시작  -->
							<div id="salesInnerD">
								<c:import url="${rootPath}/ajax/bondSalesList.do">
								</c:import>
							</div>
							</form>
						</div>
						<!--// 매출보고내역  끝  -->
						
						<p class="th_stitle2 mT10">세금계산서 발행내역</p>
						<!-- 게시판 시작  -->
						<p class="th_plus02">단위 : 원</p>
						<div class="boardList02 mB20">
							<table cellpadding="0" cellspacing="0" summary="각 게시물의 상세 내용을 볼 수 있습니다.">
							<caption>공지사항 보기</caption>
							<colgroup>
								<col class="col100" />
								<col width="px" />
								<col class="col60" />
								<col class="col80" />
								<col class="col80" />
								<col class="col80" />
								<col class="col80" />
								<col class="col50" />
							</colgroup>
							<thead>
								<tr class="height_th">
									<th>발행일</th>
									<th>업체명</th>
									<th>발행회사</th>
									<th>발행금액</th>
									<th>수금액<br/>(VAT 포함)</th>
									<th>미수금액<br/>(VAT 포함)</th>
									<th>수금내역</th>
									<th class="td_last">연결<br>매출건</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${taxPublishList}" var="result" varStatus="c">
								<tr>
									<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}"><print:date date="${result.publishDate}"/></a></td>
									<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}">${result.custNm}</a> </td>
									<td class="txt_center">${result.companyNm} </td>
									<td class="txt_center"><a href="${root}/support/taxPublishV.do?bondId=${result.bondId}"><print:currency cost="${result.sumExpense}"/></a></td>
									<td class="txt_center"><print:currency cost="${result.sumCollection}"/></td>
									<td class="txt_center"><print:currency cost="${result.noCollection}"/></td>
									<td class="txt_center"><img src="../../images/btn/btn_collect.gif" onclick="popCollection(${result.bondPrjNo});" class="cursorPointer" /></td>
									<td class="td_last txt_center">
										<c:if test="${result.bondSalesCnt>0}">
											<input type="button" class="btn_gray fr" value="보기" onclick="showLayer('bondPrjLayer', '${result.bondPrjNo}', this, 'salesShow')"/>
										</c:if>
									</td>
								</tr>
								</c:forEach>
							</tbody>
							</table>
						</div>
						<!--// 게시판 끝  -->
						
						<!-- 버튼 시작 -->
						<div class="btn_area">
							<a href="#" onclick="searchTaxPrj();"><img src="../../images/btn/btn_list.gif"/></a>
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
<%@ include file="../include/footer.jsp"%>
</div>
<input type="hidden" name="docId" id="layerDocId" value=""/>
<div id="bondPrjLayer" style="display:none; z-index:5; ">
</form>
</body>
</html>
