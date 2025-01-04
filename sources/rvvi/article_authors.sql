select ff.sid, ff.fid, ff.name as f_name,
    AVG(CAST(a.author_count as FLOAT)) aid_count
from field_ford ff 
join year_field_journal y on ff.fid = y.fid
join article a on y.jid = a.jid and y.year = a.year
group by ff.sid, ff.fid, ff.name