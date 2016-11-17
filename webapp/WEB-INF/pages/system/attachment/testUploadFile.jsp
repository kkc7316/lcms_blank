<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>单文件上传demo</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script>
function download(){
  window.location.href="<%=path%>/attachment/testDownloadFileById.do?id="+$("#attaId").val();
}
function download2(){
	  window.location.href="<%=path%>/attachment/testHttpDownloadFileById.do?id="+$("#attaId").val();
}
</script>
  </head>
  
  <body>
	<h3>上传单个文件 实例</h3>

	<p>testUploadFile</p>
	<form action="attachment/testUploadFile.do" method="post"
		enctype="multipart/form-data">
		<p>选择文件:<input type="file" name="file"></p>
		<p><input type="submit" value="提交"></p>
	</form>
	
	<p>testUploadFile2</p>
	<form action="attachment/testUploadFile2.do" method="post"
		enctype="multipart/form-data">
		<p>选择文件:<input type="file" name="file"></p>
		<p><input type="submit" value="提交"></p>
	</form>
	======================================================
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
		======================================================
	<h3>文件下载</h3>
	<P> 请输入文件id:<input type="text" id="attaId" value="19"/>
		<a  onclick="download()"><font color="red">文件下载1</font> </a>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<a  onclick="download2()"><font color="red">文件下载2</font> </a>
    </p>
    
    httpDownload
</body>
</html>
