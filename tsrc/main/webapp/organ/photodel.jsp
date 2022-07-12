<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%
	request.setCharacterEncoding("EUC-KR");

	String gubun = StringTool.NullTrim(request.getParameter("gubun"));
	String deptId = StringTool.NullTrim(request.getParameter("deptId"));
	String userId = StringTool.NullTrim(request.getParameter("userId"));
	String sSrchGubun = StringTool.NullTrim(request.getParameter("sSrchGubun"));
	String sSrchText = StringTool.NullTrim(request.getParameter("sSrchText"));
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String baseDir = prot.getProperty("PHOTODIR").trim();
	
	String userDir = "";	
	userDir = StringTool.getFilePath(userId,baseDir);
	
	String delFDir = userDir + java.io.File.separator + userId + ".jpg";
	File delF = new File(delFDir);
	
	if(delF.exists())
	{
		delF.delete();
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<form name ="MainForm">
<input type="hidden" name="deptId" id="deptId" value="<%=deptId%>">
<input type="hidden" name="sSrchGubun" id="sSrchGubun" value="<%=sSrchGubun%>">
<input type="hidden" name="sSrchText" id="sSrchText" value="<%=sSrchText%>">
</form>
<script type="text/javascript">

function goBack()
{
	alert("삭제 되었습니다.");
	var form = document.MainForm;
	var gubun = "<%=gubun%>";
	var userId = "<%=userId%>";
	var url = "";
	
	if(gubun == "view")
	{
		url = "view.jsp";
	}
	else
	{
		url = "srchview.jsp";
	}
	
	form.method = "post";
	form.action = url + "?userId="+userId;
	form.submit();
}
location.href="javascript:goBack()";
</script>
</head>

	
	