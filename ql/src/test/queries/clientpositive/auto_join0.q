--! qt:dataset:src1
--! qt:dataset:src
set hive.mapred.mode=nonstrict;
set hive.explain.user=false;
set hive.auto.convert.join = true;

-- SORT_QUERY_RESULTS

explain 
select sum(hash(a.k1,a.v1,a.k2, a.v2))
from (
SELECT src1.key as k1, src1.value as v1, 
       src2.key as k2, src2.value as v2 FROM 
  (SELECT * FROM src WHERE src.key < 10 order by src.key, src.value) src1
    JOIN 
  (SELECT * FROM src WHERE src.key < 10 order by src.key, src.value) src2
  SORT BY k1, v1, k2, v2
) a;

select sum(hash(a.k1,a.v1,a.k2, a.v2))
from (
SELECT src1.key as k1, src1.value as v1, 
       src2.key as k2, src2.value as v2 FROM 
  (SELECT * FROM src WHERE src.key < 10 order by src.key, src.value) src1
    JOIN 
  (SELECT * FROM src WHERE src.key < 10 order by src.key, src.value) src2
  SORT BY k1, v1, k2, v2
) a;
