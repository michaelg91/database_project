-- Zadanie 1
-- Poka¿ najstarszego zawodnika w ka¿dym zespole w sezonie zasadniczym (SZ)
select
    p.full_name,
    p.age,
    t.full_name_team
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN teams t ON t.idteam = pt.teamid
where (p.age , t.full_name_team) IN
    (select 
        max(p.age),
        t.full_name_team
    from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN teams t ON t.idteam = pt.teamid
    group by t.full_name_team
    )