create or replace function get_notf_watched_ratio_avg return float as
          res number;
       begin
          select avg(NS.total_watched / NS.total_notf)
          into res
          from ydemri.notification_stats NS;
          
          return res;
       end;
/
create or replace function get_num_of_friends (profile_id in number) return number as
         res number;
       begin
         select count(*)
         into res
         from friendshiprequest FR
         where FR.RECIEVER_ID = profile_id
               and FR.APPROVED = 1;
         
         return res;
       end;
/
create or replace procedure delete_all_bots as
       begin
         delete from afeder.profile P 
         where P.PROFILE_ID in (select requester_id as Requester_Id
                                from friendshiprequest FR join
                                     afeder.profile P on requester_id = profile_id
                                group by requester_id, first_name, last_name
                                having count(*) > 5);
       end;

/
create or replace procedure update_notf_content (notf_id in number, 
                                                 new_content in varchar, 
                                                 app in number default 0) as
       begin
         
         if app = 0 then
           update notification N
           set N.Content = new_content
           where N.Notification_Id = notf_id;
         else
           update notification N
           set N.Content = N.Content || new_content
           where N.Notification_Id = notf_id;
         end if;
 
       end;

/*
begin
  -- call funcs/procs
end;
*/
