--Zadanie 8
--Stwórz procedurê, która pozwoli zaktualizowaæ dowolne dane ka¿dego zawodnika
create or replace NONEDITIONABLE PROCEDURE PRO_PLAYERS 
(
  VAR_FULL_NAME IN VARCHAR2 
, VAR_AGE IN NUMBER 
, VAR_POSITION IN VARCHAR2 
) 
AS
  var_exists INT :=0;
BEGIN
    select
        count(*) INTO var_exists
    from players
    where full_name = var_full_name;
    
    IF var_exists > 0 THEN
        update players set age = var_age, position = var_position where full_name = var_full_name;
    ELSE 
        dbms_output.put_line('There is no player with this name in the database');
    END IF;
        
        
  
END PRO_PLAYERS;
/
exec pro_players('Will Barton',31, 'G-F')