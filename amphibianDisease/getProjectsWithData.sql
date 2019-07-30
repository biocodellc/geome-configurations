select 
replace(substring_index(substring_index(d.carto_id,'table&quot;:&quot;',-1),'&quot',1),'&#95;','_') as tableID,
d.public,
count(*) as num_records,
d.project_title
from records_list r,disease_tracking_data d where r.project_id=d.project_id group by r.project_id;
