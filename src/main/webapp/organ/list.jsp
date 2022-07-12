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

			String tabId = StringTool.NullTrim(request.getParameter("tabId"));
			
			String queryId = "'"+tabId+"'";
			
			Properties prot = new Properties();
			String protPath = "/config/Config.properties";
			prot.load(getClass().getResourceAsStream(protPath));
			
			String sListQuery = prot.getProperty("ORGUSERLISTQUERY").trim();
			String sCountQuery = prot.getProperty("ORGUSERCOUNTQUERY").trim();
			
			sListQuery = StringTool.ReplaceAllText(sListQuery, "_where",queryId);
			sCountQuery = StringTool.ReplaceAllText(sCountQuery, "_where",queryId);
			
			ModelOptimizer mo = new ModelOptimizer();
			
			List sList = null;
			String[] sContent = null;
			int nListSize = 15;
			int nPageNo = request.getParameter("PN") == null? 1:Integer.parseInt(request.getParameter("PN"));
			
			HashMap hm = mo.listOptimizer(sCountQuery,sListQuery,"",nPageNo,nListSize);
			
			String sCount = (String) hm.get("COUNT");
			sList = (List) hm.get("LIST");
			
			int listSize = 0;
			listSize = sList.size();
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<script type="text/javascript" src="../common/js/WinUtil.js"></script>
<script type="text/javascript">
function checkPage()
{
	return "user";
}

function OnPageMove(PageNo)
{
    var form = document.MainForm;
    form.method = "post";
	form.action = "list.jsp?&PN="+PageNo;
	form.submit();
}

function goAdd()
{
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
    form.method = "post";
	form.action = "add.jsp?PN="+PageNo;
	form.submit();
}

function checkAllOrNot()
{
	var form = document.MainForm;

	if(form.CheckAll.checked == false)
	{
		uncheckAll('MainForm','ChkItem');
	}
	else if(form.CheckAll.checked == true)
	{
		checkAll('MainForm','ChkItem');
	}
}

function goMove()
{
	var listSize = "<%=listSize%>";
	if(listSize == "0")
	{
		return;
	}	
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
	
	var temp = "";
	var id = "";
	var name = "";
	
	var idList = "";
	var nameList = "";
	
	var loop = 0;

	if(form.ChkItem.length > 1)
	{
		for(i=0 ; i<form.ChkItem.length;i++)
		{
		   if(form.ChkItem[i].checked == true)
		   {
			   temp = form.ChkItem[i].value;
			   id = temp.substring(0, temp.indexOf("|"));
			   name = temp.substring(temp.indexOf("|") +1,temp.length);
			   
			   idList += id + ",";
			   nameList += name + ",";
			   
			   loop++;
		   }
		}
	}
	else
	{
		if(form.ChkItem.checked == true)
		{
			temp = form.ChkItem.value;
			id = temp.substring(0, temp.indexOf("|"));
			name = temp.substring(temp.indexOf("|") +1,temp.length);
			
			idList += id + ",";
			nameList += name + ",";
			loop++;
		}
		else
		{

		}
	}

	if(loop == 0)
	{
		alert("이동할 사용자를 선택해 주세요.");

	}
	else
	{
		document.getElementById('userIdList').value = idList;
		document.getElementById('userNmList').value = nameList;
		form.method = "post";
		form.action = "move.jsp?PN="+PageNo;
		form.submit();
	}
}

function goDel()
{
	var listSize = "<%=listSize%>";
	if(listSize == "0")
	{
		return;
	}	
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
	
	var temp = "";
	var id = "";
	
	var idList = "";
	
	var loop = 0;

	if(form.ChkItem.length > 1)
	{
		for(i=0 ; i<form.ChkItem.length;i++)
		{
		   if(form.ChkItem[i].checked == true)
		   {
			   temp = form.ChkItem[i].value;
			   id = temp.substring(0, temp.indexOf("|"));
			   
			   idList += id + ",";
			   
			   loop++;
		   }
		}
	}
	else
	{
		if(form.ChkItem.checked == true)
		{
			temp = form.ChkItem.value;
			id = temp.substring(0, temp.indexOf("|"));
			
			idList += id + ",";
			loop++;
		}
		else
		{

		}
	}

	if(loop == 0)
	{
		alert("삭제할 사용자를 선택해 주세요.");

	}
	else
	{
		if(confirm("삭제 하시겠습니까?"))
		{
			document.getElementById('userIdList').value = idList;
			form.method = "post";
			form.action = "save.jsp?gubun=DEL&PN="+PageNo;
			form.submit();
		}
	}
}

