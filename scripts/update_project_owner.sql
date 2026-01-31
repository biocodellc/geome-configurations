-- Example script for changing project owner

--verify current project id, title, and owner
select projects.id,projects.project_title,users.username,users.id from projects,users where projects.user_id = users.id and projects.project_title like '%Datathon%';
--where projects.user_id = users.id and projects.id = 282;

-- get user_id for new user
select id,username from users where username like '%mery%'; 
--359

update projects set user_id = 359 where projects.id = 282;


-- SRA datathon scripts
select projects.id,projects.project_title,users.username,users.id from projects,users where projects.user_id = users.id and projects.project_title like '%Datathon%';
--select projects.id,users.username,users.id as users_id,projects.project_title as users_id from projects,users where projects.user_id = users.id and projects.project_title like '%Datathon%';
--update projects set user_id = 1 where projects.id = 305;
-- Resetting SRA datathon
update projects set user_id = 19 where projects.id = 305;
update project_configurations set user_id = 19 where id = 80;
