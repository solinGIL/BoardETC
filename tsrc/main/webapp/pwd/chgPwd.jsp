<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%
	request.setCharacterEncoding("utf-8");

	String userId = StringTool.NullTrim(request.getParameter("userId"));
	//userId = "wjdrkfl27";

	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>비밀번호 변경</title>
<link type="text/css" rel="stylesheet" href="../common/css/pwdcss.css">
<script type="text/javascript">
function resize()
{
	self.resizeTo(350,350);
}

function checkPassword()
{
	var form = document.MainForm;
	
	if(document.getElementById("userId").value == "")
	{
		alert("아이디가 존재하지 않습니다.");
	}
	else
	{
		if(document.getElementById("password").value != "" && document.getElementById("password_confirm").value != "")
		{
			if(document.getElementById("password").value.length < 4)
			{
				alert("최소 4자리 이상 입력하세요");
				document.getElementById("password").focus();
				return
			}
			
			else if(!strOk("password",document.getElementById("password").value))
			{
				alert("영문, 숫자, 특수문자를 섞어서 사용해 주세요.");
				document.getElementById("password").focus();
				return
			}
			else if(document.getElementById("password").value != document.getElementById("password_confirm").value)
			{
				alert("입력한 비밀번호가 다릅니다.");
				document.getElementById("password_confirm").value = "";
				document.getElementById("password_confirm").focus();
			}
			else
			{
				form.method = "post";
				form.action = "save.jsp?TYPE=PWD";
				form.submit();
			}
		}
		else
		{
			alert("비밀번호를 입력해 주세요.");
			return
		}
	}
}

function resetPassword()
{
	var form = document.MainForm;
	
	if(document.getElementById("resetId").value == "")
	{
		alert("사용자 아이디를 입력하세요.");
		document.getElementById("resetId").focus();
		return
	}
	else
	{
		form.method = "post";
		form.action = "save.jsp?TYPE=RESET";
		form.submit();
	}
}

function strOk(name,str)
{
	var eng = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var num = "0123456789";
	var etc = "`~!@#$%^&*()-_=+[]{};:,<.>/?'";

	var inEng = false;
	var inNum = false;
	var inEtc = false;

	for(var i=0; i < str.length; i++)
	{
		if(eng.indexOf(str.charAt(i)) != -1)
		{
			inEng = true;
			break;
		}
	}

	for(var i=0; i < str.length; i++)
	{
		if(num.indexOf(str.charAt(i)) != -1)
		{
			inNum = true;
			break;
		}
	}
	
	for(var i=0; i < str.length; i++)
	{
		if(etc.indexOf(str.charAt(i)) != -1)
		{
			inEtc = true;
			break;
		}
	}

	if((inEng && inNum && inEtc))
	{
		return true;
	} 
	else 
	{
		return false;
	}
}
</script>
</head>
<body onload="javascript:resize()">
 <form name="MainForm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="bg_title"><img src="../images/icon_02.gif" width="11" height="12">비밀번호 수정</td>
  </tr>
</table>
<!-- 타이틀 끝 -->
<table width="100" border="0" cellspacing="10" cellpadding="0">
  <tr>
    <td><table width="298" border="0" cellpadding="10" cellspacing="5" bgcolor="93abc6">
        <tr>
          <td bgcolor="#FFFFFF"><table width="280" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td colspan="4"></td>
            </tr>
            <tr>
              <td colspan="4"></td>
            </tr>
            <tr>
              <td width="2%" height="18" align="right" class="t_gray">&nbsp;</td>
              <td width="55%" height="24" class="t_black t_bold"> - 사용자 아이디</td>
              <td width="5%" class="t_gray">ㅣ</td>
              <td width="38%"><input type="text" size="8" max="8" id="userId" name="userId" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:12px; color:#5E5E5E; width: 100px; height:20px" readonly value="<%=userId%>"></td>
            </tr>
            <tr>
              <td height="18" align="right" class="t_gray">&nbsp;</td>
              <td height="24" class="t_black t_bold"> - 새로운 비밀번호</td>
              <td class="t_gray">ㅣ</td>
              <td><input type="password" size="8" max="8" id="password" name="password" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:12px; color:#5E5E5E; width: 100px; height:20px"></td>
            </tr>
            <tr>
              <td height="18" align="right" class="t_gray">&nbsp;</td>
              <td height="24" class="t_black t_bold"> - 새로운 비밀번호 재입력</td>
              <td class="t_gray">ㅣ</td>
              <td><input type="password" size="8" max="8" id="password_confirm" name="password_confirm" style="BACKGROUND-COLOR: #FFFFFF; BORDER: #DDDDDD 1 solid; font-family:Tahoma; font-size:12px; color:#5E5E5E; width: 100px; height:20px" ></td>
            </tr>
          </table></td>
        </tr>
    </table></td>
  </tr>
</table>
<table width="330" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center"><a href="javascript:checkPassword()"><img src="../images/btn_confirm.gif" width="59" height="28"><br><br></a></td>
  </tr>
</table>
</form>
</body>
</html>