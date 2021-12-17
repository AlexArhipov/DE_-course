select bank_clients.client_name, nvl(bd.kol_dep,0) kol_dep, nvl(bd.sum_dep,0) sum_dep, nvl(bc.kol_cred,0) kol_cred, nvl(bc.sum_cred,0) sum_cred from bank_clients
left join (select client_name, count(1) kol_cred, sum(credit_amount) sum_cred from bank_credits group by client_name) bc on bank_clients.client_name = bc.client_name
left join (select client_name, count(1) kol_dep, sum(deposit_amount) sum_dep from bank_deposits group by client_name) bd on bank_clients.client_name = bd.client_name
order by bank_clients.client_name
