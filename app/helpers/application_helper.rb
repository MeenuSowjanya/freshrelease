# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  def date(_date, collection)
    if @date.to_i >= 1
      @date.to_i == 1 ? ' 1 day ago ' : "#{@date.to_i}  days ago"
    elsif @date.to_i < 1
      @time_in_sec = (Time.now - collection.created_at).round(0)
      if @time_in_sec == 1
        '1 second ago'
      elsif @time_in_sec <= 60
        (@time_in_sec == 60 ? '1 minute ago' : "#{@time_in_sec}  seconds ago")
      elsif @time_in_sec > 60
        @time_in_min = (@time_in_sec / 60).round(0)
        if @time_in_min == 1
          '1 minute ago'
        elsif @time_in_min <= 60
          (@time_in_min == 60 ? '1 hour ago' : "#{@time_in_min}  minutes ago")
        elsif @time_in_min > 60
          @time_in_hour = (@time_in_sec / 3600).round(0)
          "#{@time_in_hour} hours ago" if @time_in_hour > 1
        end

      end
    end
  end

  def length_of_subject(subject)
    array = subject.split('')
    return_array = []
    if array.length <= 50
      return_array = array
    else
      (0..50).each do |i|
        return_array << array[i]
      end
      return_array << '...'
    end
    return_subject = return_array.join('')
  end

  def note(ticket)
    @notes = ticket.notes.last
    @notes unless @notes.nil?
  end

  def title(page)
    case page
    when 'index'
      'Zupp | Tickets'
    when 'form'
      'Zupp | Create ticket'
    end
  end
end
