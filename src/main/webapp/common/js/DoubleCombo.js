/**
* #PGM_NAME        DoubleCombo.js (/condo/common/js/DoubleCombo.js)
* #DESC                �̿��ܵ��� ����/ü�� ������ �����ϸ� �ش� �����ܵ��� Select�ȴ�.
*
* @ author         ������
**********************************************************************************************
* @                     Modification   Log
* @     DATE                AUTHOR                DESCRIPTION
* @   2004.11.10            ������                ���� �ۼ�
**********************************************************************************************
*/

function lowTypeSelect(f)
{

    var option_array = new Array(16);
    option_array[0] = new Array("--��з� ����--");

    // �� �� ���
    option_array[1] = new Array("-- �Һз�|�ڵ� --","��Ÿ���νü�|1031","����ǥ����|1041","�°�������|1061","��ȣ������|1071","�����Ÿ�ü�|1081","�ſ�����|1111","������⹰|1121","���������|1151","�ϼ�������|1152","������Ÿ|1211","��Ÿ�μ�|1271");

    // ��Ÿ���
    option_array[2] = new Array("-- �Һз�|�ڵ� --","��������|3011","�ε�����|3021","���������|3023","��輮����|3025","��Ÿ���νü�|3031","����ü�����|3081", "���������|3101","����̴��Ÿ|3251");


    // ����
    option_array[3] = new Array("-- �Һз�|�ڵ� --","��������|2011","�ε�����|2021","���������|2023","��輮����|2025","��Ÿ���νü�|2031","���������|2101");

    // ����
    option_array[4] = new Array("-- �Һз�|�ڵ� --","��������|2012","�ε�����|2022","���������|2024","��輮����|2026","��Ÿ���νü�|2032","��ǰ��ġ|2091","���������|2102","��Ȧ����|2141","��õ�ü�����|2142","�����ü�|2181","�����ͽü�|2191","���νü�|2201","��Ÿ����|2211","��ȭ&ǥ��������|2212");
    
    // ����
    option_array[5] = new Array("-- �Һз�|�ڵ� --","������ǥ����|2051","��Ÿ����ü�|2082","��ġ������|2241");

    // ��ȯ
    option_array[6] = new Array("-- �Һз�|�ڵ� --","�ſ�����|2111");

    // ����
    option_array[7] = new Array("-- �Һз�|�ڵ� --","��ġ�������|2131","����̴��Ÿ|2251","��������|2262");

    // ����
    option_array[8] = new Array("-- �Һз�|�ڵ� --","������|2221","������|2231");

    //��    
    option_array[9] = new Array("-- �Һз�|�ڵ� --","��Ÿ�μ�|2271");

    //����
    option_array[10] = new Array("?","��������|3011","�ε�����|3021","���������|3023","��輮����|3025","��Ÿ���νü�|3031","����ü�����|3081","���������|3101","����̴��Ÿ|3251");

    // ����
    option_array[11] = new Array("-- �Һз�|�ڵ� --","��������|3012","�ε�����|3022","���������|3024","��輮����|3026","��Ÿ���νü�|3032","��ǰ��ġ|3091","���������|3102","��Ȧ����|3141","��Ȧ��ġ|3142");

    // ����
    option_array[12] = new Array("-- �Һз�|�ڵ� --","������ǥ����|3051","��Ÿ����ü�|3082","��ġ������|3241");

    // ����
    option_array[13] = new Array("-- �Һз�|�ڵ� --","�����ü�|3181","�����ͽü�|3191","���νü�|3201","��Ÿ����|3211","������|3221","������|3231","���κ���|3233","�������Ա�Ÿ|3261");

    // ����
    option_array[14] = new Array("-- �Һз�|�ڵ� --","��ġ�������|3131","������|3222","������|3232","��������|3262");

    // ��ȯ
    option_array[15] = new Array("-- �Һз�|�ڵ� --","�ſ�����|3111");

    var frstSel = f.szHighType.selectedIndex;    //�ܵ�����
    var areaSel = 0;                                            //���õ� �����ܵ�.
    for (loop = f.szLowType.options.length-1; loop > 0; loop--)
    {
        f.szLowType.options[loop] = null;
    }

    if(frstSel == 0){areaSel = 0;}
    else if(frstSel == 1 ){areaSel = 1;}
    else if(frstSel == 2 ){areaSel = 2;}
    else if(frstSel == 3 ){areaSel = 3;}
    else if(frstSel == 4 ){areaSel = 4;}
    else if(frstSel == 5 ){areaSel = 5;}
    else if(frstSel == 6 ){areaSel = 6;}
    else if(frstSel == 7 ){areaSel = 7;}
    else if(frstSel == 8 ){areaSel = 8;}
    else if(frstSel == 9 ){areaSel = 9;}
    else if(frstSel == 10 ){areaSel = 10;}
    else if(frstSel == 11 ){areaSel = 11;}
    else if(frstSel == 12 ){areaSel = 12;}
    else if(frstSel == 13 ){areaSel = 13;}
    else if(frstSel == 14 ){areaSel = 14;}
    else if(frstSel == 15 ){areaSel = 15;}
    else if(frstSel == 16 ){areaSel = 16;}


    for (loop = 0; loop < option_array[areaSel].length; loop++)
    {
        f.szLowType.options[loop] = new Option(option_array[areaSel][loop]);
    }
    f.szLowType.selectedIndex = 0;
}    


