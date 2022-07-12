<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%@ page import="kr.co.ultari.File.FileController" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<%

	String adminId = (String) request.getSession().getAttribute("adminId");

if ( adminId == null )
{
%>
<script language=javascript>
	document.onload = noId();
	function noId()
	{
		parent.parent.document.location.href = "../index.html";
	}
	
</script>
<%
}
	String attachYN = StringTool.NullTrim(request.getParameter("attachYN"));
	String size = StringTool.NullTrim(request.getParameter("size"));
	String initialpwd = StringTool.NullTrim(request.getParameter("initialpwd"));
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String conf = prot.getProperty("MMSCONFIGPATH").trim();

	FileController fc = new FileController();
	
	boolean ok = false;
	
	try
	{
		fc.ModFile(conf, "4CLIENT_USE_ADD_FILE", attachYN);
		fc.ModFile(conf, "4CLIENT_MAX_FILE_MSG", size);
		fc.ModFile(conf, "4CLIENT_MAX_FILE_CHAT", size);
		fc.ModFile(conf, "4CLIENT_INITIAL_PASSWORD", initialpwd);
		
		ok = true;
	}
	catch(Exception e){e.printStackTrace();}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<form name ="MainForm">
</form>
<script type="text/javascript">

function goBack()
{
	if("<%=ok%>" == "true")
	{
		alert("변경 되었습니다.");	
	}
	else
	{
		alert("변경 실패하였습니다.");
	}
	
	var form = document.MainForm;
	form.method = "post";
	form.action = "index.jsp";
	form.submit();
}
location.href="javascript:goBack()";
</script>
</head>