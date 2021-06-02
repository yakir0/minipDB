create or replace function get_notf_watched_ratio_avg return float as
          res number;
       begin
          select avg(NS.total_watched / NS.total_notf)
          into res
          from ydemri.notification_stats NS;
          
          return res;
       end;
/
declare
      ret number;
begin
  ret := get_notf_watched_ratio_avg();
  dbms_output.put_line(ret);
end;
