<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="selectyze/selectyze.jquery.min.js"></script>
<script  type="text/javascript" src="js/main.js"></script>
<script type="text/javascript">
$(window.parent.document).find("button").removeClass('btn_active');
$(window.parent.document).find("button").removeAttr("disabled");
showMsg2('${validateMsg}');
</script>
  </head>
  
  <body>
  </body>
</html>
