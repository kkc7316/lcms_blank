

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<title><spring:message code="GLOBAL_TITLE"></spring:message></title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link rel="stylesheet" href="js/selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/selectyze/selectyze.jquery.min.js"></script>
<script src="js/main.js"></script>
<script>

</script>
</head>
<body style="background-color: rgb(240,240,240)">
<div class="main_left">
        <div id="wrapper-250">
            <ul class="accordion">
            	<!-- 系统首页 -->
            	<li style="*height: 40px;"><a href="content.do" target="content"><span>系统首页</span></a></li>
            	<!-- 资源菜单 -->
                <shiro:hasPermission name="SYSTEM_MANAGE">
                <li><span><spring:message code="SYSTEM_MANAGE"></spring:message></span>
                    <ul class="sub-menu">
                    	<shiro:hasPermission name="USER_MANAGE"><li><a href="user/userListPage.do" target="content"><spring:message code="USER_MANAGE"></spring:message></a></li></shiro:hasPermission>
                        <shiro:hasPermission name="ROLE_MANAGE"><li><a href="role/roleListPage.do" target="content"><spring:message code="ROLE_MANAGE"></spring:message></a></li></shiro:hasPermission>
                        <shiro:hasPermission name="RESOURCE_MANAGE"><li><a href="resource/resourceListPage.do" target="content"><spring:message code="RESOURCE_MANAGE"></spring:message></a></li></shiro:hasPermission>
                        <shiro:hasPermission name="DICT_MANAGE"><li><a href="dictIdxListPage.do" target="content"><spring:message code="DICT_MANAGE"></spring:message></a></li></shiro:hasPermission>
                    </ul>
                </li>
                
                </shiro:hasPermission>
            </ul>
		</div>
    </div>
</body>
</html>
