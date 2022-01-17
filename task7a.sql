select contract_id, start_dt, end_dt, delay_indicator from
(
select contract_id, start_dt, lead(start_dt) over(partition by contract_id order by start_dt)-1 end_dt,
sum(delay_indicator) over(partition by contract_id order by start_dt) delay_indicator from
(
select contract_id, start_dt, 0 as delay_indicator
    from credits
union all
select contract_id, end_dt+1, 0 as delay_indicator
    from credits
union all
select contract_id, start_dt, 1 as delay_indicator
  from delay1
union all
select contract_id, end_dt + 1, -1 as delay_indicator
  from delay1
union all
select contract_id, start_dt, 2 as delay_indicator
  from delay2
union all
select contract_id, end_dt + 1, -2 as delay_indicator
  from delay2))
where end_dt is not null and end_dt >= start_dt and end_dt<>'31.12.2999 00:00:00'
order by 1,2