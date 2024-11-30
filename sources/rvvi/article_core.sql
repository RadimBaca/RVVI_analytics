select ff.sid, ff.fid, ff.name as f_name, 
    y.year, y.ranking, 
    ai.iid, i.name as i_name, i.town, i.postal_code, i.street,
    COUNT(distinct a.aid) aid_count
from field_ford ff 
join year_field_journal y on ff.fid = y.fid
join article a on y.jid = a.jid and y.year = a.year
join article_institution ai on ai.aid = a.aid
join institution i on i.iid = ai.iid
group by ff.sid, ff.fid, ff.name, 
    y.year, y.ranking, 
    ai.iid, i.name, i.town, i.postal_code, i.street
