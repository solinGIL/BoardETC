/**
* #PGM_NAME		WinUtil.js <BR> (/ams/common/js/WinUtil.js)
* #DESC			���� �ڹٽ�ũ��Ʈ<BR>
*
* @ author		hjpark
**********************************************************************************************
* @							Modification   Log
* @     DATE				AUTHOR				DESCRIPTION
* @   2003.05.09			hjpark				���� �ۼ�
**********************************************************************************************
*/

/*** Index **********************************************
$1. Window ����
$2. ���� ����
$3. checkbox ����
$4. listbox ����
$5. form ����
$6. ���ڿ� ����
$7. Date ����
$8. Array ����
*********************************************************/


/********************************************************/
/*	$1. Window ����
/********************************************************/
/* $1-1
 * ��� : �˾�â�� ����
 * �Ķ����
 *   - name:��������
 * ��뿹 :  <a href="javascript:popupWin('RecipientIndex.html', 'S1033', '683', '380')">
 */
function popupWin(url, name, width, height)
{
	var features;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;
	var option = "toolbar=no,menubar=no,location=no,scrollbars=no,status=no,resizable=no,maximize=no";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}

/* $1-2
 * ��� : ��ũ�� �� �ִ� �˾�â ����
 * �Ķ����
 *   - name:��������
 * ��뿹 :  <a href="javascript:popupWin('RecipientIndex.html', 'S1033', '683', '380')">
 */
function popupWinScroll(url, name, width, height)
{
	var features;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;

	if(width*1 >= 750)
	{
		t -= 30;
	}

	var option = "toolbar=no,menubar=no,location=no,scrollbars=yes,status=no,resizable=yes";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}
/* $1-3
 * ��� : �޴��� �ִ� �˾�â ����
 * �Ķ����
 *   - name:��������
 * ��뿹 :  <a href="javascript:popupWin('RecipientIndex.html', 'S1033', '683', '380')">
 */
function popupWinMenu(url, name, width, height)
{
	var features;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;

	if(width*1 >= 750)
	{
		t -= 30;
	}

	var option = "toolbar=no,menubar=yes,location=no,scrollbars=no,status=no,resizable=yes";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}
function popupVWinScroll(url, name, width, height)
{
	var features;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;
	var option = "toolbar=no,menubar=no,location=no,scrollbars=yes,status=no,resizable=yes";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}
/* $1-3
 * ��� : �޴��� �ִ� �˾�â ����
 * �Ķ����
 *   - name:��������
 * ��뿹 :  <a href="javascript:popupWin('RecipientIndex.html', 'S1033', '683', '380')">
 */
function popupWinMenuScroll(url, name, width, height)
{
	var features;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;

	if(width*1 >= 750)
	{
		t -= 30;
	}

	var option = "toolbar=no,menubar=yes,location=no,scrollbars=yes,status=no,resizable=yes";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}

/* $1-3
 * ��� : ����â����
 */
function ResetStatus()
{
	window.status = "";
}

/* $1-4
 * ��� : ����â�� ǥ���ϱ�
 */
function ChngStatus(value)
{
	window.status = value;
}

/* $1-5
 * ��� : ȭ���� ���ε��Ѵ�. (���ΰ�ħ)
 */
function refresh()
{
	document.location.reload();
}

/* $1-6
 * ��� : �˾�â�� ����
 * �Ķ����
 *   - name:��������
 * ��뿹 :  <a href="javascript:popupWin('RecipientIndex.html', 'S1033', '683', '380')">
 */
function popupFullWin(url, name)
{
	var features;
	var width=screen.width;
	var height=screen.height;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;
	var option = "toolbar=no,menubar=no,location=no,scrollbars=no,status=yes,resizable=no,maximize=no";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;

	window.open(url, name, features);
}

/********************************************************/
/*	$2. ���� ����
/********************************************************/
/* $2
 * ��� : ���� ���̱�
 * �Ķ����
 *   - this, event�� �״�� �ѱ�� text�� �����Ѵ�.
 * ��뿹 : onMouseover='showTip(this, event, "������Ȳ����")' onMouseout='hideTip()'
 */
