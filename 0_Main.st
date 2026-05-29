//x3 := Plc_Ain(x1,x2);
//M552D.Err_Stbus;
 
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
  GVL|REG_6115 := HMI_MH_LastSt_Sec_P2;  
  HMI_MH_LastSt_m_P2 := GVL|REG_6129;  
  TM_MH_LastSt_m_P2 := HMI_MH_LastSt_m_P2; 
  GVL|REG_82 := TM_MH_LastSt_m_P2;
  //---- Ремонт ----
  Pump1_repair := Copy_Pump1_repair;
  GVL|REG_6075 := Pump1_repair;
   
  IF (Pump1_repair = 0) THEN 
     bitPosition := 0;
     Tm_Pumps_repair := SETBIT(false, bitPosition, Tm_Pumps_repair);
  ELSE 
     bitPosition := 0;
     Tm_Pumps_repair := SETBIT(true, bitPosition, Tm_Pumps_repair); 
  END_IF;
  
  Pump2_repair := Copy_Pump2_repair;
  GVL|REG_6076 := Pump2_repair;
  
  IF (Pump2_repair = 0) THEN 
	 bitPosition := 1;
     Tm_Pumps_repair := SETBIT(false, bitPosition, Tm_Pumps_repair);
  ELSE 
     bitPosition := 1;
     Tm_Pumps_repair := SETBIT(true, bitPosition, Tm_Pumps_repair); 
  END_IF;
  
  (*если режим авто*)
  IF (Copy_PUMP1_LOC = 0 AND Pump1_repair = 0) THEN 
	 PUMP1_LOC := 0;  //GVL|DO_PUMP1_AUTO := bON;
     GVL|REG_6070 := PUMP1_LOC;
  END_IF;
  IF (Copy_PUMP2_LOC = 0 AND Pump2_repair = 0) THEN 
	 PUMP2_LOC := 0;  //GVL.DO_PUMP2_AUTO := bON;
     GVL|REG_6071 := PUMP2_LOC;
  END_IF;
  
  // клапаны
  WordBuff := GVL|REG_6254;   
  Valve_1_Local := INT_TO_BOOL(WordBuff); //WORD_TO_BOOL(WordBuff);  
  WordBuff := GVL|REG_6255;   
  Valve_2_Local := INT_TO_BOOL(WordBuff);   
   
  toggle := TRUE;
  
  cmd := 10; // УБРАТЬ после эмуляции  !!!!  FIXME
END_IF;

//cmd := GVL|REG_6056;   // Команды от панели       // Раскомментировать после эмуляции 
IF (cmd = 0) THEN 
	cmd := GVL|REG_14;  // (*Команды от ТМ*)
END_IF;

// включаем насос Н-1 с поста
IF (PUMP1_LOC = 1 AND GVL_DI|_PUMP1_LOCAL_BUTTON_START AND GVL_DI|_PUMP1_ON_WORKING = FALSE) THEN
	   IF (GVL_DI2|_FIRE = FALSE  AND Pump_1_fault = 0 AND Pump1_repair = 0) THEN
          IF (GAS_LEVEL2_Block_P1 = 1 OR GAS_LEVEL2_Block_P2 = 1) THEN (*если блокировка включена по порогу 2 газика*)
             if (GAS_L2 = false) then
                PUMP1_CMD := iON;
             end_if;
          else
             PUMP1_CMD := iON;
          end_if;
       end_if;
       IF (PUMP1_CMD = iON) THEN  (*Сброс моточасов*) 
		  TM_MH_LastSt_m_P1 := 0;  GVL|REG_76 := TM_MH_LastSt_m_P1;
		  HMI_MH_LastSt_m_P1 := 0; GVL|REG_6123 := HMI_MH_LastSt_m_P1; 
		  fb_MH_Last_Start_P1(Start := TRUE, iTM_m := 0, active := 2);
		  HMI_MH_LastSt_sec_P1 := fb_MH_Last_Start_P1.Sec; TM_MH_LastSt_m_P1 := fb_MH_Last_Start_P1.oTM_m;
       END_IF;
END_IF;


