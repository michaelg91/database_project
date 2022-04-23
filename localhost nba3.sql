-- Zadanie 3 pierwsza opcja
-- Pokaz najslabiej punktujacego srednio na minute zawodnika kazdej druzyny (SZ+PO)
select * from (
select
    t1.full_name,
    t1.points_per_minute,
    t1.team,
    t1.regularseasoplusplayoff,
    rank() over (partition by t1.team order by t1.points_per_minute asc) rank
from
(select
    pt.idplayer_team,
    p.full_name,
    t.team,
    round(sa.points_per_game + sa.po_points_per_game / g.rs_minutes_per_game + g.po_minutes_per_game,2) regularseasoplusplayoff,
    round(sa.points_per_game /g.rs_minutes_per_game ,2) points_per_minute
from player_team pt JOIN games g ON pt.idplayer_team = g.player_teamid
                    JOIN shooting_attempted sa ON sa.player_teamid = pt.idplayer_team
                    JOIN players p ON p.idplayer = pt.playerid 
                    JOIN teams t ON t.idteam = pt.teamid) t1) t2
where t2.rank = 1                   
/
-- Zadanie 3 druga opcja (SZ)
select  
    distinct t1.team,
    first_value(t1.full_name) over (partition by t1.team order by t1.points_per_minute asc) rank  
from
(select
    pt.idplayer_team,
    p.full_name,
    t.team,
    round(sa.points_per_game /g.rs_minutes_per_game ,2) points_per_minute
from player_team pt JOIN games g ON pt.idplayer_team = g.player_teamid
                    JOIN shooting_attempted sa ON sa.player_teamid = pt.idplayer_team
                    JOIN players p ON p.idplayer = pt.playerid 
                    JOIN teams t ON t.idteam = pt.teamid)t1
/