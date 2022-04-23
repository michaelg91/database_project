--Zadanie 5 Sezon regularny
--Wska¿ najlepiej rzucaj¹cego rzuty osobiste na ka¿dej pozycji osobno dla SZ i PO
select
    p.full_name,
    o.position,
    s.free_throws_percentage
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_percentage s ON s.player_teamid = pt.idplayer_team
               JOIN position o ON o.idposition = p.positionid
where (s.free_throws_percentage, o.position) IN  (select
                                                        max(s.free_throws_percentage),
                                                        o.position
                                                    from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_percentage s ON s.player_teamid = pt.idplayer_team
               JOIN position o ON o.idposition = p.positionid
               group by o.position)
/
--Zadanie 5 Playoffy
select
    p.full_name,
    o.position,
    s.po_free_throws_percentage
from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_percentage s ON s.player_teamid = pt.idplayer_team
               JOIN position o ON o.idposition = p.positionid
where (s.po_free_throws_percentage, o.position) IN  (select
                                                        max(s.po_free_throws_percentage),
                                                        o.position
                                                    from players p JOIN player_team pt ON p.idplayer = pt.playerid
               JOIN shooting_percentage s ON s.player_teamid = pt.idplayer_team
               JOIN position o ON o.idposition = p.positionid
               group by o.position)
/