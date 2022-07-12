<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
// 고정
String adminId = (String)request.getSession().getAttribute("adminId");
String adminNm = (String)request.getSession().getAttribute("adminNm");
if ( adminId == null )
{
	%>
	<script language=javascript>
		document.onload = noId();
		function noId()
		{
			parent.document.location.href = "index.html";
		}
		
	</script>
	<%
}
// 고정 end
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>Messenger Administrator</title>
<link rel="stylesheet" href="common/css/admin.css" />
<script type="text/javascript" src="common/js/json/json2.js"></script>
<script type="text/javascript" src="common/js/common.js"></script>
<script type="text/javascript" src="common/js/jquery/jquery.js"></script>
<script type="text/javascript" src="common/js/table.js"></script>
<script type="text/javascript">
<script style="text/javascript">
function logOut() {
	frmTop.PGIDX.value="999";
	frmTop.submit();
}

$(document).ready(function() 
{
	$("#logOut").click(function() {
		logOut();
	});
});
</script>
</head>
<body>
<div id="gnb">
  <div id="gnb_width">
    <div id="logo"><a href="main.jsp" target="_parent"><img src="images/logo.png" width="295" height="27" alt="" /></a></div>
    <div id="logout"> <%=adminNm %>님 방문을 환영합니다. <a href="logout.jsp" target="_parent"><img src="images/btn_top_logout.png" width="56" height="22" align="middle" alt="" /></a></div>
  </div>
</div>
<div id="lnb">
  <div id="lnb_width">
    <div id="menu" style="text-align:left">
    	<a href="organ/tree.jsp" target="middle">조직도 관리</a>l
    	<!-- <a href="#">서버 설정</a>-->
    	<a href="adm/index.jsp"  target="middle">관리자</a>l
    	<a href="config/index.jsp" target="middle">서버 설정</a>
    	<!-- 
    	<a href="#">권한 관리</a>l
    	<a href="/process/">프로세스 관리</a>l
    	<a href="/version/">버전 관리</a>l
    	<a href="/log/">로그 모니터</a>l
    	<a href="/config/">서버 설정</a>l
    	<a href="/etc/">기타 기능 설정</a>
    	 -->
    </div> 
  </div>
</div>
</body>
</html>