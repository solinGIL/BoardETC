var oPopBody = null;
function Calendar_Click_Reserv(e) {
	cal_Day = e.title;
	chgColor(e);
}


function chgColor(obj) {
    if (obj.style.backgroundColor == "#dddddd") {
        obj.style.backgroundColor = "#ffffff";
        delList(obj.title);
    }
    else {
        obj.style.backgroundColor = "#dddddd";
        addList(obj.title);
    }
}

function delList()
{

}

function addList()
{

}

function Calendar_Change_Reserv(e) {
	cal_Day = e;
	if (cal_Day.length == 4) {
		target.value = cal_Day
	}
	if(isIE())
		oPopup.hide();
	else
		oPopup.style.display="none";
}

function Calendar_Reserv(obj) 
{
	var now = obj.value;
	target = obj;
	pop_top = document.body.clientTop + GetObjectTop(obj) - document.body.scrollTop-200;
	pop_left = document.body.clientLeft + GetObjectLeft(obj) -  document.body.scrollLeft+200;
	if (now.length == 8) 
	{
		Show_cal_Reserv(now.substring(0,4),now.substring(4,6),now.substring(6,8));
	} 
	else 
	{
		now = new Date();
		Show_cal_Reserv(now.getFullYear(), now.getMonth()+1, now.getDate());
	}
}

function Reserv()
{
	var strTag = "";
	strTag += "<table>";
	strTag += "<tr>";
      strTag += "<td height=\"5\"></td>";
      strTag += "</tr>";
	  strTag += "<tr>";
        strTag += "<td>";
        strTag += "<table width=\"195\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#91A2AC\">";
          strTag += "<tr>";
            strTag += "<td align=\"center\" bgcolor=\"#FFFFFF\" class=\"td_white\" style=\"padding : 6px 6px 6px 6px\">";
            strTag += "<select name=\"select4\" style=\"BACKGROUND-COLOR: #FFFFFF; BORDER: #D0D0D0 1 solid; font-family:����; font-size:11px; color:#5E5E5E; HEIGHT: 19px\" value=\"25\">";
            for(var i=0;i<=23;i++)
            {
            	strTag += "<option value='" + day2(i) + "'>" + day2(i) + "��</option>";
            }
            strTag += "</select>";
            strTag += "<select name=\"select\" style=\"BACKGROUND-COLOR: #FFFFFF; BORDER: #D0D0D0 1 solid; font-family:����; font-size:11px; color:#5E5E5E; HEIGHT: 19px\" value=\"25\">";
            for(var i=0;i<=55;i=i+5)
            {
              strTag += "<option value='" + day2(i) + "'>" + day2(i) + "��</option>";
            }
            strTag += "</select></td>";
          strTag += "</tr>";
        strTag += "</table>";
        strTag += "</td>";
      strTag += "</tr>";
      strTag += "<tr>";
        strTag += "<td height=\"15\" align=\"center\" class=\"t_copyright\" style=\"padding:5px 5px 5px 5px\">";
        	strTag += "<font style=\"color:#203a66; font-family : ����; font-size : 11px;\">���� ��Ҵ� ���೻�� ����Ʈ���� <br>�� �� �ֽ��ϴ�.</font>";
        strTag += "</td>";
      strTag += "</tr>";
      strTag += "<tr>";
        strTag += "<td height=\"15\" align=\"center\"><a href=\"#\"><img src=\"/sms/message/images_message/btn_reserve.gif\" width=\"100\" height=\"29\" border=0></a>&nbsp;&nbsp;<a href=\"javascript:;\" onclick=\"oPopBody.outerHTML = '';\"><img border=0 src=\"/sms/message/images_message/btn_cancle.gif\" width=\"51\" height=\"29\"></a></td>";
      strTag += "</tr>";
    strTag += "</table>";
    return strTag;
    
}

