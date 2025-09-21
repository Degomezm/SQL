CREATE EXTENSION pgcrypto;

INSERT INTO "user" (username, "password")
VALUES(
	'jazmin',
	crypt('123456', gen_salt('bf'))
);


SELECT * FROM "user" 
where username='benzini' AND
"password" = crypt('123456', "password");


CREATE OR REPLACE PROCEDURE user_login(user_name VARCHAR, user_password VARCHAR)
AS $$

DECLARE was_found BOOLEAN;

BEGIN
	SELECT count(*) INTO was_found FROM "user" 
	where username = user_name AND
	"password" = crypt(user_password, "password");
	
	IF was_found = FALSE THEN
		INSERT INTO session_failed(username, "when")
		VALUES(user_name, now());
		COMMIT;
		
		raise EXCEPTION 'Usuario y contraseña no son correctos';
		
	END IF;
	
	UPDATE "user" SET last_login = now() WHERE username = user_name;
	COMMIT;
	raise notice 'Usuario encontrado %', was_found;
END;
$$
LANGUAGE plpgsql;
 
CALL user_login('benzini', '123456 ');

CREATE OR REPLACE TRIGGER create_session_trigger 
	AFTER UPDATE on "user"
	FOR EACH ROW
	WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
	EXECUTE FUNCTION create_session_log();


CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO "session"(user_id, last_login)
	VALUES(NEW.id, now());
	
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;