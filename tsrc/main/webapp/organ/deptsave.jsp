<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%
	request.setCharacterEncoding("utf-8");

	String gubun = StringTool.NullTrim(request.getParameter("gubun"));
	String tabId = StringTool.NullTrim(request.getParameter("tabId"));
	String deptId = "";
	
	ModelOptimizer mo = new ModelOptimizer();
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String topId = prot.getProperty("TOPID").trim();
	
	boolean ok = false;
	String selectHigh = "";

	
	// 부서 추가
	if(gubun.equals("ADD"))
	{
		deptId = tabId;

		String deptNm = StringTool.NullTrim(request.getParameter("deptNm"));
		String selDeptId = StringTool.NullTrim(request.getParameter("selDeptId"));
		String deptHighId = StringTool.NullTrim(request.getParameter("deptHighId"));
		String deptGubun = StringTool.NullTrim(request.getParameter("deptGubun"));
		String deptSort = StringTool.getFormatString(StringTool.NullTrim(request.getParameter("deptSort")),6);

		if(deptGubun.equals("0"))
		{
	selectHigh = selDeptId;
		}else
		{
	selectHigh = deptHighId;
		}

		String idQuery = prot.getProperty("PARTIDSEQSELECT").trim();
		String query = prot.getProperty("DEPTADDQUERY").trim();
		
		String[] idVal = mo.getContent(idQuery);
		String partId = "add" + StringTool.getFormatString(idVal[0],10);
		
		String[] value = // 인서트 값
		{
	partId,
	selectHigh,
	deptNm,
	deptSort
		};
		
		ok = mo.execute(query,value);
	}
	
	// 부서 삭제
	if(gubun.equals("DEL"))
	{
		deptId = StringTool.NullTrim(request.getParameter("deptId"));

		String query = prot.getProperty("DEPTDELQUERY").trim();
		String[] value = // 인서트 값
		{
	deptId
		};
		
		boolean chk = true;
		
		String checkquery = prot.getProperty("DEPTCOUNT").trim();
		String[] sCheckval = {deptId};
		String[] sContent = mo.getContent(checkquery, sCheckval);

		if(Integer.parseInt(StringTool.NullTrim(sContent[0])) != 0)
		{
	chk = false;
		}

		String sUserCountQuery = prot.getProperty("USERCOUNT").trim();
		String[] sUserCountVal = {deptId};
		String[] sUserCount = mo.getContent(sUserCountQuery, sUserCountVal);

		if(Integer.parseInt(StringTool.NullTrim(sUserCount[0])) != 0)
		{
	chk = false;
		}
		
		if(chk)
		{
	ok = mo.execute(query,value);
	deptId = topId;
	tabId = topId;
		}
	}
	
	// 부서 수정
	if(gubun.equals("MOD"))
	{
		deptId = StringTool.NullTrim(request.getParameter("deptId"));
		String deptNm = StringTool.NullTrim(request.getParameter("deptNm"));
		String deptSort = StringTool.getFormatString(StringTool.NullTrim(request.getParameter("deptSort")),6);

		String query = prot.getProperty("DEPTMODQUERY").trim();
		String[] value =
		{
	deptNm,
	deptSort,
	deptId
		};
		
		ok = mo.execute(query,value);
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<form name ="MainForm">
<input type="hidden" name="id" id="id" value="<%=deptId%>">
<input type="hidden" name="tabId" id="tabId" value="<%=tabId%>">
</form>
<script type="text/javascript">
function goBack()
{
	var gubun = "<%=gubun%>";
	var ok = "<%=ok%>";
	var deptId = "<%=deptId%>";
	var form = document.MainForm;
	
	if(ok == "true")
	{
		alert("처리 성공");
		parent.reLoad("dept",deptId);
	}else
	{
		if(gubun == "MOVE")
		{
			alert("처리 실패! 자신의 하부로 이동할 수 없습니다.");
		}
		else if(gubun == "DEL")
		{
			alert("처리 실패! 하부에 부서나 구성원이 있습니다.");
		}
		else
		{
			alert("처리 실패! 관리자에게 문의하세요.");
		}
	}
	form.method = "post";
	form.action = "deptview.jsp";
	form.submit();
}
location.href="javascript:goBack()";
</script>
</head>
