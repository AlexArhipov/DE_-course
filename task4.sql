set serveroutput on
declare
  cursor CR_TAB_COLUMNS IS
    SELECT TABLE_NAME, COLUMN_NAME FROM USER_TAB_COLUMNS
    where DATA_TYPE <> 'BLOB' and DATA_TYPE <> 'CLOB'
    order by TABLE_NAME, COLUMN_NAME DESC;
    V_GT CR_TAB_COLUMNS%ROWTYPE;
    V_COLUMN_LIST varchar(4000) :='';
    V_PRED_NAME varchar(30) := '';
    V_TYPE_NAME varchar(90) := '';
    begin
        dbms_output.enable;
        open CR_TAB_COLUMNS;
        LOOP
            FETCH CR_TAB_COLUMNS
            INTO V_GT;
            if V_PRED_NAME <> V_GT.TABLE_NAME OR CR_TAB_COLUMNS%NOTFOUND then
                V_TYPE_NAME :=  'SELECT min(' || V_COLUMN_LIST || ') FROM ' || V_PRED_NAME;
                execute immediate V_TYPE_NAME
                into V_TYPE_NAME;
                dbms_output.enable;
                dbms_output.put_line('table_name='||rpad(V_PRED_NAME,20)||'column_name='||rpad(V_COLUMN_LIST,20)||'min_value='||V_TYPE_NAME);
            end if;
            V_COLUMN_LIST := V_GT.COLUMN_NAME;
            V_PRED_NAME := V_GT.TABLE_NAME;
            EXIT WHEN CR_TAB_COLUMNS%NOTFOUND;
        end loop;
        close CR_TAB_COLUMNS;
     end;