/**
* #PGM_NAME		OrgUtil.js <BR>
* #DESC			���������� �ڹٽ�ũ��Ʈ<BR>
*
* @ author		hjpark
**********************************************************************************************
* @							Modification   Log
* @     DATE				AUTHOR				DESCRIPTION
* @   2003.05.09			hjpark				���� �ۼ�
**********************************************************************************************
*/

/********************************************************/
/*	$1. ������ ����â ����
/********************************************************/
/* $1-1
 * ��� : ������ ��åâ�� ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - type: �μ� �Ǵ� ����� ���� ���� 
 *			('1': �μ� one, '2': �μ� more, '3': ����� one, '4': ����� more, '5': �μ��� ��� more, '6': �μ� �Ǵ� ��� one)
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgView(form, name, id, type, key){
	var x = new Date();
	str = 'InputOrgValues = document.' + form + '.' + name;
	eval(str);
	str = 'InputOrgIDs = document.' + form + '.' + id;
	eval(str);
	vOrgView = window.open('/jsp/org/assign/OVInitFrame.jsp?MET=org.OVInitFrame&APP=MAIL&OSV=T&K='+key+'&GRP=F&TYP='+type+'&RETIDCTRL=InputOrgIDs&x='+x.getTime(),'OrgView','width=520,height=550,resizable=yes,menubar=no,left=240,top=50');
	vOrgView.focus();
}

/* $1-2
 * ��� : ������ ��åâ�� ���� - �μ� one ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewDeptOne(form, name, id,  key){
	OrgView(form, name, id, '1', key);
}

/* $1-3
 * ��� : ������ ��åâ�� ���� - �μ� more ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewDeptMore(form, name, id,  key){
	OrgView(form, name, id, '2', key);
}

/* $1-4
 * ��� : ������ ��åâ�� ���� - ����� one ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewUserOne(form, name, id,  key){
	OrgView(form, name, id, '3', key);
}

/* $1-5
 * ��� : ������ ��åâ�� ���� - ����� more ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewUserMore(form, name, id,  key){
	OrgView(form, name, id, '4', key);
}

/* $1-6
 * ��� : ������ ��åâ�� ���� - �μ��� ����� more ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewDeptUserMore(form, name, id,  key){
	OrgView(form, name, id, '5', key);
}

/* $1-7
 * ��� : ������ ��åâ�� ���� - �μ� �Ǵ� ��� one ����
 * �Ķ����
 *   - form: form �̸�
 *   - name: �μ����� �Էµ� �ʵ��
 *   - id: �μ� id�� �Էµ� �ʵ��
 *   - key: K ��
 */
function OrgViewDeptUserOne(form, name, id,  key){
	OrgView(form, name, id, '6', key);
}


/********************************************************/
/*	$2. ������ �������� ����
/********************************************************/
/* $2-1
 * ��� : ��������� �󼼺��� �˾�â�� ����.
 * �Ķ����
 *   - szUserID: ����� ID
 *   - key: K ��
 */
function  ShowUserInfo(szUserID, key)
{
    window.open('/servlet/HIServlet?SLET=OrgMenuView&K='+key+'&MET=UD&WIN=1&UID=' + szUserID + '&__RANDOM=' + (new Date()).getTime(), 'UserDetailInfo', 'left=6000,top=2000,width=10,height=10,menubar=no,resizable=yes,scrollbars=yes');
}

/* $2-2
 * ��� : �μ����� �󼼺��� �˾�â�� ����.
 * �Ķ����
 *   - deptID: �μ� ID
 *   - key: K ��
 */
function ShowDeptInfo(deptID, key)
{
    window.open('/servlet/HIServlet?SLET=OrgMenuView&K='+key+'&MET=DD&WIN=1&DID='+deptID+'&__RANDOM=' + (new Date()).getTime(), 'DeptDetailInfo', 'left=6000,top=2000,width=10,height=10,menubar=no,resizable=yes,scrollbars=yes');
}