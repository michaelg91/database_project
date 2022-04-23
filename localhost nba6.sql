--Zadanie 6 -- Sezon regularny
--Korzystaj¹c z widoku zmaterializowanego poka¿ najlepiej punktuj¹cych zawodników SZ i PO
create materialized view mv_leader_ppg
build immediate 
refresh force
as
select
    p.full_name,
    sa.points_per_game
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_attempted sa ON sa.player_teamid = pt.idplayer_team
where sa.points_per_game = (select
                                max(points_per_game)
                            from shooting_attempted)
/
select * from mv_leader_ppg
/
--Zadanie 6 -- Playoff
create materialized view mv_leader_ppg_playoff
build immediate 
refresh force
as
select
    p.full_name,
    sa.po_points_per_game
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_attempted sa ON sa.player_teamid = pt.idplayer_team
where sa.po_points_per_game = (select
                                max(po_points_per_game)
                            from shooting_attempted)
/
select * from mv_leader_ppg_playoff