//Cookies ��Ʈ��
//��Ű�� 2���� �迭�̻��� �������� �ʴ´�.(�ְ� 2���� �迭)

function Cookies_Control(){
	
	this.name = "Cookies_Control";
	
	//��з��� ã��
	this.Ext_LSeq_Cookies = function(){
	
		var SeqOfCookies, Cookies_Seq;
		var Cookies_Arr;
		var x;
		
		Cookies_Seq = arguments[0];
		SeqOfCookies = Cookies_Seq + "=";
		
		//��Ű�� ����
			Cookies_Arr = document.cookie.split(";");
			x = 0;
			for(i=0;i<Cookies_Arr.length;i++){
				//������ ��з��� ��Ű���� �ִ� ���
				if((Cookies_Arr[i]).indexOf(SeqOfCookies) != -1){
					x++;
					
					//��з��� ���� �����ִ� �ߺз� ��Ű����(&�� ��������������)
					return (Cookies_Arr[i].substring(Cookies_Arr[i].indexOf("=")+1,Cookies_Arr[i].length));
					break;
				}
			}
			if(x == 0){
				return "";
			}
	};
	
	//�ߺз��� ã��
	this.Ext_MSeq_Cookies = function(){			
		var Cookies_Split;
		var Cookies_Value, C_Val, C_Name;
		var x;
		var offSet_Cookies;
		
		offSet_Cookies = this.Ext_LSeq_Cookies(arguments[0])
		if(offSet_Cookies != ""){
			if(offSet_Cookies.indexOf("&") != -1){
				//2���� ��Ű
				Cookies_Split = offSet_Cookies.split("&");
				
				x = 0;
				for(i=0;i<Cookies_Split.length;i++){
					Cookies_Value = Cookies_Split[i].split("=")
					C_Val = Cookies_Value[0]
					C_Name = Cookies_Value[1]
					if(C_Val == arguments[1]){
						x = x + 1
						return C_Name;
					}
				}
				
				if(x == 0){
					return "";
				}
			}
			else{
				if(offSet_Cookies.indexOf("=") != -1){
					//2���� ��Ű(�Ѱ������ &�� ����)
					Cookies_Split = offSet_Cookies.split("=")
					if(Cookies_Split[0] == arguments[1]){
						return Cookies_Split[1];
					}
					else{
						return "";
					}
				}
				else{
					//1���� ��Ű
					return offSet_Cookies;
				}
				
			}
		}
		else{
			return "";
		}
		
	};
	
	//��Ű�� ����, ���� �� ����(��з���, �ߺз���, �ߺз���, ����ð� - ��з����� ������ 1���� ��Ű) 
	this.Create_Cookies = function(){
		var L_Seq, M_Seq, Value, Expire;
		var Exp_Day, vExp_Date, C_Val, C_Val_M
		var Spt_Arr, Spt_Spt_Arr, Spt_Check_Cook
		Check_Cook = ""
		Spt_Check_Cook = ""
		
		L_Seq = arguments[0];
		M_Seq = arguments[1];
		Value = arguments[2];
		Expire = arguments[3];
		
		vExp_Date = "";
		//���� �ð� ����
		if(Expire != ""){
			Exp_Day = new Date();

			Exp_Day.getDate(Exp_Day.getDate() + (Expire));
			vExp_Date = Exp_Day.toGMTString();
		}
		
		if(M_Seq == ""){
			C_Val = (Value);
		}
		else{
			//��з��� ���� �����Ѵ�
			Check_Cook = this.Ext_LSeq_Cookies(L_Seq);
			
			if(Check_Cook != ""){
			//��з��� ���� �����ϴ� ���
				//����� ���� unescape�� ���̹Ƿ� �ٽ� Ǯ� escape���ش�
				Spt_Check_Cook = "";
				if(Check_Cook.indexOf("&") == -1){
					//�Ѱ��� ���� ���� ���
					Spt_Arr = Check_Cook.split("=");
					Spt_Check_Cook = Spt_Arr[0] + "=" + (Spt_Arr[1]);
					
				}
				else{
					//2���̻��� ���� ���
					Spt_Arr = Check_Cook.split("&");
					for(i=0;i<Spt_Arr.length;i++){
						Spt_Spt_Arr = Spt_Arr[i].split("=");
						Spt_Check_Cook = Spt_Check_Cook + Spt_Spt_Arr[0] + "=" + (Spt_Spt_Arr[1]);
						if(i < Spt_Arr.length - 1 ){
							Spt_Check_Cook = Spt_Check_Cook + "&"
						}
					}
				}
				
				C_Val_M = this.Ext_MSeq_Cookies(L_Seq, M_Seq)
				//�ߺз��� ���� �����ϴ� ���
				if(C_Val_M != ""){
					C_Val = Spt_Check_Cook.replace(M_Seq + "=" + (C_Val_M), M_Seq + "=" + (Value));
				}
				else{
					C_Val = Spt_Check_Cook + "&" + M_Seq + "=" + (Value);
				}
			}
			else{
				//��з��� ���� ���� ���(ó�� ����)
				C_Val = M_Seq + "=" + (Value);
			}
		}
		document.cookie = L_Seq + "=" + C_Val + "; expires=" + vExp_Date;
	};
}
