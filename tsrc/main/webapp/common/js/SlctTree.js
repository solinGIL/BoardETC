ns4 = (document.layers) ? true : false;
ie4 = (document.all) ? true : false;

var offsetx = 20;
var offsety = 0;
var x = -5;
var y =  0;

var idNm = "";	// ����ī�װ��� �����ö� ����ϴ� ī�װ� id �̸�

var folder = 0;			// ����
var folderStyle = 0;	// ����(DIV) Style
var desc = "";			// �Ϻ� ī�װ�(����) ���

var openNodeImg = "/ams/img/IconMinus.gif";		// ���� ��尡 ������ ��� �̹���
var closeNodeImg = "/ams/img/IconPlus.gif";		// ���� ��带 �ݾ��� ��� �̹���

var selectFolderImg = "/ams/img/IconTreeOn.gif";	// ���� �̹���(������ ���)
var FolderImg = "/ams/img/IconTreeOff.gif";	// ���� �̹���(������ ���)
var selectDelFolderImg = "/ams/img/IconTreeEOn.gif";	// �����μ��� ���� �̹���(������ ���)
var delFolderImg = "/ams/img/IconTreeEOff.gif";	// �����μ��� ���� �̹���(������ ���)

var cnt = 0;		// folder sequence
var ctgryList = new Array;	// folder list
var frm = "";
var checkBoxCl = "";


/**************************************************************
 * ����(2002/4/12) ������ �κ�
 *************************************************************/

// ���� ī�װ��� �����ö� ����ϴ� �� �̸��� URL (���� ��Ÿ������ ����ؾ���. url�� �켱�Ѵ�.)

var __url    = "";                // ���� ī�װ��� ���� ���� URL (URL ���� ������ �Ʒ��� ���� ����Ѵ�.)
var __target = "hiddenFrame";     // target�� �Ǵ� hidden frame�� (���� ������ ���� �����ӿ�)

// Ex) URL�� �б�
//  __url    = "<%=Controller%>?SLET=com.hs.kms.personal.kmap.KMapTreeCmd&EIPJSP=/kms/personal/kmap/Hidden.jsp&K=<%=szKey%>";
//  __target = "top.hidden";  Ȥ��  __target = "document.iframeHidden";

var __form   = "";                // ���� ī�װ��� ���� ���� �� (default�� ù��° �� -> OnClickNode�� ����)
var __action = "";                // form�� action (���� ������ ���� ������ ���� �������� ����)

// Ex) ������ �б�
//  __form   = document.form1;    // SLET, EIPJSP, K �� �ʿ��� ������ �̸� ���� �����ؾ���
//  __action = "<%=Controller%>"; // ���� �ٸ� ���α׷��� �������� �� ��� action�� target��
//  __target = "hiddenFrame";     // �������� �����ؾ��� �ʿ䰡 �����Ƿ�

/**************************************************************/


function Folder(id, parentId, name, url, childCnt, endFl)
{
	this.id = id;
	this.parentId = parentId;			// �θ� ID
	this.name = name;	// ī�װ���
	this.url = url;

	this.loadFlag = false;	// �̹� �ε��ƴ��� �ƴ����� ���¸� ������ Flag

	if(endFl == "0")
	{
		this.selectIconImg = selectFolderImg;	// ī�װ�(����) �̹���
		this.IconImg = FolderImg;	// ī�װ�(����) �̹���
	}
	else
	{
		this.selectIconImg = selectDelFolderImg;	// ī�װ�(����) �̹���
		this.IconImg = delFolderImg;	// ī�װ�(����) �̹���
	}

	this.childCnt = childCnt;
}


