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
<link type="text/css" rel="stylesheet" href="css/layout.css" />
<link rel="stylesheet" href="js/selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
</head>
<body>
<div class="head">
    <div class="logo"></div>
    <span class="title"><spring:message code="SYSTEM_NAME"></spring:message></span>
    <div class="message">
<%--        <span style="background:none;"><img src="image/touxiang.png"/><font style="margin-left:10px;"><spring:message code="WELCOME"></spring:message>，夏冬青</font></span>--%>
<%--        <span><img src="image/ico1.png"/></span>--%>
<%--        <span><img src="image/ico2.png"/></span>--%>
<%--        <span><img src="image/ico3.png"/></span> --%>
        <span style="padding-right: 25px;cursor: default;"><spring:message code="WELCOME"/>,${currentUser.employeeNum } ${currentUser.employeeName } &nbsp; <spring:message code="LOGIN_TIME"/>:${loginTime}</span>
    </div>
    <div style="height: 0px;">
      <input type="button" id="showMsgBtn" onclick="showDiv();" />
      <input type="hidden" id="showMsgHid" value=""/>
      
      <input type="button" id="showMsgBtn2" onclick="showDiv2();" />
      <input type="hidden" id="showMsgHid2" value=""/>
      
      <input type="button" id="showMsgBtn3" onclick="showDiv3();" />
      <input type="hidden" id="showMsgHid3" value=""/>
    </div>
</div>
<script>
</script>
</body>
</html>
