-- query 1 : all pending requests [TRIVIAL]
select requ_id, requester_id, reciever_id
from friendshiprequest
where approved is null;

-- query 2 : most active (more then X notifications) profiles [TRIVIAL]
select profile_id, first_name, last_name, count(*) as notf_num
from notification N natural join afeder.profile P
group by profile_id, first_name, last_name
having count(*) > 5;

-- query 3 : most recommended profiles [TRIVIAL]
select offerid, first_name, last_name, count(*) as rec_num
from friendshipsuggestion FS join afeder.profile P on offerid = profile_id
group by offerid, first_name, last_name
having count(*) > 5;

-- query 4 : most desprate profiles [TRIVIAL]
select requester_id, first_name, last_name, count(*) as req_num
from friendshiprequest FR join afeder.profile P on requester_id = profile_id
group by requester_id, first_name, last_name
having count(*) > 5;

-- query 5 : all good suggestions
select FS.SUGGESTIONID, 
       FS.RECIEVERID, 
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

-- query 6 : all watched notifications on friend request/suggestion
select *
from notification N
where N.Watched = 1 and
      N.PROFILE_ID in ((select FR.RECIEVER_ID
                       from friendshiprequest FR)
                       union
                       (select FS.RECIEVERID
                        from friendshipsuggestion FS));

-- query 7 : all popular profiles - more then 5 requests
select FR.RECIEVER_ID, first_name, last_name, count(*) as req_num
from friendshiprequest FR join afeder.profile P on FR.RECIEVER_ID = P.PROFILE_ID
group by FR.RECIEVER_ID, first_name, last_name
having count(*) > 5;

---- query 8 : suspicious activity
select P.profile_id, first_name, last_name
from afeder.profile P
where P.GENDER = 'M' and
      (select count(*)
       from friendshiprequest FR join afeder.profile P1 on FR.RECIEVER_ID = P1.PROFILE_ID
       where FR.REQUESTER_ID = P.PROFILE_ID and P1.GENDER = 'F') >= 3






                       

