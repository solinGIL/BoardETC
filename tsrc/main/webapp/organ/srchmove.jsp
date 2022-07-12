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
	
	String PN = StringTool.NullTrim(request.getParameter("PN"));
	String sSrchGubun = StringTool.NullTrim(request.getParameter("sSrchGubun"));
	String sSrchText = StringTool.NullTrim(request.getParameter("sSrchText"));
	
	String deptId = StringTool.NullTrim(request.getParameter("tabId"));
	String tabId = StringTool.NullTrim(request.getParameter("tabId"));
	String deptNm = StringTool.NullTrim(request.getParameter("deptNm"));
	
	String userIdList = StringTool.NullTrim(request.getParameter("userIdList"));
	userIdList = userIdList.substring(0, userIdList.length() -1);
	String userNmList = StringTool.NullTrim(request.getParameter("userNmList"));
	userNmList = userNmList.substring(0, userNmList.length() -1);
	
	String orgDeptId = deptId;
	String orgDeptNm = deptNm;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript" src="../common/js/jquery.alphanumeric.pack.js"></script>
<script type="text/javascript" src="../common/js/json/json2.js"></script>
<script type="text/javascript">
function checkPage()
{
	return "mod";
}

function setDept(id,nm)
{
	document.getElementById('deptId').value = id;
	document.getElementById('deptNm').value = nm;
}
function goBack()
{
	form = document.MainForm;
	form.method = "post";
	form.action = "usersrch.jsp";
	form.submit();
}

function goSave()
{
	form = document.MainForm;
	form.method = "post";
	form.action = "srchsave.jsp?gubun=MOVE";
	form.submit();
}
</script>
</head>
<body>
<form name="MainForm">
<input type="hidden" name="tabId" id="tabId" value="<%=orgDeptId%>">
<input type="hidden" name="orgDeptId" id="orgDeptId" value="<%=orgDeptId%>">
<input type="hidden" name="orgDeptNm" id="orgDeptNm" value="<%=orgDeptNm%>">
<input type="hidden" name="sSrchGubun" id="sSrchGubun" value="<%=sSrchGubun%>">
<input type="hidden" name="sSrchText" id="sSrchText" value="<%=sSrchText%>">
<input type="hidden" name="PN" id="PN" value="<%=PN%>">
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
    			<a href="javascript:goBack();"><img src="../images/btn_cancel.png" width="48" height="23"></a>
    			<a href="javascript:goSave();"><img src="../images/btn_save.png" width="48" height="23"></a>
    		</td>
    	</tr>
    </table>
    <table width="700" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="150" class="formtype-gray">사용자 이름</td>
			<td class="formtype_noline">
				<input type="hidden" name="userIdList" id="userIdList" value="<%=userIdList%>">
				<textarea name="userNmList" id="userNmList" class="formtype" style="width:98%; height:70px" readonly><%=userNmList%></textarea>
			</td>
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td width="150" class="formtype-gray">이동 할 부서명</td>
			<td class="formtype_noline" colspan="2"><input type="text" name="deptNm" id="deptNm" value="<%=deptNm%>" class="formtype" style="width:98%;" readonly></td>
			<input type="hidden" name="deptId" id="deptId" value="<%=deptId%>">
		</tr>
		<tr><td height="5"></td></tr>
		<tr>
			<td colspan="3">※ 왼쪽 트리에서 부서를 선택 하세요.</td>
		</tr>
    </table>
</form>
</body>
</html>