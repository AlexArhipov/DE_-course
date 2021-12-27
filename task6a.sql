select parent_id,
       name,
       replace(replace(replace(replace(replace('0'||reverse(sys_connect_by_path(sex,',')),',',''),'F','мамы '),'M','папы '),'0мамы','мама'),'0папы','папа') who,
       replace(replace(replace(replace(replace(translate(replace(sex, 'M', 'папа')||replace(sex, 'F', 'мама'), 'FM', '  '), ' ')||
       substr(replace(sys_connect_by_path('пра', ','), ',')||
       replace(translate(replace(sex, 'M', 'дедушка')||replace(sex, 'F', 'бабушка'), 'FM', '  '), ' '), 4),
       'пападедушка', 'папа'), 'мамабабушка', 'мама'), 'мамапра', ''), 'папапра', '') who2 from
            (select relative_links.parent_id, relative_links.id, relatives.name, relatives.sex from relative_links
            left join relatives on relatives.id = relative_links.parent_id)
connect by prior parent_id = id start with id = 1
order by parent_id