(*Программа по работе с дискретными сигналами ПЛК*)
BuffBool := DiM1_551D.Err_stbus; //SYSTEM (34,6);
IF (BuffBool = false) THEN //"0"-есть связь, Связь с модулем Ai1
	Module_status := SETBIT(TRUE, M1, Module_status); 	       // для HMI, поднимаем 5-ый бит в слове Module_status
	GVL|_Status_device := SETBIT(TRUE, 9, GVL|_Status_device); // для ТМ,  поднимаем 9 бит в слове TM|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, M1, Module_status); 	        // для HMI
		GVL|_Status_device := SETBIT(FALSE, 9, GVL|_Status_device); // для ТМ 
END_IF; 
BuffBool := DiM2_551D.Err_stbus; //SYSTEM (34,7);
IF (BuffBool = false) THEN //"0"-есть связь, Связь с модулем Ai1
	Module_status := SETBIT(TRUE, M2, Module_status); 	      
	GVL|_Status_device := SETBIT(TRUE, 10, GVL|_Status_device);  
	ELSE 
		Module_status := SETBIT(FALSE, M2, Module_status); 	         // для HMI
		GVL|_Status_device := SETBIT(FALSE, 10, GVL|_Status_device); // для ТМ 
END_IF; 

(*Дискретный вход, чтение уставок *)
FOR i := 1 TO GVL_QUANTITY_DI_CH DO
  CASE i OF
    1:  GVL_DI|_P1_BodyFill_Sect1 := DiGet(i);
    2:  GVL_DI|_P1_BodyFill_Sect2 := DiGet(i);
    3:  GVL_DI|_DRY_RUNNING_ALARM_P1 := DiGet(i);
    4:  GVL_DI|_PUMP1_LOCAL_BUTTON_START := DiGet(i);
    5:  GVL_DI|_PUMP1_LOCAL_BUTTON_STOP := DiGet(i);
    6:  GVL_DI|_P2_BodyFill_Sect1 := DiGet(i);
    7:  GVL_DI|_P2_BodyFill_Sect2 := DiGet(i);
    8:  GVL_DI|_DRY_RUNNING_ALARM_P2 := DiGet(i);
    9:  GVL_DI|_PUMP2_LOCAL_BUTTON_START := DiGet(i);
    10: GVL_DI|_PUMP2_LOCAL_BUTTON_STOP := DiGet(i);
    11: GVL_DI|_Tank100E_Level_UpperAlarm := DiGet(i);
    12: GVL_DI|_PUMP1_ON_WORKING := DiGet(i);
    13: GVL_DI|_SHUN1_FAULT := DiGet(i);
    14: GVL_DI|_PUMP2_ON_WORKING := DiGet(i);
    15: GVL_DI|_SHUN2_FAULT := DiGet(i);
    16: GVL_DI|_POWER_IN1_NORME := DiGet(i);
    17: GVL_DI|_POWER_IN2_NORME := DiGet(i);
    18: GVL_DI|_SECTION_SWITCH_ON := DiGet(i);

    19: GVL_DI2|_VALVE_XV_101_OPENED := DiGet(i);
    20: GVL_DI2|_VALVE_XV_101_CLOSED := DiGet(i);
    21: GVL_DI2|_VALVE_XV_101_FAULT  := DiGet(i);

    22: GVL_DI2|_VALVE_XV_102_OPENED := DiGet(i);
    23: GVL_DI2|_VALVE_XV_102_CLOSED := DiGet(i);
    24: GVL_DI2|_VALVE_XV_102_FAULT  := DiGet(i);

    25: GVL_DI2|_VALVE_XV_103_OPENED := DiGet(i);
    26: GVL_DI2|_VALVE_XV_103_CLOSED := DiGet(i);
    27: GVL_DI2|_VALVE_XV_103_FAULT  := DiGet(i);

    28: GVL_DI2|_VALVE_XV_104_OPENED := DiGet(i);
    29: GVL_DI2|_VALVE_XV_104_CLOSED := DiGet(i);
    30: GVL_DI2|_VALVE_XV_104_FAULT  := DiGet(i);

    31: GVL_DI2|_VALVE_XV_106_OPENED := DiGet(i);
    32: GVL_DI2|_VALVE_XV_106_CLOSED := DiGet(i);
    33: GVL_DI2|_VALVE_XV_106_FAULT  := DiGet(i);

    34: GVL_DI2|_VALVE_XV_107_OPENED := DiGet(i);
    35: GVL_DI2|_VALVE_XV_107_CLOSED := DiGet(i);
    36: GVL_DI2|_VALVE_XV_107_FAULT  := DiGet(i);

    37: GVL_DI2|_VALVE_XV_108_OPENED := DiGet(i);
    38: GVL_DI2|_VALVE_XV_108_CLOSED := DiGet(i);
    39: GVL_DI2|_VALVE_XV_108_FAULT  := DiGet(i);

    40: GVL_DI2|_VALVE_XV_109_OPENED := DiGet(i);
    41: GVL_DI2|_VALVE_XV_109_CLOSED := DiGet(i);
    42: GVL_DI2|_VALVE_XV_109_FAULT  := DiGet(i);

    43: GVL_DI2|_VALVE_PCV101_READY := DiGet(i);
    44: GVL_DI2|_VALVE_PCV101_FAULT := DiGet(i);

    45: GVL_DI2|_VALVE_PCV102_READY := DiGet(i);
    46: GVL_DI2|_VALVE_PCV102_FAULT := DiGet(i);

    47: GVL_DI2|_VALVE_PCV103_READY := DiGet(i);
    48: GVL_DI2|_VALVE_PCV103_FAULT := DiGet(i);

    49: GVL_DI2|_FIRE_FAULT := DiGet(i);
  END_CASE;