function showTip(current,e,text)
{
	if (document.all){
			current.title = removeStr(text,'<br>');
	}
	else if (document.layers)
	{
		document.tooltip.document.write('<layer bgColor="white" style="border:1px solid black;font-size:12px;">'+text+'</layer>');
		document.tooltip.document.close();
		document.tooltip.left=e.pageX+5;
		document.tooltip.top=e.pageY+5;
		document.tooltip.visibility="show";
	}
}

/* $2-1
 * ��� : ���� �����
 * ��뿹 : onMouseover='showTip(this, event, "������Ȳ����")' onMouseout='hideTip()'
 */
function hideTip()
{
	if (document.layers)
		document.tooltip.visibility="hidden";
}


/********************************************************/
/*	$3. checkbox ����
/********************************************************/
/* $3-1
 * ��� : checkbox ��μ���
 * ��뿹 : checkAll('MainForm', 'checkItem')
 * 20030530 �̽��� disabled���� �ȵȰ͵鸸 check �ǰ� �ٲ�
 */
function checkAll(formName, itemName)
{
	var foundCheckBoxes= findElements(formName, itemName);
	var i;
	for(i= 0; i < foundCheckBoxes.length; i++)
	{
		if(foundCheckBoxes[i].disabled!=true){
			foundCheckBoxes[i].checked= true;
		}
	}
}

/* $3-2
 * ��� : checkbox ��μ������
 * ��뿹 : uncheckAll('MainForm', 'checkItem')
 */
function uncheckAll(formName, itemName)
{
	var foundCheckBoxes= findElements(formName, itemName);
	var i;
	for(i= 0; i < foundCheckBoxes.length; i++)
	{
		foundCheckBoxes[i].checked= false;
	}
}

/* $3-3
 * ��� : checked�� checkbox element ã��
 * ��뿹 : findCheckedItems('MainForm', 'checkItem')
 */
function findCheckedItems(formName, itemName)
{
	var result= new Array();
	var foundCheckBoxes= findElements(formName, itemName);
	var i;
	for(i= 0; i < foundCheckBoxes.length; i++)
	{
		if(foundCheckBoxes[i].checked == true) result.push(foundCheckBoxes[i]);
	}

	return result;
}

/* $3-4
 * ��� : checkbox �� checked ����Ȯ��
 * ��뿹 : isChecked('MainForm', 'checkItem')
 * @param	item : checkbox ��ü
 * @return	boolean
 */
function isChecked(item)
{
	var result = false;
	var itemCnt = item.length;

	if(itemCnt > 1)
	{
		for(var i=0; i<itemCnt; i++)
		{
			if(item[i].checked)
			{
				result = true;
				break;
			}
		}
	}
	else
	{
		if(item.checked)
		{
			result = true;
		}
	}
	return result;
}

/* $3-4
 * ��� : ������ checkbox�� ������ ������ checkbox�� unckeck�Ѵ�. (radio ��ưó�� ����)
 * ��뿹 : <inpu type="checkbox" name="checkItem" onClick="toggleCheckBox('MainForm', 'checkItem', this)">
 */
function toggleCheckBox(formName, itemName, checkedObj)
{
	var foundCheckBoxes= findElements(formName, itemName);
	var i;
	for(i= 0; i < foundCheckBoxes.length; i++)
	{
		if(foundCheckBoxes[i] != checkedObj){
			foundCheckBoxes[i].checked= false;
		}
	}

}

/********************************************************/
/*	$4. listbox ����
/********************************************************/
/* $4-1
 * ��� : select list �� ��� value �� String���� ����(";" �� ������)
 * @param listBox:Select
 * @return :String, all item values separated by ";", if not exist, return null;
 */
function getAllValuesInListBox(listBox)
{
	var result= "";
	var i;
	for(i=0; i < listBox.options.length; i++)
	{
		result+= listBox.options[i].value + ";";
	}

	if(result == "") result= null;

	return result;
}
/* $4-2
 * ��� : select list�� value ���� �ش��ϴ� list option ã��
 * @param listBox:Select
 * @param value:String
 * @return  :Option, a item has the parameter 'value', return null if not exist.
 *
 */
