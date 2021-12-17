create or replace PACKAGE KK_AV is
    function KK_MYF(name_length in integer) return varchar2;
    procedure KK_MYP(num_row in integer, max_length in integer);
end KK_AV;

create or replace PACKAGE body KK_AV is
    function KK_MYF(name_length in integer) return varchar2 is RET varchar2(4000);
        begin
        for z in (SELECT planets.name from planets order by name) loop
            if length(z.name) = name_length then
                RET := z.name;
                return RET;
            end if;
        end loop;
        RET := 'NO VALUE';
        return RET;
    end KK_MYF;
    
    procedure KK_MYP(num_row in integer, max_length in integer) is
        begin
            for i in 1 .. num_row LOOP
                insert into planets(id, name) values (sq_planets.nextval, dbms_random.string('a', trunc(max_length*dbms_random.value()+1)));
            end LOOP;
    end KK_MYP;
end KK_AV;