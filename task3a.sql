select ' ',' ','Зенит','Спартак','ЦСКА','Химки', 'Побед', 'Ничьих','Поражений','Забито','Пропущено','Очков дома','Очков в гостях','Очков всего' from dual
union all
select to_char(c.id),    
       c.name,
       nvl(max(case
            when 1 != c.id and 1 = g.id2 and g.goals1 > g.goals2 then  g.goals1||':'||g.goals2
            when 1 != c.id and 1 = g.id2 and g.goals1 < g.goals2 then  g.goals2||':'||g.goals1
            when 1 != c.id and 1 = g.id2 and g.goals1 = g.goals2 then  g.goals2||':'||g.goals1 
       end), ' ') as zenit,
       
       nvl(max(case
            when 2 != c.id and 2 = g.id2 and g.goals1 > g.goals2 then  g.goals1||':'||g.goals2
            when 2 != c.id and 2 = g.id2 and g.goals1 < g.goals2 then  g.goals2||':'||g.goals1
            when 2 != c.id and 2 = g.id2 and g.goals1 = g.goals2 then  g.goals2||':'||g.goals1 
       end),' ') as spart, 

        nvl(max(case
            when 3 != c.id and 3 = g.id2 and g.goals1 > g.goals2 then  g.goals1||':'||g.goals2
            when 3 != c.id and 3 = g.id2 and g.goals1 < g.goals2 then  g.goals2||':'||g.goals1
            when 3 != c.id and 3 = g.id2 and g.goals1 = g.goals2 then  g.goals2||':'||g.goals1 
       end), ' ') as csk,
       
        nvl(max(case
            when 4 != c.id and 4 = g.id2 and g.goals1 > g.goals2 then  g.goals1||':'||g.goals2
            when 4 != c.id and 4 = g.id2 and g.goals1 < g.goals2 then  g.goals2||':'||g.goals1
            when 4 != c.id and 4 = g.id2 and g.goals1 = g.goals2 then  g.goals2||':'||g.goals1 
       end), ' ') as himki,
       
       to_char(sum(case
            when g.id1 = c.id and g.goals1 > g.goals2 or    
                 g.id2 = c.id and g.goals1 < g.goals2 then 1    
            when g.goals1 = g.goals2 then 0    
       end)) as wins,
       
       to_char(6- sum(case when g.id1 = c.id and g.goals1 > g.goals2 or g.id2 = c.id and g.goals1 < g.goals2 then 1    
       when g.goals1 = g.goals2 then 0 end) -
       sum(case when g.id1 = c.id and g.goals1 < g.goals2 or g.id2 = c.id and g.goals1 > g.goals2 then 1    
       when g.goals1 = g.goals2 then 0 end)) as neitral,
       
       to_char(sum(case
            when g.id1 = c.id and g.goals1 < g.goals2 or    
                 g.id2 = c.id and g.goals1 > g.goals2 then 1    
            when g.goals1 = g.goals2 then 0    
       end)) as lose, 
     
       to_char(sum(case
            when g.id1 = c.id then g.goals1    
            when g.id2 = c.id then g.goals2    
       end)) as win_goal, 
       
       to_char(sum(case
            when g.id1 = c.id then g.goals2    
            when g.id2 = c.id then g.goals1    
       end)) as lose_goal, 
       
       to_char(sum(case
            when g.id1 = c.id and g.goals1 > g.goals2 then 3    
            when g.id1 = c.id and g.goals1 = g.goals2 then 1    
       end)) as points_home, 
       
       to_char(sum(case
            when g.id2 = c.id and g.goals1 < g.goals2 then 3    
            when g.id2 = c.id and g.goals1 = g.goals2 then 1    
       end)) as points_guest,
       
       to_char(sum(case
            when g.id1 = c.id and g.goals1 > g.goals2 or    
                 g.id2 = c.id and g.goals1 < g.goals2 then 3    
            when g.goals1 = g.goals2 then 1    
            end)) as points_total   
  from commands c    
  join game_results g    
    on c.id = g.id1    
    or c.id = g.id2    
 group by c.id, c.name    
 order by 1;