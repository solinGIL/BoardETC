<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
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

			String tabId = StringTool.NullTrim(request.getParameter("tabId"));
			String userId = StringTool.NullTrim(request.getParameter("userId"));
			String PN = StringTool.NullTrim(request.getParameter("PN"));
			
			String sSrchGubun = StringTool.NullTrim(request.getParameter("sSrchGubun"));
			String sSrchText = StringTool.NullTrim(request.getParameter("sSrchText"));
			
			ModelOptimizer mo = new ModelOptimizer();
			
			Properties prot = new Properties();
			String protPath = "/config/Config.properties";
			prot.load(getClass().getResourceAsStream(protPath));
			
			String sQuery = prot.getProperty("USERVIEWQUERY").trim();
			String[] value = {userId};
			String[] sContent = mo.getContent(sQuery, value);
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
function checkPage()
{
	return "mod";
}

function setDept()
{
}

function goBack()
{
	var tabId = "<%=tabId%>";
	var form = document.MainForm;
	form.method = "post";
	form.action = "usersrch.jsp?tabId="+tabId;
	form.submit();
}

function goSave()
{
	if(document.getElementById("userNm").value == "")
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
		form.action = "srchsave.jsp?gubun=MOD";
		form.submit();
	}
}

function goReset()
{
	if(confirm("비밀번호를 초기화 하시겠습니까?"))
	{
		form = document.MainForm;
		form.method = "post";
		form.action = "srchsave.jsp?gubun=RESETPWD";
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

function resetPwd()
{
	document.getElementById("pwd").value = "1234";
}

function addName(val) {
	
	var form=document.MainForm;
	var objfile = document.getElementById("photoFile").value;
	
	/*objfile.select();
	var selRange = document.selection.createRange();
	var sFileNM = selRange.text.toString();*/
	
	var delRoute  =  objfile.lastIndexOf("\\");
	var str = objfile.substring(delRoute+1,objfile.length); //경로를 뺀 파일이름
	var checkstr = str.substring(str.lastIndexOf(".") +1);
	var checkvalue = checkPhotoStr(checkstr); //확장자 검색(xls,xlsx 만 등록가능)
	
	if(checkvalue != false)
	{
		document.getElementById("photoNm").value = str;
	}
}

function checkPhotoStr(str)
{
	var countnum = 0;
	var checkstr = "jpg";
	//checkstr = checkstr.split(",");
	
	str = str.toLowerCase();

	/*
	for(var i=0; i < checkstr.length; i++)
	{
		if(str == checkstr[i])
		{
			countnum++;
		}
	}
	*/
	//alert(str + " / " + checkstr);
	if(str != checkstr)
	{
		alert("jpg 파일만 업로드됩니다.");
		document.getElementById("photoNm").value = "";
		filedel(); //file 초기화
		return false;
	}
	else
	{
		return true;
	}
}
function filedel()
{
	var name = "#photoFile";
	
	if($.browser.msie)
	{
		$(name).replaceWith($(name).clone(true));
	}
	else
	{
		$(name).val("");
	}
}

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
</script>
</head>
<body>
<form name="MainForm">
	<input type="hidden" name="userId" id="userId" value="<%=userId%>">
	<input type="hidden" name="tabId" id="tabId" value="<%=tabId%>">
	<input type="hidden" name="PN" id="PN" value="<%=PN%>">
	<input type="hidden" name="sSrchGubun" id="sSrchGubun" value="<%=sSrchGubun%>">
	<input type="hidden" name="sSrchText" id="sSrchText" value="<%=sSrchText%>">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=3&tabId=<%=tabId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
			</td>
		</tr>
		<tr>
    		<td width="100%" height="2" bgcolor="#BDBDBD"></td>
    	</tr>
    	<tr>
    		<td width="100%" height="5"></td>
    	</tr>
	</table>
	<table width="500" border="0" cellspacing="0" cellpadding="0"> 
    	<tr>
    		<td width="50%" align="left">
    			<a href="javascript:goBack();"><img src="../images/btn_cancel.png" width="48" height="23"></a>
<%
				if(StringTool.NullTrim(sContent[10]).equals("ADD"))
				{
%>
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
    		<td width="50%" align="right">
    			<a href="javascript:goReset();">비밀번호 초기화</a>
    		</td>
    	</tr>
    </table>
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<input type="hidden" name="userId" value="<%=userId%>">
		<tr>
			<td width="150" class="formtype-gray">이름</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="userNm" id="userNm" value="<%=StringTool.NullTrim(sContent[3])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">부서명</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptNm" id="deptNm" value="<%=StringTool.NullTrim(sContent[2])%>" style="width:99%;" readonly></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">직위</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="pos" id="pos" value="<%=StringTool.NullTrim(sContent[4])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">전화번호</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="phone" id="phone" value="<%=StringTool.NullTrim(sContent[5])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">휴대폰</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="mobile" id="mobile" value="<%=StringTool.NullTrim(sContent[6])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">이메일</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="email" id="email" value="<%=StringTool.NullTrim(sContent[7])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">사원번호</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="empcode" id="empcode" value="<%=StringTool.NullTrim(sContent[11])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">담당업무</td>
			<td class="formtype_noline" colspan="2"><textarea name="job" id="job" rows="5" class="formtype" style="width:99%;ime-mode: active;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>><%=StringTool.NullTrim(sContent[8])%></textarea></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">정렬순서</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="sort" id="sort" value="<%=StringTool.NullTrim(sContent[9])%>" style="width:99%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "readonly" : "" %>></td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">사용여부</td>
			<td class="formtype_noline" colspan="2">
				<select name="useyn" id="useyn" <%=StringTool.NullTrim(sContent[9])%>" style="width:100%;" <%=StringTool.NullTrim(sContent[10]).equals("ORG") ? "disabled" : "" %>>
	    			<option value="Y" <%=StringTool.NullTrim(sContent[12]).equals("Y") ? "selected" : "" %>>Y</option>
	    			<option value="N" <%=StringTool.NullTrim(sContent[12]).equals("N") ? "selected" : "" %>>N</option>
	         	</select>
			</td>
		</tr>
    </table>    
</form>
</body>
</html>