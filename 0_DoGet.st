(*Функция чтения уставок дискретных выходных каналов *)
IF (number > 0 AND number < 33) THEN 
	BuffInt := GVL|REG_5104;
ELSIF (number > 32) THEN  // 32 кол-во каналов в одном модуле	
	BuffInt := GVL|REG_5106;
END_IF;
 
IF (GETBIT(number - 1, BuffInt) = FALSE) THEN // если нет инверсии
  DoGet := inD;	 
ELSE  // если активна инверсия
  IF (inD) THEN
      DoGet := FALSE;
  ELSE	  
	  DoGet := TRUE;
  END_IF;	 
END_IF;
