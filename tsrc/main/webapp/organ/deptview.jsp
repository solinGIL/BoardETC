<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%@ page import="kr.co.ultari.process.PartProcessorFile" %>
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
	request.setCharacterEncoding("utf-8");

	String deptId = StringTool.NullTrim(request.getParameter("tabId"));
	String deptNm = "";
	
	ModelOptimizer mo = new ModelOptimizer();
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String sQuery = prot.getProperty("DEPTVIEWQUERY").trim();
	String[] value = {deptId};
	String[] sContent = mo.getContent(sQuery, value);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>부서 관리</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript">
function checkPage()
{
	return "dept";
}

function goAdd()
{
	var form = document.MainForm;
    form.method = "post";
	form.action = "deptadd.jsp";
	form.submit();
}

function goMove()
{
	var form = document.MainForm;
    form.method = "post";
	form.action = "deptmove.jsp";
	form.submit();
}

function goDel()
{
	if(confirm("삭제 하시겠습니까?"))
	{
		form = document.MainForm;
		form.method = "post";
		form.action = "deptsave.jsp?gubun=DEL";
		form.submit();
	}
}

function goMod()
{
	var form = document.MainForm;
    form.method = "post";
	form.action = "deptmod.jsp";
	form.submit();
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

//글자제한, 숫자만 입력
$(function()
{
	$(document).on("keyup", "#deptSort", function() 
	{
		if($(this).val().length > 6)
			this.value = this.value.substring(0,6);
	});
	
	$("#deptSort").keypress(function(event)
	{
		if (event.which && (event.which > 47 && event.which < 58 || event.which == 8)) {
		}
		else
		{
			event.preventDefault();
		}
	});   

	//크롬등에서 ime-mode:disabled 정상작동 되지않으므로 정규식으로 처리
    $("#deptSort").keyup(function(event)
	{
		$(this).val($(this).val().replace(/[^0-9]/g,''));
    });
});
</script>
</head>
<body>
<form name="MainForm">
<input type="hidden" name="tabId" id="tabId" value="<%=deptId%>">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=2&tabId=<%=deptId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
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
    		<td align="left">
    			<a href="javascript:goAdd();"><img src="../images/btn_add.png" width="48" height="23"></a>
<%
				if(StringTool.NullTrim(sContent[4]).equals("ADD"))
				{
%>
    			<a href="javascript:goDel();"><img src="../images/btn_del.png" width="48" height="23"></a>
    			<a href="javascript:goSave();"><img src="../images/btn_save.png" width="48" height="23"></a>
<%
				}
				else
				{
%>
				&nbsp;&nbsp;
<%
				}
%>
    		</td>
    	</tr>
    </table>
    <table width="450" border="0" cellspacing="0" cellpadding="0">
    	<tr>
			<td width="150" class="formtype-gray">부서코드</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptId" id="deptId" value="<%=StringTool.NullTrim(sContent[0])%>" style="width:99%;" readonly></td>
		</tr>
		<tr><td height="3"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">상위부서코드</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptHigh" id="deptHigh" value="<%=StringTool.NullTrim(sContent[1])%>" style="width:99%;" readonly></td>
		</tr>
		<tr><td height="3"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">부서명</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptNm" id="deptNm" value="<%=StringTool.NullTrim(sContent[2])%>" style="width:99%;"></td>
		</tr>
		<tr><td height="3"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">정렬순서</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptSort" id="deptSort" value="<%=StringTool.NullTrim(sContent[3])%>" style="width:99%;"></td>
		</tr>
		<tr><td height="3"></td></tr>
    </table>
</form>
</body>
</html>