-- Query 1 : active (more then X notifications) profiles who run BuisnessPage
select profile_id as manager_id,
       first_name,
       last_name,
       bp.bp_id as page_id,
       bp.page_name,
       bt.buisness_type_name as buisness_type,
       bp.followers_num,
       bp.about
from nshushan.buisnesspage BP 
     natural join 
     nshushan.buisnesstype BT 
     natural join 
     (select profile_id, first_name, last_name
     from notification N natural join afeder.profile P
     group by profile_id, first_name, last_name
     having count(*) > 5) T;

-- Query 2 : desprate profiles who runs event(s) -- optional: more then X events
select profile_id as host_id,
       first_name,
       last_name,
       count(*) as num_events,
       sum(participants_num) as total_participants,
       sum(intrested_num) as total_intrested
from (
     select profile_id,
            first_name,
            last_name,
            E.event_id,
            E.participants_num,
            E.intrested_num
     from nshushan.event E 
          natural join 
          (select requester_id as profile_id, first_name, last_name
          from friendshiprequest FR join afeder.profile P on requester_id = profile_id
          group by requester_id, first_name, last_name
          having count(*) > 5) T)
group by profile_id, first_name, last_name
having count(*) >= 2;

-- Query 3 : popular profiles (more then 5 requests) who runs popular SocialGroup
select profile_id as manager_id,
       first_name,
       last_name,
       SG.group_id,
       SG.group_name,
       SG.members_num,
       SG.about,
       V.visability_name
from nshushan.socialgroup SG 
     natural join
     nshushan.visability V
     natural join 
     (select FR.RECIEVER_ID as profile_id, first_name, last_name
     from friendshiprequest FR join afeder.profile P on FR.RECIEVER_ID = P.PROFILE_ID
     group by FR.RECIEVER_ID, first_name, last_name
     having count(*) > 5) T
where SG.members_num > 1000000;