/*
* Ʈ���� �ֻ��� ������ �����Ѵ�.
* ������ ����� K���� �Ѱܼ� ����Ŭ�� �̺�Ʈ�� ����Ѵ�.
*/
function createMainFolder(name, idNm)
{
	this.frm = document.forms[0];
	this.checkBoxCl = frm.CHECKCL.value;  // checkboxǥ�ñ���. 0:ǥ�þ���, 1:1������, 2:��Ƽ����
	this.idNm = idNm

	mainFolder = "<div id=\"overDiv\" style=\"display:block\" border=0>"
		+ "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style='display:none' >"
		+ "<tr><td class=\"Tree\">&nbsp;"
		+ "<a href=\"javascript:OnClickNode('C000000000')\">"
		+ "<img id=\"nodeIconC0\" src=\""+ openNodeImg + "\" border=\"0\"></a> "
		+ "<img id=\"folderIconC0\" src=\""+ selectFolderImg +"\" border=\"0\">&nbsp;"+name
		+ "</td></tr></table></div>"
		+ "<div id=\"C000000000\" style=\"position:relative; display:none\"></div>";

	document.write(mainFolder);
}

/*
* '+', '-' �������� Ŭ�� �Լ�
*/
function OnClickNode(div1, idNm)
{
	eval("var div = "+stringReplace(div1,"^","_")+";");

	var clickNode = div.style;
	var nodeImg = "";
	var folderImg = "";

	if(div.id != "C000000000")	// �ֻ��� ī�װ��� �ƴҶ�
	{
		var folderInfo;

		// ��� Ŭ���� �ش��ϴ� ī�װ� id�� �ش��ϴ� �̹����� �����´�.
		for(i=0; i < ctgryList.length; i++)
		{
			if(div1 == ctgryList[i].id)
			{
				folderInfo = ctgryList[i];
			}
		}

		if(clickNode.display == "block")
		{
			// ��尡 �̹� �������� ��� display�� block���� �����ؼ� �ݰ�
			// Ŭ���� id�� �ش��ϴ� ��� �̹����� '+'�� �����Ѵ�..
			hideCategory(clickNode);

			nodeImg = closeNodeImg;
		}
		else
		{
			/*
			 * ��尡 �������� ��� DB���� Ŭ���� ����� ���� ī�װ����� �����ͼ� �߰���
			 * ��� �̹����� '-'�� �����Ѵ�.
			 * �ѹ� �ε��� ���� ī�װ��� �ٽ� �ε����� �ʴ´�.
			*/
			if(!folderInfo.loadFlag)
			{

                folderInfo.loadFlag = true;
                // URL�� ���ؼ� ���� ī�װ��� �д´�.
				if(__url != "")
                {
                    var target = (__target == "") ? document : eval(__target);
                    target.location.href = __url + "&ctgryId=" + div1.substr(1);

                // URL���� ���� ��� ���� ���ؼ� ���� ī�װ��� �д´�.
                } else {

                    document.getElementById(idNm).value = div1.substr(1);	// ���� Ŭ���� ī�װ� ID

                    var form = __form ? __form : document.forms[0];
                    if(__action != "") form.action = __action;
                    if(__target != "") form.target = __target;

                    form.submit();

                }
			}

			showCategory(clickNode);

			nodeImg = openNodeImg;
//			folderImg = folderInfo.selectIconImg;
		}
	}
	else	// �� ���� ī�װ�(����)
	{
		if(clickNode.display == "block")
		{
			hideCategory(clickNode);

			nodeImg = closeNodeImg;
		}
		else
		{
			showCategory(clickNode);

			nodeImg = openNodeImg;
		}
	}

	document.getElementById("nodeIcon" + div.id).src = nodeImg;
}

/*
*	���� Ŭ���Լ� (urlȣ��)
*/
function onClickCategory(url, divId, endFl)
{
	parent.parent.WorkingArea.LeftTopMenu.document.location.href = url;	
	parent.parent.WorkingArea.RightMenu.document.location.href = "about:blank";	

	for(i=0; i < ctgryList.length; i++)
	{
		document.getElementById("folderIcon" + ctgryList[i].id).src = ctgryList[i].IconImg;
	}
	if(endFl == "0") // �����μ�
	{
		document.getElementById("folderIcon" + divId).src = selectFolderImg;
	}
	else
	{
		document.getElementById("folderIcon" + divId).src = selectDelFolderImg;
	}
}

