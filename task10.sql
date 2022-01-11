select ba.fio, apl.fio, min(UTL_MATCH.EDIT_DISTANCE(ba.fio,apl.fio)) di from
(select fio, soundex(replace( 
replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace( 
translate(replace(replace(fio, 'КС','X'), 'кс','x'), 
'АБВГДЕЗИЙКЛМНОПРСТУФХЫЪЬабвгдезийклмнопрстуфхыъь', 'ABVGDEZIYKLMNOPRSTUFHY#'||chr(39)||'abvgdeziyklmnoprstufhy#'||chr(39) ) 
,'Ж','ZH') ,'Ё','YO') ,'Ц','TS') ,'Ч','CH') ,'Ш','SH') ,'Щ','SCH') ,'Э','EH') ,'Ю','YU') ,'Я','YA') ,'ж','zh') ,'ё','yo') ,'ц','ts')
,'ч','ch') ,'ш','sh') ,'щ','sch'),'э','eh') ,'ю','yu') ,'я','ya')) transl
from bankrupts) ba,
(select fio, soundex(replace( 
replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace( 
translate(replace(replace(fio, 'КС','X'), 'кс','x'), 
'АБВГДЕЗИЙКЛМНОПРСТУФХЫЪЬабвгдезийклмнопрстуфхыъь', 'ABVGDEZIYKLMNOPRSTUFHY#'||chr(39)||'abvgdeziyklmnoprstufhy#'||chr(39) ) 
,'Ж','ZH') ,'Ё','YO') ,'Ц','TS') ,'Ч','CH') ,'Ш','SH') ,'Щ','SCH') ,'Э','EH') ,'Ю','YU') ,'Я','YA') ,'ж','zh') ,'ё','yo') ,'ц','ts')
,'ч','ch') ,'ш','sh') ,'щ','sch'),'э','eh') ,'ю','yu') ,'я','ya')) transl
from applicants) apl
where ba.transl = apl.transl
GROUP BY apl.fio, ba.fio
order by di
fetch first 100 rows ONLY