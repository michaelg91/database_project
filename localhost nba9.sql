-- Zadanie 9
/*Po ka�dej aktualizacji danych procedur� z punktu 8 powinni�my
mie� wpis we wcze�niej stworzonej tabeli log�w 
z informacj� co i na co zosta�o zmienione. Wykorzystaj funkcjonalno�� trigger�w*/
create table players_log (id int generated always as identity,update_time timestamp, old_data varchar(50), new_data varchar(50))
/
CREATE OR REPLACE TRIGGER trig_players
AFTER UPDATE 
    ON players
FOR EACH ROW
BEGIN
    IF UPDATING('age') THEN
    insert into players_log(update_time, old_data, new_data) values
                (current_timestamp, :OLD.age, :NEW.age);
    ELSIF UPDATING('position') THEN 
        insert into players_log(update_time, old_data, new_data) values
                (current_timestamp, :OLD.position, :NEW.position);
    END IF;            
END;
/