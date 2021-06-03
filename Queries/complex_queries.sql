-------------------- (*) Query 5 : all good suggestions (*) --------------------
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
-- Result: 240 rows in 6.883 sec

-------------------- (*) Query 6 : all watched notifications on friend request/suggestion (*) --------------------
select *
from notification N
where N.Watched = 1 and
      N.PROFILE_ID in ((select FR.RECIEVER_ID
                       from friendshiprequest FR)
                       union
                       (select FS.RECIEVERID
                        from friendshipsuggestion FS));
-- Result: 9807 rows in 12.549 sec

-------------------- (*) Query 7 : all popular profiles - more then 5 requests (*) --------------------
select FR.RECIEVER_ID as FriendshipRequest_Id,
       first_name as First_Name,
       last_name as Last_Name,
       count(*) as Request_Amount
from friendshiprequest FR 
       join afeder.profile P
       on FR.RECIEVER_ID = P.PROFILE_ID
group by FR.RECIEVER_ID,
         first_name,
         last_name
having count(*) > 5;
-- Result: 176 rows in 12.624 sec

-------------------- (*) Query 8 : suspicious activity (*) --------------------
select P.profile_id as Profile_Id,
       first_name as First_Name,
       last_name as Last_Name
from afeder.profile P
where P.GENDER = 'M' and
      (select count(*)
       from friendshiprequest FR join afeder.profile P1 on FR.RECIEVER_ID = P1.PROFILE_ID
       where FR.REQUESTER_ID = P.PROFILE_ID and P1.GENDER = 'F') >= 3
-- Result: 114 rows in 12.950 sec