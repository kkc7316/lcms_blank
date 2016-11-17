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
showMsg('保存完成');
$(window.parent.parent.document).find("#import_ifa,#bgDiv").css("display",'none');
$(window.parent.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
$(window.parent.parent.document).find("#update_ifa,#bgDiv").css("display",'none');
$(window.parent.parent.document).find("#relay").attr("src","about:blank");
$(window.parent.parent.document).find("#relay1").attr("src","about:blank");
$(window.parent.parent.document).find("#relay2").attr("src","about:blank");

//关闭弹窗时清除弹窗链接
$(window.parent.parent.document).find("#userList_kcpd").attr("src","about:blank");
$(window.parent.parent.document).find("#roleList_kcpd").attr("src","about:blank");
window.parent.parent.refresh();
</script>
  </head>
  
  <body>
  </body>
</html>
