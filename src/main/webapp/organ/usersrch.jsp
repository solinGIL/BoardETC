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
			
			String sSrchGubun = StringTool.NullTrim(request.getParameter("sSrchGubun"));
			String sSrchText = StringTool.NullTrim(request.getParameter("sSrchText"));
			String tabId = StringTool.NullTrim(request.getParameter("tabId"));
			
			String sAddQuery = "";
			Properties prot = new Properties();
			String protPath = "/config/Config.properties";
			prot.load(getClass().getResourceAsStream(protPath));
			String sListQuery = prot.getProperty("ORGUSERSRCHQUERY").trim();
			String sCountQuery = prot.getProperty("ORGUSERSRCHCOUNT").trim();
			ModelOptimizer mo = new ModelOptimizer();
			
			List sList = null;
			String[] sContent = null;
			int nListSize = 15;
			int nPageNo = request.getParameter("PN") == null? 1:Integer.parseInt(request.getParameter("PN"));
			int listSize = 0;
			String sCount = "0";
			
			if(!sSrchGubun.equals(""))
			{
		sAddQuery = " AND " + sSrchGubun+" LIKE '%"+sSrchText+"%'";
		sListQuery = StringTool.ReplaceAllText(sListQuery, "_where", sAddQuery);
		sCountQuery = StringTool.ReplaceAllText(sCountQuery, "_where", sAddQuery);
		HashMap hm = mo.listOptimizer(sCountQuery,sListQuery,"",nPageNo,nListSize);
		sCount = (String)hm.get("COUNT");
		sList = (List)hm.get("LIST");
		listSize = sList.size();
			}
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
	return "srch";
}

function setDept()
{
}
function OnPageMove(PageNo)
{
    var form = document.MainForm;
    form.method = "post";
	form.action = "usersrch.jsp?&PN="+PageNo;
	form.submit();
}

function goAdd()
{
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
    form.method = "post";
	form.action = "usradd.jsp?PN="+PageNo;
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
		form.action = "srchmove.jsp?PN="+PageNo;
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
			form.action = "srchsave.jsp?gubun=DEL&PN="+PageNo;
			form.submit();
		}
	}
}

function goMod(userId)
{
	var PageNo = "<%=nPageNo%>";
	var form = document.MainForm;
	form.method = "post";
	form.action = "srchview.jsp?userId="+userId+"&PN="+PageNo;
	form.submit();
}

function viewOrgan()
{
	var title = "orgview";
	var status = "width=850,height=500,scrollbars=no,resizable=no";
	window.open('organ.jsp',title,status);
	
	/*
	var form = document.MainForm;
	var url = "organ.jsp";
	var title = "orgview";
	var status = "width=720,height=640,scrollbars=no,resizable=no";
	var win = window.open('about:blank',title,status);
	form.target = title;
	form.action = url;
	form.method = "post";
	form.submit();*/
}

function goSave(idList)
{
	document.getElementById("idList").value = idList;
	var form = document.MainForm;
	form.method = "post";
	form.action = "deptsave.jsp?gubun=ADD";
	form.submit();
	
}

function sample()
{
	location.href="../sample/usersample.xls";
}

function checkXls() 
{
	var form=document.ExcelForm;
	var objfile = document.getElementById("excelFile").value;
	
	if(objfile != "")
	{
		var delRoute  =  objfile.lastIndexOf("\\");
		var nm = objfile.substring(delRoute+1,objfile.length); //경로를 뺀 파일이름
		var checkstr = str.substring(str.lastIndexOf(".") +1);
		var checkvalue = checkStr(checkstr); //확장자 검색(xls,xlsx 만 등록가능)
	}
}

function checkStr(str)
{
	var countnum = 0;
	var checkstr = "xls";
	checkstr = checkstr.split(",");
	
	str = str.toLowerCase();

	if(str != checkstr)
	{
		alert("xls 엑셀파일만 업로드됩니다.");
		filedel(); //file 초기화
		return false
	}
}

function filedel()
{
	var name = "#excelFile";
	
	if($.browser.msie)
	{
		$(name).replaceWith($(name).clone(true));
	}
	else
	{
		$(name).val("");
	}
}

function goSaveExcel()
{
	if(document.getElementById("excelFile").value == "")
	{
		alert("파일을 첨부하세요.");
		return
	}
	else
	{
		var form = document.ExcelForm;
		form.method = "post";
		form.action = "excelsave.jsp";
		form.submit();
	}
}

function goSrch()
{
	var form = document.MainForm;
	
	var sSrchGubun = document.getElementById("sSrchGubun").value;
	var sSrchText = document.getElementById("sSrchText").value;
	
	if(sSrchGubun == "" )
	{
		alert("검색 조건을 선택해주세요.");
		document.getElementById("sSrchGubun").focus();
		return
	}
	else if(sSrchText.length < 2)
	{
		alert("두글자 이상 입력하세요.");
		document.getElementById("sSrchText").focus();
		return
	}
	else
	{
		if(sSrchText == "" && sSrchGubun)
		{
			alert("검색 내용을 입력해주세요.");
			document.getElementById("sSrchText").focus();
			return
		}
		else
		{
			form.method = "post";
			form.action = "usersrch.jsp";
			form.submit();
		}
	}
}

function checkEnter()
{
	var code = window.event.keyCode; 
	if(code ==13)
	{
		goSrch();
	}else
	{
		return
	}
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
	<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
    	<tr>
    		<td width="" align="left">
    			<a href="javascript:goDel();"><img src="../images/btn_del.png" width="48" height="23"></a>
    			<a href="javascript:goMove();"><img src="../images/btn_user_move.png" width="87" height="23"></a>
    		</td>
    		<td width="" align="right">
	    		<select name="sSrchGubun" id="sSrchGubun" onchange="javascript:checkOption();">
	    			<option value="USER_NAME" <%=sSrchGubun.equals("USER_NAME") ? "selected" : "" %>>이름</option>
	    			<option value="PART_NAME" <%=sSrchGubun.equals("PART_NAME") ? "selected" : "" %>>부서명</option>
		          	<option value="POS_NAME" <%=sSrchGubun.equals("POS_NAME") ? "selected" : "" %>>직위</option>
		          	<option value="PHONE" <%=sSrchGubun.equals("PHONE") ? "selected" : "" %>>전화번호</option>
		          	<option value="MOBILE" <%=sSrchGubun.equals("MOBILE") ? "selected" : "" %>>휴대폰</option>
		          	<option value="EMAIL" <%=sSrchGubun.equals("EMAIL") ? "selected" : "" %>>이메일</option>
		          	<option value="EMPCODE" <%=sSrchGubun.equals("EMPCODE") ? "selected" : "" %>>사원번호</option>
	         	</select>
			   	<input type="text" id="sSrchText" name="sSrchText" value="<%=StringTool.NullTrim(sSrchText)%>" class="formtype" style="width:210px; vertical-align:top;" onkeydown="javascript:checkEnter();">
			    <a href="javascript:goSrch();"><img src="../images/whtie_but_search.gif" width="51" height="20" style="vertical-align:top;"></a>
			    <span style="display:none"><input type="text" id="tmp" name="tmp"></span>
			</td>
    	</tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
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
	if(listSize == 0)
	{
%>
		<tr>
			<td colspan="10" align="center">
				검색된 사용자가 없습니다.
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
	<table width="870px" height="100%" cellpadding="0" cellspacing="0" border="0" >
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