<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%    
// 고정
String adminId = (String)request.getSession().getAttribute("adminId");
String adminNm = (String)request.getSession().getAttribute("adminNm");
if ( adminId == null )
{
	%>
	<script language=javascript>
		document.onload = noId();
		function noId()
		{
			document.location.href = "index.html";
		}
		
	</script>
	<%
}
// 고정 end
%>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
</head>
	<frameset rows="150,*,80" frameborder="no" border="0" framespacing="0">
		<frame src="top.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" align="center"/>
		<frame src="middle.jsp" name="middle" id="middle" title="middle" scrolling="no">
		<frame src="bottom.jsp" name="bottomFrame" scrolling="no" noresize="noresize" id="bottomFrame" title="bottomFrame" />
	</frameset>
	<noframes></noframes>
</html>