/*
* @ id : ī�װ�(����) id
* @ parentId : ī�װ�(����) �θ� id
* @ ctgryNm : ī�װ�(����) ��
* @ url : ī�װ�(����) ��ũ ����
* @ openStat : ī�װ�(����) ���� �ݱ� ����(0, 1)
*/
function addCategory(id, parentId, ctgryNm, ctgryValue, checkYn, url, openStat, childCnt, seq, level, endFl, docDeptFl)
{

	var divId = stringReplace(id, "^", "_");
	var divParId = stringReplace(parentId, "^", "_");

    if(divParId > 0 && !isCategoryExist(divParId)) return;

	var nodeImg = "";	// ���� �̹��� ����( ���ȴ��� ��������)
	var folderImg = "";	// ���� �̹��� ����( ���ȴ��� ��������)

	// ��� Ŭ���� �ش� ī�װ�(����)�� ������ ����ϱ� ���ؼ�
	// �߰��ϴ� ī�װ����� ������ �����ؼ� �迭�� �����Ѵ�.
	var category = new Folder(id, parentId, ctgryNm, url, childCnt, endFl);

	// ���� ���¿� ���� �̹����� �����ؼ� �����ش�.
	if(openStat == 1)
	{
		category.loadFlag = true;

		nodeImg = openNodeImg;
		if(endFl == "0") // �����μ�
		{
			folderImg = FolderImg;
		}
		else // �����μ�
		{
			folderImg = delFolderImg;
		}
	}
	else
	{
		nodeImg = closeNodeImg;
		if(endFl == "0") // �����μ�
		{
			folderImg = FolderImg;
		}
		else // �����μ�
		{
			folderImg = delFolderImg;
		}
	}

	ctgryList[cnt] = category;
	cnt++;

	desc += " <table border=0 cellpadding=0 cellspacing=0><tr><td class=\"Tree\" nowrap>";

	if(level > 1)
		desc += " <img src='/ams/img/IconTreeD.gif' style='vertical-align:middle'>";


	desc1 = "";
	parObj= getCategory(parentId);
	for(var i=2;i<level;i++)
	{
		sparObj = getCategory(parObj.parentId);
		if(sparObj.childCnt != parObj.seq)
		{
			desc1 = " <img src='/ams/img/IconTreeIn.gif' style='vertical-align:middle'>" + desc1;
		}
		else
		{
			desc1 = " <img src='/ams/img/IconTreeD.gif' style='vertical-align:middle'>" + desc1;
		}
		parObj = sparObj
	}
	desc += desc1;

	if(childCnt != "0")	
	{
		desc += " <a href=\"javascript:OnClickNode('"+id+"', '"+ this.idNm +"')\"><img id=nodeIcon"+divId+" src=\""+ nodeImg +"\" border=\"0\" style='vertical-align:middle'></a>";
	}
	else
	{
		if(level > 1)
		{
			if(seq != getCategory(parentId).childCnt)
			{
				desc += " <img src='/ams/img/IconTreeAn.gif' border='0' style='vertical-align:middle'>";
			}
			else
			{
				desc += " <img src='/ams/img/IconTreeLn.gif' border='0' style='vertical-align:middle'>";
			}
		}
	}


	var checkFlag = "";	// üũ���� ��

	if(checkYn == "Y")
	{
		checkFlag = "checked=\'true\'";
	}
	// SLET�̳� EIPJSP�� �������� �ʴ� ��� ���� ��ũ�� �������� �ʴ´�.
	if(url != "")
	{
   		desc += " <a href=\"javascript:onClickCategory('"+url+"','"+divId+"', '"+endFl+"')\"><img id=folderIcon"+ divId +" src=\""+ folderImg +"\" border=\"0\" style='vertical-align:middle'> "+ ctgryNm +"("+id.substr(1)+")</a>";
	}
	else
	{
		desc += " <img id=folderIcon"+ divId +" src=\""+ folderImg +"\" border=\"0\" style='vertical-align:middle'> ";


		if(checkBoxCl == "0")
		{
			desc += ctgryNm;
		}
		else
		{
			var checkboxCtgryNm = "";
			if(docDeptFl == "Y")
			{
				checkboxCtgryNm = "<input type='checkbox' id='"+id.substr(1)+"' name='category' "+checkFlag+ " value=\""+ctgryValue+"\" onClick=\"javascript:toggleCheck(this)\" style='vertical-align:middle;height:16px'>" + ctgryNm +"("+id.substr(1)+")"; // üũ�ڽ��� �� �˾�â ī�װ� ��
			}
			else
			{
				checkboxCtgryNm = ctgryNm +"("+id.substr(1)+")";
			}
			desc += checkboxCtgryNm;
		}
	}

	desc += " </td></tr></table>"
		+ "<div id=\""+divId+"\" style=\"position:relative; display:"+isOpen(openStat)+"\"></div>"
		+ "<table></table>"
		+ "<div id=\"\" style=\"position:relative; display:none\"></div>";
			// div�ؿ� �ٽ� <table>�� <div>�� �߰��� ������ ���� ī�װ����� �ڽ��� ������� ������� ���ֱ� ���ؼ� ����
}