function Show_cal_Reserv(sYear, sMonth, sDay) 
{
	var Months_day = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31)
	var Month_Val = new Array("01","02","03","04","05","06","07","08","09","10","11","12");
	var intThisYear = new Number(), intThisMonth = new Number(), intThisDay = new Number();

	datToday = new Date();													// ���� ���� ����
	
	intThisYear = parseInt(sYear,10);
	intThisMonth = parseInt(sMonth,10);
	intThisDay = parseInt(sDay,10);

	if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ���� ���
	if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth(),10)+1;	// �� ���� ������ ���� -1 �� ���� �ŵ��� ����.
	if (intThisDay == 0) intThisDay = datToday.getDate();

	switch(intThisMonth) {
		case 1:
				intPrevYear = intThisYear -1;
				intPrevMonth = 12;
				intNextYear = intThisYear;
				intNextMonth = 2;
				break;
		case 12:
				intPrevYear = intThisYear;
				intPrevMonth = 11;
				intNextYear = intThisYear + 1;
				intNextMonth = 1;
				break;
		default:
				intPrevYear = intThisYear;
				intPrevMonth = parseInt(intThisMonth,10) - 1;
				intNextYear = intThisYear;
				intNextMonth = parseInt(intThisMonth,10) + 1;
				break;
	}
	
	intPPyear = intThisYear-1
	intNNyear = intThisYear+1

	NowThisYear = datToday.getFullYear();									// ���� ��
	NowThisMonth = datToday.getMonth()+1;									// ���� ��
	NowThisDay = datToday.getDate();										// ���� ��

	datFirstDay = new Date(intThisYear, intThisMonth-1, 1);			// ���� ���� 1�Ϸ� ���� ��ü ����(���� 0���� 11������ ����(1������ 12��))
	intFirstWeekday = datFirstDay.getDay();									// ���� �� 1���� ������ ���� (0:�Ͽ���, 1:������)
	//intSecondWeekday = intFirstWeekday;
	intThirdWeekday = intFirstWeekday;

	datThisDay = new Date(intThisYear, intThisMonth, intThisDay);	// �Ѿ�� ���� ���� ����
	//intThisWeekday = datThisDay.getDay();										// �Ѿ�� ������ �� ����

	intPrintDay = 1;																// ���� ���� ����
	secondPrintDay = 1;
	thirdPrintDay = 1;

	Stop_Flag = 0

	if ((intThisYear % 4)==0) {												// 4�⸶�� 1���̸� (��γ����� ��������)
		if ((intThisYear % 100) == 0) {
			if ((intThisYear % 400) == 0) {
				Months_day[2] = 29;
			}
		} else {
			Months_day[2] = 29;
		}
	}
	intLastDay = Months_day[intThisMonth];						// ������ ���� ����

	Cal_HTML = "<html>";
    Cal_HTML +="<head>";
    Cal_HTML +="</head>";
    Cal_HTML +="<body>";
	Cal_HTML += "<form name='calendar'>";
	Cal_HTML += "<table width=\"210\" border=\"0\" cellpadding=\"3\" cellspacing=\"2\" bgcolor=\"#547294\">";
  	Cal_HTML += "<tr>";
    Cal_HTML += "<td bgcolor=\"#FFFFFF\">";
            Cal_HTML += "<table width=\"195\" border=\"0\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#91A2AC\">";
          Cal_HTML += "<tr>";
            Cal_HTML += "<td align=\"center\" bgcolor=\"#FFFFFF\" class=\"td_white\" style=\"padding : 0px 0px 0px 0px\">";
	Cal_HTML += "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=200 onmouseover='doOver(window.event.srcElement)' onmouseout='doOut(window.event.srcElement)' style='font-size : 12;font-family:����;'>";
	Cal_HTML += "<tr height='30' align=center bgcolor='#f4f4f4'>";
	Cal_HTML += "<td colspan=7 align=center>";
	Cal_HTML += "<select onmouseover=\"javascript:nowObj='calendar';\" onmouseout=\"javascript:nowObj=null;\" name='selYear' STYLE='font-size:11;' OnChange='fnChangeYearD_Reserv(calendar.selYear.value, calendar.selMonth.value, "+intThisDay+")';>";
	for (var optYear=(intThisYear-3); optYear<(intThisYear+3); optYear++) 
	{
		Cal_HTML += "		<option value='"+optYear+"' ";
		if (optYear == intThisYear) Cal_HTML += " selected>\n";
		else Cal_HTML += ">\n";
		Cal_HTML += optYear+"</option>\n";
	}
	Cal_HTML += "</select>";
	Cal_HTML += "&nbsp;&nbsp;&nbsp;<a style='cursor:hand;' OnClick='Show_cal_Reserv("+intPrevYear+","+intPrevMonth+","+intThisDay+");'><img src=\"/sms/img/pop_btn_prev.gif\" border=0></a> ";
	Cal_HTML += "<select onmouseover=\"javascript:nowObj='calendar';\" onmouseout=\"javascript:nowObj=null;\" name='selMonth' STYLE='font-size:11;' OnChange='fnChangeYearD_Reserv(calendar.selYear.value, calendar.selMonth.value, "+intThisDay+")';>";
	for (var i=1; i<13; i++) 
	{
		Cal_HTML += "		<option value='"+Month_Val[i-1]+"' ";
		if (intThisMonth == parseInt(Month_Val[i-1],10)) 
			Cal_HTML += " selected>\n";
		else Cal_HTML += ">\n";
			Cal_HTML += Month_Val[i-1]+"</option>\n";
	}
	Cal_HTML += "	</select>&nbsp;";
	Cal_HTML += "<a style='cursor:hand;' OnClick='Show_cal_Reserv("+intNextYear+","+intNextMonth+","+intThisDay+");'><img src=\"/sms/img/pop_btn_next.gif\" border=0></a>";
	Cal_HTML += "</td></tr>";
	Cal_HTML += "<tr align=center bgcolor='#87B3D6' style='color:#2065DA;' height='20'>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=red>��</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=black>��</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=black>ȭ</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=black>��</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=black>��</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=black>��</font></td>";
	Cal_HTML += "	<td style='padding-top:3px;'><font color=blue>��</font></td>";
	Cal_HTML += "</tr>";

	for (intLoopWeek=1; intLoopWeek < 7; intLoopWeek++) {	// �ִ��� ���� ����, �ִ� 6��
		Cal_HTML += "<tr height='20' align=center bgcolor='white'>"
		for (intLoopDay=1; intLoopDay <= 7; intLoopDay++) {	// ���ϴ��� ���� ����, �Ͽ��� ����
			if (intThirdWeekday > 0) {											// ù�� �������� 1���� ũ��
				Cal_HTML += "<td>";
				intThirdWeekday--;
			} else {
				if (thirdPrintDay > intLastDay) 
				{								// �Է� ��¦ �������� ũ�ٸ�
					Cal_HTML += "<td>";
				} 
				else 
				{																// �Է³�¥�� ������� �ش� �Ǹ�
					Cal_HTML += "<td onClick=Calendar_Click_Reserv(this); title="+intThisYear + day2(intThisMonth).toString() + day2(thirdPrintDay).toString() + " style=\"cursor:pointer;border:1px solid white;";
					if (intThisYear == NowThisYear && intThisMonth==NowThisMonth && thirdPrintDay==intThisDay) 
					{
						Cal_HTML += "background-color:#C6F2ED;\"";
					}

					switch(intLoopDay) {
						case 1:															// �Ͽ����̸� ���� ������
							Cal_HTML += "color:red;"
							break;
						//case 7:
						//	Cal_HTML += "color:blue;"
						//	break;
						default:
							Cal_HTML += "color:black;"
							break;
					}
					Cal_HTML += "\">"+thirdPrintDay;
				}
				thirdPrintDay++;

				if (thirdPrintDay > intLastDay) 
				{								// ���� ��¥ ���� ���� ������ ũ�� ������ Ż��
					Stop_Flag = 1;
				}
			}
			Cal_HTML += "</td>";
		}
		Cal_HTML += "</tr>";
		if (Stop_Flag==1) break;
	}
	
	Cal_HTML += "</table>";
	Cal_HTML += "</td></tr></table>";
	Cal_HTML += Reserv();
	Cal_HTML += "</td></tr></table>";
	Cal_HTML += "</form></body></html>";
	

	if(isIE())
	{
		if(oPopBody!=null)
			oPopBody.outerHTML = "";
		oPopBody = document.createElement("div");
		oPopBody.style.backgroundColor = "white";
		oPopBody.innerHTML = Cal_HTML;
		document.body.appendChild(oPopBody);
		oPopBody.style.display = "block";
		oPopBody.style.visibility = "visible";
		oPopBody.style.position = "absolute";
		oPopBody.style.left = pop_left;
		oPopBody.style.top = (pop_top + target.offsetHeight);
		oPopBody.style.width = "180px";

		var calHeight = "";
		//���� 6�� ������, 5������ ����
		if (intLoopWeek == 6)
			calHeight = 180;
		else
			calHeight = 160;
		calHeight+= 129;
		oPopBody.style.height = calHeight;
	}
}


//----------------------------------
//	�ϴ޷� �⵵����Ʈ���� �⵵ ����
//----------------------------------
function fnChangeYearD_Reserv(sYear,sMonth,sDay){
	nowObj=null;
	Show_cal_Reserv(sYear, sMonth, sDay);
}