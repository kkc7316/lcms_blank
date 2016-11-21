<%@ page contentType="application/json;charset=UTF-8" language="java"%>
<%Exception e = (Exception) request.getAttribute("ex");
%>
{
	"type":"ajaxException",
	"ex_error":"<%=e.getClass().getSimpleName()%>",
 	"ex_detail":"<%=e.getMessage()%>"
}