--Zadanie 4 Sezon Regularny
--Pokaz nazwisko zawodnika, ktory spedzil najwiecej czasu na parkiecie(SZ, PO, SZ+PO)
select
    p.full_name,
    g.rs_minutes_per_game
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN games g ON g.player_teamid = pt.idplayer_team
where 
    g.rs_minutes_per_game = (select
                                    max(rs_minutes_per_game)
                             from games)
/
--Zadanie 4 Sezon Playoff
select
    p.full_name,
    g.po_minutes_per_game
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN games g ON g.player_teamid = pt.idplayer_team
where 
    g.po_minutes_per_game = (select
                                    max(po_minutes_per_game)
                             from games)
/
-- Zadanie 4 Sezon regularny + Playoff
select
    p.full_name,
    g.rs_minutes_per_game + g.po_minutes_per_game suma
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN games g ON g.player_teamid = pt.idplayer_team
where 
    g.rs_minutes_per_game + g.po_minutes_per_game  = (select
                                    max(rs_minutes_per_game + po_minutes_per_game)
                             from games)
/