END_FOR;

(*/========================= Дискретный выход =====================/ *)
BuffInt := SYSTEM (34,8); //DoM1_552O.Err_stbus; 
IF (BuffInt = 0) THEN //"0"-есть связь, Связь с модулем Ai1
	Module_status := SETBIT(TRUE, Do_M1, Module_status); 	    // для HMI, поднимаем 7-ой бит в слове Module_status
	GVL|_Status_device := SETBIT(TRUE, 11, GVL|_Status_device); // для ТМ,  поднимаем 11-ый бит в слове TM|_Status_device
	ELSE 
		Module_status := SETBIT(FALSE, Do_M1, Module_status); 	     // для HMI
		GVL|_Status_device := SETBIT(FALSE, 11, GVL|_Status_device); // для ТМ 
END_IF; 
BuffInt := SYSTEM (34,9);
IF (BuffInt = 0) THEN //"0"-есть связь, Связь с модулем Ai1
	Module_status := SETBIT(TRUE, Do_M2, Module_status); 	      
	GVL|_Status_device := SETBIT(TRUE, 12, GVL|_Status_device);  
	ELSE 
		Module_status := SETBIT(FALSE, Do_M2, Module_status); 	     // для HMI
		GVL|_Status_device := SETBIT(FALSE, 12, GVL|_Status_device); // для ТМ 
END_IF; 	

