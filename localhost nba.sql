-- Tworzenie tabel i relacji pomiedzy nimi

create table nbaregularseason (
    Ranking int,
    Full_name varchar2(30),
    Team varchar2(10),
    Position varchar2(10),
    Age number,
    Games_played number,
    Minute_per_game number, 
    Minutes_Percentage number,
    Usage_Rate_percentage number,
    Turnovers number,
    Free_Throws_attempted number,
    Free_Throws_procente number,
    Two_points_attempted number,
    Two_points_procente number,
    three_points_attempted number,
    three_points_procente number,
    Effective_Shooting_Percentage number,
    True_Shooting_Percentage number,
    Points_per_game number,
    Rebounds_per_game number,
    Total_Rebound_Percentage number,
    Assists_per_game number,
    Assist_Percentage number,
    Steals_per_game number,
    Blocks_per_game number,
    Turnovers_per_game number,
    Index_Versatility number,
    Offensive_rating_individual number,
    Defensive_rating_individual number
)
/
create table nbaplayoff (
    Ranking int,
    Full_name varchar2(30),
    Team varchar2(10),
    Position varchar2(10),
    Age number,
    Games_played number,
    Minute_per_game number, 
    Minutes_Percentage number,
    Usage_Rate_percentage number,
    Turnovers number,
    Free_Throws_attempted number,
    Free_Throws_procente number,
    Two_points_attempted number,
    Two_points_procente number,
    three_points_attempted number,
    three_points_procente number,
    Effective_Shooting_Percentage number,
    True_Shooting_Percentage number,
    Points_per_game number,
    Rebounds_per_game number,
    Total_Rebound_Percentage number,
    Assists_per_game number,
    Assist_Percentage number,
    Steals_per_game number,
    Blocks_per_game number,
    Turnovers_per_game number,
    Index_Versatility number,
    Offensive_rating_individual number,
    Defensive_rating_individual number
)
/
create table players
(idplayer int generated as identity,
full_name varchar2(200),
age number,
positionid int,
position varchar(30))
/
insert into players (full_name, age,positionid , position)
select 
    distinct full_name,
    age,
    null,
    position
from nbaregularseason
/

create table position
(idposition int generated as identity,
position varchar(30),
full_name_position varchar(50))
/
insert into position(position,full_name_position)
select 
    distinct position,
    null
from nbaregularseason
/
select * from player_team
order by playerid
/
update players p set positionid = (select idposition from position
                                    where p.position=position)
/
select * from position
/
create table teams
(idteam int generated as identity,
team varchar(30),
full_name_team varchar(50))
/
insert into teams (team,full_name_team)
select
    distinct team,
    null
from nbaregularseason

/
select * from teams
/
create table player_team
(idplayer_team int generated as identity,
playerid int,
full_name varchar(200),
teamid int,
team varchar(50))
/
insert into player_team (playerid, full_name, teamid,team)
select
    null,
    full_name,
    null,
    team
from nbaregularseason
/
select * from player_team
order by playerid desc
/

update player_team t set teamid = (select  distinct idteam 
                                    from teams
                                    where t.team = team
                                    )
/
update player_team t set playerid = (select
                                         idplayer 
                                    from players
                                    where t.full_name = full_name
                                    and rownum = 1
                                    )
/
select * from player_team
order by playerid asc
/
select * from players
order by 1
/
alter table players add constraints pk_players PRIMARY KEY (idplayer)
/
ALTER TABLE player_team
ADD CONSTRAINT playersid_fk FOREIGN KEY (playerid)
REFERENCES players (idplayer)
/

alter table teams add constraints pk_teams PRIMARY KEY (idteam)
/
ALTER TABLE player_team
ADD CONSTRAINT teamid_fk FOREIGN KEY (teamid)
REFERENCES teams (idteam);
/
alter table position add constraints pk_position PRIMARY KEY (idposition);
/
ALTER TABLE players
ADD CONSTRAINT position_fk FOREIGN KEY (positionid)
REFERENCES position (idposition);
/
create table games (
player_teamid int,
full_name varchar(50),
team varchar(50),
rs_games_played number,
rs_minutes_per_game number,
rs_minutes_percentage number,
rs_usage_rate_percentage number,
po_games_played number,
po_minutes_per_game number,
po_minutes_percentage number,
po_usage_rate_percentage number
)
/
insert into games (player_teamid,full_name,team,rs_games_played,rs_minutes_per_game,
rs_minutes_percentage,rs_usage_rate_percentage,po_games_played,po_minutes_per_game,po_minutes_percentage
,po_usage_rate_percentage)
select
    null,
    full_name,
    team,
    games_played,
    minute_per_game,
    minutes_percentage,
    usage_rate_percentage,
    null,
    null,
    null,
    null
