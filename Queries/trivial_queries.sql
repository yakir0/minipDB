-------------------- (*) Query 1 : all pending requests [TRIVIAL] (*) --------------------
select requ_id as Request_Num,
       requester_id as Request_Id,
       reciever_id as Reciever_Id
from friendshiprequest
where approved is null;
-- Result: 6616 rows in 6.427 sec

-------------------- (*) Query 2 : most active (more then X notifications) profiles [TRIVIAL] (*) --------------------
select profile_id as Profile_Id,
       first_name as First_Name,
       last_name as Last_Name,
       count(*) as Notification_Amount
from notification N
       natural join 
       afeder.profile P
group by profile_id, first_name, last_name
having count(*) > 5;
-- Result: 166 rows in 6.535 sec

-------------------- (*) Query 3 : most recommended profiles [TRIVIAL] (*) --------------------
select offerid as Offer_Id,
       first_name as First_Name,
       last_name as Last_Name,
       count(*) as Request_Amount
from friendshipsuggestion FS
       join feder.profile P
       on (offerid = profile_id)
group by offerid, first_name, last_name
having count(*) > 5;
-- Result: 156 rows in 6.663 sec

-------------------- (*) Query 4 : most desprate profiles [TRIVIAL] (*) --------------------
select requester_id as Requester_Id,
       first_name as First_Name,
       last_name as Last_Name,
       count(*) as Request_Amount
from friendshiprequest FR join
       afeder.profile P on (requester_id = profile_id)
group by requester_id, first_name, last_name
having count(*) > 5;
-- Result: 173 rows in 6.752 sec