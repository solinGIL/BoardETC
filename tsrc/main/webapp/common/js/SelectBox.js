
function deptSel(f)
{

    var option_array = new Array(9);

    //�⺻����
    option_array[0] = new Array("--�� ����--");

    //��ȹ������
    option_array[1] = new Array("--�� ����--", "��ȹ���������", "��ȭ����������", "������Ŵ�����");

    //�ѹ���
    option_array[2] = new Array("--�� ����--", "�ѹ���","�ֹ���ġ��", "ȸ���", "�ο������");

    //���� ���籹
   option_array[3] = new Array("--�� ����--","������","����������","�󸲰�","������");

   //ȯ�溹����
    option_array[4] = new Array("--�� ����--", "��ȸ������", "����û�ҳ��", "ȯ��������", "û��������", "�������", "�ϼ�����");

    //�Ǽ����뱹
    option_array[5] = new Array("--�� ����--","���ð�ȹ��","�Ǽ���","���ΰ�","����������","���ð�");

    //���ӱ��
    option_array[6] = new Array("--�� ����--","���ǰ�����","����������");

    //�����
    option_array[7] = new Array("--����� ����--", "ȯ������", "ü���ü������繫��", "�淮��ö�Ǽ������", "����������");

    //���繫��
    option_array[8] = new Array("--���繫�� ����--","������1�� �繫��","������2���繫��","������3���繫��","ȣ��1���繫��","ȣ��2���繫��", "��ϵ�","�Ű�1���繫��","�Ű�2���繫��","�ۻ�1���繫��","�ۻ�2���繫��","�ڱݵ��繫��", "����1���繫��", "����2���繫��", "����3���繫��", "��絿�繫��");

     var selIndex = f.SELDEPT1.selectedIndex;

        for (loop = f.SELDEPT2.options.length-1; loop > 0; loop--)
        {
            f.SELDEPT2.options[loop] = null;
        }

        for (loop = 0; loop < option_array[selIndex].length; loop++)
        {
            f.SELDEPT2.options[loop] = new Option(option_array[selIndex][loop]);
        }
        f.SELDEPT2.selectedIndex = 0;
}

