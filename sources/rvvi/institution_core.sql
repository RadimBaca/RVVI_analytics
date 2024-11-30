select i.iid, i.name, i.town, COUNT(distinct a.aid) cnt
from institution i
join article_institution ai on i.iid = ai.iid
join article a on a.aid = ai.aid
join year_field_journal y on y.jid = a.jid and y.year = a.year
where y.ranking = 'decil'
group by i.iid, i.name, i.town, i.postal_code, i.street
having COUNT(*) > 50
order by cnt desc