var target;
var pop_top;
var pop_left;
var cal_Day;
var oPopup=window.createPopup();
var nowObj=null;


function isIE() {
var agt=navigator.userAgent.toLowerCase();
if (agt.indexOf("msie") != -1)
	return true;
else
	return false;
}

function Calendar_Click(e) {
	cal_Day = e.title;
	if (cal_Day.length >= 4) {
		target.value = cal_Day
	}
	if(isIE())
		oPopup.hide();
	else
		oPopup.style.display="none";
}

function Calendar_Change(e) {
	cal_Day = e;
	if (cal_Day.length == 4) {
		target.value = cal_Day
	}
	if(isIE())
		oPopup.hide();
	else
		oPopup.style.display="none";
}

function Calendar_D(obj) {
	var now = obj.value;
	target = obj;
	pop_top = document.body.clientTop + GetObjectTop(obj) - document.body.scrollTop;
	pop_left = document.body.clientLeft + GetObjectLeft(obj) -  document.body.scrollLeft;
	if (now.length == 8) {
		Show_cal(now.substring(0,4),now.substring(4,6),now.substring(6,8));
	} else {
		now = new Date();
		Show_cal(now.getFullYear(), now.getMonth()+1, now.getDate());
	}
}

function Calendar_M(obj) {
	var now = obj.value;
	target = obj;
	pop_top = document.body.clientTop + GetObjectTop(obj) - document.body.scrollTop;
	pop_left = document.body.clientLeft + GetObjectLeft(obj) -  document.body.scrollLeft;

	if (now.length == 2) {
		Show_cal_M(now.substring(0,4),now.substring(4,6));
	} else {
		now = new Date();
		Show_cal_M(now.getFullYear(), now.getMonth()+1);
	}
}

function Calendar_Y(obj) {
	target = obj;

	pop_top = document.body.clientTop + GetObjectTop(obj) - document.body.scrollTop;
	pop_left = document.body.clientLeft + GetObjectLeft(obj) -  document.body.scrollLeft;

	if (obj.value.length == 4) {
		Show_cal_Y(obj.value);
	} else {
		now = new Date();
		Show_cal_Y(now.getFullYear());
	}
}

function doOver(el) {
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		el.style.borderColor = "#FF0000";
	}
}

function doOut(el) {
	cal_Day = el.title;

	if (cal_Day.length > 7) {
		el.style.borderColor = "#FFFFFF";
	}
}

function day2(d) {	// 2�ڸ� ���ڷ� ����
	var str = new String();

	if (parseInt(d) < 10) {
		str = "0" + parseInt(d);
	} else {
		str = "" + parseInt(d);
	}
	return str;
}

function Show_cal_Reserv()
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
              strTag += "<option>01��</option>";
              strTag += "<option>02��</option>";
            strTag += "</select>";
            strTag += "<select name=\"select\" style=\"BACKGROUND-COLOR: #FFFFFF; BORDER: #D0D0D0 1 solid; font-family:����; font-size:11px; color:#5E5E5E; HEIGHT: 19px\" value=\"25\">";
              strTag += "<option>00��</option>";
              strTag += "<option>05��</option>";
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
        strTag += "<td height=\"15\" align=\"center\"><a href=\"#\"><img src=\"images_message/btn_reserve.gif\" width=\"100\" height=\"29\" border=0></a>&nbsp;&nbsp;<a href=\"#\"><img border=0 src=\"images_message/btn_cancle.gif\" width=\"51\" height=\"29\"></a></td>";
      strTag += "</tr>";
    strTag += "</table>";
    return strTag;
    
}

