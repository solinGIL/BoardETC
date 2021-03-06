<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String localIp = request.getRemoteAddr();

	System.out.println(localIp);
	
	if(!localIp.equals("127.0.0.1"))
	{
%>
	<script type="text/javascript">
		location.href="failip.html";
	</script>
<%
	}
%>		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
<link rel="stylesheet" href="common/css/login.css" />
<script type="text/javascript" src="common/js/json/json2.js"></script>
<script type="text/javascript" src="common/js/common.js"></script>
<script type="text/javascript" src="common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="common/js/table.js"></script>
<script type="text/javascript">
function goLogin()
{
	var form = document.MainForm;
	
	if(document.getElementById("adminId").value == "")
	{
		alert("아이디를 입력하세요.");
		document.getElementById("adminId").focus();
		return
	}
	else if(checkStr("adminId",document.getElementById("adminId").value) == false) 
	{ 
		document.getElementById("adminId").focus();
		return 
	}
	else if(document.getElementById("adminPwd").value == "")
	{
		alert("비밀번호를 입력하세요.");
		document.getElementById("adminPwd").focus();
		return
	}
	else if(checkStr("adminPwd",document.getElementById("adminPwd").value) == false) 
	{ 
		document.getElementById("adminPwd").focus();
		return 
	}
	else
	{
		form.method = "post";
		form.action = "login.jsp";
		form.submit();
	}
}
function checkStr(name,str)
{
	var countnum = 0;
	var checkstr = "script,alert,/script,cookie,document";
	checkstr = checkstr.split(",");
	
	str = str.toLowerCase();

	for(var i=0; i < checkstr.length; i++)
	{
		if(str.match(checkstr[i]) != null)
		{
			countnum++;
		}
	}
	
	if(countnum != 0)
	{
		alert("허용되지 않는 문자열이 있습니다.");
		document.getElementById(name).value = "";
		return false
	}
}
function checkEnter(){

	var form = document.MainForm;
	var code = window.event.keyCode; 
	if(code ==13)
	{
		goLogin();
	}else
	{
		return
	}
}
function onFocus()
{
	if(document.getElementById("adminId").value == "")
	{
		document.getElementById("adminId").focus();
	}
	else
	{
		document.getElementById("adminPwd").focus();
	}
	
}
</script>
</head>
<body onload="javascript:onFocus()">
<div id="login_wrap">
<div id="login_border">
<div id="login_width">
  <div class="login_logo"><a href="#"><img src="images/logo.png" width="295" height="27" alt="" /></a></div>
  <div class="form_box">
    <form name="MainForm">
	 <fieldset>
		<div class="id_area">
		  <input type="text" name="adminId" id="adminId" maxlength="12" placeholder="LogIn ID" value=""  onKeyDown="javascript:checkEnter()"/> 
		  <!-- 인풋타입에 회색으로 보여지는 글씨 placeholder -->
		</div>
		<div class="pw_area">
		  <input type="password" name="adminPwd" id="adminPwd" maxlength="20" placeholder="Password" value=""  onKeyDown="javascript:checkEnter()"/>
		</div>		
		<div class="login_area">
		  <input type="button" name="btnLogin" id="btnLogin" value="LogIn" title="LogIn" style="cursor:pointer" onclick="javascript:goLogin();" />		
		</div>
	 </fieldset>
	 </form>
  </div>
</div>
</div>  
</div>
</body>
</html>