---
title: Výsledky RVVI
---


<Details title='Zdroj dat'>

Jako zdroj dat byly použity data z veřejné databáze [RVVI](https://hodnoceni.rvvi.cz/`).
</Details>

## Počet článků podle oblasti vědy

<Dropdown 
  data={fos} 
  name=fos 
  value=name>
    <DropdownOption value="%" valueLabel="All Fields"/>
</Dropdown>


<BarChart
    data={articles_by_fos}
    title="Articles by Year, {inputs.fos.label}"
    x=year
    y=count
    series=name
/>

## Instituce

<Dropdown 
    data={ford} 
    name=ford_picker 
    value=name>
    <DropdownOption value="%" valueLabel="All Ford Fields"/>
</Dropdown>

<BarChart
    data={articles_by_institution}
    title="Články dle instituce a ranking, {inputs.ford_picker.label}"
    x=name
    y=ranking_cnt
    series=ranking
    seriesOrder={['decil', 'Q1', 'Q2', 'Q3', 'Q4']}
    swapXY=true
/>


```fos
select name
from rvvi.field_of_science
```


```articles_by_fos
select fos.name, ac.year, SUM(aid_count) count
from rvvi.field_of_science fos
join rvvi.article_core ac on fos.sid = ac.sid
where fos.name LIKE '${inputs.fos.value}'
group by fos.sid, fos.name, ac.year
order by fos.sid
```

```ford
select name
from rvvi.field_ford
```

```articles_by_institution
select concat(rnk, '. ', i_name) as name, *
from (
  select *,
    dense_rank() over (order by cnt desc) rnk
  from (
    select ac.iid, ac.i_name, ac.ranking, 
      sum(aid_count) ranking_cnt,
      max(sum(case when ac.ranking = 'Decil' or ac.ranking = 'Q1' then aid_count end)) over (partition by ac.iid) cnt,
    from rvvi.article_core ac
    where ac.f_name LIKE '${inputs.ford_picker.value}'
    group by ac.iid, ac.i_name, ac.ranking 
  ) t
) t
where rnk <= 15 and cnt is not null and cnt > 0
order by rnk
```
