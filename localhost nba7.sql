-- Zadanie 7
/* Poka¿ punktacjê kanadyjsk¹(punkt + asysty) dla zawodników
o nazwiskach Jones, Brown, Bridges, Simmons i Thomas. Wykorzystaj wyra¿enia regularne */
select
    p.full_name,
    t.team,
    s.points_per_game,
    a.assists_per_game,
    s.points_per_game + a.assists_per_game canadian_scoring
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN teams t ON t.idteam = pt.teamid
               JOIN shooting_attempted s ON pt.idplayer_team = s.player_teamid
               JOIN assists_stats a ON pt.idplayer_team = a.player_teamid
where
    REGEXP_LIKE (p.full_name,'{1,}Brown$|{1,}Jones$|{1,}Bridges$|{1,}Simmons$|{1,}Thomas$')
/