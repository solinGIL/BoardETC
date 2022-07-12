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
			parent.document.location.href = "../index.html";
		}
		
	</script>
	<%
}
//고정 end

	request.setCharacterEncoding("utf-8");

	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String topPart = prot.getProperty("TOPPART").trim();
	String topId = prot.getProperty("TOPID").trim();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
	<link href="../common/css/admin.css" rel="stylesheet" type="text/css">
	<link href="../common/css/ui.dynatree.css" rel="stylesheet" type="text/css">
	<link type="text/css" rel="stylesheet" href="../common/css/css.css">
	<script type="text/javascript" src="../common/js/json/json2.js"></script>
	<script type="text/javascript" src="../common/js/jquery.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery-ui.custom.js"></script>
	<script type="text/javascript" src="../common/js/jquery/jquery.dynatree.js"></script>
<script language="javascript" >
var ClassLoader = "Service.jsp";
var ClassName = "kr.co.ultari.process.OrgProcessor";
var nowNode = null;
var topPart = "<%=topPart%>";
var topId = "<%=topId%>";
var tree = null;

var selNode = null;
var targetNode = null;

part.prototype.toJ = function()
{
	return JSON.stringify(this);
}

String.prototype.Enc = function()
{
	return chgEnc(this);
}
function part(id,high,name,order)
{
	this.C = "";
	this.M = "";
	this.ReqType = "JSON";
	this.id = id;
	this.name = name;
	this.high = high;
	this.order = order;
	this.setMethod = function(M)
	{
		
		this.C = ClassName;
		this.M = M;
		return this;	
	}
	
}

var bindTree = function ()
{
	this.bind = function(method){
		$("#tree").dynatree(
		{
			clickFolderMode: 1,
			
       		onActivate: function(node){
        	},
			onClick: function(node, event) {
				
			  	$("#UserInfo").fadeOut("fast");
				$("#PartInfo").fadeOut("fast");
				$("#treeLayerForm").fadeOut("fast");
				
		        if( $(".contextMenu:visible").length > 0 )
		        {
		        	
		            $(".contextMenu").hide();
		        }
				
		        setDeptNm(node.data.title);
		        
		        // 창 컨트롤
		        var rtn =  list.checkPage();

		    	if(rtn == "user" || rtn == "")
		    	{
		    		setUserList(node.data.key);
		    	}
		    	else if(rtn == "dept")
		    	{
		    		setDeptList(node.data.key);
		    	}
		    	else
		    	{
		    		list.setDept(node.data.key,node.data.title,node.data.high);
		    	}
		    	
			},
		
			onCreate: function(node, span)
			{
				
				if(node.data.key == topId)
				{
					node.expand(true);
					node.activate(true);
					setRootNode();
					setDeptNm(node.data.title);
				}
				
			},
		
		  	imagePath: "../img/",
		  	checkbox: true,
		  	
		    initAjax: {
				type : "POST",
				url : ClassLoader,
				dataType : "json",
				data : new part("",topPart,"","").setMethod(method).toJ()
		    },
	    
	    	onLazyRead: function(node){
				node.appendAjax({
				  	type : "POST",	
			        url: ClassLoader,
					dataType : "json",
					data : new part("",node.data.key,"","").setMethod(method).toJ(),
			        debugLazyDelay: 750 
				});
	    	}
		});
	}
};

$(document).ready(
		function()
		{
			tree = new bindTree();
			tree.bind("getChild");	
		}
);

function setDeptNm(nm)
{
	document.getElementById("deptNm").value = nm;
}

function setUserList(key,nm)
{
	document.getElementById("list").src = "list.jsp?tabId="+key;
}

function setDeptList(key,nm)
{
	document.getElementById("list").src = "deptview.jsp?tabId="+key;
}

function reLoad(gubun,id)
{
	$("#tree").dynatree("getTree").reload();
	
	if(gubun == "dept")
	{
		setDeptList(id);
	}
}

function setSelNode(node)
{
	selNode = node;
}

function setTargetNode(node)
{
	targetNode = node;
}

function setRootNode()
{
	selNode = $("#tree").dynatree("getActiveNode");
}

function test()
{
	alert("test");
}

function getDeptNm()
{
	var nm = document.getElementById("deptNm").value;
	return nm;
}
</script>
</head>
<body>
<form name="MainForm">
<input type="hidden" id="deptNm"  name="deptNm" value="">
<div id="title">
  <div id="title_width">
    <p>조직도 관리</p>
  </div>
</div>
	<tr>
		<table width="1200" height="100%" align="center" border="0" cellspacing="0" cellpadding="0">
		<col width=300"><col width="">
			<tr>
			<td height="10"></td>
			</tr>
			<tr>
				<td>
					<table width="100%" height="100%" border="1" cellpadding="0" cellspacing="0">
						<tr>
							<td><div id="tree" style="width:100%; height:550px;" valign="top"></div></td>
						</tr>
					</table>
				</td>
				<td>
					<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
						&nbsp;
						<iframe width="100%"  height="550px" frameborder="0" scrolling="auto" name="list" id="list" src="list.jsp?tabId=<%=topId%>"></iframe>
					</table>
				</td>
			</tr>
		</table>
	</tr>
</form>
</body>
</html>