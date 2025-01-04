select i.iid, i.name,i.postal_code, i.town, i.street
from institution as i
join article_institution as ai on i.iid = ai.iid
group by i.iid, i.name,i.postal_code, i.town, i.street
having COUNT(*) > 500
