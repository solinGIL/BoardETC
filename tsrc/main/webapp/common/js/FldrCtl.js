/**
* #PGM_NAME        FldrCtl.js (/ams/common/js/FldrCtl.js)
* #DESC            �޴��� ������ ��Ӵٿ� �������� ó���Ͽ� �ش�.
*
* @ author         �̿�ȸ
**********************************************************************************************
* @                     Modification   Log
* @     DATE                AUTHOR                DESCRIPTION
* @   2003.05.27            �̿�ȸ                ���� �ۼ�
**********************************************************************************************
*/

var backFldrObj=null;
function toggleFolder(imgObj, runFunc, fldrId){
    imgConv(imgObj);

    eval(runFunc);

    if(backFldrObj!=null) backFldrObj.style.display='none';
    if(fldrId=='') return;

    var fldrObj=document.all(fldrId);

    fldrObj.style.display='';

    backFldrObj=fldrObj;
}


var backImg=null;
function imgConv(img){
    if(backImg!=null)
        backImg.src=getImgSrc(backImg);

    backImg=img;
    img.src=getImgSrc(img);
}

//var imgOn='On', imgOff='';
function getImgSrc(img){
    var fn=(img.src).split('.');
    var pos=fn.length-2;
    var newSrc='';

    if(fn[pos].substring(fn[pos].length-imgOn.length, fn[pos].length)==imgOn){
        fn[pos]=fn[pos].substring(0, fn[pos].length-imgOn.length);
        fn[pos]+=imgOff;
    }else if(fn[pos].substring(fn[pos].length-imgOff.length, fn[pos].length)==imgOff){
        fn[pos]=fn[pos].substring(0, fn[pos].length-imgOff.length);
        fn[pos]+=imgOn;
    }

    for(i=0; i<fn.length; i++)
        if(i!=(fn.length-1)) newSrc+=fn[i]+'.';
        else newSrc+=fn[i];

    return newSrc;
}
