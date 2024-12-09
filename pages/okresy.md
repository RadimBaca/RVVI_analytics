---
title: Počet článků dle okresu
---



<Dropdown 
    title="FORD:"
    data={ford} 
    name=ford_picker 
    value=name>
    <DropdownOption value="%" valueLabel="All Ford Fields"/>
</Dropdown>

<AreaMap
    data={clanky_v_okresech}
    geoJsonUrl='/rvvi/okresy.json'
    areaCol=KODOKRESU
    geoId=nationalCode
    startingLat=49.8
    startingLong=15.4
    startingZoom=7
    height=400
    value=article_count
/>



```clanky_v_okresech
select kodokresu, sum(aid_count) article_count
from psc.psc
join rvvi.article_core i on i.postal_code = psc.psc
where i.f_name LIKE '${inputs.ford_picker.value}'
group by kodokresu
```


```ford
select name
from rvvi.field_ford
```

