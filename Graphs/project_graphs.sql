
-- Graph 1: number of friend requests as a function of number of notifications
select num_notf, avg(num_requ)
from (
select count(distinct N.NOTIFICATION_ID) as num_notf,
       count(distinct FR.REQU_ID) as num_requ
from notification N
       natural join 
       afeder.profile P
       join
       ydemri.friendshiprequest FR
       on profile_id = FR.RECIEVER_ID
group by profile_id)
group by num_notf;

-- Graph 2: popularity based on gender
select gender, count(*)
from (
     select FR.RECIEVER_ID as profile_id, first_name, last_name, gender
     from friendshiprequest FR join afeder.profile P on FR.RECIEVER_ID = P.PROFILE_ID
     group by FR.RECIEVER_ID, first_name, last_name, P.gender
     having count(*) > 5) T
group by gender
