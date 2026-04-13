(*Программа по работе с аналоговыми сигналами ПЛК *)
BuffBool := AiM1_555A.Err_stbus; //SYSTEM (34,1);
IF (BuffBool = false) THEN //"0"-есть связь, Связь с модулем Ai1
	Module_status := SETBIT(TRUE, M1, Module_status); 	       // для HMI, поднимаем 0-ой бит в слове GVL|_Ai_status
	GVL|_Status_device := SETBIT(TRUE, 4, GVL|_Status_device); // для ТМ,  поднимаем 4-ый бит в слове GVL|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, M1, Module_status); 	        // для HMI
		GVL|_Status_device := SETBIT(FALSE, 4, GVL|_Status_device); // для ТМ 
END_IF; 

BuffInt := SYSTEM (34,2); 
IF (BuffInt = 0) THEN //"0"-есть связь, Связь с модулем Ai2
	Module_status := SETBIT(TRUE, M2, Module_status); 	       // для HMI, поднимаем 1-ый бит в слове GVL|_Ai_status
	GVL|_Status_device := SETBIT(TRUE, 5, GVL|_Status_device); // для ТМ,  поднимаем 5-ый бит в слове GVL|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, M2, Module_status); 	          // для HMI
		GVL|_Status_device := SETBIT(FALSE, 5, GVL|_Status_device);   // для ТМ 
END_IF; 

BuffInt := SYSTEM (34,3); 
IF (BuffInt = 0) THEN //"0"-есть связь, Связь с модулем Ai3
	Module_status := SETBIT(TRUE, M3, Module_status); 	       // для HMI, поднимаем 2-ой бит в слове GVL|_Ai_status
	GVL|_Status_device := SETBIT(TRUE, 6, GVL|_Status_device); // для ТМ,  поднимаем 6-ой бит в слове GVL|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, M3, Module_status); 	          // для HMI
		GVL|_Status_device := SETBIT(FALSE, 6, GVL|_Status_device);   // для ТМ 
END_IF;  

