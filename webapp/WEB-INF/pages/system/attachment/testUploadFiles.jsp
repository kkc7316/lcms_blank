<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>多文件上传demo</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
  </head>
  
  <body>
    		<form id="multipleUploadForm" action="attachment/testUploadFiles.do" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td colspan="2" align="center">
						<button type="button" onclick="addFileInput()">+</button>
						<button type="button" onclick="deleteFileInput()">-</button>
					</td>
				</tr>
				<tr>
					<td>文件</td>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td>文件</td>
					<td><input type="file" name="file"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="上传" />
					</td>
				</tr>
			</table>
		</form>
  </body>
</html>
