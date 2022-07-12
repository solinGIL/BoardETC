<%--
/**
* #PGM_NAME	��������� �������׺���̼�  (/amd/common/include/ListMovePage.jsp)
* #DESC     ����������� �������׺���̼��� �������� �����ϱ����� JSP
* ��뿹)
* 	request.setAttribute("PN",1);
*		request.setAttribute("RC",35);
*		request.setAttribute("LS",10);
*
*		OnPageMove() function �� Click�� ȣ��� javascript function �̸�, ��Ŭ��� ȭ�鿡�� ������.
*
--%>

<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%
	int nPageNo			=	Integer.parseInt((String)request.getAttribute("PN")); // ����������
	int nRecordCount=	Integer.parseInt((String)request.getAttribute("RC")); // ��ü���ڵ��
	int nListSize		=	Integer.parseInt((String)request.getAttribute("LS")); // �� �������� ǥ���� ���ڵ��
	int nPageSize		= 10;	// �������׺���̼� ũ��(1~10, 11~20...)
	int nTotalEnd		= nRecordCount/nListSize + ((nRecordCount%nListSize > 0) ? 1 : 0);	// �� �� �������� ���Ѵ�.(�� �ۼ� / ȭ�鿡 ������ �������� ��)

	//���� �������� ������ ���������� Ŭ�� ������ �������� �����ش�.
	if(nPageNo > nTotalEnd)
	{
		nPageNo = nTotalEnd;
	}

	int nStartPage	= ((nPageNo - 1) / nPageSize) * nPageSize + 1;
	int nEndPageTmp = nStartPage + nPageSize - 1;
	int nEndPage	= (nTotalEnd > nEndPageTmp) ? nEndPageTmp : nTotalEnd;
	int nPrevious	= (nStartPage == 1) ? 0 : (nStartPage - 1);
	int nNext		= (nTotalEnd > nEndPage) ? (nEndPage + 1) : 0;
	
%>
<STYLE TYPE="text/css">
<!--
a.PageCrnt{color: #FF0000; font-size: 9pt;font-weight: bold;text-decoration: none; }
a.PageNavi:link{color: #353535; font-size: 9pt; text-decoration: none; }
a.PageNavi:active{color: #353535; font-size: 9pt;text-decoration: none; }
a.PageNavi:visited{color: #353535; font-size: 9pt; text-decoration: none; }
a.PageNavi:hover { color: #353535; font-size: 9pt; text-decoration: none; }
A:link     {font: 9pt Gulim, ����; text-decoration: none; color: #666666; letter-spacing: -0.06em}
-->
</STYLE><table align="center" cellspacing="0" cellpadding="0">
	<tr height="15">
		<%
			// �˻��� ����� ������� �̵���ư �̹����� ������ �ʴ´�.
			if(nRecordCount != 0)
			{
		%>
		<td width="80" align="left">
		<%
				if(nPrevious != 0)
				{
		%>
				<a href="javascript:OnPageMove('<%=nPrevious%>')"><img alt="���� 10������" src="../img/bu_prepre_on.gif" border="0" ></a>
		<%
				}
				else
				{
		%>
				<img alt="���� 10������" src="../img/bu_prepre_off.gif" border="0">
		<%
				}
				if(nPageNo > 1)
				{
		%>
				<a href="javascript:OnPageMove('<%=nPageNo-1%>')"><img alt="����" src="../img/bu_pre_on.gif" border="0" ></a>
		<%
				}
				else
				{
		%>

 				<img alt="����" src="../img/bu_pre_off.gif" border="0">
		<%
				}
		%>
		</td>
		<td width="4"></td>
		<%
				for(int i=nStartPage ; i <= nEndPage ; i++)
				{
		%>
		<td width="4" align="center">
		<%
					if(i == nPageNo)
					{
		%>
					<a class="PageCrnt" ><%=i%></a>
		<%
					}
					else
					{
		%>
					 <a href="javascript:OnPageMove('<%=i%>')" PageCrnt="PageNavi"><%=i%></a>
		<%
					}
		%>
		</td><td width="4"></td>
		<%
				}
		%>
		<td width="80" align="right">
		<%
				if(nPageNo < nTotalEnd)
				{
		%>
				<a href="javascript:OnPageMove('<%=nPageNo+1%>')"><img alt="����" src="../img/bu_next_on.gif" border="0" ></a>
		<%
				}
				else
				{
		%>
					<img alt="����" src="../img/bu_next_off.gif" border="0">
		<%
				}
				if(nNext != 0)
				{
		%>
				<a href="javascript:OnPageMove('<%=nNext%>')"><img alt="���� 10������" src="../img/bu_nextnext_on.gif" border="0" ></a>
		<%
				}
				else
				{
		%>
					<img alt="���� 10������" src="../img/bu_nextnext_off.gif" border="0">
		<%
				}
			}
		%>
		</td>
	</tr>
</table>