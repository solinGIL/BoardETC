<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
			parent.parent.document.location.href = "index.html";
		}
		
	</script>
	<%
}
//고정 end
	String tab = StringTool.NullTrim(request.getParameter("tab"));
	String tabId = StringTool.NullTrim(request.getParameter("tabId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
<style type="text/css">	
		body table {font-size:12px; color:#333333; font-family:돋움,tahoma,verdana;line-height: 150%;}
		.tab_style {width: 100%;height: 40px; background: url(../images/bg_tab.gif);}
		.tab_on {float: left;color: #050099;font-weight: bold;text-align:center;vertical-align:middle;cursor:pointer; width: 97px;height: 23px;margin-right:3px;background: url(../images/tap_on.gif);padding:5px 0px 0px 0px;}
		.tab_off {float: left;color: #BDBDBD;font-weight: bold;text-align:center;vertical-align:middle;cursor:pointer; width: 97px;height: 23px;margin-right:3px;background: url(../images/tap_off.gif);padding:5px 0px 0px 0px;}
		a{text-decoration: none}
	</style>
<script type="text/javascript">
function goMenu(val)
{
	var form = document.MainForm;
	var getMenu = "";

	if(val == 1)
	{
		getMenu = "list.jsp?tabId=<%=tabId%>";
	}
	if(val == 2)
	{
		getMenu = "deptview.jsp?tabId=<%=tabId%>";
	}
	if(val == 3)
	{
		getMenu = "usersrch.jsp?tabId=<%=tabId%>";
	}

	form.target = "_parent";
	form.method = "post";
	form.action = getMenu;
	form.submit();	
}


</script>
</head>
<body>
<form name="MainForm">
</form>
	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr> 
			<td>
				<div class="tab_style">	
					<a href="javascript:goMenu('1')" span class=<%=tab.equals("1") ? "tab_on" : "tab_off"%>>사용자 관리</span></a>
					<a href="javascript:goMenu('2')" span class=<%=tab.equals("2") ? "tab_on" : "tab_off"%>>부서 관리</span></a>
					<a href="javascript:goMenu('3')" span class=<%=tab.equals("3") ? "tab_on" : "tab_off"%>>검색</span></a>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>