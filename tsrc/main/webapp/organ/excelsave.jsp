<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="kr.co.ultari.common.StringTool" %>
<%@ page import="kr.co.ultari.db.ModelOptimizer" %>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
	
	Properties prot = new Properties();
	String protPath = "/config/Config.properties";
	prot.load(getClass().getResourceAsStream(protPath));
	
	String topId = prot.getProperty("TOPID").trim();
	
	// ���� �⵵�� ���� ���Ѵ�
	Date YYYYMMDD = new Date();
	SimpleDateFormat myFormat = new SimpleDateFormat("yyyyMMdd");
	String year = (myFormat.format(YYYYMMDD)).substring(0, 4);
	String month = (myFormat.format(YYYYMMDD)).substring(4, 6);
	String day = (myFormat.format(YYYYMMDD)).substring(6, 8);
	String today = year + "-" + month + "-" + day;
	
	String sSavePath = prot.getProperty("EXCELPATH").trim();
	int iMaxSize = 105000000; // ���� ������ ���� 100M
	String sAddSavePath = java.io.File.separator + year + java.io.File.separator + month + java.io.File.separator + day + java.io.File.separator; // �߰� ���(������/��/��/)
	sSavePath += sAddSavePath;
	
	File dirsrch = new File(sSavePath);
	try {
		if (!dirsrch.exists()) {
	if (dirsrch.mkdirs()) {
		System.out.println("���丮 ����");
	} else {
		System.out.println("���丮 ���� ����");
	}
		}
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
	
	MultipartRequest multi = null;
	String sFileName = null;
	
	try {
		multi = new MultipartRequest(request, sSavePath, iMaxSize, "euc-kr");
		Enumeration formNames = multi.getFileNames();  // ���� �̸� ��ȯ
		while (formNames.hasMoreElements()) { // �ڷᰡ ���� ��쿣 while ���� ���
	String formName = (String) formNames.nextElement(); 
	sFileName = multi.getFilesystemName(formName); // ������ �̸� ���
		}
	}catch (Exception e) {
		System.out.println("���� ���ε� ����");
%>
			<script type="text/javascript">
				function goMain(){

					alert("���Ͽ뷮 �ʰ�");
					history.back();
				}
				location.href="JavaScript:goMain()";
			</Script>
<%
	return;
	}
	
	//���� ���ε� �� DB ����
	String rtnstr = "";
	
	String deptFile = StringTool.NullTrim(multi.getParameter("FileNameDept"));
	String userFile = StringTool.NullTrim(multi.getParameter("FileNameUser"));
	
	ModelOptimizer mo = new ModelOptimizer();
	
	String sDeptAddQuery = prot.getProperty("EXCELDEPTADD").trim();
	String sDeptDelQuery = prot.getProperty("EXCELDEPTDEL").trim();
	
	String sUserAddQuery = prot.getProperty("EXCELUSERADD").trim();
	String sUserDelQuery = prot.getProperty("EXCELUSERDEL").trim();
	
	
	String[] deptValue = null;
	String[] userValue = null;
	
	boolean deptAddOk = false;
	boolean deptDelOk = false;
	boolean userAddOk = false;
	boolean userDelOk = false;
	
	if(!deptFile.equals("")) //�μ� ����ȭ
	{
		
		deptDelOk = mo.execute(sDeptDelQuery);
		
		if(deptDelOk)
		{
	try
	{			
		String sPath = sSavePath + deptFile;
		java.io.FileInputStream file = new java.io.FileInputStream(new java.io.File(sPath));
		Workbook workbook = Workbook.getWorkbook(file);
		Sheet sheet = workbook.getSheet(0); // ù��° ��Ʈ�� ����
		
		int rows = sheet.getRows();
	
		Cell id = null;
		Cell high = null;
		Cell name = null;
		Cell sort = null;
		
		String idCell = "";
		String highCell = "";
		String nameCell = "";
		String sortCell = "";
		
		String[][] deptInsertValue =  new String[rows - 1][4];
		
		if(rows > 0)
		{
	for(int j=1 ; j < rows; j++)
	{
		int i=j-1;
		
		id = sheet.getCell(0,j);
		idCell = StringTool.NullTrim(id.getContents());
		
		high = sheet.getCell(1,j);
		highCell = StringTool.NullTrim(high.getContents());
		
		name = sheet.getCell(2,j);
		nameCell = StringTool.NullTrim(name.getContents());
		
		sort = sheet.getCell(3,j);
		sortCell = StringTool.NullTrim(sort.getContents());
		
		//System.out.println(idCell + " / " + highCell + " / " + nameCell + " / " + sortCell);
		
		deptInsertValue[i][0] = idCell;
		deptInsertValue[i][1] = highCell;
		deptInsertValue[i][2] = nameCell;
		deptInsertValue[i][3] = sortCell;
	}
	deptAddOk = mo.executeBatch(sDeptAddQuery, deptInsertValue);
		}
		if(deptAddOk)
		{
	rtnstr += " �μ� ����ȭ ���� ";
		}
		else
		{
	rtnstr += " �μ� ����ȭ ���� ";
		}
	}catch(Exception e)
	{ 
		e.printStackTrace(); 
	}
	
	//System.out.println("�μ� ���� : " + deptDelOk + " / �μ� ���� : " + deptAddOk);
		}
		else
		{
	rtnstr += " �μ� ����ȭ ���� ";
		}
	}
	
	if(!userFile.equals("")) //����� ����ȭ
	{
		userDelOk = mo.execute(sUserDelQuery);
		
		if(userDelOk)
		{
	try
	{			
		String sPath = sSavePath + userFile;
		java.io.FileInputStream file = new java.io.FileInputStream(new java.io.File(sPath));
		Workbook workbook = Workbook.getWorkbook(file);
		Sheet sheet = workbook.getSheet(0); // ù��° ��Ʈ�� ����
		
		int rows = sheet.getRows();
	
		Cell userId = null;
		Cell deptId= null;
		Cell userNm = null;
		Cell deptNm = null;
		Cell pos = null;
		
		Cell grade = null;
		Cell job = null;
		Cell phone = null;
		Cell mobile = null;
		Cell email = null;
		
		Cell sort = null;
		
		String userIdCell = "";
		String deptIdCell = "";
		String userNmCell = "";
		String deptNmCell = "";
		String posCell = "";
		
		String gradeCell = "";
		String jobCell = "";
		String phoneCell = "";
		String mobileCell = "";
		String emailCell = "";
		
		String sortCell = "";
		
		String[][] userInsertValue =  new String[rows - 1][11];
		
		if(rows > 0)
		{
	for(int j=1 ; j < rows; j++)
	{
		int i=j-1;
		
		userId = sheet.getCell(0,j);
		userIdCell = StringTool.NullTrim(userId.getContents());
		
		deptId = sheet.getCell(1,j);
		deptIdCell = StringTool.NullTrim(deptId.getContents());
		
		userNm = sheet.getCell(2,j);
		userNmCell = StringTool.NullTrim(userNm.getContents());
		
		deptNm = sheet.getCell(3,j);
		deptNmCell = StringTool.NullTrim(deptNm.getContents());
		
		pos = sheet.getCell(5,j);
		posCell = StringTool.NullTrim(pos.getContents());
		
		grade = sheet.getCell(6,j);
		gradeCell = StringTool.NullTrim(grade.getContents());
		
		job = sheet.getCell(7,j);
		jobCell = StringTool.NullTrim(job.getContents());
		
		phone = sheet.getCell(8,j);
		phoneCell = StringTool.NullTrim(phone.getContents());
		
		mobile = sheet.getCell(9,j);
		mobileCell = StringTool.NullTrim(mobile.getContents());
		
		email = sheet.getCell(10,j);
		emailCell = StringTool.NullTrim(email.getContents());
		
		sort = sheet.getCell(11,j);
		sortCell = StringTool.NullTrim(sort.getContents());
		
		
		
		//System.out.println(idCell + " / " + highCell + " / " + nameCell + " / " + sortCell);
		
		userInsertValue[i][0] = userIdCell;
		userInsertValue[i][1] = deptIdCell;
		userInsertValue[i][2] = userNmCell;
		userInsertValue[i][3] = deptNmCell;
		userInsertValue[i][4] = posCell;
		
		userInsertValue[i][5] = gradeCell;
		userInsertValue[i][6] = jobCell;
		userInsertValue[i][7] = phoneCell;
		userInsertValue[i][8] = mobileCell;
		userInsertValue[i][9] = emailCell;
		
		userInsertValue[i][10] = sortCell;
	}
	userAddOk = mo.executeBatch(sUserAddQuery, userInsertValue);
	if(userAddOk)
	{
		rtnstr += " ����� ����ȭ ���� ";
	}
	else
	{
		rtnstr += " ����� ����ȭ ���� ";
	}
		}
	}catch(Exception e)
	{ 
		e.printStackTrace(); 
	}
		}
		else
		{
	rtnstr += " ����� ����ȭ ���� ";
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<form name ="MainForm">
</form>
<script type="text/javascript">

function goBack()
{
	var rtn = "<%=rtnstr%>";
	var deptFile = "<%=deptFile%>";
	var topId = "<%=topId%>";
	
	if(deptFile != "")
	{
		parent.reLoad("dept",topId);
	}
	
	alert(rtn);
	var form = document.MainForm;
	form.method = "post";
	form.action = "excelupload.jsp";
	form.submit();
}
location.href="javascript:goBack()";
</script>
</head>

	
	