create or replace trigger KK_TRIG_BI before insert on sbermarket_order
    for each row begin
        select sq_sbermarket_order.nextval into :NEW.id from dual;
end KK_TRIG_BI;      

create or replace trigger KK_TRIG_AI after insert on sbermarket_order
    for each row begin
        if pck_journal_mode.journal_mode = true then
            insert into sbermarket_order_journal(id, price, dt) values(:NEW.id, :NEW.price, SYSDATE);
        end if;
end KK_TRIG_AI; 