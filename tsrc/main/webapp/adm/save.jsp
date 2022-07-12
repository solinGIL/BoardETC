<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
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
	String passwd = StringTool.NullTrim(request.getParameter("pwd"));
	String encPwd = StringTool.getSHA256(passwd);
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	ModelOptimizer mo = new ModelOptimizer();
	
	String query = prot.getProperty("PWDMODQUERY").trim();
	String[] val = {encPwd,adminId};
	
	boolean ok = mo.execute(query,val);
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