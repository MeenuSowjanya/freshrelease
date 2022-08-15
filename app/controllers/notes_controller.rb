# frozen_string_literal: true

class NotesController < ApplicationController

  @@id = 0 # Class variable created to store id of a ticket requested for adding canned response

  # Listing Method - route(\notes\:ticket_id)
  def show
    @count = 0   # To keep a track on how many notes listed and to keep a log (Also used for js show hide events)
    @id = params[:id]  # Getting ticket id from the redirected url 
    @@id = @id   # Storing in class variable declared previously
    @ticket = Ticket.find(@id)   # Maps to tickets table with @id
    @notes = @ticket.notes  # Maps to notes table with current ticket as a reference
    @user = User.find(current_user.id) # Getting details of current user for profile details and storing user id credentials
    @user_org = Organisation.all # Used for editing ticket properties
    @canned_responses = @user.canned_responses # To list canned responses for bot feature
  end

  # Create Method - Add note form
  def create
    current_user # Current user details
    note = Note.new(ticket_id: @@id, user_id: current_user.id, note: note_params[:note]) # Instantiating Note Model
    note.images.attach(note_params[:images])  # Attaching images to the record using Active Storage
    if note.save 
      redirect_to "/notes/#{return_id}"
    else
      flash[:error] = 'Failed to add your note.Something went wrong'
      redirect_to "/notes/#{return_id}"
    end
  end

  def update
    note = Note.find(params[:id])
    note.update(note: params[:note])
    note.save
    redirect_to "/notes/#{return_id}"
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    note.save
    redirect_to "/notes/#{return_id}"
  end

  def add_response
    @canned_response = CannedResponse.find(params[:id])
    current_user
    note = Note.new(ticket_id: @@id, user_id: current_user.id, note: @canned_response.description)
    if note.save
      redirect_to "/notes/#{return_id}"
    else
      render plain: 'False'
    end
  end

  def update_ticket
    current_user
    id = params[:id]
    @ticket = Ticket.find(id)
    ticket = @ticket
    before_update = {subject: ticket.subject,source: ticket.source,impact: ticket.impact,urgency: ticket.urgency,description: ticket.description,agent: ticket.agent,user_id: ticket.user_id,priority_id: ticket.priority_id,status_id: ticket.status_id}
    @ticket.update(agent: params[:agent], status_id: params[:status_id],
                  priority_id: params[:priority_id])
    if @ticket.save
      after_update = {subject: @ticket.subject,source: @ticket.source,impact: @ticket.impact,urgency: @ticket.urgency,description: @ticket.description,agent: @ticket.agent,user_id: @ticket.user_id,priority_id: @ticket.priority_id,status_id: @ticket.status_id}
      activity = Activity.new(user_id: current_user.id, action_id: 2,activity_model_id: 1)
      if activity.save
        puts activity.id
        ticket_update_activity = TicketUpdateActivity.new(activity_id: activity.id,ticket_id: ticket.id,before_update: before_update,after_update: after_update)
        if ticket_update_activity.save
         redirect_to "/notes/#{return_id}"
        else 
          render plain: "False in update activity"
        end
      else
        render plain: "False in activity"
      end
    else
      render plain: 'Fail'
    end
  end

  def close_ticket
    ticket = Ticket.find(params[:id])
    ticket.update(status_id: 4)
    ticket.save
    redirect_to "/notes/#{return_id}"
  end

  def return_id
    @@id
  end

  def clone_ticket
    current_user
    ticket = Ticket.find(params[:ticket_id])
    puts "---------------------------------"
    puts ticket.subject
    clone_subject = "Clone of #{ticket.subject}"
    puts clone_subject
    ticket_clone = Ticket.new(subject: clone_subject,source: ticket.source,impact: ticket.impact,urgency: ticket.urgency,priority_id: ticket.priority_id,status_id: ticket.status_id,user_id: ticket.user_id,description: ticket.description,agent: ticket.agent)
    ticket_clone.screenshots.attach(ticket.screenshots)
    if ticket_clone.save
      activity = Activity.new(user_id: current_user.id, action_id: 4,activity_model_id: 1)
      if activity.save
       activity_id = activity.id
       puts activity_id
       puts ticket_clone.id
       ticket_cd_activity = TicketCdActivity.new(activity_id: activity_id,ticket_id: ticket_clone.id)
       if ticket_cd_activity.save
        redirect_to "/notes/#{ticket_clone.id}"
       else
         render plain: "False in cd activity"
       end
      else 
        render plain: "False in activity"
      end
    else
      render plain: "False in clone"
    end
  end

  private

  def note_params
    params.require(:note).permit(:note, images: [])
  end
end
