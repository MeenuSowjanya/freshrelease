module ApplicationHelper
    def date(date)
        if @date.to_i >= 1
            return @date.to_i == 1 ? " 1 day ago ": (@date.to_i.to_s + "days ago") 
            elsif @date.to_i < 1
              @time_in_sec = (Time.now - @note.created_at).round(0)
              if @time_in_sec <= 60
                 return @time_in_sec == 60 ? " 1 minute ago ": (@time_in_sec.to_s + "minutes ago") 
               elsif @time_in_sec > 60
                 @time_in_min = (@time_in_sec/60).round(0)
                if @time_in_min < 60
                  return "#{@time_in_min} minutes ago"
                 else
                @time_in_hour = (@time_in_sec/3600).round(0)
                   return @time_in_hour == 1 ? " 1 hour ago ": (@time_in_hour.to_s + "hours ago") 
                 end

              end
            end
    end
end
