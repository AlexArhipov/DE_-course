declare
    i integer := 1;
    lev integer := 1;
begin
    for z in (select dt, cnt from trans order by cnt desc) loop
        update trans1 set group_id = i where dt = z.dt;
        if lev < 4 then i := i + 1; else i := i - 1; end if;
        if (i = 9 and lev < 4) then i:= 1; lev := lev + 1; if lev = 4 then i := 8; end if;  end if;
    end loop;
end;    