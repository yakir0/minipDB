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