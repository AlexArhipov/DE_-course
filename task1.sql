CREATE or replace VIEW VI as (select replace(NAME, ' ') NAMES, length(replace(translate(NAME, 'בגדהזחיךכלםןנסעפץצקרשüתÁÂÃÄÆÇÉÊËÌÍÏÐÑÒÔÕÖ×ØÙ','
                                          '),' ')) counts, length(NAME)-length(replace(NAME, ' ')) maxs, length(NAME)-length(replace(NAME, ' ')) mins  from cities);

select NAMES, max(counts), min(mins), max(maxs)  from VI
GROUP BY NAMES
order by NAMES