function findItemByValueInListBox(listBox, value)
{
	var result= null;
	var i;
	for(i=0; i < listBox.options.length; i++)
	{
		if(listBox.options[i].value == value)	result= listBox.options[i];
	}

	return result;
}

/* $4-3
 * ��� : ���õ� select list �� list option ã��
 * @param listBox:Select
 * @return  Option array, return null if not exist.
 *
 */
function findSelectedItemsInListBox(listBox)
{
	var result= new Array();
	var i;
	for(i=0; i < listBox.options.length; i++)
	{
		if(listBox.options[i].selected == true)	result.push(listBox.options[i]);
	}

	if(result.length == 0) result= null;
	return result;
}

/********************************************************/
/*	$5. form ����
/********************************************************/
/* $5-1
 * ��� : �̸����� form element object ���ϱ�
 * @param forName:String
 * @param name:String
 * @return :Array
 */
function findElements(formName, name)
{
	if(formName == null) retrun;
	var result= new Array();
	var fn= formName.indexOf("document.") == -1 ?  ("document." + formName): formName;
	var elems= eval(fn + ".elements");
	var i;
	var count = 0;
	for(i=0; i < elems.length; i++)
	{
		if(elems[i].name.indexOf(name) == 0){
			result[count] = elems[i];
			count++;
		}
	}

	return result;
}

/* $5-2
 * ��� : Ư�� element�� ���� ���θ� �Ǻ��ϴ� �Լ�
 * �Ķ����
 *   - form : form �̸�, - elmnt : ���翩�θ� �Ǻ��� element�� �̸�
 * ��뿹 : if(existElement(document.forms[0], "CBLIST") == true) {...}
 * ���ϰ�
 *   - true : ������ , - false : �������� ����
 */
function existElement(form, elmnt)
{
	var elementLength = form.elements.length;
	var flag = false;

	for(i=0; i<elementLength; i++)
	{
		var e1 = form.elements[i];
		if(e1.name == elmnt)
		{
			flag = true;
			break;
		}
	}
	return flag;
}

/********************************************************/
/*	$6. ���ڿ� ����
/********************************************************/
/* $6-1
 * ��� : ���ڿ�����
 * �Ķ����
 *   - beforeStr : �����ϱ� ���� ���ڿ�, - deleteStr : ������ ���ڿ�
 * ��뿹 : removeStr("abcdefgh", "bcd") -> aefgh
 */
function removeStr(beforeStr, deleteStr)
{
	aStr=beforeStr.split(deleteStr);
	afterStr ='';
	for (i=0;i<aStr.length;i++)
		afterStr += aStr[i];
	return afterStr;
}

/* $6-2
 * ��� : �Է¹��� ������ ���� ���� �����ֱ�
 * ��뿹 : trim("  abc  ") -> "abc"
 */
function trim(beforeStr){
	var sLeftTrimed = beforeStr.replace(/^\s+/,"");
	var sBothTrimed = sLeftTrimed.replace(/\s+$/,"");
	return sBothTrimed;
}

/* $6-3
 * ��� : �Ѿ�� ���ڿ����߿� ���ʿ� ���Ե� ������ ��� ���� ���ڿ��� �����Ѵ�
 */
function Ltrim(strings)
{
    var retString = "";
    var c;
    var i;
    var end=0;
    for(i=0;i<strings.length;i++) {
        c = strings.charAt(i);
        if(c != ' ' || end==1){
           retString += c;
           end = 1;
        }
    }
    return(retString);
}

/* $6-4
 * ��� : �Ѿ�� ���ڿ����߿� �����ʿ� ���Ե� ������ ��� ���� ���ڿ��� �����Ѵ�
 */
function Rtrim(strings)
{
    var retString = "";
    var c;
    var i;
    var end=0;
    for(i=strings.length - 1;i>=0;i--) {
        c = strings.charAt(i);
        if(c != ' ' || end==1){
           retString = c + retString;
           end = 1;
        }
    }
    return(retString);
}

