---
title: Obory FORD
---



## Počet článků dle oboru FORD

<Dropdown 
    title="Instituce:"
    data={institution} 
    name=institution_picker 
    value=name>
    <DropdownOption value="%" valueLabel="All Institutions"/>
</Dropdown>

<BarChart
    data={articles_by_ford}
    title="Počet článků dle oboru FORD a ranking"
    x=f_name
    y=ranking_cnt
    series=ranking
    seriesOrder={['decil', 'Q1', 'Q2', 'Q3', 'Q4']}
    swapXY=true
/>


## Průměrný počet autorů na článek dle oboru FORD

<BarChart
    data={articles_authors}
    title="Průměrný počet autorů na článek"
    x="Obor FORD"
    y="prumerny pocet autoru"
    swapXY=true
/>


```institution
select name
from rvvi.instution
```

```articles_by_ford
  select *,
    dense_rank() over (order by cnt desc) rnk
  from (
    select ac.fid, ac.f_name, ac.ranking, 
      sum(aid_count) ranking_cnt,
      max(sum(case when ac.ranking = 'Decil' or ac.ranking = 'Q1' then aid_count end)) over (partition by ac.fid) cnt,
    from rvvi.article_core ac
    where ac.i_name LIKE '${inputs.institution_picker.value}'
    group by ac.fid, ac.f_name, ac.ranking 
  ) t
```



```articles_authors
select f_name "Obor FORD", aid_count "prumerny pocet autoru"
from rvvi.article_authors
```
