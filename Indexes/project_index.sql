create index idx_requester on ydemri.Friendshiprequest(requester_id);
create index idx_reciever on ydemri.Friendshipsuggestion(recieverid);
create index idx_notf_profile on ydemri.Notification(profile_id);
/* Resultes:
       Query 1 - 6616 rows in 3.832 sec (6.427 before)
       Query 2 -  166 rows in 3.891 sec (6.535 before)
       Query 3 -  156 rows in 3.953 sec (6.663 before)
       Query 4 -  173 rows in 4.044 sec (6.752 before)
       Query 5 -  240 rows in 4.146 sec (6.883 before)
       Query 6 - 9807 rows in 9.832 sec (12.549 before)
       Query 7 -  176 rows in 9.923 sec (12.624 before)
       Query 8 -  114 rows in 9.963 sec (12.950 before)
*/
