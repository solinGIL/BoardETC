/**
* #PGM_NAME        Magic.js (/ams/common/js/Magic.js)
* #DESC            ������ ó��
*
* @ author         �̿�ȸ
**********************************************************************************************
* @                     Modification   Log
* @     DATE                AUTHOR                DESCRIPTION
* @   2003.05.27            �̿�ȸ                ���� �ۼ�
**********************************************************************************************
*/
var backupStep=0;
var returnStep=0;

//�ܰ� �ʱ�ȭ�� �����ϸ� MagicTop���� onload�ÿ� �����Ͽ� �ܰ谪�� �Է��Ѵ�.
function init(currStep)
{
    parent.moveTo(0, 0);

    FrmTop.statusImgURL=statusImgURL;
    FrmTop.commentArr1=commentArr1;
    FrmTop.commentArr2=commentArr2;
    FrmTop.init(currStep);

    step=(--currStep);
    next();
}

//������ �� �ܰ踦 �����Ѵ�.
function setNextStep(nStep)
{
    step=nStep-1;
}

//�ڷ� �� �ܰ踦 �����Ѵ�.
function setPrevStep(nStep)
{
    step=nStep+1;
}

//�ܰ踦 �����Ͽ� �������� ���� ������ �ܰ�� �̵��Ѵ�.
function newStep(nStep)
{
    if(returnStep==0)
    {
        backupStep=nStep;
        returnStep=step;
    }
    step=nStep-1;
}

//���� �ܰ�� ���ư���.
function prev(bPrevCheck)
{
    if(bPrevCheck==null) bPrevCheck=true;
    if(bPrevCheck && FrmBody.location!='about:blank')
        //�����ܰ�� �Ѿ�� �Ǵ��� ��ȿ�� �˻縦 �� �۾��������� �ο��Ѵ�.
        if(!FrmBody.prevPage()) return;

    //alert('backupStep : '+backupStep+'\nreturnStep : '+returnStep+'\nstep : '+step);
    if(backupStep==step)
    {
        step=returnStep-1;
        next(false);
        returnStep=0;
        return;
    }

    if(step<2) return;

    topInit(--step);

    //���� Body ���� �۾� ������ ó���Ѵ�.
    FrmBody.location.href=ancStep[step-1]+getParam();

    if(step==1) footImg('FootPrevBtn', 'none');
    else footImg('FootPrevBtn', '');
    if(!footImg('FootNextBtn', '')) footImg('FootNextBtn', '');
}

//���� �ܰ�� ���ư���.
function next(bNextCheck)
{
    if(bNextCheck==null) bNextCheck=true;
    if(bNextCheck && FrmBody.location!='about:blank')
        //�����ܰ�� �Ѿ�� �Ǵ��� ��ȿ�� �˻縦 �� �۾��������� �ο��Ѵ�.
        if(!FrmBody.nextPage()) return;

    //alert('backupStep : '+backupStep+'\nreturnStep : '+returnStep+'\nstep : '+step);

    step++;

    if(ancStep.length<step || ancStep[step-1]=='')
    {
        alert(step+' �ܰ��� �۾��� �غ�Ǿ� ���� �ʽ��ϴ�.');
        prev();
        return;
    }

    topInit(step);

    //���� Body ���� �۾� ������ ó���Ѵ�.
    FrmBody.location.href=ancStep[step-1]+getParam();

    footImg('FootPrevBtn', 'none');
    if((step-1)>=1) footImg('FootPrevBtn', '');

    if(endStep==step)
        if(!footImg('FootNextBtn', 'none')) footImg('FootNextBtn', 'none');
}

//�����縦 �����Ѵ�.
function exit()
{
    if(!confirm('�����縦 �����Ͻðڽ��ϱ�?')) return;
    parent.close();
}



//��ܳ������ �ʱ�ȭ �Ѵ�.
function topInit(newStep)
{
    FrmTop.init(newStep);
}

//�ϴ��� ����, ���� �̹����� �����Ѵ�.
function footImg(imgName, visible)
{
    var obj=FrmFoot.document.all(imgName);
    if(obj!=null) obj.style.display=visible;
    else return false;
    return true;
}