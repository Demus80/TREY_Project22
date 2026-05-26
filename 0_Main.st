//x3 := Plc_Ain(x1,x2);
//M552D.Err_Stbus;
//GVL|Ai := 51;
(*Инициализируем данные при первом запуске *)
IF toggle = FALSE THEN
  // вентиляторы
  FAN1_LOC := 1; // если 1 ,то нет реагирования на самопроизвольное включение	
  FAN2_LOC := 1; 
  (*TODO: Версия прошивки! Kirinsc_22.0.0 *)
  PLC_prog_ver := 2200;
  GVL|REG_6104 := PLC_prog_ver; // переносим в базу регистров модбас
  //---- моточасы Н1 ----
  HMI_MH_B_Sec_P1 := 0;
  GVL|REG_6110 := HMI_MH_B_Sec_P1;
  HMI_MH_B_m_P1 := GVL|REG_6119;  
  TM_MH_B_m_P1 := HMI_MH_B_m_P1;  
  GVL|REG_72 := TM_MH_B_m_P1;   

  HMI_MH_AftRep_Sec_P1 := 0;
  GVL|REG_6111 := HMI_MH_AftRep_Sec_P1;
  HMI_MH_AftRep_m_P1 := GVL|REG_6121;  
  TM_MH_AftRep_m_P1 := HMI_MH_AftRep_m_P1;  
  GVL|REG_74 := TM_MH_AftRep_m_P1;   

  HMI_MH_LastSt_Sec_P1 := 0;
  GVL|REG_6112 := HMI_MH_LastSt_Sec_P1;  
  HMI_MH_LastSt_m_P1 := GVL|REG_6123;  
  TM_MH_LastSt_m_P1 := HMI_MH_LastSt_m_P1; 
  GVL|REG_76 := TM_MH_LastSt_m_P1;
  //---- моточасы Н2 ----
  HMI_MH_B_Sec_P2 := 0;
  GVL|REG_6113 := HMI_MH_B_Sec_P2; 
  HMI_MH_B_m_P2 := GVL|REG_6125;  
  TM_MH_B_m_P2 := HMI_MH_B_m_P2;  
  GVL|REG_78 := TM_MH_B_m_P2;  (*Функция  для записи данных в регистр modbus *)

  HMI_MH_AftRep_Sec_P2 := 0;
  GVL|REG_6114 := HMI_MH_AftRep_Sec_P2;
  HMI_MH_AftRep_m_P2 := GVL|REG_6127;  
  TM_MH_AftRep_m_P2 := HMI_MH_AftRep_m_P2;  
  GVL|REG_80 := TM_MH_AftRep_m_P2;   

  HMI_MH_LastSt_Sec_P2 := 0;
  GVL|REG_6115, HMI_MH_LastSt_Sec_P2;  
  HMI_MH_LastSt_m_P2 := GVL|REG_6129;  
  TM_MH_LastSt_m_P2 := HMI_MH_LastSt_m_P2; 
  GVL|REG_82 := TM_MH_LastSt_m_P2;
  //---- Ремонт ----
  Pump1_repair := Copy_Pump1_repair;
  GVL|REG_6075 := Pump1_repair);
  IF (Pump1_repair = 0) THEN 
	 fbBIT_IN_INT(bitPosition := 0, bitValue := bOFF, result => Tm_Pumps_repair); 
  ELSE 
     fbBIT_IN_INT(bitPosition := 0, bitValue := bON, result => Tm_Pumps_repair); 
  END_IF;
  Pump2_repair := Copy_Pump2_repair;
  GVL|REG_6076 := Pump2_repair;
  IF (Pump2_repair = 0) THEN 
	 fbBIT_IN_INT(bitPosition := 1, bitValue := bOFF, result => Tm_Pumps_repair); 
  ELSE 
     fbBIT_IN_INT(bitPosition := 1, bitValue := bON, result => Tm_Pumps_repair); 
  END_IF;
  
  (*если режим авто*)
  IF (Copy_PUMP1_LOC = 0 AND Pump1_repair = 0) THEN 
	 PUMP1_LOC := 0;  GVL.DO_PUMP1_AUTO := bON;
     GVL|REG_6070 := PUMP1_LOC);
  END_IF;
  IF (Copy_PUMP2_LOC = 0 AND Pump2_repair = 0) THEN 
	 PUMP2_LOC := 0;  GVL.DO_PUMP2_AUTO := bON;
     GVL|REG_6071 := PUMP2_LOC);
  END_IF;

  // клапаны
  WordBuff := gMDB.GetWord(MbADDR.REG_6254);   
  Valve_1_Local := WORD_TO_BOOL(WordBuff);  
  WordBuff := gMDB.GetWord(MbADDR.REG_6255);   
  Valve_2_Local := WORD_TO_BOOL(WordBuff);   
   
  toggle := TRUE;
  
  cmd := 10; // УБРАТЬ после эмуляции  !!!!  FIXME
END_IF;



