-- Zadanie 9
/*Po kazdej aktualizacji danych procedura z punktu 8 powinnismy
miec wpis we wczesniej stworzonej tabeli logow 
z informacja co i na co zostalo zmienione. Wykorzystaj funkcjonalnosc triggerow*/
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