// выключаем насос Н-1 с поста
IF (GVL_DI|_PUMP1_LOCAL_BUTTON_STOP AND GVL_DI|_PUMP1_ON_WORKING) THEN
	PUMP1_CMD := iOFF; 
END_IF;
// включаем насос Н-2 с поста
IF (PUMP2_LOC = 1 AND GVL_DI|_PUMP2_LOCAL_BUTTON_START AND GVL_DI|_PUMP2_ON_WORKING = FALSE) THEN
	   IF (GVL_DI2|_FIRE = FALSE  AND Pump_2_fault = 0 AND Pump2_repair = 0) THEN
          IF (GAS_LEVEL2_Block_P1 = 1 OR GAS_LEVEL2_Block_P2 = 1) THEN (*если блокировка включена по порогу 2 газика*)
             if (GAS_L2 = false) then
                PUMP2_CMD := iON;
             end_if;
          else
             PUMP2_CMD := iON;
          end_if;
       end_if;
       IF (cmd = 46) THEN TM_COMMAND_STATE := 46; END_IF;
       IF (PUMP2_CMD = iON) THEN (*Сброс моточасов*) 
		  TM_MH_LastSt_m_P2 := 0; GVL|REG_82 := TM_MH_LastSt_m_P2;	
          HMI_MH_LastSt_m_P2 := 0; GVL|REG_6129 := HMI_MH_LastSt_m_P2; 
          fb_MH_Last_Start_P2(Start := TRUE, iTM_m := 0, active := 2);
		  HMI_MH_LastSt_sec_P2 := fb_MH_Last_Start_P2.Sec; TM_MH_LastSt_m_P2 := fb_MH_Last_Start_P2.oTM_m;
      END_IF;
END_IF;
// выключаем насос Н-2 с поста
IF (GVL_DI|_PUMP2_LOCAL_BUTTON_STOP AND GVL_DI|_PUMP2_ON_WORKING) THEN
	PUMP2_CMD := iOFF; 
END_IF;

