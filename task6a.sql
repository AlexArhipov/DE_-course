select parent_id,
       name,
       replace(replace(replace(replace(replace('0'||reverse(sys_connect_by_path(sex,',')),',',''),'F','���� '),'M','���� '),'0����','����'),'0����','����') who,
       replace(replace(replace(replace(replace(translate(replace(sex, 'M', '����')||replace(sex, 'F', '����'), 'FM', '  '), ' ')||
       substr(replace(sys_connect_by_path('���', ','), ',')||
       replace(translate(replace(sex, 'M', '�������')||replace(sex, 'F', '�������'), 'FM', '  '), ' '), 4),
       '�����������', '����'), '�����������', '����'), '�������', ''), '�������', '') who2 from
            (select relative_links.parent_id, relative_links.id, relatives.name, relatives.sex from relative_links
            left join relatives on relatives.id = relative_links.parent_id)
connect by prior parent_id = id start with id = 1
order by parent_id