/* $6-5
 * ��� : �Ѿ�� ���ڿ����� ��� �����ΰ��� Ȯ�� true:��μ���, false:��������
 */
function isNumber(value) {
	num = new Number(value);
	var Result = num + '';
	if(Result == 'NaN') return false;
	return true;
}

/* $6-6
 * ��� : ����(null) �Է� ���� check, true: ����, false: ���� �ƴ�
 */
function isNull(nval) {
	for(var i = 0; i < nval.length; i++){
		tst = nval.substring(i,i+1);
		if((tst != ' ')&&(tst != '\r')&&(tst != '\n')&&(tst != '\t')&&(tst != '\b')&&(tst != '\f'))
			return false;
	}
	return true;
}

/* $6-7
 * ��� : ������ ��ü�� ���ڿ��� ���̸� ����ϴ� �Լ�
 */
function getTextByte(InputStr) {
	str = new String(InputStr);
	var strLen = str.length;
	var strByte = 0;

	for (var i=0; i<strLen; i++) {
		tmp = new String(str.charCodeAt(i));
		strByte++;
		if (tmp.length > 3) {
			strByte++;
		}
	}
	return strByte;
}

/* $6-8
 * ��� : 1�ڸ� ���ڸ� 2�ڸ��� ����(ex: 1 --> 01)
 */
function make1To2Word(vIn) {
	var vLength = vIn.length;
	if(vLength == 1) {
		vIn = '0' + vIn;
	}
	return vIn;
}

/* $6-9
 * ��� : ���ڿ� ġȯ. orgStr ���� findText �� �ش��ϴ� ���ڿ��� ã�Ƽ� rplcText �� ��ȯ�Ѵ�.
 */
function stringReplace(orgStr,findText,rplcText) {
	var pos = 0;
	pos = orgStr.indexOf(findText);
	while(pos != -1) {
		preStr = orgStr.substring(0,pos);
		postStr = orgStr.substring(pos+(findText.length)*1,orgStr.length);
		orgStr = preStr + rplcText + postStr;
		pos = orgStr.indexOf(findText);
	}
	return orgStr;
}

/********************************************************/
/*	$7. Date ����
/********************************************************/
/* $7-1
 * ��� : ��¥ Format �� ��Ȯ�� Check
 * @param	��¥ ��Ʈ�� (��: 2003-05-01)
 * @return  true / false
 */
function isValidDate(dt)
{
	if(dt == null) return false;
	var re= /(^\d\d\d\d)-(\d\d)-(\d\d)/;
	var aDate= dt;
	var ar= dt.match(re);

	if(ar == null || ar.length == 0) return false;

	var aYear= ar[1];
	var aMonth= ar[2]-1;
	var aDay= ar[3];

	var utcDate= new Date(Date.UTC(aYear, aMonth, aDay));

	var newYear= utcDate.getFullYear();
	var newMonth= utcDate.getMonth();
	var newDay= utcDate.getDate();

	if( aYear == newYear && aMonth == newMonth && aDay == newDay)
	{
		return true;
	}
	else
	{
		return false;
	}
}

/*
 * $7-2
 * ��� : ��¥ Format���� "-" ���� �Լ�
 */
function delHyphen(arg){
	var tmpDate = "";
	arg+="";
	for(var i=0;i<arg.length; i++){
		if(arg.charAt(i) == '-'){
			continue;
		}
		else{
			tmpDate += arg.charAt(i);
		}
	}

	return tmpDate;
}

function isOld(dt)
{
	var tmpDay = new Date();
	var baseDay = dt.substring(0,4) + dt.substring(5,7) + dt.substring(8,10);
	var today = tmpDay.getFullYear() +""+ make1To2Word((tmpDay.getMonth()+1)+"") +""+ make1To2Word((tmpDay.getDate())+"");
	if(parseInt(today) > parseInt(baseDay))
		return true;
	else
		return false;
}

