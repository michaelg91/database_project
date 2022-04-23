--Zadanie 10
--Stwórz widok, który poka¿e ile procent punktów zdoby³ ka¿dy zawodnik wzglêdem wszystkich punktów swojej dru¿yny
select
    t1.*,
    concat(round(t1.points_per_game/t1.team_points * 100,2), '%')procent
from (    
select
    pt.idplayer_team,
    p.full_name,
    t.team,
    s.points_per_game,
    sum(s.points_per_game) over (partition by t.team order by s.points_per_game desc
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) team_points
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN teams t ON t.idteam = pt.teamid
               JOIN shooting_attempted s ON s.player_teamid = pt.idplayer_team) t1
/