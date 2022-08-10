# frozen_string_literal: true

class NotesController < ApplicationController
  @@id = 0
  def show
    @count = 0
    @id = params[:id]
    @@id = @id
    @ticket = Ticket.find(@id)
    @notes = @ticket.notes
    @user = User.find(current_user.id)
    @user_org = Organisation.all
    @canned_responses = @user.canned_responses
  end

  def create
    current_user
    note = Note.new(ticket_id: @@id, user_id: current_user.id, note: note_params[:note])
    if note.save
    else
      flash[:error] = 'Failed to add your not.Something went wrong'
    end
    redirect_to "/notes/#{return_id}"
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
    ticket = Ticket.find(params[:id])
    ticket.update(status_id: params[:status_id], priority_id: params[:priority_id], agent: params[:agent])
    ticket.save
    redirect_to "/notes/#{return_id}"
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

  private

  def note_params
    params.require(:note).permit(:note)
  end
end