// Аналоговый вход, чтение уставок и пересчёт тока в значение! Статусы Аи. 
FOR i := 1 TO GVL_QUANTITY_AI_CH DO   
 channel := i;
 CASE GVL_Ai|ch_change[channel] OF
	 1: Ai_current[channel] := AiM1_555A.CH_01;
	 2: Ai_current[channel] := AiM1_555A.CH_02;
	 3: Ai_current[channel] := AiM1_555A.CH_03;
	 4: Ai_current[channel] := AiM1_555A.CH_04;
	 5: Ai_current[channel] := AiM1_555A.CH_05;
	 6: Ai_current[channel] := AiM1_555A.CH_06;
	 7: Ai_current[channel] := AiM1_555A.CH_07;
	 8: Ai_current[channel] := AiM1_555A.CH_08;
	 9: Ai_current[channel] := AiM1_555A.CH_09;
	10: Ai_current[channel] := AiM1_555A.CH_10;
	11: Ai_current[channel] := AiM1_555A.CH_11;
	12: Ai_current[channel] := AiM1_555A.CH_12;
	13: Ai_current[channel] := AiM1_555A.CH_13;
	14: Ai_current[channel] := AiM1_555A.CH_14;
	15: Ai_current[channel] := AiM1_555A.CH_15;
	16: Ai_current[channel] := AiM1_555A.CH_16;
	17: Ai_current[channel] := AiM1_555A.CH_17;
	18: Ai_current[channel] := AiM1_555A.CH_18;
	19: Ai_current[channel] := AiM1_555A.CH_19;
	20: Ai_current[channel] := AiM1_555A.CH_20;
	21: Ai_current[channel] := AiM1_555A.CH_21;
	22: Ai_current[channel] := AiM1_555A.CH_22;
	23: Ai_current[channel] := AiM1_555A.CH_23;
	24: Ai_current[channel] := AiM1_555A.CH_24;
	25: Ai_current[channel] := AiM1_555A.CH_25;
	26: Ai_current[channel] := AiM1_555A.CH_26;
	27: Ai_current[channel] := AiM1_555A.CH_27;
	28: Ai_current[channel] := AiM1_555A.CH_28;
	29: Ai_current[channel] := AiM1_555A.CH_29;
	30: Ai_current[channel] := AiM1_555A.CH_30;
	31: Ai_current[channel] := AiM1_555A.CH_31;
	32: Ai_current[channel] := AiM1_555A.CH_32;

	33: Ai_current[channel] := AiM2_555A.CH_01;
	34: Ai_current[channel] := AiM2_555A.CH_02;
	35: Ai_current[channel] := AiM2_555A.CH_03;
	36: Ai_current[channel] := AiM2_555A.CH_04;
	37: Ai_current[channel] := AiM2_555A.CH_05;
	38: Ai_current[channel] := AiM2_555A.CH_06;
	39: Ai_current[channel] := AiM2_555A.CH_07;
	40: Ai_current[channel] := AiM2_555A.CH_08;
	41: Ai_current[channel] := AiM2_555A.CH_09;
	42: Ai_current[channel] := AiM2_555A.CH_10;
	43: Ai_current[channel] := AiM2_555A.CH_11;
	44: Ai_current[channel] := AiM2_555A.CH_12;
	45: Ai_current[channel] := AiM2_555A.CH_13;
	46: Ai_current[channel] := AiM2_555A.CH_14;
	47: Ai_current[channel] := AiM2_555A.CH_15;
	48: Ai_current[channel] := AiM2_555A.CH_16;
	49: Ai_current[channel] := AiM2_555A.CH_17;
	50: Ai_current[channel] := AiM2_555A.CH_18;
	51: Ai_current[channel] := AiM2_555A.CH_19;
	52: Ai_current[channel] := AiM2_555A.CH_20;
	53: Ai_current[channel] := AiM2_555A.CH_21;
	54: Ai_current[channel] := AiM2_555A.CH_22;
	55: Ai_current[channel] := AiM2_555A.CH_23;
	56: Ai_current[channel] := AiM2_555A.CH_24;
	57: Ai_current[channel] := AiM2_555A.CH_25;
	58: Ai_current[channel] := AiM2_555A.CH_26;
	59: Ai_current[channel] := AiM2_555A.CH_27;
	60: Ai_current[channel] := AiM2_555A.CH_28;
	61: Ai_current[channel] := AiM2_555A.CH_29;
	62: Ai_current[channel] := AiM2_555A.CH_30;
	63: Ai_current[channel] := AiM2_555A.CH_31;
	64: Ai_current[channel] := AiM2_555A.CH_32;

	65: Ai_current[channel] := AiM3_555A.CH_01;
	66: Ai_current[channel] := AiM3_555A.CH_02;
	67: Ai_current[channel] := AiM3_555A.CH_03;
	68: Ai_current[channel] := AiM3_555A.CH_04;
	69: Ai_current[channel] := AiM3_555A.CH_05;
	70: Ai_current[channel] := AiM3_555A.CH_06;
	71: Ai_current[channel] := AiM3_555A.CH_07;
	72: Ai_current[channel] := AiM3_555A.CH_08;
	73: Ai_current[channel] := AiM3_555A.CH_09;
	74: Ai_current[channel] := AiM3_555A.CH_10;
	75: Ai_current[channel] := AiM3_555A.CH_11;
	76: Ai_current[channel] := AiM3_555A.CH_12;
	77: Ai_current[channel] := AiM3_555A.CH_13;
	78: Ai_current[channel] := AiM3_555A.CH_14;
	79: Ai_current[channel] := AiM3_555A.CH_15;
	80: Ai_current[channel] := AiM3_555A.CH_16;
	81: Ai_current[channel] := AiM3_555A.CH_17;
	82: Ai_current[channel] := AiM3_555A.CH_18;
	83: Ai_current[channel] := AiM3_555A.CH_19;
	84: Ai_current[channel] := AiM3_555A.CH_20;
	85: Ai_current[channel] := AiM3_555A.CH_21;
	86: Ai_current[channel] := AiM3_555A.CH_22;
	87: Ai_current[channel] := AiM3_555A.CH_23;
	88: Ai_current[channel] := AiM3_555A.CH_24;
	89: Ai_current[channel] := AiM3_555A.CH_25;
	90: Ai_current[channel] := AiM3_555A.CH_26;
	91: Ai_current[channel] := AiM3_555A.CH_27;
	92: Ai_current[channel] := AiM3_555A.CH_28;
	93: Ai_current[channel] := AiM3_555A.CH_29;
	94: Ai_current[channel] := AiM3_555A.CH_30;
	95: Ai_current[channel] := AiM3_555A.CH_31;
	96: Ai_current[channel] := AiM3_555A.CH_32;	 
 END_CASE;	
  
 IF (GVL_Ai|ch_change[channel]  > 0) THEN
  	// пересчет тока 4-20 мА в инженерную величину 
  	IF (Ai_current[channel] < 0.0) THEN
  	  	Ai_current[channel] := 0.0;
 	END_IF;
  	IF (GVL_Ai|masking[channel] <> 1) THEN
    	Ai_value[channel] := ((Ai_current[channel] - 4.0) * (GVL_Ai|HEm[channel] - GVL_Ai|LEm[channel])) / (20.0 - 4.0) + GVL_Ai|LEm[channel];
  	ELSE
    	Ai_value[channel] := GVL_Ai|masking_value[channel];
  	END_IF;
 
  	GVL_Ai|State[channel] := AI_ST_OK;
  	IF (Ai_value[channel] > GVL_Ai|H[channel]) THEN
      	GVL_Ai|State[channel] := AI_ST_H;
  	END_IF;
  	IF (Ai_value[channel] > GVL_Ai|HH[channel]) THEN
      	GVL_Ai|State[channel] := AI_ST_HH;
  	END_IF;
  	IF (Ai_value[channel] < GVL_Ai|L[channel]) THEN
        GVL_Ai|State[channel] := AI_ST_L;
  	END_IF;
  	IF (Ai_value[channel] < GVL_Ai|LL[channel]) THEN
      	GVL_Ai|State[channel] := AI_ST_LL;
  	END_IF;
  	// 3.6 и 21.0 это min,max значения тока, при которых будет отображена авария канала
  	IF (Ai_current[channel] < 3.6 AND GVL_Ai|masking[channel] <> 1) THEN
      	GVL_Ai|State[channel] := AI_ST_ERR;
  	END_IF;
  	IF (Ai_current[channel] > 21.0 AND GVL_Ai|masking[channel] <> 1) THEN
      	GVL_Ai|State[channel] := AI_ST_ERR;
  	END_IF;
	
	IF (GVL_Ai|State[channel] = AI_ST_ERR) THEN	// для HMI помимо общего статуса AiState[ch], отдельный флаг мигающей индикации
		IF (channel > 0 AND channel < 33) THEN	
            Bits := channel - 1;		 
			Ai_Fault1 :=  SETBIT(TRUE, Bits, Ai_Fault1);	
		END_IF;
		
		IF (channel > 32) THEN
            Bits := channel - 33;			
			Ai_Fault2 :=  SETBIT(TRUE, Bits, Ai_Fault2);
		END_IF;	
    ELSE 
        IF (channel > 0 AND channel < 33) THEN	
		    Bits := channel - 1;		 
			Ai_Fault1 :=  SETBIT(FALSE, Bits, Ai_Fault1);
		END_IF;	
        IF (channel > 32) THEN
		    Bits := channel - 33;			 
			Ai_Fault2 :=  SETBIT(FALSE, Bits, Ai_Fault2);
		END_IF;			
	END_IF;	
 ELSE
    Ai_value[channel] := 0.0;
    GVL_Ai|State[channel] := AI_ST_UNK;
 END_IF;
  
 CASE channel OF
	 4: IF (GVL_Ai|State[channel] = AI_ST_ERR) THEN Valve1_pos:= 333.0; ELSE Valve1_pos:= Ai_value[channel]; END_IF;   
	 8: IF (GVL_Ai|State[channel] = AI_ST_ERR) THEN Valve2_pos:= 333.0; ELSE Valve2_pos:= Ai_value[channel]; END_IF;
	//10: GVL.P_OUT_P1  := Ai_value[channel]; GVL.SET_P_OUT_P1 := GVL.Ai.H[channel]; 
	//16: GVL.GAS1_conc := Ai_value[channel]; GVL.G1_Level_1_set := GVL.Ai.H[channel]; GVL.G1_Level_2_set := GVL.Ai.HH[channel];  
    //18: GVL.P_OUT_P2  := Ai_value[channel]; GVL.SET_P_OUT_P2 := GVL.Ai.H[channel];
    //24: GVL.GAS2_conc := Ai_value[channel]; GVL.G2_Level_1_set := GVL.Ai.H[channel]; GVL.G2_Level_2_set := GVL.Ai.HH[channel];
	//27: GVL.T_BT      := Ai_value[channel];  
 END_CASE;
