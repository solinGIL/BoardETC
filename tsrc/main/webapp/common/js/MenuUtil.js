function removeCookie(name, value)
{
	if(value == null) return;

	var today = new Date();
	today.setTime(today.getTime() -1);
	var cook = name+"="+escape(value)+";" 
		+ "expires=" + today.toGMTString() + ";";
	document.cookie = cook;
}

function removeKey(userid)
{
	removeCookie('AUTHKEY[' + userid + ']','');
}

function setCookie(key, value)
{
	var today = new Date();
    today.setMonth(today.getMonth() + 1);
	document.cookie = key + "=" + escape(value) + ";"
		+ "expires=" + today.toGMTString() + ";";
}

function getCookie(key)
{
	if(document.cookie.length)
	{
		var cookies = ' ' + document.cookie;
		var start = cookies.indexOf(' ' + key + '=');
		if (start == -1) { return ''; }

		var end = cookies.indexOf(";", start);
		if (end == -1) { end = cookies.length; }
		end -= start;
		var cookie = cookies.substr(start,end);

		return unescape(cookie.substr(cookie.indexOf('=') + 1, cookie.length - cookie.indexOf('=') + 1));

	}
	else { return ''; }
}

/*
 * ���ڿ� str���� index ��°�� �ִ� ���ڿ��� ���Ѵ�.
 * index ���� 1���� ������
*/

function getStrByIndex(str, index, del)
{

	var str1 = '';
	/* str�� ���ڿ� object�� �ƴ� ��쿡�� ���ڿ� object�� ����� ���ؼ� */
	str1 += str;
	var idx1 = str1.indexOf(del);
	var val;
	for(var i=1; (idx1 >= 0); i++)
	{
		if(i == index) return (str1.substring(0,idx1));
		else
		{
			str1 = str1.substring(idx1 + del.length);
			idx1 = str1.indexOf(del);
		}
	}
	if(i == index) return str1;
	return '';
}


