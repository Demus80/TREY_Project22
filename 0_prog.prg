<PROGRAM>
Main,ST,Основная программа
</PROGRAM>

<FUNCTION>
DoGet,ST,B,Функция чтения уставок дискретных выходных каналов
DiGet,ST,B,Функция чтения уставок дискретных входных каналов
AiSet,ST,B,Запись уставок Аи в HMI
Analog_inOut_default_init,ST,B,уставкам присваиваются значения по по умолчанию
Discrete_inOut_default_init,ST,B,уставкам присваиваются значения по по умолчанию
DiSet,ST,B,Функция записи уставок дискретных входных каналов 
</FUNCTION>

<FBLOCK>
fbDiGet,ST,Функц.блок чтения уставок дискретных входных каналов
</FBLOCK>

<CHILD_PROGRAM>
Plc_AinOut,ST,I,Main,Подпрограмма работы с Ai сигналами
Plc_DinOut,ST,B,Main,Подпрограмма для работы с Di сигналами
</CHILD_PROGRAM>

<STRUCTED_UNIT>
</STRUCTED_UNIT>

