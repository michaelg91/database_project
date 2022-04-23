-- Zadanie 2
-- Stworz ranking 10 najlepiej zbierajacych i przechwytujacych graczy
-- Przechwyty
select
    *
from(
select
    p.full_name,
    d.player_teamid,
    d.steals_per_game,
    rank() over (order by steals_per_game desc) steals_rank
from defense_stats d JOIN player_team pt ON d.player_teamid = pt.idplayer_team
                     JOIN players p ON p.idplayer = pt.playerid)t1
where
     t1.steals_rank <=10
/
-- Zbiórki
select
    *
from(
select
    p.full_name,
    r.player_teamid,
    r.rebounds_per_game,
    rank() over (order by rebounds_per_game desc) rebounds_rank
from rebounds_stats r JOIN player_team pt ON r.player_teamid = pt.idplayer_team
                     JOIN players p ON p.idplayer = pt.playerid)t1
where
     t1.rebounds_rank <= 10
/