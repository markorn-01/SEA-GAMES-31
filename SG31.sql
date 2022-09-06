create table summ as (
    select home_team team,
           1 Pld,
           if(home_score > away_score, 1, 0) W,
           if(home_score = away_score, 1, 0) D,
           if(home_score < away_score, 1, 0) L,
           home_score F,
           away_score A,
           home_score-away_score gd,
           case when(home_score > away_score) then 3 when(home_score = away_score) then 1 else 0 end Pts
    from groupA_SG31
    union all
    select away_team,
           1,
           if(home_score < away_score, 1, 0),
           if(home_score = away_score, 1, 0),
           if(home_score > away_score, 1, 0),
           away_score,
           home_score,
           away_score-home_score,
           case when(away_score > home_score) then 3 when(home_score = away_score) then 1 else 0 end
    from groupA_SG31
); 

select team as team, sum(Pld) as Pld, sum(W) as W, sum(D) as D, sum(L) as L, sum(F) as GF, sum(A) as GA, sum(GD) as GD, sum(Pts) as Pts
from(select team , 1 pld, w, d, l, f, a, gd, pts from summ)
group by team
order by Pts desc;