<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
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

	String tabId = StringTool.NullTrim(request.getParameter("tabId"));
	String PN = StringTool.NullTrim(request.getParameter("PN"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>사용자 관리</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript" src="../common/js/jquery.alphanumeric.pack.js"></script>
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
	return "add";
}

function setDept(id,nm,high)
{
	document.getElementById('deptId').value = id;
	document.getElementById('deptNm').value = nm;
}

function goBack()
{
	form = document.MainForm;
	form.method = "post";
	form.action = "list.jsp";
	form.submit();
}

function goSave()
{
	if(document.getElementById("checkId").value == "")
	{
		alert("아이디 중복체크를 진행 하세요.");
		document.getElementById("userid").focus();
		return
	}
	else if(document.getElementById("userNm").value == "")
	{
		alert("이름을 입력하세요.");
		document.getElementById("userNm").focus();
		return
	}else if(checkStr("userNm",document.getElementById("userNm").value) == false) 
	{ 
		document.getElementById("userNm").focus();
		return 
	}
	
	else if(document.getElementById("sort").value.length > 7)
	{
		alert("정렬순서는 최대 6자리까지 입력하세요");
		document.getElementById("sort").focus();
		return
	}
	
	else
	{
		form = document.MainForm;
		form.method = "post";
		form.action = "save.jsp?gubun=ADD";
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

function addId()
{
	var str = document.getElementById('userId').value;
	document.getElementById('pwd').value = str;
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

/*
//4글자 제한
$(function()
{
	$(document).on("keyup", "#sort", function() 
	{
		if($(this).val().length > 4)
			this.value = this.value.substring(0,4);
	});
});
$(function() 
{
	$("#sort").numeric(); //숫자만 입력가능하도록 설정
	//$("#sort").css("ime-mode", "disabled"); //해당 text박스에 style로 한글 입력 불가 처리
});
*/

//글자제한, 숫자만 입력
$(function()
{
	$(document).on("keyup", "#sort", function() 
	{
		if($(this).val().length > 6)
			this.value = this.value.substring(0,6);
	});
	
	$("#sort").keypress(function(event)
	{
		if (event.which && (event.which > 47 && event.which < 58 || event.which == 8)) {
		}
		else
		{
			event.preventDefault();
		}
	});   

	//크롬등에서 ime-mode:disabled 정상작동 되지않으므로 정규식으로 처리
    $("#sort").keyup(function(event)
	{
		$(this).val($(this).val().replace(/[^0-9]/g,''));
    });
});

function checkOverLap()
{
	var id = document.getElementById('userid').value;
	if(id != "")
	{
		if(id.length >= 4)
		{
			$.ajax(
			{
				type : "POST",
				url : ClassLoader,
				dataType : "JSON",
				data : new checkData(id).setMethod("checkOverLap").toJ(),
				success:function (data)
				{
					if(data.status == "ok")
					{
						alert("사용할 수 있는 아이디입니다.");
						document.getElementById('checkOk').value = "ok";
						document.getElementById('checkId').value = id;
						return
					}else
					{
						alert("사용할 수 없는 아이디입니다.");
						document.getElementById('checkId').value = "";
						document.getElementById('userid').value = "";
						document.getElementById('checkOk').value = "";
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
		alert("아이디를 입력하세요");
		return
	}
}

function checkEnter(){

	var form = document.MainForm;
	var code = window.event.keyCode; 
	if(code ==13)
	{
		checkOverLap();
	}else
	{
		return
	}
}

function getDeptNm()
{
	var nm = parent.getDeptNm();
	
	if(document.getElementById("deptNm").value == "")
		document.getElementById("deptNm").value = nm;
}

</script>
</head>
<body onload="javascript:getDeptNm();">
<form name="MainForm">
<input type="hidden" name="PN" id="PN" value="<%=PN%>">
<input type="hidden" name="tabId" id="tabId" value="<%=tabId%>">
<input type="hidden" name="checkOk" id="checkOk" value="">
<input type="hidden" name="checkId" id="checkId" value="">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=1&tabId=<%=tabId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
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
			<td width="150" class="formtype-gray">아이디</td>
			<td>
				<input type="text" name="userid" id="userid" value="" style="width:100%;ime-mode:disabled;" onkeydown="checkEnter();" onpaste="javascript:return false;">
			</td>
			<td width="70"><a href="javascript:checkOverLap();"><img src="../images/btn_confirm_repetition.png" width="60" height="22" align="right"></a></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">부서명</td>
			<td colspan="2"><input type="text" name="deptNm" id="deptNm" value="" style="width:99%;" readonly></td>
			<input type="hidden" name="deptId" id="deptId" value="<%=tabId%>">
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">이름</td>
			<td colspan="2"><input type="text" name="userNm" id="userNm" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">직위</td>
			<td colspan="2"><input type="text" name="pos" id="pos" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">전화번호</td>
			<td colspan="2"><input type="text" name="phone" id="phone" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">휴대폰</td>
			<td colspan="2"><input type="text" name="mobile" id="mobile" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">이메일</td>
			<td colspan="2"><input type="text" name="email" id="email" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">사원번호</td>
			<td colspan="2"><input type="text" name="empcode" id="empcode" value="" style="width:99%;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">담당업무</td>
			<td colspan="2"><textarea name="job" id="job" rows="5" class="formtype" style="width:99%;ime-mode: active;"></textarea></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">정렬순서</td>
			<td colspan="2"><input type="text" name="sort" id="sort" value="" style="width:99%;ime-mode:disabled;"></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td colspan="3">※ 초기 패스워드는 아이디와 같습니다.</td>
		</tr>
		<tr>
			<td colspan="3">※ 왼쪽 트리에서 부서를 선택 하세요.</td>
		</tr>
    </table>    
</form>
</body>
</html>