function Show_cal(sYear, sMonth, sDay) 
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
	Cal_HTML += "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=200 onmouseover='parent.doOver(window.event.srcElement)' onmouseout='parent.doOut(window.event.srcElement)' style='font-size : 12;font-family:����;'>";
	Cal_HTML += "<tr height='30' align=center bgcolor='#f4f4f4'>";
	Cal_HTML += "<td colspan=7 align=center>";
	Cal_HTML += "<select onmouseover=\"javascript:parent.nowObj='calendar';\" onmouseout=\"javascript:parent.nowObj=null;\" name='selYear' STYLE='font-size:11;' OnChange='parent.fnChangeYearD(calendar.selYear.value, calendar.selMonth.value, "+intThisDay+")';>";
	for (var optYear=(intThisYear-3); optYear<(intThisYear+3); optYear++) 
	{
		Cal_HTML += "		<option value='"+optYear+"' ";
		if (optYear == intThisYear) Cal_HTML += " selected>\n";
		else Cal_HTML += ">\n";
		Cal_HTML += optYear+"</option>\n";
	}
	Cal_HTML += "</select>";
	Cal_HTML += "&nbsp;&nbsp;&nbsp;<a style='cursor:hand;' OnClick='parent.Show_cal("+intPrevYear+","+intPrevMonth+","+intThisDay+");'><img src=\"/sms/img/pop_btn_prev.gif\" border=0></a> ";
	Cal_HTML += "<select onmouseover=\"javascript:parent.nowObj='calendar';\" onmouseout=\"javascript:parent.nowObj=null;\" name='selMonth' STYLE='font-size:11;' OnChange='parent.fnChangeYearD(calendar.selYear.value, calendar.selMonth.value, "+intThisDay+")';>";
	for (var i=1; i<13; i++) 
	{
		Cal_HTML += "		<option value='"+Month_Val[i-1]+"' ";
		if (intThisMonth == parseInt(Month_Val[i-1],10)) 
			Cal_HTML += " selected>\n";
		else Cal_HTML += ">\n";
			Cal_HTML += Month_Val[i-1]+"</option>\n";
	}
	Cal_HTML += "	</select>&nbsp;";
	Cal_HTML += "<a style='cursor:hand;' OnClick='parent.Show_cal("+intNextYear+","+intNextMonth+","+intThisDay+");'><img src=\"/sms/img/pop_btn_next.gif\" border=0></a>";
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
					Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+intThisYear + day2(intThisMonth).toString() + day2(thirdPrintDay).toString() + " style=\"cursor:pointer;border:1px solid white;";
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
	Cal_HTML += "</td></tr></table>";
	Cal_HTML += "</form></body></html>";
	var oPopBody = null;

	if(isIE())
	{
		oPopBody = oPopup.document.body;
		oPopBody.style.backgroundColor = "white";
//		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;


		var calHeight = "";
		//���� 6�� ������, 5������ ����
		if (intLoopWeek == 6)
			calHeight = 192;
		else
			calHeight = 170;
		oPopup.show(pop_left, (pop_top + target.offsetHeight), 213, calHeight, document.body);
	}
	else
	{
		oPopup.innerHTML = "";
		oPopBody = document.createElement("div");
		oPopBody.style.backgroundColor = "white";
		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;
		oPopup.appendChild(oPopBody);
		oPopup.style.display = "block";
		oPopup.style.visibility = "visible";
		oPopup.style.position = "absolute";
		oPopup.style.left = pop_left;
		oPopup.style.top = (pop_top + target.offsetHeight);
		oPopup.style.width = "180px";

		var calHeight = document.getElementById("Cal_Table").offsetHeight;
		//���� 6�� ������, 5������ ����
//		if (intLoopWeek == 6)
//			calHeight = 180;
//		else
//			calHeight = 160;
		oPopup.style.height = calHeight;
	}
}


