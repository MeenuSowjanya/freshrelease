class TicketsController < ApplicationController

  before_action :ensure_user_logged_in
  @@sort = "Date created"
  @@order = "Ascending"
  @@ids_array = []
  def index
     current_user
     @count = 0
     @length = false
     @sort_order = sort_by
     @sorting_order = order_by
     if current_user.role == "admin"
      @tickets_list = Ticket.all
      @tickets = tickets_sort(@tickets_list,@sort_order,@sorting_order)
     else
      @tickets_list = current_user.tickets
      @tickets = tickets_sort(@tickets_list,@sort_order,@sorting_order)
     end
     @user = User.find(current_user.id)
     @user_org = Organisation.all
     @array_returned = update_array_return
     if @array_returned.length == @tickets.length
       @length = true
     else
       @length = false
     end
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
      ticket = Ticket.new(subject: ticket_params[:subject],source: ticket_params[:source],status_id: ticket_params[:status_id],urgency: ticket_params[:urgency],impact: ticket_params[:impact],priority_id: ticket_params[:priority_id],description: ticket_params[:description],agent: ticket_params[:agent],user_id: current_user.id)
      ticket.screenshots.attach(ticket_params[:screenshots])
      puts ticket
      if ticket.save
        redirect_to tickets_path
      elsec
        # flash[:error] = ticket.errors.full_messages.first 
        # redirect_to tickets_path
        render plain: "False"
      end
  end

  def update 
      id = params[:id]
      ticket = Ticket.find(id)
      ticket.update(subject: params[:subject], agent: params[:agent], status_id: params[:status_id], priority_id: params[:priority_id], description: params[:description])
    if ticket.save
      redirect_to tickets_path
    else
      render plain: "Fail"
    end
  end

  def destroy
      current_user
      id = params[:id]
      ticket = Ticket.find(id)
      ticket.destroy
      ticket.save  
      redirect_to tickets_path
  end

  def delete_array
    @@ids_array = []
    render plain: "Success"
  end

  def sort
    @@sort = params[:sort]
    @@order = params[:order]
    redirect_to tickets_path
  end

  def option
    current_user
    @user_org = Organisation.all
    @user = User.find(current_user.id)
    if params[:option] == "pickup"
      update_array_return.each do |id|
        ticket = Ticket.find(id)
        ticket.update(agent: current_user.first_name)
        ticket.save
        @@ids_array=[]
      end
      
    elsif params[:option] == "assigned_to"
      update_array_return.each do |id|
        ticket = Ticket.find(id)
        ticket.update(agent: params[:agent])
        ticket.save
        @@ids_array=[]
       end
    
    end
    redirect_to tickets_path
  end

  
  def search
    current_user
    @count = 0
    if current_user.role == "admin"
      @tickets_list = Ticket.all 
    else
      @tickets_list = current_user.tickets
    end
    @search_text = params[:search]
    @tickets_search = @tickets_list.where("subject LIKE ?", "%" + @search_text + "%").or(Ticket.where("description LIKE ?", "%" + params[:search] + "%"))
    @user = User.find(current_user.id)
    @user_org = Organisation.all
    @array_returned = update_array_return
    render "search"
  end
  def array
  
  end
  def select_all
    current_user
    if current_user.role == "admin"
      @tickets_list = Ticket.all
    else
      @tickets_list = current_user.tickets
    end
     if params[:selected][:result] == "1"
       @tickets_list.each do |ticket|
       @@ids_array << ticket.id
       end
     elsif params[:selected][:result] == "0"
      @tickets_list.each do |ticket|
        @@ids_array.delete(ticket.id)
        end
     end
     redirect_to tickets_path
  end
  def update_array
   if params[:selected][:result] == "1"
    @@ids_array << (params[:id]).to_i
    puts "------------"
    puts @@ids_array
   elsif params[:selected][:result] == "0"
    @@ids_array.delete((params[:id]).to_i)
    puts "-------------"
    puts @@ids_array
   end
   redirect_to tickets_path
  end

  private 
  def ticket_params
    params.require(:ticket).permit(:subject,:source,:status_id,:urgency,:impact,:priority_id,:agent,:description,screenshots: [])
  end
  def sort_by
    return @@sort
  end
  def order_by
    return @@order
  end
  def update_array_return
    return @@ids_array
  end
  def tickets_sort(tickets,order,sorting_order)
    if order == "Date created"
      if sorting_order == "Ascending"
       tickets.order("created_at ASC")
      else
        tickets.order("created_at DESC")
      end
    elsif order == "Priority"
      if sorting_order == "Ascending"
        tickets.order("priority_id ASC")
       else
         tickets.order("priority_id DESC")
       end
    elsif order == "Status"
      if sorting_order == "Ascending"
        tickets.order("status_id ASC")
       else
         tickets.order("status_id DESC")
       end
    elsif order == "Last Modified"
      if sorting_order == "Ascending"
        tickets.order("updated_at DESC")
       else
         tickets.order("updated_at ASC")
       end
    end
  end
end
