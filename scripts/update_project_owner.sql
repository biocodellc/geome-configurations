-- Example script for changing project owner

--verify current project id, title, and owner
--select projects.id,projects.project_title,users.username,users.id from projects,users 
--where projects.user_id = users.id and projects.id = 282;

-- get user_id for new user
--select id,username from users where username like '%mery%'; 
--359

--update projects set user_id = 359 where projects.id = 282;