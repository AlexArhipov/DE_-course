select unit, sys_connect_by_path(name, '>') from classification
connect by prior unit = substr(unit, 1, regexp_instr(unit, '[.][0-9]+$') - 1)
start with substr(unit, 1, regexp_instr(unit, '[.][0-9]+$') - 1) is null