(*Команды от панели оператора или ТМ*)
IF (cmd > 0) THEN
   CASE cmd OF
   10: void := Analog_inOut_default_init(); 
       void := Discrete_inOut_default_init();  
       ALL_default := TRUE; 
   // Сброс всех аварий    
   15: FAN1_CMD := iRESET; FAN2_CMD := iRESET; FAN3_CMD := iRESET; FAN4_CMD := iRESET;    
       PUMP1_CMD := iRESET; Pump_1_fault := 0; 
       TM_status_blocks_p1 := 0; CbP1 := 0; GVL|REG_1258 := TM_status_blocks_p1;
	   PUMP2_CMD := iRESET; Pump_2_fault := 0;  
       TM_status_blocks_p2 := 0; CbP2 := 0; GVL|REG_1259 := TM_status_blocks_p2;
	   Timer_FAULT_P1(IN := FALSE, PT := 3000); // 3000 - мс = 3 сек.
	   Timer_FAULT_P2(IN := FALSE, PT := 3000);
	   Valve1_CMD := RES_Fault; TM_Status_Fault_Valves := 0; // Сброс аварии задвижки 2112 
	   Valve2_CMD := RES_Fault; TM_Status_Fault_Valves := 0; // Сброс аварии задвижки 2122 
  (*Управление вентиляторами 1 и 2*)
  (*
   21,61: // вкл. В1
	   IF (GVL_DI2|_FIRE = FALSE AND cmd = 21) THEN
          FAN1_CMD := iON;
       end_if;
       IF (cmd = 61) THEN
          TM_COMMAND_STATE := 61; 
          FAN1_CMD := iON;
       END_IF;	   
   22,62: // выкл. В1
	  IF (GAS_L1 = FALSE) THEN // AND GAS_L2 = FALSE) THEN
          FAN1_CMD := iOFF;
       end_if;
       IF (cmd = 62) THEN TM_COMMAND_STATE := 62; END_IF;
	   
   23,63: FAN1_CMD := iRESET; IF (cmd = 63) THEN TM_COMMAND_STATE := 63; END_IF;  // Сброс аварий вент.
   
   //24: FAN1_LOC := 0; gMDB.SetWord(MbADDR.REG_6033, FAN1_LOC); // дист. 
   
   //25: FAN1_LOC := 1; gMDB.SetWord(MbADDR.REG_6033, FAN1_LOC); // ручной
   26,64: // вкл. В2
	   IF (GVL_DI2|_FIRE = FALSE AND cmd = 26) THEN
          FAN2_CMD := iON;
       end_if;
       IF (cmd = 64) THEN
          TM_COMMAND_STATE := 64;
          FAN2_CMD := iON;
       end_if;
   27,65: // выкл. В2
	   IF (GAS_L1 = FALSE) THEN
          FAN2_CMD := iOFF;
       end_if;
       if (cmd = 65) THEN TM_COMMAND_STATE := 65; END_IF;
	  
   28,66: FAN2_CMD := iRESET; IF (cmd = 66) THEN TM_COMMAND_STATE := 66; END_IF;  // Сброс аварий вент.
   *)
   (*29: FAN2_LOC := _OFF;
   30: FAN2_LOC := _ON; *)
  (*Управление насосами*)
  (*пуск н1*)
   31,36: IF (GVL_DI2|_FIRE = FALSE AND PUMP1_LOC = iOFF AND Pump_1_fault = 0 AND Pump1_repair = 0) THEN
          IF (GAS_LEVEL2_Block_P1 = 1 OR GAS_LEVEL2_Block_P2 = 1) THEN (*если блокировка включена по порогу 2 газика*)
             if (GAS_L2 = false) then
                PUMP1_CMD := iON;
             end_if;
          else
             PUMP1_CMD := iON;
          end_if;
       end_if;
       IF (cmd = 36) THEN TM_COMMAND_STATE := 36; END_IF;
       IF (PUMP1_CMD = iON) THEN  (*Сброс моточасов*) 
		  TM_MH_LastSt_m_P1  := 0; GVL|REG_76 := TM_MH_LastSt_m_P1; 
		  HMI_MH_LastSt_m_P1 := 0; GVL|REG_6123 := HMI_MH_LastSt_m_P1;		  
		  fb_MH_Last_Start_P1(Start := TRUE, iTM_m := 0, active := 2);
		  HMI_MH_LastSt_sec_P1 := fb_MH_Last_Start_P1.Sec; TM_MH_LastSt_m_P1 := fb_MH_Last_Start_P1.oTM_m;
       END_IF;  
   (*стоп н1*)
   32,37: PUMP1_CMD := iOFF; IF (cmd = 37) THEN TM_COMMAND_STATE := 37; END_IF;
   (*сброс аварии н1*)
   33,38: PUMP1_CMD := iRESET; Pump_1_fault := 0; 
          IF (cmd = 38) THEN TM_COMMAND_STATE := 38; END_IF;
          TM_status_blocks_p1 := 0; CbP1 := 0; GVL|REG_1258 := TM_status_blocks_p1;
		  Timer_FAULT_P1(IN := FALSE, PT := 3000); 
   (*Режим ручной*)
   34: PUMP1_LOC := 1; Copy_PUMP1_LOC := PUMP1_LOC; GVL|REG_6070 := PUMP1_LOC; //GVL.DO_PUMP1_AUTO := bOFF;
   (*Режим авто у частотника*)
   35: IF (Pump1_repair = 0) THEN PUMP1_LOC := 0; END_IF; Copy_PUMP1_LOC := PUMP1_LOC; GVL|REG_6070 := PUMP1_LOC;// GVL.DO_PUMP1_AUTO := bON; 
   (*пуск н2*)
   41,46: IF (GVL_DI2|_FIRE = FALSE AND PUMP2_LOC = iOFF AND Pump_2_fault = 0  AND Pump2_repair = 0) THEN
          IF (GAS_LEVEL2_Block_P1 = 1 OR GAS_LEVEL2_Block_P2 = 1) THEN (*если блокировка включена по порогу 2 газика*)
             if (GAS_L2 = false) then
                PUMP2_CMD := iON;
             end_if;
          else
             PUMP2_CMD := iON;
          end_if;
       end_if;
       IF (cmd = 46) THEN TM_COMMAND_STATE := 46; END_IF;
       IF (PUMP2_CMD = iON) THEN (*Сброс моточасов*) 
		  TM_MH_LastSt_m_P2  := 0; GVL|REG_82 := TM_MH_LastSt_m_P2;	
          HMI_MH_LastSt_m_P2 := 0; GVL|REG_6129 := HMI_MH_LastSt_m_P2; 
          fb_MH_Last_Start_P2(Start := TRUE, iTM_m := 0, active := 2);
		  HMI_MH_LastSt_sec_P2 := fb_MH_Last_Start_P2.Sec; TM_MH_LastSt_m_P2 := fb_MH_Last_Start_P2.oTM_m;
      END_IF;
   (*стоп н2*)	  
   42,47: PUMP2_CMD := iOFF; IF (cmd = 47) THEN TM_COMMAND_STATE := 47; END_IF;
   (*сброс аварии н2*)
   43,48: PUMP2_CMD := iRESET; Pump_2_fault := 0; //gMDB.SetDWord(MbADDR.REG_6084, Pump_2_fault);  
          IF (cmd = 48) THEN TM_COMMAND_STATE := 48; END_IF;
          TM_status_blocks_p2 := 0; CbP2 := 0; GVL|REG_1259 := TM_status_blocks_p2;
		  Timer_FAULT_P2(IN := FALSE, PT := 3000); 
   (*Режим ручной*)		  
   44: PUMP2_LOC := 1; Copy_PUMP2_LOC := PUMP2_LOC; GVL|REG_6071 := PUMP2_LOC; //GVL.DO_PUMP2_AUTO := bOFF; 
   (*Режим авто у частотника*)
   45: Copy_PUMP2_LOC := PUMP2_LOC; GVL|REG_6071 := PUMP2_LOC;
       //IF (Pump2_repair = 0) THEN PUMP2_LOC := 0;  GVL.DO_PUMP2_AUTO := bON) END_IF;  
   (*
   51,56: if (DI_FIRE = false AND DO_PUMP3_AUTO = bON  AND Pump_3_fault = 0 AND Pump3_repair = 0) then
          if (GAS_LEVEL2_Block_P3 = 1) then // если блокировка включена по порогу 2 газика
             if (GAS_L2 = false) then
                PUMP3_CMD := iON;
             end_if;
          else
             PUMP3_CMD := iON;
          end_if;
       end_if;
       if (cmd = 56) then TM_COMMAND_STATE := 56; end_if;
       if (PUMP3_CMD = iON) then TM_MH_LastSt_m_h_P3 := 0; TM_MH_LastSt_m_L_P3 := 0; end_if;
   52,57: PUMP3_CMD := iOFF; if (cmd = 57) then TM_COMMAND_STATE := 57; end_if;
   53,58: PUMP3_CMD := iRESET; Pump_3_fault := 0; if (cmd = 58) then TM_COMMAND_STATE := 58; end_if;
          TM_status_blocks_p3 := 0; CbP3 := 0;
   54: PUMP3_LOC := 1; DO_PUMP3_AUTO := bOFF; Copy_PUMP3_LOC := PUMP3_LOC;
   55: IF (Pump3_repair = 0) THEN PUMP3_LOC := 0;  DO_PUMP3_AUTO := bON; Copy_PUMP3_LOC := PUMP3_LOC; END_IF;
   *)
   (*Перевод н1 в ремонт*)
   70,80: IF (GVL_DI|_PUMP1_ON_WORKING = bOFF) THEN               
		 Pump1_repair := 1; GVL|REG_6075 := Pump1_repair;
		 bitPosition := 0;
     	 Tm_Pumps_repair := SETBIT(bON, bitPosition, Tm_Pumps_repair); Copy_Pump1_repair :=  Pump1_repair;
		 GVL|REG_1262 := Tm_Pumps_repair;
         PUMP1_LOC := 1; GVL|REG_6070 := PUMP1_LOC;
		 Copy_PUMP1_LOC := PUMP1_LOC; (*Режим ручной*) //GVL.DO_PUMP1_AUTO := bOFF; 
       END_IF;
       if (cmd = 70) then TM_COMMAND_STATE := 70; end_if;
   (*Перевод н1 в работу*)
   71,81: Pump1_repair := 0; Tm_Pumps_repair := SETBIT(bOFF, bitPosition, Tm_Pumps_repair);
       GVL|REG_6075 := Pump1_repair;
	   GVL|REG_1262 := Tm_Pumps_repair;
       Copy_Pump1_repair :=  Pump1_repair;
       if (cmd = 71) then TM_COMMAND_STATE := 71; end_if;
       (*Сброс моточасов*)
	   TM_MH_AftRep_m_P1 := 0;  GVL|REG_74 := TM_MH_AftRep_m_P1; 
       HMI_MH_AftRep_m_P1 := 0; GVL|REG_6121 := HMI_MH_AftRep_m_P1;      
       fb_MH_AfterRepair_P1(Start := TRUE, iTM_m := 0, active := 2);
	   HMI_MH_AftRep_sec_P1 := fb_MH_AfterRepair_P1.Sec; TM_MH_AftRep_m_P1 := fb_MH_AfterRepair_P1.oTM_m; 
   (*Перевод н2 в ремонт*)
   72,82: IF (GVL_DI|_PUMP2_ON_WORKING = bOFF) THEN	   
	   	 Pump2_repair := 1; GVL|REG_6076 := Pump2_repair;
	   	 bitPosition := 1;
	   	 Tm_Pumps_repair := SETBIT(bON, bitPosition, Tm_Pumps_repair); Copy_Pump2_repair :=  Pump2_repair;
	     GVL|REG_1262 := Tm_Pumps_repair;
         PUMP2_LOC := 1; GVL|REG_6071 := PUMP2_LOC;
	     Copy_PUMP2_LOC := PUMP2_LOC; //GVL.DO_PUMP2_AUTO := bOFF;  (*Режим ручной*)
       END_IF; 
 	   IF (cmd = 72) THEN TM_COMMAND_STATE := 72; END_IF;  
   (*Перевод н2 в работу*)
   73,83: Pump2_repair := 0; bitPosition := 1;
       Tm_Pumps_repair := SETBIT(bOFF, bitPosition, Tm_Pumps_repair); Copy_Pump2_repair :=  Pump2_repair;
       GVL|REG_6076 := Pump2_repair;
	   GVL|REG_1262 := Tm_Pumps_repair;	   
       IF (cmd = 73) THEN TM_COMMAND_STATE := 73; END_IF;
	   (*Сброс моточасов*)	   
	   TM_MH_AftRep_m_P2 := 0;  GVL|REG_80 := TM_MH_AftRep_m_P2; 
       HMI_MH_AftRep_m_P2 := 0; GVL|REG_6127 := HMI_MH_AftRep_m_P2; 	   
	   fb_MH_AfterRepair_P2(Start := TRUE, iTM_m := 0, active := 2);
	   HMI_MH_AftRep_sec_P2 := fb_MH_AfterRepair_P2.Sec; TM_MH_AftRep_m_P2 := fb_MH_AfterRepair_P2.oTM_m; 
  (*Управление вентиляторами 3 и 4*)
  (*
   91,101: // вкл. В3
	   IF (GVL_DI2|_FIRE = FALSE AND Fan3_LOC = 1) THEN
          FAN3_CMD := iON;
       end_if;
       IF (cmd = 101 AND FAN3_LOC = 1) THEN
          TM_COMMAND_STATE := 101; 
       END_IF;	   
   92,102: // выкл. В3
	   FAN3_CMD := iOFF;
       IF (cmd = 102) THEN TM_COMMAND_STATE := 102; END_IF;   
   93,103: FAN3_CMD := iRESET; IF (cmd = 103) THEN TM_COMMAND_STATE := 103; END_IF;  // Сброс аварий вент.
   
   94: Fan3_LOC := 0; GVL|REG_6035 := FAN3_LOC; // авто.    
   95: Fan3_LOC := 1; GVL|REG_6035 := FAN3_LOC; // ручной
   
   96,104: // вкл. В4
	   IF (GVL_DI2|_FIRE = FALSE AND Fan3_LOC = 1) THEN
          FAN4_CMD := _ON;
       end_if;
       IF (cmd = 104 AND FAN3_LOC = 1) THEN
          TM_COMMAND_STATE := 104;
       END_IF;
   97,105: // выкл. В4
	   FAN4_CMD := iOFF;
       IF (cmd = 105) THEN TM_COMMAND_STATE := 105; END_IF;
	  
   98,106: FAN4_CMD := iRESET; IF (cmd = 106) THEN TM_COMMAND_STATE := 106; END_IF;  // Сброс аварий вент.
   *)
   // Управление эл. задвижками
   110,130: Valve_1_Local := bON;  // Разрешить управление задвижкой 2112 через панель HMI или АРМ (ручной режим)
        WordBuff := BOOL_TO_INT(Valve_1_Local);  
     	GVL|REG_6254 := WordBuff; GVL|REG_1265 := WordBuff;
   111,131: Valve_1_Local := bOFF; // Перевод управления задвижкой 2112 в автоматический режим (по алгоритму, ПИД регулятору);
        WordBuff := BOOL_TO_INT(Valve_1_Local);  
     	GVL|REG_6254 := WordBuff; GVL|REG_1265 := WordBuff;
   112,132: Valve1_CMD := OPEN;    	 // Команда "ОТКРЫТЬ" задвижку 2112 
   113,133: Valve1_CMD := CLOSE;   	 // Команда "ЗАКРЫТЬ" задвижку 2112 
   114,134: Valve1_CMD := STOP;    	 // Команда "СТОП" задвижки 2112 
            Valve_1_Local := bON; WordBuff := BOOL_TO_INT(Valve_1_Local); // (ручной режим)
            GVL|REG_6254 := WordBuff; GVL|REG_1265 := WordBuff;
   115,135: Valve1_CMD := RES_Fault; TM_Status_Fault_Valves := 0; // Сброс аварии задвижки 2112 
   116,136: Valve1_CMD := POS_RUN;   // Команда на переход задвижки 2112 в указанную позицию
   120,140: Valve_2_Local := bON;    // Разрешить управление задвижкой 2122 через панель HMI (ручной режим) 
        WordBuff := BOOL_TO_INT(Valve_2_Local);  
     	GVL|REG_6255 := WordBuff; GVL|REG_1266 := WordBuff;
   121,141: Valve_2_Local := bOFF;   // Перевод управления задвижкой 2122 в автоматический режим (по алгоритму, ПИД регулятору);
        WordBuff := BOOL_TO_INT(Valve_2_Local);  
     	GVL|REG_6255 := WordBuff; GVL|REG_1266 := WordBuff;
   122,142: Valve2_CMD := OPEN;    	 // Команда "ОТКРЫТЬ" задвижку 2122 
   123,143: Valve2_CMD := CLOSE;   	 // Команда "ЗАКРЫТЬ" задвижку 2122 
   124,144: Valve2_CMD := STOP;    	 // Команда "СТОП" задвижки 2122  
  			Valve_2_Local := bON; WordBuff := BOOL_TO_INT(Valve_2_Local); // (ручной режим)
            GVL|REG_6255 := WordBuff; GVL|REG_1266 := WordBuff;
   125,145: Valve2_CMD := RES_Fault; TM_Status_Fault_Valves := 0; // Сброс аварии задвижки 2122 
   126,146: Valve2_CMD := POS_RUN;   // Команда на переход задвижки 2122 в указанную позицию
   1000:    // блокировки    		      
	        HMI_block_ARR[1] := 0; TM_block_ARR[1] := 0; (*заполняем все биты "0"*)
	        HMI_block_ARR[2] := 0; TM_block_ARR[2] := 0; (*заполняем все биты "0"*)
	        GVL|REG_6020 := HMI_block_ARR[1]; GVL|REG_6021 := HMI_block_ARR[2];	
	        GVL|REG_66   := TM_block_ARR[1]; GVL|REG_67   := TM_block_ARR[2];		
            
   END_CASE;	
   
   IF (cmd > 129 AND cmd < 147) THEN  // чтоб не дублировать в каждой строке команд 
       TM_COMMAND_STATE := cmd;
   END_IF; 	
   IF (TM_COMMAND_STATE > 0) THEN 
	   GVL|REG_6090 := TM_COMMAND_STATE;
   END_IF;
   cmd := 0; GVL|REG_6056 := cmd; GVL|REG_14 := cmd;
END_IF;


