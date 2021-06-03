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
/