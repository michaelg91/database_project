-- Zadanie 1
-- Pokaz najstarszego zawodnika w kazdym zespole w sezonie zasadniczym (SZ)
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
/	
-- Zadanie 1 druga opcja
select t.team, max(p.age) as age,
       max(p.full_name) keep (dense_rank FIRST order by p.age desc) as person
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN teams t ON t.idteam = pt.teamid
group by t.team
