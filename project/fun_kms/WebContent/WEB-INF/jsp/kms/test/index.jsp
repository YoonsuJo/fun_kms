<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<ccc:constantsMap
  className="kms.com.common.config.PathConfig"
  var="path"/>

<script>
function login(id, pass) {
	location.href = "${rootPath}/actionLogin.do?userId="+ id + "&password=" + pass;
}

</script>
<input type="button" value="adolys" onclick="login('adolys','aa');" style="width:100%; height:200px;"/><br/>
<input type="button" value="blindblue" onclick="login('blindblue','bb');" style="width:100%; height:200px;"/>
<input type="button" value="a" onclick="login('a','a');" style="width:100%; height:200px;"/>
<input type="button" value="b" onclick="login('b','a');" style="width:100%; height:200px;"/>