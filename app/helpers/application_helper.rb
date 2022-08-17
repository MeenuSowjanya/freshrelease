# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
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
    return_array.join('')
  end

  def note(ticket)
    @notes = ticket.notes.last
    @notes unless @notes.nil?
  end

  def title(page)
    case page
    when 'index'
      'Zupp | Tickets'
    else
      'Zupp | Create ticket'
    end
  end

  def changes_in(activity_collection, model_no)
    @from_to_changes = []
    if model_no == 1
      @ticket_update_activity = TicketUpdateActivity.find_by(activity_id: activity_collection.id)
      if !@ticket_update_activity.nil?
        @before_update = @ticket_update_activity.before_update
        @after_update = @ticket_update_activity.after_update
        if @before_update['status_id'] != @after_update['status_id']
          @from_to_changes << Status.find(@before_update['status_id']).status
          @from_to_changes << Status.find(@after_update['status_id']).status
          @from_to_changes << 'status'
        elsif @before_update['priority_id'] != @after_update['priority_id']
          @from_to_changes << Priority.find(@before_update['priority_id']).priority
          @from_to_changes << Priority.find(@after_update['priority_id']).priority
          @from_to_changes << 'priority'
        elsif @before_update['agent'] != @after_update['agent']
          @from_to_changes << @before_update['agent']
          @from_to_changes << @after_update['agent']
          @from_to_changes << 'agent'
        end
      else
        @from_to_changes = []
      end
    else
      @note_update_activity = NoteUpdateActivity.find_by(activity_id: activity_collection.id)
      if !@note_update_activity.nil?
        @before_update = @note_update_activity.before_update
        @after_update = @note_update_activity.after_update
        if @before_update['note'] != @after_update['note']
          @from_to_changes << @before_update['note']
          @from_to_changes << @after_update['note']
        else
          @from_to_changes = []
        end
      else
        @from_to_changes = []
      end
    end
  end

  def date(_date, collection)
    if _date.to_i >= 1
      _date.to_i == 1 ? ' 1 day ago ' : "#{_date.to_i}  days ago"
    elsif _date.to_i < 1
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
end