function goMod(userId)
{
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
	form.method = "post";
	form.action = "view.jsp?userId="+userId+"&PN="+PageNo;
	form.submit();
}

</script>
</head>
<body>
<form name="MainForm">
<input type="hidden" name="tabId" id="tabId" value="<%=tabId%>">
<input type="hidden" name="userIdList" id="userIdList" value="">
<input type="hidden" name="userNmList" id="userNmList" value="">
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
	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    	<tr>
    		<td align="left">
    			<a href="javascript:goAdd();"><img src="../images/btn_add.png" width="48" height="23"></a>
    			<a href="javascript:goDel();"><img src="../images/btn_del.png" width="48" height="23"></a>
    			<a href="javascript:goMove();"><img src="../images/btn_user_move.png" width="87" height="23"></a>
    		</td>
    	</tr>
    </table>
    <table width="100% border="0" cellspacing="0" cellpadding="0"> 
      <tr>
      	<td width="25" class="formtype-gray"><input type="checkbox" name="CheckAll" id="CheckAll" onClick="javascript:checkAllOrNot();"></td>
      	<td width="80" class="formtype-gray">이름</td>
      	<td width="160" class="formtype-gray">부서명</td>
        <td width="120" class="formtype-gray">직위</td>
        <td width="80" class="formtype-gray">전화번호</td>
        <td width="100" class="formtype-gray">휴대폰</td>
        <td width="" class="formtype-gray">이메일</td>
        <td width="100" class="formtype-gray">사원번호</td>
        <td width="70" class="formtype-gray">사용여부</td>
      </tr>
<%
	if(sList.size() == 0)
	{
%>
		<tr>
			<td colspan="10" align="center">
				등록된 사용자가 없습니다.
			</td>
		</tr>
<%
	}
	else
	{
		for(int i=0;i<sList.size();i++)
		{
			sContent = (String[])sList.get(i);
			
			if(StringTool.NullTrim(sContent[8]).equals("ADD"))
			{
%> 	
		<tr onmouseover="this.style.backgroundColor='#C4DEFF';style.cursor='pointer';" onmouseout="this.style.backgroundColor='';">
			<td height="23" class="formtype_noline" align="center"><input type="checkbox" name="ChkItem" id="ChkItem" value="<%=StringTool.NullTrim(sContent[0])%>|<%=StringTool.NullTrim(sContent[1])%>"></td>
			<td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[2])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[9])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[3])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[4])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[5])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[6])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[10])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[11])%></td>
		</tr>
<%
			}
			else
			{
%>		
		<tr onmouseover="this.style.backgroundColor='#C4DEFF';style.cursor='pointer';" onmouseout="this.style.backgroundColor='';">
			<td height="23" class="formtype_noline" align="center">&nbsp;</td>
			<td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[2])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[9])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[3])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[4])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[5])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[6])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[10])%></td>
	        <td align="center" onclick="javascript:goMod('<%=StringTool.NullTrim(sContent[0])%>');"><%=StringTool.NullTrim(sContent[11])%></td>
		</tr>
<%
			}
		}
	}
%>
    </table>
    <!-- 페이징 시작 -->
	<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
		<br>	
		<tr>
			<td align="center">
<%
				request.setAttribute("PN",Integer.toString(nPageNo));
				request.setAttribute("RC",sCount);
				request.setAttribute("LS",Integer.toString(nListSize));
%>
			<jsp:include page = "ListMovePage.jsp"/>									
			<td align="center">&nbsp;&nbsp;</td>					
		</tr>
	</table>
<!-- 페이징 끝 -->
</form>
</body>
</html>