END_FOR; 

(*/========================= Аналоговый выход =====================/ *)
// Связь с модулем Ao1
BuffBool := AoM1_534V.Err_stbus; //SYSTEM (34,4);
IF (BuffBool = false) THEN //"0"-есть связь, Связь с модулем Ao1
	Module_status := SETBIT(TRUE, Ao_M1, Module_status); 	   // для HMI, поднимаем 0-ой бит в слове GVL|_Ai_status
	GVL|_Status_device := SETBIT(TRUE, 7, GVL|_Status_device); // для ТМ,  поднимаем 7 бит в слове GVL|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, Ao_M1, Module_status); 	    // для HMI
		GVL|_Status_device := SETBIT(FALSE, 7, GVL|_Status_device); // для ТМ 
END_IF; 

BuffInt := SYSTEM (34,5); 
IF (BuffInt = 0) THEN //"0"-есть связь, Связь с модулем Ao2
	Module_status := SETBIT(TRUE, Ao_M2, Module_status); 	   // для HMI, поднимаем 1-ый бит в слове GVL|_Ai_status
	GVL|_Status_device := SETBIT(TRUE, 8, GVL|_Status_device); // для ТМ,  поднимаем 5-ый бит в слове GVL|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, Ao_M2, Module_status); 	      // для HMI
		GVL|_Status_device := SETBIT(FALSE, 8, GVL|_Status_device);   // для ТМ 
END_IF; 