(*Дискретный выход, чтение уставок *)
FOR i := 1 TO GVL_QUANTITY_DO_CH DO   
  CASE i OF
    1:  DoM1_552O.Canal_01 := DoGet(i, GVL_DO|_INDICATION_PUMP2);
    2:  DoM1_552O.Canal_02 := DoGet(i, GVL_DO|_INDICATION_PUMP1);
    3:  DoM1_552O.Canal_03 := DoGet(i, GVL_DO|_PUMP1_ON);
    4:  DoM1_552O.Canal_04 := DoGet(i, GVL_DO|_PUMP2_ON);

    5:  DoM1_552O.Canal_05 := DoGet(i, GVL_DO|_VALVE_XV_101_OPEN);
    6:  DoM1_552O.Canal_06 := DoGet(i, GVL_DO|_VALVE_XV_101_CLOSE);

    7:  DoM1_552O.Canal_07 := DoGet(i, GVL_DO|_VALVE_XV_102_OPEN);
    8:  DoM1_552O.Canal_08 := DoGet(i, GVL_DO|_VALVE_XV_102_CLOSE);

    9:  DoM1_552O.Canal_09 := DoGet(i, GVL_DO|_VALVE_XV_103_OPEN);
    10: DoM1_552O.Canal_10 := DoGet(i, GVL_DO|_VALVE_XV_103_CLOSE);

    11: DoM1_552O.Canal_11 := DoGet(i, GVL_DO|_VALVE_XV_104_OPEN);
    12: DoM1_552O.Canal_12 := DoGet(i, GVL_DO|_VALVE_XV_104_CLOSE);

    13: DoM1_552O.Canal_13 := DoGet(i, GVL_DO|_VALVE_XV_106_OPEN);
    14: DoM1_552O.Canal_14 := DoGet(i, GVL_DO|_VALVE_XV_106_CLOSE);

    15: DoM1_552O.Canal_15 := DoGet(i, GVL_DO|_VALVE_XV_107_OPEN);
    16: DoM1_552O.Canal_16 := DoGet(i, GVL_DO|_VALVE_XV_107_CLOSE);

    17: DoM1_552O.Canal_17 := DoGet(i, GVL_DO|_VALVE_XV_108_OPEN);
    18: DoM1_552O.Canal_18 := DoGet(i, GVL_DO|_VALVE_XV_108_CLOSE);

    19: DoM1_552O.Canal_19 := DoGet(i, GVL_DO|_VALVE_XV_109_OPEN);
    20: DoM1_552O.Canal_20 := DoGet(i, GVL_DO|_VALVE_XV_109_CLOSE);

    (* Второй моудль DO *)

    21: DoM2_552O.Canal_01 := DoGet(i, GVL_DO2|_VALVE_XV_101_OPEN);
    22: DoM2_552O.Canal_02 := DoGet(i, GVL_DO2|_VALVE_XV_101_CLOSE);

    23: DoM2_552O.Canal_03 := DoGet(i, GVL_DO2|_VALVE_XV_102_OPEN);
    24: DoM2_552O.Canal_04 := DoGet(i, GVL_DO2|_VALVE_XV_102_CLOSE);

    25: DoM2_552O.Canal_05 := DoGet(i, GVL_DO2|_VALVE_XV_103_OPEN);
    26: DoM2_552O.Canal_06 := DoGet(i, GVL_DO2|_VALVE_XV_103_CLOSE);

    27: DoM2_552O.Canal_07 := DoGet(i, GVL_DO2|_VALVE_XV_104_OPEN);
    28: DoM2_552O.Canal_08 := DoGet(i, GVL_DO2|_VALVE_XV_104_CLOSE);

    29: DoM2_552O.Canal_09 := DoGet(i, GVL_DO2|_VALVE_XV_106_OPEN);
    30: DoM2_552O.Canal_10 := DoGet(i, GVL_DO2|_VALVE_XV_106_CLOSE);

    31: DoM2_552O.Canal_11 := DoGet(i, GVL_DO2|_VALVE_XV_107_OPEN);
    32: DoM2_552O.Canal_12 := DoGet(i, GVL_DO2|_VALVE_XV_107_CLOSE);

    33: DoM2_552O.Canal_13 := DoGet(i, GVL_DO2|_VALVE_XV_108_OPEN);
    34: DoM2_552O.Canal_14 := DoGet(i, GVL_DO2|_VALVE_XV_108_CLOSE);

    35: DoM2_552O.Canal_15 := DoGet(i, GVL_DO2|_VALVE_XV_109_OPEN);
    36: DoM2_552O.Canal_16 := DoGet(i, GVL_DO2|_VALVE_XV_109_CLOSE);
  END_CASE;
END_FOR;
