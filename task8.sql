create or replace function gen_str return VARCHAR2 as
res VARCHAR2(100);
v VARCHAR2(100);
begin
    res := ',';
    for i in 1..6 loop
        loop
            v := to_char(round(dbms_random.value(1,46)));
            if length(v) < 2 then v := '0' || v; end if;
            if nvl(INSTR(res, v), 0) = 0 then
                res := res || v || ',';
                exit;
            end if;
        end loop;
    end loop;
    res := replace(res, ',0', ',');
    res := substr(res, 2, length(res)-2);
    return res;
end;

declare
    v varchar2(200);
begin
    v := gen_str;
    for i in 1..6 loop
        insert into lotery_results(val) values(regexp_substr(v, '[^,]+', 1, i));  
    end LOOP; 
end;

begin
    for i in 1..10000 loop
        insert into lotery_guess(vallist) values(gen_str); 
    end LOOP; 
end;

select rw, vallist, count(val) num_right_answers  from lotery_results
right join (select rw, vallist, regexp_substr(vallist, '[^,]+', 1, level) num_right from (select vallist, rownum rw from lotery_guess)
connect by regexp_substr(vallist, '[^,]+', 1, level) is not null and prior rw=rw
    and prior dbms_random.value is not null) on to_char(val) = num_right
    group by rw, vallist 
    order by num_right_answers desc
