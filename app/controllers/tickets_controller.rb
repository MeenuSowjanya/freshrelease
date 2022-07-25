class TicketsController < ApplicationController

  before_action :ensure_user_logged_in

  def index
     current_user
     if current_user.role == "admin"
      @tickets = Ticket.all
     else
      @tickets = current_user.tickets
     end
     @user = User.find(current_user.id)
     @user_org = Organisation.all
     puts "-------------------------------"
     puts @sort
    end
  
  def new
      current_user
      @user = User.find(current_user.id)
      @user_org = Organisation.all
      puts @user_org
  end

  def create 
      current_user
      @user = User.find(current_user.id)
      @user_org = Organisation.all
      puts @user_org
      ticket = Ticket.new(
        subject: ticket_params[:subject],
        source: ticket_params[:source],
        status: ticket_params[:status],
        urgency: ticket_params[:urgency],
        impact: ticket_params[:impact],
        priority: ticket_params[:priority],
        description: ticket_params[:description],
        agent: ticket_params[:agent],
        user_id: current_user.id
      )
      if ticket.save 
          redirect_to tickets_path
      else
          flash[:error] = ticket.errors.full_messages.join(", ")
          redirect_to tickets_path
      end
  end

  def update 
      id = params[:id]
      ticket = current_user.tickets.find(id)
      ticket.agent = params[:agent]
      ticket.status = params[:status]
      ticket.priority = params[:priority]
      if ticket.save
       redirect_to tickets_path
      else
        render plain: "Fail"
      end
  end

  def destroy
      id = params[:id]
      todo = current_user.todos.find(id)
      todo.destroy
      todo.save  
      redirect_to todos_path
  end

  def sort
    @sort = params[:sort]
  end
  
  private 
  def ticket_params
    params.require(:ticket).permit(:subject,:source,:status,:urgency,:impact,:priority,:agent,:description)
  end
end
