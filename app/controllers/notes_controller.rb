# frozen_string_literal: true

class NotesController < ApplicationController
  @@id = 0 # Class variable created to store id of a ticket requested for adding canned response

  # Listing Method - route(\notes\:ticket_id)
  def show
    @count = 0
    @id = params[:id]
    @@id = @id
    @ticket = Ticket.find(@id)
    @notes = @ticket.notes
    @user = User.find(current_user.id)
    @user_org = Organisation.all # Used for editing ticket properties
    @canned_responses = CannedResponse.all
  end

  # Create Method - Add note form
  def create
    current_user # Current user details
    note = Note.new(ticket_id: @@id, user_id: current_user.id, note: note_params[:note]) # Instantiating Note Model
    note.images.attach(note_params[:images])  # Attaching images to the record using Active Storage
    if note.save
      activity = Activity.new(user_id: current_user.id, action_id: 5, activity_model_id: 2, ticket_id: note.ticket_id)
      if activity.save
        activity_id = activity.id
        note_cd_activity = NoteCdActvity.new(activity_id: activity_id, ticket_id: note.ticket_id, note_id: note.id)
        if note_cd_activity.save
          redirect_to "/notes/#{return_id}"
        else
          render plain: 'False in cd activity'
        end
      else
        render plain: 'False in activity'
      end
    else
      flash[:error] = 'Failed to add your note.Something went wrong'
    end
  end

  def update
    note = Note.find(params[:id])
    before_update = { note: note.note }
    note.update(note: params[:note])
    if note.save
      after_update = { note: note.note }
      activity = Activity.new(user_id: current_user.id, action_id: 6, activity_model_id: 2, ticket_id: note.ticket_id)
      if activity.save
        note_update_activity = NoteUpdateActivity.new(activity_id: activity.id, ticket_id: note.ticket_id,
                                                      note_id: note.id,
                                                      before_update: before_update,
                                                      after_update: after_update)
        redirect_to "/notes/#{return_id}" if note_update_activity.save
      end
    end
  end

  def destroy
    note = Note.find(params[:id])
    backup_note = note
    if note.destroy
      activity = Activity.new(user_id: current_user.id, action_id: 7, activity_model_id: 2,
                              ticket_id: backup_note.ticket_id)
      if activity.save
        note_cd_activity = NoteCdActvity.new(activity_id: activity.id, ticket_id: backup_note.ticket_id,
                                             note_id: backup_note.id)
        puts 'Success'
      end
    end
    redirect_to "/notes/#{return_id}"
  end

  def add_response
    @canned_response = CannedResponse.find(params[:id])
    current_user
    note = Note.new(ticket_id: @@id, user_id: current_user.id, note: @canned_response.description)
    if note.save
      activity = Activity.new(user_id: current_user.id, action_id: 5,
                              activity_model_id: 2, ticket_id: note.ticket_id)
      if activity.save
        activity_id = activity.id
        note_cd_activity = NoteCdActvity.new(activity_id: activity_id, ticket_id: note.ticket_id,
                                             note_id: note.id)
        if note_cd_activity.save
          redirect_to "/notes/#{return_id}"
        else
          render plain: 'False in cd activity'
        end
      else
        render plain: 'False in activity'
      end
    else
      render plain: 'False'
    end
  end

  def update_ticket
    current_user
    id = params[:id]
    @ticket = Ticket.find(id)
    ticket = @ticket
    before_update = { subject: ticket.subject, source: ticket.source,
                      impact: ticket.impact, urgency: ticket.urgency,
                      description: ticket.description, agent: ticket.agent,
                      user_id: ticket.user_id,
                      priority_id: ticket.priority_id, status_id: ticket.status_id }
    @ticket.update(agent: params[:agent], status_id: params[:status_id],
                   priority_id: params[:priority_id])
    if @ticket.save
      after_update = { subject: @ticket.subject, source: @ticket.source,
                       impact: @ticket.impact, urgency: @ticket.urgency,
                       description: @ticket.description, agent: @ticket.agent,
                       user_id: @ticket.user_id, priority_id: @ticket.priority_id,
                       status_id: @ticket.status_id }
      activity = Activity.new(user_id: current_user.id, action_id: 2,
                              activity_model_id: 1, ticket_id: ticket.id)
      if activity.save
        puts activity.id
        ticket_update_activity = TicketUpdateActivity.new(activity_id: activity.id, ticket_id: ticket.id,
                                                          before_update: before_update,
                                                          after_update: after_update)
        if ticket_update_activity.save
          redirect_to "/notes/#{return_id}"
        else
          render plain: 'False in update activity'
        end
      else
        render plain: 'False in activity'
      end
    else
      render plain: 'Fail'
    end
  end

  def close_ticket
    ticket = Ticket.find(params[:id])
    before_update = { subject: ticket.subject, source: ticket.source,
                      impact: ticket.impact, urgency: ticket.urgency,
                      description: ticket.description, agent: ticket.agent,
                      user_id: ticket.user_id, priority_id: ticket.priority_id,
                      status_id: ticket.status_id }
    ticket.update(status_id: 4)
    if ticket.save
      after_update = { subject: ticket.subject, source: ticket.source,
                       impact: ticket.impact, urgency: ticket.urgency,
                       description: ticket.description, agent: ticket.agent,
                       user_id: ticket.user_id, priority_id: ticket.priority_id,
                       status_id: ticket.status_id }
      activity = Activity.new(user_id: current_user.id, action_id: 2,
                              activity_model_id: 1, ticket_id: ticket.id)
      if activity.save
        note_update_activity = TicketUpdateActivity.new(activity_id: activity.id,
                                                        ticket_id: ticket.id,
                                                        before_update: before_update,
                                                        after_update: after_update)
        redirect_to "/notes/#{return_id}" if note_update_activity.save
      end
    end
  end

  def return_id
    @@id
  end

  def clone_ticket
    current_user
    @ticket = Ticket.find(params[:ticket_id])
    clone_subject = "Clone of #{@ticket.subject}"
    ticket_clone = Ticket.new(subject: clone_subject, source: @ticket.source, impact: @ticket.impact,
                              urgency: @ticket.urgency, priority_id: @ticket.priority_id,
                              status_id: @ticket.status_id, user_id: @ticket.user_id,
                              description: @ticket.description, agent: @ticket.agent)
    ticket_clone.screenshots.attach(@ticket.screenshots.blobs)
    if ticket_clone.save
      puts ticket_clone.screenshots.attached?
      activity = Activity.new(user_id: current_user.id, action_id: 4,
                              activity_model_id: 1, ticket_id: ticket_clone.id)
      if activity.save
        activity_id = activity.id
        puts activity_id
        puts ticket_clone.id
        ticket_cd_activity = TicketCdActivity.new(activity_id: activity_id, ticket_id: ticket_clone.id)
        if ticket_cd_activity.save
          redirect_to "/notes/#{ticket_clone.id}"
        else
          render plain: 'False in cd activity'
        end
      else
        render plain: 'False in activity'
      end
    else
      render plain: 'False in clone'
    end
  end

  private

  def note_params
    params.require(:note).permit(:note, images: [])
  end
end
