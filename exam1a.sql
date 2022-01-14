create or replace function gen_str return VARCHAR2 as
res VARCHAR2(4000);
v VARCHAR2(4000);
cu VARCHAR2(4000);
begin
    res := ',';
    for i in 1..100 loop
        loop
            cu := to_char(round(dbms_random.value(1,100)));
            v := to_char(round(dbms_random.value(1,100)));
            if length(v) < 2 then v := '0' || v; end if;
            if length(cu) < 2 then cu := '0' || cu; end if;
            if (to_number(cu)>to_number(v) or to_number(cu)<to_number(v)) and nvl(INSTR(res, cu||'+'||v), 0) = 0 and nvl(INSTR(res, v||'+'||cu), 0) = 0 then
                res :=  res || cu || '+' || v || ',';
                exit;
            end if;
        end loop;
    end loop;
    res := substr(res, 2, length(res)-2);
    return res;
end;

declare
    v varchar2(4000);
    sub_v varchar2(10);	
begin
    v := gen_str;
    for i in 1..100 loop
        sub_v := regexp_substr(v, '[^,]+', 1, i);
        insert into acquaintance(id1, id2) values(substr(sub_v, 1, instr(sub_v,'+')-1), substr(sub_v, instr(sub_v,'+'), length(sub_v)));  
    end LOOP; 
end;


with sel2 as (
select id1, id2, lvl, (substr(grp, 1, instr(grp, ')',-8))) P, (lst) P1  from
(select id1, id2, LEVEL lvl, substr(sys_connect_by_path(id1, '>'),2) lst, substr(sys_connect_by_path('(' || id2 || ',' || id1, ');') || ')',3) grp
from (select id1, id2 from acquaintance union select id2, id1 from acquaintance)
where level < 12
start with id1=1
connect by nocycle prior id2=id1)
) 

select id1 ID, lvl, P, P1 
  from (select id1 ,
               lvl,
               P,
               P1,
               row_number() over(partition by id1 order by lvl) rn
          from sel2)
where rn=1 and lvl>1               