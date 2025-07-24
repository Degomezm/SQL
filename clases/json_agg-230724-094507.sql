select 
	json_agg( json_build_object(
	  'user', comments.user_id,
	  'comment', comments.content
	))
from comments where comment_parent_id = 1;

