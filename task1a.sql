select '������ ' || client_name || ' ����� ���� ' || account_code || ' � �������� ' || to_char(balance, '99999990.99') || ' ' || currency_code from acc_blnc
order by account_code