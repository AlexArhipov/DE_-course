select ba.fio, apl.fio, min(UTL_MATCH.EDIT_DISTANCE(ba.fio,apl.fio)) di from
(select fio, soundex(replace( 
replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace( 
translate(replace(replace(fio, '��','X'), '��','x'), 
'������������������������������������������������', 'ABVGDEZIYKLMNOPRSTUFHY#'||chr(39)||'abvgdeziyklmnoprstufhy#'||chr(39) ) 
,'�','ZH') ,'�','YO') ,'�','TS') ,'�','CH') ,'�','SH') ,'�','SCH') ,'�','EH') ,'�','YU') ,'�','YA') ,'�','zh') ,'�','yo') ,'�','ts')
,'�','ch') ,'�','sh') ,'�','sch'),'�','eh') ,'�','yu') ,'�','ya')) transl
from bankrupts) ba,
(select fio, soundex(replace( 
replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace( 
translate(replace(replace(fio, '��','X'), '��','x'), 
'������������������������������������������������', 'ABVGDEZIYKLMNOPRSTUFHY#'||chr(39)||'abvgdeziyklmnoprstufhy#'||chr(39) ) 
,'�','ZH') ,'�','YO') ,'�','TS') ,'�','CH') ,'�','SH') ,'�','SCH') ,'�','EH') ,'�','YU') ,'�','YA') ,'�','zh') ,'�','yo') ,'�','ts')
,'�','ch') ,'�','sh') ,'�','sch'),'�','eh') ,'�','yu') ,'�','ya')) transl
from applicants) apl
where ba.transl = apl.transl
GROUP BY apl.fio, ba.fio
order by di
fetch first 100 rows ONLY