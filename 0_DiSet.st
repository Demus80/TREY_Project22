//Функция (DiSet) записи уставок дискретных входных каналов 
BuffBool := INT_TO_BOOL(inverse);
IF (number > 0 AND number < 33) THEN 
	GVL|REG_5004 := SETBIT(BuffBool,number-1,GVL|REG_5004); 	
ELSIF (number > 32 AND number < 65) THEN // 32 кол-во каналов в одном модуле	
	GVL|REG_5006 := SETBIT(BuffBool,number-33,GVL|REG_5006); 
END_IF;
//TODO: Если каналы будут редактируемые, то добавить сюда массив ch_change и передавать ему значения от вх.переменной ch_change функции !