from nbaregularseason
/
select * from games
order by player_teamid desc
/
update games g set (po_games_played, po_minutes_per_game, 
po_minutes_percentage, po_usage_rate_percentage) = (select
                                                     games_played,
                                                     minute_per_game,
                                                     minutes_percentage,
                                                     usage_rate_percentage
                                                    from nbaplayoff
                                                    where g.full_name = full_name
                                                    and g.team = team)
                                                    
/
update games g set player_teamid = (select
                                        idplayer_team
                                    from player_team
                                    where g.full_name=full_name
                                    and g.team = team
                                    )
/
select * from games
order by 1
/
select * from player_team
order by 1
/
alter table player_team add constraints pk_player_teamid PRIMARY KEY (idplayer_team)
/
ALTER TABLE games
ADD CONSTRAINT player_team_games_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table turnovers_stats (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    Turnovers_per_game number, 
    Turnovers_rate number,
    po_Turnovers_per_game number,
    po_Turnovers_rate number)
/
insert into turnovers_stats (player_teamid,full_name,team,Turnovers_per_game,Turnovers_rate,po_Turnovers_per_game,po_Turnovers_rate)
select
    null,
    full_name,
    team,
    Turnovers_per_game,
    Turnovers,
    null,
    null
from nbaregularseason
/
select * from turnovers_stats
/
update turnovers_stats t set (po_Turnovers_per_game,po_Turnovers_rate) = (select
                                                     Turnovers_per_game,
                                                     Turnovers
                                                    from nbaplayoff
                                                    where t.full_name = full_name
                                                    and t.team = team)
/
update turnovers_stats t set player_teamid = (select
                                        idplayer_team
                                    from player_team
                                    where t.full_name=full_name
                                    and t.team = team)
/

ALTER TABLE turnovers_stats
ADD CONSTRAINT player_team_games_turnovers_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table defense_stats (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    steals_per_game number,
    blocks_per_game number,
    po_steals_per_game number,
    po_blocks_per_game number)
/
insert into defense_stats (player_teamid,full_name,team,steals_per_game,blocks_per_game,po_steals_per_game,
po_blocks_per_game)
select
    null,
    full_name,
    team,
    steals_per_game,
    blocks_per_game,
    null,
    null
from nbaregularseason
/
update defense_stats d set (po_steals_per_game,po_blocks_per_game) = (select
                                                     steals_per_game,
                                                     blocks_per_game
                                                    from nbaplayoff
                                                    where d.full_name = full_name
                                                    and d.team = team)
/
update defense_stats d set player_teamid = (select distinct
                                        idplayer_team
                                    from player_team
                                    where d.full_name=full_name and
                                   d.team = team)
/
select * from defense_stats
/
ALTER TABLE defense_stats
ADD CONSTRAINT player_team_defense_stats_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table assists_stats (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    Assists_per_game number,
    Assists_Percentage number,
    po_Assists_per_game number,
    po_Assists_Percentage number)
/
insert into assists_stats (player_teamid,full_name,team,Assists_per_game,Assists_Percentage,po_Assists_per_game,
po_Assists_Percentage)
select
    null,
    full_name,
    team,
    Assists_per_game,
    Assist_Percentage,
    null,
    null
from nbaregularseason
/
update assists_stats a set (po_Assists_per_game,po_Assists_Percentage) = (select
                                                     Assists_per_game,
                                                     Assist_Percentage
                                                    from nbaplayoff
                                                    where a.full_name = full_name
                                                    and a.team = team)
/
update assists_stats a set player_teamid = (select 
                                        idplayer_team
                                    from player_team
                                    where a.full_name=full_name and
                                   a.team = team)
/
select * from assists_stats
/
ALTER TABLE assists_stats
ADD CONSTRAINT player_team_assists_stats_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table rebounds_stats (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    rebounds_per_game number,
    rebounds_Percentage number,
    po_rebounds_per_game number,
    po_rebounds_Percentage number)
/
insert into rebounds_stats (player_teamid,full_name,team,rebounds_per_game,rebounds_Percentage,po_rebounds_per_game,
po_rebounds_Percentage)
select
    null,
    full_name,
    team,
    rebounds_per_game,
    total_rebound_percentage,
    null,
    null
from nbaregularseason
/
update rebounds_stats r set (po_rebounds_per_game,po_rebounds_Percentage) = (select
                                                     rebounds_per_game,
                                                     total_rebound_percentage
                                                    from nbaplayoff
                                                    where r.full_name = full_name
                                                    and r.team = team)
