(*Функция чтения уставок дискретных входных каналов *)
IF (number > 0 AND number < 33) THEN 
	//num_m := M1; // модуль в порядке расположения	
	BuffInt := GVL|REG_5004; //GVL.DI_All_MBinv[1] := gMDB.GetWord(MbADDR.REG_5004);  
ELSIF (number > 32) THEN // 32 кол-во каналов в одном модуле	
	//num_m := M2;
	BuffInt := GVL|REG_5006;//GVL.DI_All_MBinv[2] := gMDB.GetWord(MbADDR.REG_5004 + 1); 
END_IF;

IF (number > 0) THEN
  CASE number OF
    // -------- MODULE 1 (1..32) --------
    1:  BuffBool := DiM1_551D.CH_01;
    2:  BuffBool := DiM1_551D.CH_02;
    3:  BuffBool := DiM1_551D.CH_03;
    4:  BuffBool := DiM1_551D.CH_04;
    5:  BuffBool := DiM1_551D.CH_05;
    6:  BuffBool := DiM1_551D.CH_06;
    7:  BuffBool := DiM1_551D.CH_07;
    8:  BuffBool := DiM1_551D.CH_08;
    9:  BuffBool := DiM1_551D.CH_09;
    10: BuffBool := DiM1_551D.CH_10;
    11: BuffBool := DiM1_551D.CH_11;
    12: BuffBool := DiM1_551D.CH_12;
    13: BuffBool := DiM1_551D.CH_13;
    14: BuffBool := DiM1_551D.CH_14;
    15: BuffBool := DiM1_551D.CH_15;
    16: BuffBool := DiM1_551D.CH_16;
    17: BuffBool := DiM1_551D.CH_17;
    18: BuffBool := DiM1_551D.CH_18;
    19: BuffBool := DiM1_551D.CH_19;
    20: BuffBool := DiM1_551D.CH_20;
    21: BuffBool := DiM1_551D.CH_21;
    22: BuffBool := DiM1_551D.CH_22;
    23: BuffBool := DiM1_551D.CH_23;
    24: BuffBool := DiM1_551D.CH_24;
    25: BuffBool := DiM1_551D.CH_25;
    26: BuffBool := DiM1_551D.CH_26;
    27: BuffBool := DiM1_551D.CH_27;
    28: BuffBool := DiM1_551D.CH_28;
    29: BuffBool := DiM1_551D.CH_29;
    30: BuffBool := DiM1_551D.CH_30;
    31: BuffBool := DiM1_551D.CH_31;
    32: BuffBool := DiM1_551D.CH_32;

    // -------- MODULE 2 (33..64) --------
    33: BuffBool := DiM2_551D.CH_01;
    34: BuffBool := DiM2_551D.CH_02;
    35: BuffBool := DiM2_551D.CH_03;
    36: BuffBool := DiM2_551D.CH_04;
    37: BuffBool := DiM2_551D.CH_05;
    38: BuffBool := DiM2_551D.CH_06;
    39: BuffBool := DiM2_551D.CH_07;
    40: BuffBool := DiM2_551D.CH_08;
    41: BuffBool := DiM2_551D.CH_09;
    42: BuffBool := DiM2_551D.CH_10;
    43: BuffBool := DiM2_551D.CH_11;
    44: BuffBool := DiM2_551D.CH_12;
    45: BuffBool := DiM2_551D.CH_13;
    46: BuffBool := DiM2_551D.CH_14;
    47: BuffBool := DiM2_551D.CH_15;
    48: BuffBool := DiM2_551D.CH_16;
    49: BuffBool := DiM2_551D.CH_17;
    50: BuffBool := DiM2_551D.CH_18;
    51: BuffBool := DiM2_551D.CH_19;
    52: BuffBool := DiM2_551D.CH_20;
    53: BuffBool := DiM2_551D.CH_21;
    54: BuffBool := DiM2_551D.CH_22;
    55: BuffBool := DiM2_551D.CH_23;
    56: BuffBool := DiM2_551D.CH_24;
    57: BuffBool := DiM2_551D.CH_25;
    58: BuffBool := DiM2_551D.CH_26;
    59: BuffBool := DiM2_551D.CH_27;
    60: BuffBool := DiM2_551D.CH_28;
    61: BuffBool := DiM2_551D.CH_29;
    62: BuffBool := DiM2_551D.CH_30;
    63: BuffBool := DiM2_551D.CH_31;
    64: BuffBool := DiM2_551D.CH_32;
  END_CASE;  
   
  // 32 кол-во каналов в одном модуле	
  IF (BuffBool = TRUE) THEN // если на входе 1
    IF GETBIT(number - 1, BuffInt) THEN // если 1 - инверсия  	 
		DiGet := FALSE; // Di не активен
	ELSE
		DiGet := TRUE;
	END_IF;	
  ELSE // если на входе ноль
	IF GETBIT(number - 1, BuffInt) THEN  
		DiGet := TRUE;
	ELSE
		DiGet := FALSE;
	END_IF;	
  END_IF;
 
END_IF;

 
