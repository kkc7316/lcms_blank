<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>单文件下载demo</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<h2>上传单个文件 实例</h2>


	<a href="<%=path%>/attachment/testDownloadFile.do">下载</a>  
	
	<a href="<%=path%>/attachment/testDownloadFileById.do?id=200">下载101</a>  
	
	<p>TODO ExtJS 文件列表，点击下载</p>
	<p>TODO ExtJS 文件列表，多先，批量下载</p>
</body>
</html>
