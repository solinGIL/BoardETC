<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%@ page import="kr.co.ultari.File.FileController" %>
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
	
	String conf = prot.getProperty("MMSCONFIGPATH").trim();
	
	FileController fc = new FileController();
	String attachYN = fc.getConfigList(conf, "4CLIENT_USE_ADD_FILE");
	String max = fc.getConfigList(conf, "4CLIENT_MAX_FILE_MSG");
	
	String initialpwd = fc.getConfigList(conf, "4CLIENT_INITIAL_PASSWORD");
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
	
	if(document.getElementById("size").value == "")
	{
		alert("?????? ????????? ???????????????.");
		document.getElementById("size").focus();
		return
	}
	else
	{
		form.method = "post";
		form.action = "save.jsp";
		form.submit();
	}
}

//????????????, ????????? ??????
$(function()
{
	$(document).on("keyup", "#size", function() 
	{
		if($(this).val().length > 4)
			this.value = this.value.substring(0,4);
	});
	
	$("#size").keypress(function(event)
	{
		if (event.which && (event.which > 47 && event.which < 58 || event.which == 8)) {
		}
		else
		{
			event.preventDefault();
		}
	});   

	//??????????????? ime-mode:disabled ???????????? ?????????????????? ??????????????? ??????
    $("#size").keyup(function(event)
	{
		$(this).val($(this).val().replace(/[^0-9]/g,''));
    });
});	
</script>
<body>
<form name="MainForm">
<div id="title">
  <div id="title_width">
    <p>?????? ??????</p>
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
			<td width="250" class="formtype-gray">???????????? ??????</td>
			<td width="150">
			<select name="attachYN" id="attachYN" onchange="javascript:checkOption();">
    			<option value="Y" <%=attachYN.equals("Y") ? "selected" : "" %>>??????&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
    			<option value="N" <%=attachYN.equals("N") ? "selected" : "" %>>?????????</option>
         	</select>
			</td>
			<td width=""></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="250" class="formtype-gray">???????????? ?????? ??????(MB)</td>
			<td width="150" class="formtype"><input type="text" name="size" id="size" value="<%=max%>" style="width:100%;ime-mode:disabled;"></td>
			<td width=""></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="250" class="formtype-gray">????????? ?????? ????????????</td>
			<td width="150" class="formtype"><input type="text" name="initialpwd" id="initialpwd" value="<%=initialpwd%>" style="width:100%;ime-mode:disabled;"></td>
			<td width=""></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td colspan="3">??? ??? ?????? ?????? ????????? ???????????? ??? ?????? ?????????.</td>
		</tr>
		<tr>
			<td colspan="3">??? ?????? ??????????????? ?????? ?????? ???????????? ????????? ????????????, ?????? ?????? ?????? ?????? ?????? ?????? ??????????????? ?????? ?????????.</td>
		</tr>
    </table> 
</form> 
</body>
</html>