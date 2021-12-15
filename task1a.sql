select 'Клиент ' || client_name || ' имеет счет ' || account_code || ' с остатком ' || to_char(balance, '99999990.99') || ' ' || currency_code from acc_blnc
order by account_code