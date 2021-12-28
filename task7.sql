declare
    v1 float;
    v2 float;
    v3 float;
    v4 float;
    v float;
    i integer := 0;
begin
    v1 := round(dbms_random.value(), 2);
    v2 := round(dbms_random.value(), 2);
    v3 := round(dbms_random.value(), 2);
    v4 := round(dbms_random.value(), 2);
    v := v1 + v2 + v3 + v4;
    v := 100 / v;
    insert into candidates (name, prc) values (dbms_random.string('a', 10), round(v1 * round(v,2), 2));
    insert into candidates (name, prc) values (dbms_random.string('a', 10), round(v2 * round(v,2), 2));
    insert into candidates (name, prc) values (dbms_random.string('a', 10), round(v3 * round(v,2), 2));
    insert into candidates (name, prc) values (dbms_random.string('a', 10), round(v4 * round(v,2), 2));
    
    for z in (select candidates.name, candidates.prc from candidates order by candidates.prc desc, candidates.name) loop
        if z.prc > 50 then
            insert into vote_results(name, prc, is_finished) values (z.name, z.prc, 1);
            exit;
        end if;    
        insert into vote_results(name, prc, is_finished) values (z.name, z.prc, 0);
        i := i+1;
        if i>=2 then
            exit;
        end if;
    end loop;    
end;