/********************************************************/
/*	$8. Array ����
/********************************************************/
/* $8-1
 * ��� : �迭�������� �Ϲݺ������� �����ϴ� �Լ� : true�̸� �迭����, false�̸� �Ϲݺ���
 * ��뿹 : if (isArray(this.form.expertId) == true){ ... }
 */
function isArray(source)
{
    if(source[0] == null)
		return false;
	else
		return true;
}

/* $8-2
 * copy 2 desimension array  source 'source' to 'target'
 */
function copyArray2D(source, target)
{
	if( source == null || target==null) return;
	var i,j;
	for(i=0; i < source.length; i++)
	{
		var aAr= new Array();
		for(j=0; j < source[i].length; j++)
		{
			aAr.push( source[i][j] );
		}

		target.push(aAr);
	}
}

/* $8-2
 * ��� : array ����
 */
function cloneArray(source)
{
	if( source == null) return;
	var result= new Array();
	var i,j;
	for(i=0; i < source.length; i++)
	{
		result.push(source[i]);
	}

	return result;
}
function viewFolderInfo(bindNo)
{
  var form = document.MainForm;
  var viewUrl = form.action +"?SLET=com.hs.ams.common.util.viewInfo.PopViewBindInfoCmd&EIPJSP=/ams/common/PopViewBindInfo.jsp&K="+form.K.value+"&GUBUN=BindInfo&CallBindNo="+bindNo;
//  popupWinScroll(viewUrl, bindNo, "827", "520");

	var features;
	var height = 520;
	var width = 827;
	var t = screen.height / 2 - height / 2;
	var l = screen.width  / 2 - width  / 2;
	var option = "toolbar=no,menubar=no,location=no,scrollbars=auto,status=no,resizable=no,maximize=no";

	features = "top=" + t + ",left=" + l + ",width=" + width + ",height=" + height + "," + option;
	var BIND = window.open(viewUrl, bindNo, features);
	BIND.focus();
}

/********************************************************/
/*	$9. Tree�޴� ����
/********************************************************/
/* $9-1
 * ��� : �޴� �����̵� ����
 */