function Show_cal_M(sYear, sMonth) {
	var intThisYear = new Number(), intThisMonth = new Number()
	datToday = new Date();													// ���� ���� ����

	intThisYear = parseInt(sYear,10);
	intThisMonth = parseInt(sMonth,10);

	if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ���� ���
	if (intThisMonth == 0) intThisMonth = parseInt(datToday.getMonth(),10)+1;	// �� ���� ������ ���� -1 �� ���� �ŵ��� ����.

	switch(intThisMonth) {
		case 1:
				intPrevYear = intThisYear -1;
				intNextYear = intThisYear;
				break;
		case 12:
				intPrevYear = intThisYear;
				intNextYear = intThisYear + 1;
				break;
		default:
				intPrevYear = intThisYear;
				intNextYear = intThisYear;
				break;
	}
	intPPyear = intThisYear-1
	intNNyear = intThisYear+1

	Cal_HTML = "<html><head>\n";
	Cal_HTML += "</head><body>\n";
	Cal_HTML += "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=100% onmouseover='parent.doOver(window.event.srcElement)' onmouseout='parent.doOut(window.event.srcElement)' style='font-size : 12;font-family:����;'>\n";
	Cal_HTML += "<tr height='20' align=center bgcolor='#f4f4f4'>\n";
	Cal_HTML += "<td colspan='4' align='center'>\n";
	Cal_HTML += "<a style='cursor:hand;' OnClick='parent.Show_cal_M("+intPPyear+","+intThisMonth+");'><img src=\"/sms/img/pop_btn_prev.gif\" border=0></a>&nbsp;";
	Cal_HTML += "<select onmouseover=\"javascript:parent.nowObj='calendar';\" onmouseout=\"javascript:parent.nowObj=null;\" name='selYear' STYLE='font-size:11;' OnChange='parent.fnChangeYearM(this.value, "+intThisMonth+")';>";
	for (var optYear=(intThisYear-3); optYear<(intThisYear+3); optYear++) {
			Cal_HTML += "		<option value='"+optYear+"' ";
			if (optYear == intThisYear) Cal_HTML += " selected>\n";
			else Cal_HTML += ">\n";
			Cal_HTML += optYear+"</option>\n";
	}
	Cal_HTML += "	</select>\n";
	Cal_HTML += "<a style='cursor:pointer;' OnClick='parent.Show_cal_M("+intNNyear+","+intThisMonth+");'><img src=\"/sms/img/pop_btn_next.gif\" border=0></a>";
	Cal_HTML += "</td></tr>\n";
	Cal_HTML += "<tr><td colspan=4 height='1' bgcolor='#000000'></td></tr>";
	Cal_HTML += "<tr height='20' align=center bgcolor=white>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "01 style=\"cursor:pointer;\">Jan</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "02 style=\"cursor:pointer;\">Feb</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "03 style=\"cursor:pointer;\">Mar</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "04 style=\"cursor:pointer;\">Apr</td>";
	Cal_HTML += "</tr>\n";
	Cal_HTML += "<tr height='20' align=center bgcolor=white>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "05 style=\"cursor:pointer;\">May</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "06 style=\"cursor:pointer;\">Jun</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "07 style=\"cursor:pointer;\">Jul</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "08 style=\"cursor:pointer;\">Aug</td>";
	Cal_HTML += "</tr>\n";
	Cal_HTML += "<tr height='20' align=center bgcolor=white>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "09 style=\"cursor:pointer;\">Sep</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "10 style=\"cursor:pointer;\">Oct</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "11 style=\"cursor:pointer;\">Nov</td>";
	Cal_HTML += "<td onClick=parent.Calendar_Click(this); title="+ intThisYear+ "12 style=\"cursor:pointer;\">Dec</td>";
	Cal_HTML += "</tr>\n";
	Cal_HTML += "</table>\n</body></html>";

	var oPopBody = null;

	if(isIE())
	{
		oPopBody= oPopup.document.body;
		oPopBody.style.backgroundColor = "lightyellow";
		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;
		oPopup.show(pop_left, (pop_top + target.offsetHeight), 160, 90, document.body);
	}
	else
	{
		oPopup.innerHTML = "";
		oPopBody = document.createElement("div");
		oPopBody.style.backgroundColor = "lightyellow";
		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;
		oPopup.appendChild(oPopBody);
		oPopup.style.display = "block";
		oPopup.style.visibility = "visible";
		oPopup.style.position = "absolute";
		oPopup.style.left = pop_left;
		oPopup.style.top = (pop_top + target.offsetHeight);
		oPopup.style.width = "160px";
		oPopup.style.height = "90px";
	}

}


