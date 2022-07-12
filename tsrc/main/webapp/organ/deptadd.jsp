<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%
//고정
String adminId = (String)request.getSession().getAttribute("adminId");
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
//고정 end
	request.setCharacterEncoding("utf-8");

	String deptId = StringTool.NullTrim(request.getParameter("deptId"));
	String deptNm = StringTool.NullTrim(request.getParameter("deptNm"));
	String deptHigh = StringTool.NullTrim(request.getParameter("deptHigh"));
	String deptSort = StringTool.NullTrim(request.getParameter("deptSort"));
	String deptType = StringTool.NullTrim(request.getParameter("deptType"));
	
	String tabId = StringTool.NullTrim(request.getParameter("tabId"));
	
	String type = "";
	if(deptType.equals("ORG"))
	{
		type = "조직도 부서";
	}else
	{
		type = "추가 부서";
	}
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>사용자 관리</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript" src="../common/js/json/json2.js"></script>
<script type="text/javascript">
var ClassLoader = "Service.jsp";
var ClassName = "kr.co.ultari.process.CheckId";
checkData.prototype.toJ = function()
{
	return JSON.stringify(this);
}

String.prototype.Enc = function()
{
	return chgEnc(this);
}
function checkData(id)
{
	this.C = "";
	this.M = "";
	this.ReqType = "JSON";
	this.id = id;
	this.setMethod = function(M)
	{
		this.C = ClassName;
		this.M = M;
		return this;	
	}
}

function checkPage()
{
	return "deptadd";
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
		form.action = "deptsave.jsp?gubun=ADD";
		form.submit();
	}
}

function setDept(id,nm,orgHigh)
{
	//alert(id+" / " + nm + " / " + orgHigh);
	document.getElementById('selDeptId').value = id;
	document.getElementById('deptHighId').value = orgHigh;
	document.getElementById('deptHighNm').value = nm;
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

function checkOverLap()
{
	var id = document.getElementById('deptId').value;
	if(id != "")
	{
		if(id.length >= 4)
		{
			$.ajax(
			{
				type : "POST",
				url : ClassLoader,
				dataType : "JSON",
				data : new checkData(id).setMethod("checkOverLapDept").toJ(),
				success:function (data)
				{
					if(data.status == "ok")
					{
						alert("사용할 수 있는 코드입니다.");
						document.getElementById('checkId').value = "ok";
						return
					}else
					{
						alert("사용할 수 없는 코드입니다.");
						document.getElementById('checkId').value = "";
						document.getElementById('deptId').value = "";
						return
					}
				},
				error:function ()
				{
					alert("중복체크 에러 관리자에게 문의하세요.");
				}
			});
		}else
		{
			alert("최소 4글자 이상 입력하세요.");
			return
		}
	}else
	{
		alert("부서코드를 입력하세요");
		return
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
<input type="hidden" name="checkId" id="checkId" value="">
<input type="hidden" name="tabId" id="tabId" value="<%=tabId%>">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=2&tabId=<%=tabId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
			</td>
		</tr>
		<tr>
    		<td width="100%" height="2" bgcolor="#BDBDBD"></td>
    	</tr>
    	<tr>
    		<td width="100%" height="5"></td>
    	</tr>
	</table>
	<table width="600" border="0" cellspacing="0" cellpadding="0"> 
    	<tr>
    		<td width="100%" colspan="20" align="left">
    			<a href="javascript:goSave();"><img src="../images/btn_save.png" width="48" height="23"></a>
    			<a href="javascript:goBack();"><img src="../images/btn_cancel.png" width="48" height="23"></a>
    		</td>
    	</tr>
    </table>
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="150" class="formtype-gray">부서명</td>
			<td colspan="2"><input type="text" name="deptNm" id="deptNm" value="" style="width:100%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">선택부서</td>
			<td colspan="2"><input type="text" name="deptHighNm" id="deptHighNm" value="<%=deptNm%>" style="width:100%;" readonly></td>
			<input type="hidden" name="selDeptId" id="selDeptId" value="<%=deptId%>">
			<input type="hidden" name="deptHighId" id="deptHighId" value="<%=deptHigh%>">
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">구분</td>
			<td class="formtype_noline" colspan="2">
				<select name="deptGubun" id="deptGubun">
	          	<option value="0">하부로</option>
	          	<option value="1">동등 레벨로</option>
	         </select>
			</td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">정렬순서</td>
			<td colspan="2"><input type="text" name="deptSort" id="deptSort" value="" style="width:100%;" onkeydown="javascript:onlyNum()" onkeyup="javascript:onlyNum(this.value);"></td>
		</tr>
		<tr><td height="5"></td></tr>
    </table>
</form>
</body>
</html>