function AMSrunMenu(myName,newspeed)
	{

		ieStep=0;
		thereS=false;
		thereC=false;
		if(newspeed>0)
		{
			mySpeed=newspeed;
		}
		first=myName;
		if(whichOpen==-1&&!running&&AMSmain[myName]&&!(whichOpen==myName))
		{
			running=true;
			if(NN)
			{
				myLayer[myName+1].clip.height=0;
				myLayer[myName+1].visibility=VISIBLE;
			}
			if(IE)
			{
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
				myLayer[myName+1].visibility=VISIBLE;
			}
			AMSopenMenuS(myName);
			AMSopenMenuC(myName);
		}
		if(whichOpen>=0&&!running&&!(whichOpen==myName))
		{
			running=true;
			second=whichOpen;
			ieStep1=myHeight[second+1];
			thereCS=false;
			thereCC=false;
			AMScloseMenuS(second);
			AMScloseMenuC(second);
		}
		/* �ڱ��ڽ��� ���� ���ϰ� ����
		if(whichOpen>=0&&!running&&whichOpen==myName&&closes)
		{
			running=true;
			second=whichOpen;
			ieStep1=myHeight[second+1];
			thereCS=false;
			thereCC=false;
			AMScloseMenuS(second);
			AMScloseMenuC(second);
		}
		*/
	}
	
	function AMSstopCloseS(myName)
	{
		running=false;
		thereCS=true;
		if(closes&&first==whichOpen)
		{
			whichOpen=-1;
		}
		else
		{
			whichOpen=-1;
			AMSrunMenu(first);
		}
	}
	
	function AMSstopOpenS(myName)
	{
		running=false;
		thereS=true;
		if(IE)
		{
			myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ ("auto") +" "+ ("auto") +")";}
			whichOpen=myName;
		}
	
	function AMSopenMenuS(myName)
	{
		myStep=mySpeed;
		if(NN&&!thereS&&!(first==lastMain))
		{
			if(myLayer[first+2].top+myStep>mySlide[first+1])
			{
				myStep=mySlide[first+1]-myLayer[first+2].top;
			}
			for(i=first+2; i<myLayer.length; i+=2)
			{
				myLayer[i].top+=myStep;
			}
			if(myLayer[first+2].top==mySlide[first+1])
			{
				AMSstopOpenS(first)
			}
			if(running)setTimeout('AMSopenMenuS(first)',10);
		}
		if(IE&&!thereS&&!(first==lastMain))
		{
			if(myLayer[first+2].pixelTop+myStep>mySlide[first+1])
			{
				myStep=mySlide[first+1]-myLayer[first+2].pixelTop;
			}
			for(i=first+2; i<myLayer.length; i+=2)
			{
				myLayer[i].pixelTop+=myStep;
			}
			if(myLayer[first+2].pixelTop==mySlide[first+1])
			{
				AMSstopOpenS(first)
			}
			if(running)setTimeout('AMSopenMenuS(first)',10);
		}
	}
	function AMSopenMenuC(myName)
	{
		myStep=mySpeed;
		if(NN&&!thereC)
		{
			if ((myLayer[first+1].clip.height+myStep)>myHeight[first+1])
			{
				myLayer[first+1].clip.height=myHeight[first+1]
			}
			if(myLayer[first+1].clip.height==myHeight[first+1])
			{
				thereC=true;
				whichOpen=first;
				AMSstopOpenS(first)

			}else
			{
				myLayer[first+1].clip.height+=myStep;
			}
			if(running)setTimeout('AMSopenMenuC(first)',10);
		}
		if(IE&&!thereC)
		{
			ieStep+=myStep;
			myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (ieStep) +" "+ ("auto") +")";

			if(ieStep>=myHeight[first+1])
			{
				thereC=true;
				whichOpen=first;
				AMSstopOpenS(first)
			}
			if(running)setTimeout('AMSopenMenuC(first)',10);
		}
	}
	function AMScloseMenuS(myName)
	{
		myStep=mySpeed;
		if(NN&&!thereCS&&!(second==lastMain))
		{
			if(myLayer[second+2].top-myStep<myTop[second+2])
			{
				myStep=myLayer[second+2].top-myTop[second+2];
			}
			for(i=second+2; i<myLayer.length; i+=2)
			{
				myLayer[i].top-=myStep;

			}
			if(myLayer[second+2].top==myTop[second+2])
			{
				AMSstopCloseS(second);
			}
			if(running)setTimeout('AMScloseMenuS(second)',10);
		}
		if(IE&&!thereCS&&!(second==lastMain))
		{
			if(myLayer[second+2].pixelTop-myStep<myTop[second+2])
			{
				myStep=myLayer[second+2].pixelTop-myTop[second+2];
			}
			for(i=second+2; i<myLayer.length; i+=2)
			{
				myLayer[i].pixelTop-=myStep;

			}
			if(myLayer[second+2].pixelTop==myTop[second+2])
			{
				AMSstopCloseS(second);
			}
			if(running)setTimeout('AMScloseMenuS(second)',10);
		}
	}
	function AMScloseMenuC(myName)
	{
		myStep=-mySpeed;
		ieStep1-=mySpeed;
		if(NN&&!thereCC)
		{
			if ((myLayer[second+1].clip.bottom+myStep)<0)
			{
				myLayer[second+1].clip.bottom=0;
			}
			if(myLayer[second+1].clip.bottom==0)
			{
				thereCC=true;

				if(second==lastMain)AMSstopCloseS(second);
			}
			else
			{
				myLayer[second+1].clip.bottom+=myStep;

			}
			if(running)setTimeout('AMScloseMenuC(second)',10);
		}
		if(IE&&!thereCC)
		{
			if(ieStep1<=0)
			{
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (0) +" "+ ("auto") +")";
				thereCC=true;
				if(second==lastMain)AMSstopCloseS(second);

			}
			else
			{
				myLayer[myName+1].clip= "rect(" + ("auto") +" "+ ("auto") +" "+ (ieStep1) +" "+ ("auto") +")";

			}
			if(running)setTimeout('AMScloseMenuC(second)',10);
		}
	}