/*
* status(0, 1)�� ���� div visibility stat(show, hide)�� ��ȯ�Ѵ�.
* 0 : ����, 1: ����
*/
function isOpen(status)
{
	var stat = "";

	if (ns4)
	{
		if(status == 0)
			stat = "hide";
		else
			stat = "show";
	}
	else if (ie4)
	{
		if(status == 0)
			stat = "none";
		else
			stat = "block";
	}
	return stat;
}

function setup(div)
{
	init(div, desc);
}

function init(div, child)
{
	folder = div;

	if ( (ns4) || (ie4) )
	{
		if (ns4) folderStyle = document.div;
		if (ie4) folderStyle = div.style;
	}

	desc = "";	// ����� ���� ī�װ� �ʱ�ȭ

	display(child);
}

function display(child)
{
//	moveTo(folderStyle, x + offsetx, y + offsety);
	layerWrite(child);
	showCategory(folderStyle);
}

/*
* obj�� �ش��ϴ� ī�װ��� ���ļ� �����ش�.
*/
function showCategory(obj)
{
	if (ns4)
	{
		obj.visibility = "show"
	}
	else if (ie4)
	{
		obj.display = "block"
	}
}

/*
* obj�� �ش��ϴ� ī�װ��� �����
*/
function hideCategory(obj)
{
	if (ns4)
	{
		obj.visibility = "hide";
	}
	else if (ie4)
	{
		obj.display = "none";
	}
}

/*
* �߰��ҷ��� �ڽ� ī�װ����� �θ𺸴� �̵��ؼ� ǥ���Ѵ�.
*/
function moveTo(obj, xPos, yPos)
{
	obj.left = xPos;
	obj.top = yPos;
}

/*
* addCategory()���� ������ ����ī�װ��� �θ� �ؿ� innerHTML�� �����Ѵ�.
* @child �ڽ�ī�װ�
*/
function layerWrite(child)
{
	if (ns4)
	{
		var layer = document.folder.document;
		layer.open("text/html");
		layer.write(child);
		layer.close();
	}
	else if (ie4)
	{
		document.all[folder.id].innerHTML = child;
	}
}


/*
* �Ķ���ͷ� �Ѿ�� id�� �ش��ϴ� ���� ī�װ����� ��ȯ�Ѵ�.
*/
function getCategory(categoryId)
{
	var categoryObject;

	for(i=0; i < ctgryList.length; i++)
	{
		if(ctgryList[i].id.substr(1) == categoryId)
		{
			categoryObject = ctgryList[i];
		}
	}

	return categoryObject;
}

function isCategoryExist(categoryId)
{
    for(var i = 0; i < ctgryList.length; i++)
		if(stringReplace(ctgryList[i].id.substr(1),"^","_") == categoryId)
            return true;
    return false;
}

/*
* ���ϼ����� ��� ������ ���õ� ī�װ��� �����Ѵ�.
*/
function toggleCheck(checkBoxObj)
{
	if(checkBoxObj.checked == true && checkBoxCl == "1")
	{
		for(i=0; i < frm.elements.length; i++)
		{
			checkedObject = frm.elements[i];

			if(checkedObject != checkBoxObj)
			{
				checkedObject.checked = false;
			}
		}		
	}
}