<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Spring MVC Multiple File Upload</title>
    <script type="text/javascript">
    function back() {
    	history.go(-1);
    }
    </script>
</head>
<body>
    <h1>Spring Multiple File Upload example</h1>
    <p>Following files are uploaded successfully.</p>
    <ol>
        <c:forEach items="${files}" var="file">
            <li>
            	id= ${file.fileId}&nbsp;&nbsp;&nbsp;&nbsp;
            	fileName = ${file.fileName}
            </li>
        </c:forEach>
    </ol>
    <a onclick="back()">返回</a>
</body>
</html>