function Show_cal_Y(sYear) {
	var intThisYear = new Number(), intThisMonth = new Number()
	datToday = new Date();													// ���� ���� ����

	intThisYear = parseInt(sYear,10);

	if (intThisYear == 0) intThisYear = datToday.getFullYear();				// ���� ���� ���
	switch(intThisMonth) {
		case 1:
				intPrevYear = intThisYear -1;
				intNextYear = intThisYear;
				break;
		case 12:
				intPrevYear = intThisYear;
				intNextYear = intThisYear + 1;
				break;
		default:
				intPrevYear = intThisYear;
				intNextYear = intThisYear;
				break;
	}
	intPPyear = intThisYear-1
	intNNyear = intThisYear+1

	Cal_HTML = "<html><head>\n";
	Cal_HTML += "</head><body>\n";
//	Cal_HTML += "<table id=Cal_Table border=0 bgcolor='#f4f4f4' cellpadding=1 cellspacing=1 width=100% onmouseover='parent.doOver(window.event.srcElement)' onmouseout='parent.doOut(window.event.srcElement)' style='font-size : 12;font-family:����;'>\n";
	Cal_HTML += "<table id=Cal_Table border=0 bgcolor='' cellpadding=1 cellspacing=1 width=100% onmouseover='parent.doOver(window.event.srcElement)' onmouseout='parent.doOut(window.event.srcElement)' style='font-size : 12;font-family:����;'>\n";
	Cal_HTML += "<tr><td style='height:20px' bgcolor='#f4f4f4'  align='center'><b>Year</b></td></tr>"
	
/*
	Cal_HTML += "<select name='selYear' STYLE='font-size:11;' OnChange='parent.Calendar_Change(this)';>";

	for (var optYear=(intThisYear-3); optYear<(intThisYear+3); optYear++) {
			Cal_HTML += "		<option value='"+optYear+"' ";
			if (optYear == intThisYear) Cal_HTML += " selected>\n";
			else Cal_HTML += ">\n";
			Cal_HTML += optYear+"</option>\n";
	}

	Cal_HTML += "	</select>\n";
	Cal_HTML += "</td></tr>\n";
*/

	for (var optYear=(intThisYear-2); optYear<(intThisYear+2); optYear++) {
			Cal_HTML += "		<tr style='cursor:pointer;'><td style='height:20px' align='center' style='cursor:pointer;' onClick='parent.Calendar_Click(this);' title='"+optYear+"'>"+optYear+"</td></tr>";
	}


	Cal_HTML += "</table>\n</body></html>";

	var oPopBody = null;

	if(isIE())
	{
		oPopBody= oPopup.document.body;
		oPopBody.style.backgroundColor = "lightyellow";
		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;
		oPopup.show(pop_left, (pop_top + target.offsetHeight), 45, 110, document.body);
	}
	else
	{
		oPopup.innerHTML = "";
		oPopBody = document.createElement("div");
		oPopBody.style.backgroundColor = "lightyellow";
		oPopBody.style.border = "solid black 1px";
		oPopBody.innerHTML = Cal_HTML;
		oPopup.appendChild(oPopBody);
		oPopup.style.display = "block";
		oPopup.style.visibility = "visible";
		oPopup.style.position = "absolute";
		oPopup.style.left = pop_left;
		oPopup.style.top = (pop_top + target.offsetHeight);
		oPopup.style.width = "45px";
		oPopup.style.height = "110px";

		//oPopup.show(pop_left, (pop_top + target.offsetHeight), 45, 110, document.body);
	}

}


//----------------------------------
//	�ϴ޷� �⵵����Ʈ���� �⵵ ����
//----------------------------------
function fnChangeYearD(sYear,sMonth,sDay){
	nowObj=null;
	Show_cal(sYear, sMonth, sDay);
}


//----------------------------------
//	���޷� �⵵����Ʈ���� �⵵ ����
//----------------------------------
function fnChangeYearM(sYear,sMonth){
	nowObj=null;
	Show_cal_M(sYear, sMonth);
}

/**
	HTML ��ü�� ��ƿ��Ƽ �Լ�
**/
function GetObjectTop(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetTop;
	else
		return obj.offsetTop + GetObjectTop(obj.offsetParent);
}

function GetObjectLeft(obj)
{
	if (obj.offsetParent == document.body)
		return obj.offsetLeft;
	else
		return obj.offsetLeft + GetObjectLeft(obj.offsetParent);
}

