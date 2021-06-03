-- User 1 ---- Data & AI Scientists ---------------------
-- View 1 ---- best suggestions ---------------------
create view best_suggestions as
select FS.SUGGESTIONID, FS.RECIEVERID, 
       P1.FIRST_NAME as RECIEVER_FNAME, 
       P1.LAST_NAME as RECIEVER_LNAME,
       FS.OFFERID,
       P2.FIRST_NAME as OFFER_FNAME,
       P2.LAST_NAME as OFFER_LNAME
from friendshipsuggestion FS 
     join
     afeder.profile P1 
     on FS.RECIEVERID = P1.PROFILE_ID 
     join afeder.profile P2 
     on FS.OFFERID = P2.PROFILE_ID
where exists (select *
              from friendshiprequest FR
              where FS.RECIEVERID = FR.REQUESTER_ID 
                    and FS.OFFERID = FR.RECIEVER_ID
                    and FR.Approved = 1);

-- View 2 ---- Notification Statistiscs ----------------
create view notification_stats as
select profile_id, first_name, last_name,
       count(notification_id) as total_notf,
       sum(watched) as total_watched
from afeder.profile P
     natural left outer join
     notification N
group by profile_id, first_name, last_name;

-- User 2 ---- Marketing Department -------------------
-- View 3 ---- all popular profiles & their events ----
create view popular_pf_events as
select profile_id, first_name, last_name,
       event_id, event_name,
       e.location,
       e.event_date,
       e.participants_num
from nshushan.event E
     natural right outer join
        (select FR.RECIEVER_ID as profile_id,
                first_name, last_name
         from friendshiprequest FR 
              join afeder.profile P
              on FR.RECIEVER_ID = P.PROFILE_ID
         group by FR.RECIEVER_ID, first_name, last_name
         having count(*) > 5) T;

-- View 4 ---- all active profiles & their big social groups ----
create view active_pf_groups as
select profile_id, first_name, last_name,
       sg.group_id, sg.group_name, sg.members_num, sg.about, v.visability_name
from nshushan.socialgroup SG
     natural join
     nshushan.visability V
     natural right outer join
        (select profile_id as Profile_Id,
                first_name as First_Name,
                last_name as Last_Name
         from notification N
              natural join 
              afeder.profile P
         group by profile_id, first_name, last_name
         having count(*) > 5) T
where members_num > 500000;