/
update rebounds_stats r set player_teamid = (select 
                                        idplayer_team
                                    from player_team
                                    where r.full_name=full_name and
                                   r.team = team)
/
select * from rebounds_stats
/
ALTER TABLE rebounds_stats
ADD CONSTRAINT player_team_rebounds_stats_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table individual_rating (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    offensive_rating number,
    defensive_rating number,
    index_versatility number,
    po_offensive_rating number,
    po_defensive_rating number,
    po_index_versatility number)
/
insert into individual_rating (player_teamid,full_name,team,offensive_rating,defensive_rating,index_versatility,
po_offensive_rating,po_defensive_rating,po_index_versatility)
select
    null,
    full_name,
    team,
    offensive_rating_individual,
    defensive_rating_individual,
    index_versatility,
    null,
    null,
    null
from nbaregularseason
/
update individual_rating i set (po_offensive_rating,po_defensive_rating,po_index_versatility) = (select
                                                     offensive_rating_individual,
                                                     defensive_rating_individual,
                                                     index_versatility
                                                    from nbaplayoff
                                                    where i.full_name = full_name
                                                    and i.team = team)
/
update individual_rating i set player_teamid = (select 
                                        idplayer_team
                                    from player_team
                                    where i.full_name=full_name and
                                   i.team = team)
/
select * from individual_rating
/
ALTER TABLE individual_rating
ADD CONSTRAINT player_team_individual_rating_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table shooting_attempted (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    free_throws number,
    two_points number,
    three_points number,
    points_per_game number,
    po_free_throws number,
    po_two_points number,
    po_three_points number,
    po_points_per_game number)
/
insert into shooting_attempted (player_teamid,full_name,team,free_throws,two_points,three_points,
points_per_game,po_free_throws,po_two_points,po_three_points,po_points_per_game)
select
    null,
    full_name,
    team,
    free_throws_attempted,
    two_points_attempted,
    three_points_attempted,
    points_per_game,
    null,
    null,
    null,
    null
from nbaregularseason
/
update shooting_attempted s set (po_free_throws,po_two_points,po_three_points,po_points_per_game) = (select
                                                     free_throws_attempted,
                                                     two_points_attempted,
                                                     three_points_attempted,
                                                     points_per_game
                                                    from nbaplayoff
                                                    where s.full_name = full_name
                                                    and s.team = team)
/
update shooting_attempted s set player_teamid = (select 
                                        idplayer_team
                                    from player_team
                                    where s.full_name=full_name and
                                   s.team = team)
/
select * from shooting_attempted
/
ALTER TABLE shooting_attempted
ADD CONSTRAINT player_team_shooting_attempted_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/
create table shooting_percentage (
    player_teamid int,
    full_name varchar(50),
    team varchar(50),
    free_throws_percentage number,
    two_points_percentage  number,
    three_points_percentage  number,
    true_shooting_percentage number,
    effective_shooting_percentage number,
    po_free_throws_percentage  number,
    po_two_points_percentage  number,
    po_three_points_percentage  number,
    po_true_shooting_percentage number,
    po_effective_shooting_percentage number)
/
insert into shooting_percentage (player_teamid,full_name,team,free_throws_percentage,two_points_percentage,three_points_percentage,
true_shooting_percentage,effective_shooting_percentage,po_free_throws_percentage,po_two_points_percentage,po_three_points_percentage,
po_true_shooting_percentage,po_effective_shooting_percentage)
select
    null,
    full_name,
    team,
    free_throws_procente,
    two_points_procente,
    three_points_procente,
    true_shooting_percentage,
    effective_shooting_percentage,
    null,
    null,
    null,
    null,
    null
from nbaregularseason
/
update shooting_percentage s set (po_free_throws_percentage,po_two_points_percentage,po_three_points_percentage,
                                    po_true_shooting_percentage,po_effective_shooting_percentage) = 
                                    (select
                                        free_throws_procente,
                                        two_points_procente,
                                        three_points_procente,
                                        true_shooting_percentage,
                                        effective_shooting_percentage
                                    from nbaplayoff
                                    where s.full_name = full_name
                                    and s.team = team)
/
update shooting_percentage s set player_teamid = (select 
                                        idplayer_team
                                    from player_team
                                    where s.full_name=full_name and
                                   s.team = team)
/
select * from shooting_percentage
order by 1
/
ALTER TABLE shooting_percentage
ADD CONSTRAINT player_team_shooting_percentage_fk FOREIGN KEY (player_teamid)
REFERENCES player_team (idplayer_team);
/