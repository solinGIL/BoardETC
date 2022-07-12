<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
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
	request.setCharacterEncoding("EUC-KR");

	String deptId = StringTool.NullTrim(request.getParameter("id"));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>엑셀 업로드</title>
<link type="text/css" rel="stylesheet" href="../common/css/css.css">
<link type="text/css" rel="stylesheet" href="../common/css/jquery-ui.css">
<script type="text/javascript" src="../common/js/jquery.js"></script>
<script type="text/javascript" src="../common/js/json/json2.js"></script>
<script type="text/javascript" src="../common/js/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="../common/js/jquery/jquery.filestyle.js"></script>
<script type="text/javascript" src="../common/js/jquery/jquery.form.min.js"></script>
<script type="text/javascript" src="../common/js/jquery/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(
		
		function(){
			
			 $("input[type=file]").filestyle({ 
				 image: "../images/btn_attachedFile.gif",
				 imageheight : 21,
				 imagewidth : 58,
				 width : 58
			 })
		}
);
function checkPage()
{
	return "excel";
}
function uploadExcelDown()
{
	var path = document.getElementById("path").value;
	location.href="logdown.jsp?path="+path;
}
function addName(val) {
	
	var form=document.MainForm;
	var objfile = document.getElementById('File'+val).value;
	
	/*objfile.select();
	var selRange = document.selection.createRange();
	var sFileNM = selRange.text.toString();*/
	
	var delRoute  =  objfile.lastIndexOf("\\");
	var str = objfile.substring(delRoute+1,objfile.length); //경로를 뺀 파일이름
	var checkstr = str.substring(str.lastIndexOf(".") +1);
	var checkvalue = checkStr(val,checkstr); //확장자 검색(xls,xlsx 만 등록가능)
	
	if(checkvalue != false)
	{
		document.getElementById('FileName'+val).value = str;
	}
}

function checkStr(name,str)
{
	var countnum = 0;
	var checkstr = "xls";
	checkstr = checkstr.split(",");
	
	str = str.toLowerCase();

	/*for(var i=0; i < checkstr.length; i++)
	{
		if(str.match(checkstr[i]) != null)
		{
			countnum++;
		}
	}*/
	
	if(str != checkstr)
	{
		alert("xls 엑셀파일만 업로드됩니다.");
		document.getElementById('FileName'+name).value = "";
		filedel(name); //file 초기화
		return false
	}
}

function filedel(name)
{
	var name = "#File"+name;
	
	if($.browser.msie)
	{
		$(name).replaceWith($(name).clone(true));
	}
	else
	{
		$(name).val("");
	}
}

function down(gubun)
{
	var url = "";
	
	if(gubun == "dept")
	{
		url = "../file/dept_sample.xls";
	}
	else
	{
		url = "../file/user_sample.xls";
	}
	
	location.href = url;
}

function goSave()
{
	if(document.getElementById("FileNameDept").value == "" && document.getElementById("FileNameUser").value == "")
	{
		alert("파일을 첨부하세요.");
		return
	}
	else
	{
		var form = document.MainForm;
		form.method = "post";
		form.action = "excelsave.jsp";
		form.submit();
	}
}

</script>
</head>
<body>
<form name="MainForm" enctype="multipart/form-data">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="left">
				<iframe src="topmenu.jsp?tab=4&id=<%=deptId%>" name="topmenu" id="topmenu" width="100%" height="25" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
			</td>
		</tr>
		<tr>
    		<td width="100%" height="2" bgcolor="#BDBDBD"></td>
    	</tr>
    	<tr>
    		<td width="100%" height="5"></td>
    	</tr>
	</table>
		<table width="600" border="0" cellpadding="0" cellspacing="10">
			<tr>
				<td width="70" height="21" class="t_boldBlack" align="left">
					부서 파일
				</td>
			  <td height="21" class="t_boldBlack" align="left">
  			  		<input type="text" name="FileNameDept" id="FileNameDept" class="formtype" style="width:100%" readonly/>
  			  		<input type="file"  name="FileDept" id="FileDept" onChange="javascript:addName('Dept');"/>
  			  	</td>
  			  	<td width="58" height="21" class="t_boldBlack" align="left">
  			  	</td>
  			  	<td width="70" class="t_boldBlack" rowspan="2">
  			  		<a href="javascript:goSave();"><img src="../images/btn_regist.gif" width="70" height="26"></a>
  			  	</td>
			</tr>
			<tr>
				<td width="70" height="21" class="t_boldBlack" align="left">
					사용자 파일
				</td>
			  <td height="21" class="t_boldBlack" align="left">
  			  		<input type="text" name="FileNameUser" id="FileNameUser" class="formtype" style="width:100%"readonly/>
  			  		<input type="file"  name="FileUser" id="FileUser" onChange="javascript:addName('User');"/>
  			  	</td>
  			  	<td width="58" height="21" class="t_boldBlack" align="left">
  			  	</td>
			</tr>
		</table>
		<table width="600" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table border="0" cellpadding="5" cellspacing="0" width="100%" height="30"></table>
				</td>
			</tr>
			<tr>
				<td align="center" valign="middle">
					<table border="0" cellpadding="5" cellspacing="1" bgcolor="#C8CBD1" width="550">
						<tr height="25">
							<td colspan="2" align="center" bgcolor="#F4F2C6" class="t_boldBlack">
								사용 설명
							</td>
						</tr>
						<tr>
							<td width="80" align="center" bgcolor="#ECEEF1">
								부서 업로드
							</td>
							<td bgcolor="#FFFFFF" align="left">
								<br>
								○ 부서를 엑셀파일로 일괄 등록할 수 있습니다.<br>
								○ 부서용 엑셀 형식 다운받기 ↓↓<br>
								○ <strong><a href="javascript:down('dept')">dept.xls</a></strong><br><br>
							</td>
						</tr>
						<tr>
							<td width="80" align="center" bgcolor="#ECEEF1">
								사용자 업로드
							</td>
							<td bgcolor="#FFFFFF" align="left">
								<br>
								○ 사용자를 엑셀파일로 일괄 등록할 수 있습니다.<br>
								○ 사용자용 엑셀 형식 다운받기 ↓↓<br>
								○ <strong><a href="javascript:down('user')">user.xls</a></strong><br><br>
							</td>
						</tr>
						<tr>
							<td width="80" align="center" bgcolor="#ECEEF1">
								주의사항
							</td>
							<td bgcolor="#FFFFFF" align="left">
								<br>
								○ 빨간색 셀은 필수 항목입니다.<br>
								○ 부서 테이블의 부서아이디와 사용자 테이블의 사용자 아이디는 고유값입니다. 중복될 수 없습니다.<br>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</form>
</body>
</html>