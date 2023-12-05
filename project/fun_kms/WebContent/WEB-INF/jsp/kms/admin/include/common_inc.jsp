<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <!-- start checkboxTree configuration -->
    <script type="text/javascript" src="${commonPath}/library/jquery-1.4.4.js"></script>
    <script type="text/javascript" src="${commonPath}/library/jquery-ui-1.8.12.custom/js/jquery-ui-1.8.12.custom.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${commonPath}/library/jquery-ui-1.8.12.custom/css/smoothness/jquery-ui-1.8.12.custom.css"/>

    <script type="text/javascript" src="${commonPath}/js/jquery.checkboxtree.js"></script>
    <link rel="stylesheet" type="text/css" href="${commonPath}/css/jquery.checkboxtree.css"/>
    <!-- end checkboxTree configuration -->

    <script type="text/javascript" src="${commonPath}/library/jquery.cookie.js"></script>
    <script type="text/javascript">
        //<!--
        $(document).ready(function() {
            $('#tabs').tabs({
                cookie: { expires: 30 }
            });
            $('.jquery').each(function() {
                eval($(this).html());
            });
            $('.button').button();
        });
        //-->
    </script>