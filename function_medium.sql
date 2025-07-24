select 
	json_agg( json_build_object(
	  'user', comments.user_id,
	  'comment', comments.content
	))
from comments where comment_parent_id = 1;

CREATE
OR REPLACE FUNCTION comment_replies (id INTEGER) 
RETURNS JSON
AS
$$
DECLARE result json;

BEGIN

	select 
		json_agg( json_build_object(
		  'user', comments.user_id,
		  'comment', comments.content
		)) INTO result
	from comments 
	where comment_parent_id = id;
	
	RETURN result;
END
$$ 
LANGUAGE plpgsql;


SELECT comment_replies(1);

SELECT
  a.*,
  comment_replies(a.comment_id) as replies  
FROM
  "comments" a
where
  a.comment_parent_id is null;

------------------------------------------------------------


CREATE
OR REPLACE FUNCTION sayHello (user_name VARCHAR) 
RETURNS VARCHAR 
AS
$$
BEGIN

	RETURN 'Hola '|| user_name;

END
$$ 
LANGUAGE plpgsql;


SELECT sayhello(users."name")  FROM users;