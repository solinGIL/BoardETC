<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%
	request.setCharacterEncoding("EUC-KR");

	String deptId = StringTool.NullTrim(request.getParameter("deptId"));
	String deptNm = StringTool.NullTrim(request.getParameter("deptNm"));
	String deptHigh = StringTool.NullTrim(request.getParameter("deptHigh"));
	String deptSort = StringTool.NullTrim(request.getParameter("deptSort"));
	String deptType = StringTool.NullTrim(request.getParameter("deptType"));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>사용자 관리</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript">

function checkPage()
{
	return "deptmod";
}

function goBack()
{
	history.back();
}

function goSave()
{
	if(document.getElementById("deptNm").value == "")
	{
		alert("부서명을 입력하세요.");
		document.getElementById("deptNm").focus();
		return
	}else if(checkStr("deptNm",document.getElementById("deptNm").value) == false) 
	{ 
		document.getElementById("deptNm").focus();
		return 
	}
	
	else
	{
		form = document.MainForm;
		form.method = "post";
		form.action = "deptsave.jsp?gubun=MOD";
		form.submit();
	}
}

function setDept(id,nm,orgHigh)
{
	/*nm = nm.substring(0,nm.lastIndexOf("(")-1);
	document.getElementById('deptId').value = id;
	document.getElementById('deptNm').value = nm;*/
}

function onlyNum()
{
	 var code = window.event.keyCode;  

	 if ((code > 34 && code < 41) || (code > 47 && code < 58) || (code > 95 && code < 106) || code == 8 || code == 9 || code == 13 || code == 46) 
	 { 
		window.event.returnValue = true;
		return;
	 }

	 window.event.returnValue = false;
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
</script>
</head>
<body>
<form name="MainForm">
<input type="hidden" name="checkId" id="checkId" value="">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=2&id=<%=deptId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
			</td>
		</tr>
		<tr>
    		<td width="100%" height="2" bgcolor="#BDBDBD"></td>
    	</tr>
    	<tr>
    		<td width="100%" height="5"></td>
    	</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    	<tr>
    		<td width="100%" colspan="20" align="left">
    			<a href="javascript:goSave();"><img src="../images/btn_regist2.gif" width="55" height="30"></a>
    			<a href="javascript:goBack();"><img src="../images/btn_cancle.gif" width="55" height="30"></a>
    		</td>
    	</tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr><td height="10"></td></tr>
		<tr>
			<td width="150" class="formtype-yellow2">부서 아이디</td>
			<td class="formtype_noline">
				<input type="text" name="deptId" id="deptId" value="<%=deptId%>" class="formtype" style="width:99%;ime-mode:disabled;"  readonly>
			</td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-yellow2">부서명</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptNm" id="deptNm" value="<%=deptNm%>" class="formtype" style="width:98%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-yellow2">정렬순서</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptSort" id="deptSort" value="<%=deptSort%>" class="formtype" style="width:98%;" onkeydown="javascript:onlyNum()" onkeyup="javascript:onlyNum(this.value);"></td>
		</tr>
    </table>
</form>
</body>
</html>