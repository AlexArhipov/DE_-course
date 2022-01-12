create or replace function fn_create_script_check_hist_(in_table_name in varchar2, in_pk_list in varchar2,
                        in_date_start in varchar2, in_date_finish in varchar2) return varchar2 as res varchar2(4000);
begin
    res :=  'select ' || in_pk_list || ', ' || in_date_start || ', ' || in_date_finish || ' from
    (select ' || in_pk_list || ', ' ||
    in_date_start || ', lag(' || in_date_finish || ')
    over(partition by ' || in_pk_list || ' order by ' || in_pk_list || ', ' || in_date_start || ', ' || in_date_finish || ')+1 real_start,
    ' || in_date_finish || ', lead(' || in_date_start || ')
    over(partition by ' || in_pk_list || ' order by ' || in_pk_list || ', ' || in_date_start || ', ' || in_date_finish || ')-1 real_end
    from ' || in_table_name ||')
    where real_start != ' || in_date_start || ' or real_end != '|| in_date_finish || ' or ' || in_date_start || '>' || in_date_finish;
    return res;
end;