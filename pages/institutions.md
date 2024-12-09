---
title: Počet článků dle instituce
---



<Dropdown 
    title="FORD:"
    data={ford} 
    name=ford_picker 
    value=name>
    <DropdownOption value="%" valueLabel="All Ford Fields"/>
</Dropdown>

<Tabs>

    <Tab label="Absolutní počty článků">
      <BarChart
          data={articles_by_institution}
          title="Články dle instituce a ranking"
          x=name
          y=ranking_cnt
          series=ranking
          seriesOrder={['decil', 'Q1', 'Q2', 'Q3', 'Q4']}
          swapXY=true
          sort=false
      />
    </Tab>
    <Tab label="Poměry počtů článků dle ranking">
      <BarChart
          data={articles_by_institution}
          title="Počet článků dle instituce"
          x=name
          y=ranking_cnt
          series=ranking
          seriesOrder={['decil', 'Q1', 'Q2', 'Q3', 'Q4']}
          type=stacked100
          swapXY=true
          sort=false
      />
    </Tab>    
</Tabs>




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
      sum(sum(case when ac.ranking = 'Decil' or ac.ranking = 'Q1' then aid_count end)) over (partition by ac.iid) cnt,
    from rvvi.article_core ac
    where ac.f_name LIKE '${inputs.ford_picker.value}'
    group by ac.iid, ac.i_name, ac.ranking 
  ) t
) t
where rnk <= 15 and cnt is not null and cnt > 0
order by rnk
```
