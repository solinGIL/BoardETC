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
	return "deptmove";
}

function goBack()
{
	history.back();
}

function goSave()
{
	if(document.getElementById("deptHighNm").value == "")
	{
		alert("부서를 선택하세요.");
		document.getElementById("deptHighNm").focus();
		return
	}	
	else
	{
		form = document.MainForm;
		form.method = "post";
		form.action = "deptsave.jsp?gubun=MOVE";
		form.submit();
	}

}

function setDept(id,nm,orgHigh)
{
	var nowId = "<%=deptId%>";
	if(id != nowId)
	{
		document.getElementById('deptSelId').value = id;
		document.getElementById('deptHighId').value = orgHigh;
		document.getElementById('deptHighNm').value = nm;
	}
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
			<td width="150" class="formtype-yellow2">부서명</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptNm" id="deptNm" value="<%=deptNm%>" class="formtype" style="width:98%;"readonly></td>
			<input type="hidden" name="deptId" id="deptId" value="<%=deptId%>">
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-yellow2">선택부서</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptHighNm" id="deptHighNm" value="" class="formtype" style="width:98%;" readonly></td>
			<input type="hidden" name="deptHighId" id="deptHighId" value="">
			<input type="hidden" name="deptSelId" id="deptSelId" value="">
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-yellow2">구분</td>
			<td class="formtype_noline" colspan="2">
				<select name="deptGubun" id="deptGubun">
	          	<option value="0">하부로</option>
	          	<option value="1">동등 레벨로</option>
	         </select>
			</td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td colspan="10">※ 왼쪽 트리에서 부서를 선택 하세요.</td>
		</tr>
    </table>
</form>
</body>
</html>