<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%
String adminId = (String) request.getSession().getAttribute("adminId");

if ( adminId == null )
{
%>
<script language=javascript>
	document.onload = noId();
	function noId()
	{
		parent.document.location.href = "../index.html";
	}
	
</script>
<%
}
	request.setCharacterEncoding("utf-8");

	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<link type="text/css" rel="stylesheet" href="../common/css/admin.css">
	<link type="text/css" rel="stylesheet" href="../common/css/css.css">
	<link type="text/css" rel="stylesheet" href="../common/css/jquery-ui.css" />
	<script type="text/javascript" src="../common/js/WinUtil.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery.form.min.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery.filestyle.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery-ui.js"></script>
</head>
<script type="text/javascript">
function goSave()
{
	var form = document.MainForm;
	var pwd = document.getElementById("pwd").value;
	
	if(pwd == "")
	{
		alert("변경할 패스워드를 입력하세요.");
	}
	else
	{
		form.method = "post";
		form.action = "save.jsp";
		form.submit();
	}
}
	
</script>
<body>
<form name="MainForm">
<div id="title">
  <div id="title_width">
    <p>관리자</p>
  </div>
</div>
<br>
	<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center"> 
    	<tr>
    		<td width="100%" colspan="20" align="left">
    			<a href="javascript:goSave();"><img src="../images/btn_save.png" width="48" height="23"></a>
    		</td>
    	</tr>
    </table>
	<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr><td height="5"></td></tr>
		<tr>
			<td width="250" class="formtype-gray">관리자 로그인 패스워드</td>
			<td width="250" class="formtype"><input type="password" name="pwd" id="pwd" value="" style="width:100%;ime-mode:disabled;"></td>
			<td width=""></td>
		</tr>
    </table> 
</form> 
</body>
</html>