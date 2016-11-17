<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<link rel="icon" href="image/favicon.ico">
<title><spring:message code="GLOBAL_TITLE"></spring:message></title>
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<link type="text/css" rel="stylesheet" href="css/common_login.css" />
<link type="text/css" rel="stylesheet" href="css/layout_login.css" />
<script type="text/javascript">
$(function(){
    var boxTop = $("body").height()-$(".box_login").height()-50;
    $(".box_login").css("top",boxTop/2+"px");
});
</script>
</head>
<body style="background:rgb(240,244,246);">
<form name="loginForm" action="<%=request.getContextPath() %>/login.do" method="post">
<div class="login">
    <div class="bg_login_bottom"></div>
    
    <!-- box_login s -->
    <div class="box_login">
         <div class="box_logo"><p style="color: red;font-size: large;">${message}</p></div>
        
        <div class="login_panel">
            <spring:message code="LOGIN_NAME"></spring:message>
            <p class="login_user"><input type="text" class="file_fixed_310px" name="userUID"><span class="label_user"></span></p>
            <spring:message code="PASSWORD"></spring:message>
            <p class="login_pwd"><input type="password" class="file_fixed_310px" name="password"><span class="label_pwd"></span></p>
            <div class="box_btn_login">
                <button class="btn_login" type="submit"><spring:message code="LOGIN"></spring:message></button>
                <button class="btn_register float_R" type="reset"><spring:message code="CANCEL"></spring:message></button>
            </div>
        </div>
    </div>
    <!-- box_login e -->
</div>

</form>
<!--footer s-->
<div class="footer">
	<spring:message code="COPYRIGHT"></spring:message>
</div>
<!--footer e-->
</body>
</html>