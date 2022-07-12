<%@ page language="java" pageEncoding="utf-8"%>
<%
session.removeAttribute("adminId");
session.removeAttribute("adminNm");
response.sendRedirect("main.jsp");
%>