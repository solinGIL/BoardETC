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

	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String topId = prot.getProperty("TOPID").trim();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>엑셀 업로드</title>
	<link href="../common/css/css.css" rel="stylesheet" type="text/css">
	<link href="../common/css/ui.dynatree.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="../common/js/json/json2.js"></script>
	<script type="text/javascript" src="../common/js/jquery.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery-ui.custom.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery.dynatree.js"></script>
<script type="text/javascript">
var ClassLoader = "Service.jsp";
var ClassName = "kr.co.ultari.process.SyncProcessor";
checkData.prototype.toJ = function()
{
	return JSON.stringify(this);
}
String.prototype.Enc = function()
{
	return chgEnc(this);
}
function checkData()
{
	this.C = "";
	this.M = "";
	this.ReqType = "JSON";
	this.setMethod = function(M)
	{
		this.C = ClassName;
		this.M = M;
		return this;	
	}
}

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

function goOrgSync()
{
	var topId = "<%=topId%>";
	
	if(confirm("조직도 동기화를 실행하시겠습니까?"))
	{
		document.getElementById("orgSpan_button").style.display = "none";
		document.getElementById("orgSpan_loading").style.display = "";
		document.getElementById("orgSpan_text").style.display = "";
		
		$.ajax(
		{
			type : "POST",
			url : ClassLoader,
			dataType : "JSON",
			data : new checkData().setMethod("OrgSync").toJ(),
			success:function (data)
			{
				if(data.status == "true")
				{
					alert("동기화 완료.")
					return
				}
				else
				{
					alert("동기화 실패. 관리자에게 문의하세요.")
					return
				}
			},
			error:function ()
			{
				alert("조직도 동기화 에러 관리자에게 문의하세요.");
			}
		});
		
		document.getElementById("orgSpan_button").style.display = "";
		document.getElementById("orgSpan_loading").style.display = "none";
		document.getElementById("orgSpan_text").style.display = "none";
		parent.reLoad();
	}
}

function goPhotoSync()
{
	alert("dev");
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
		<table width="700" border="0" cellpadding="0" cellspacing="10">
			<tr>
				<td width="100" height="21" class="t_boldBlack" align="left">
					조직도 동기화
				</td>
			    <td width="100" height="21" class="t_boldBlack" align="left">
			    	<span id="orgSpan_button" style="display:;">
			    		<a href="javascript:goOrgSync();"><img src="../images/btn_sync.gif" width="55" height="30"></a>
			    	</span>
			    	<span id="orgSpan_loading" style="display:none;">
			    		<img src="../images/loading.gif" width="60" height="35">
			    	</span>
  			  	</td>
  			  	<td width="" height="21" class="t_boldBlack" align="left">
  			  		<span id="orgSpan_text" style="display:none;">
  			  			동기화 진행중입니다. 페이지 이동 및 창을 종료하지 마세요.
  			  		</span>
  			  	</td>
			</tr>
			<tr>
				<td width="100" height="21" class="t_boldBlack" align="left">
					사진 동기화
				</td>
			    <td width="100" height="21" class="t_boldBlack" align="left">
			    	<span id="photoSpan_button" style="display:;">
			    		<a href="javascript:goPhotoSync();"><img src="../images/btn_sync.gif" width="55" height="30"></a>
			    	</span>
			    	<span id="photoSpan_loading" style="display:none;">
			    		<img src="../images/loading.gif" width="60" height="35">
			    	</span>
  			  	</td>
  			  	<td width="" height="21" class="t_boldBlack" align="left">
  			  		<span id="photoSpan_text" style="display:none;">
  			  			동기화 진행중입니다. 페이지 이동 및 창을 종료하지 마세요.
  			  		</span>
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
								조직도 동기화
							</td>
							<td bgcolor="#FFFFFF" align="left">
								○ 인사 DB 에서 메신저 DB로 조직도 동기화 및 메신저 서버의 메모리 갱신<br>
							</td>
						</tr>
						<tr>
							<td width="80" align="center" bgcolor="#ECEEF1">
								사진 동기화
							</td>
							<td bgcolor="#FFFFFF" align="left">
								○ 인사 서버 에서 메신저 서버로 사진 파일을 FTP를 통해 동기화
							</td>
						</tr>
						<tr>
							<td width="80" align="center" bgcolor="#ECEEF1" class="t_red">
								주의사항
							</td>
							<td bgcolor="#FFFFFF" align="left" class="t_red">
								○ 완료시까지 페이지 이동 및 인터넷 창을 종료하지 마세요.
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
</form>
</body>
</html>