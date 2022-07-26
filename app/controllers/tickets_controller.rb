# frozen_string_literal: true

class TicketsController < ApplicationController
  include Pagy::Backend
  before_action :ensure_user_logged_in
  @@sort = 'Date created'
  @@order = 'Ascending'
  @@ids_array = []
  @@length = nil
  @@searched = false
  @@searched_array = []
  @@filter = 'all'
  @@filtered = false
  @@selected_all = false

  def index
    current_user # logged in user method
    @count = 0
    @sort_order = sort_by
    @sorting_order = order_by
    @filter = filter_returner
    @filtered = filtered_returner
    @selected_all = selected_all_returner # #local variables
    # #model data
    @tickets_list = tickets_list_returner(searched_returner)
    @user = User.find(current_user.id)
    @user_org = Organisation.all
    @array_returned = update_array_return
    @filtered_array = (@filtered == true ? filtered_tickets(@tickets_list, @filter) : @tickets_list)
    @title = (@filtered == true ? title(@filter) : 'All Tickets')
    @pagy, @tickets = pagy(tickets_sort(@filtered_array, @sort_order, @sorting_order), items: 6)
    @length = (@array_returned.length == @tickets.length)
    reset
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
    ticket = Ticket.new(subject: ticket_params[:subject], source: ticket_params[:source],
                        status_id: ticket_params[:status_id], urgency: ticket_params[:urgency],
                        impact: ticket_params[:impact], priority_id: ticket_params[:priority_id],
                        description: ticket_params[:description], agent: ticket_params[:agent],
                        user_id: current_user.id)
    ticket.screenshots.attach(ticket_params[:screenshots])
    if ticket.save
      activity = Activity.new(user_id: current_user.id, action_id: 1, activity_model_id: 1, ticket_id: ticket.id)
      if activity.save
        activity_id = activity.id
        puts activity_id
        puts ticket.id
        ticket_cd_activity = TicketCdActivity.new(activity_id: activity_id, ticket_id: ticket.id)
        if ticket_cd_activity.save
          redirect_to tickets_path
        else
          render plain: 'False in cd activity'
        end
      else
        render plain: 'False in activity'
      end
    else
      flash.now[:error] = ticket.errors.full_messages.first
      puts flash.now[:error]
      render '/tickets/new'
    end
  end

  def update
    current_user
    id = params[:id]
    @ticket = Ticket.find(id)
    ticket = @ticket
    before_update = { subject: ticket.subject, source: ticket.source,
                      impact: ticket.impact, urgency: ticket.urgency,
                      description: ticket.description, agent: ticket.agent,
                      user_id: ticket.user_id, priority_id: ticket.priority_id,
                      status_id: ticket.status_id }
    @ticket.update(agent: params[:agent], status_id: params[:status_id],
                   priority_id: params[:priority_id])
    if @ticket.save
      after_update = { subject: @ticket.subject, source: @ticket.source, impact: @ticket.impact,
                       urgency: @ticket.urgency,
                       description: @ticket.description, agent: @ticket.agent,
                       user_id: @ticket.user_id, priority_id: @ticket.priority_id,
                       status_id: @ticket.status_id }
      activity = Activity.new(user_id: current_user.id, action_id: 2, activity_model_id: 1, ticket_id: ticket.id)
      if activity.save
        puts activity.id
        ticket_update_activity = TicketUpdateActivity.new(activity_id: activity.id, ticket_id: ticket.id,
                                                          before_update: before_update, after_update: after_update)
        if ticket_update_activity.save
          redirect_to tickets_path
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

  def destroy
    current_user
    id = params[:id]
    ticket = Ticket.find(id)
    if ticket.destroy
      activity = Activity.new(user_id: current_user.id, action_id: 3, activity_model_id: 1, ticket_id: ticket.id)
      if activity.save
        TicketCdActivity.new(activity_id: activity.id, ticket_id: id)
        puts 'Success'
      end
    end
    redirect_to tickets_path
  end

  def title(filter)
    case filter
    when 'all'
      'All Tickets'
    when 'priority'
      'High Priority Tickets'
    when 'open'
      'Open Tickets'
    when 'resolved'
      'Resolved Tickets'
    else
      'All tickets'
    end
  end

  def bulk_delete
    current_user
    update_array_return.each do |id|
      ticket = Ticket.find(id)
      next unless ticket.destroy

      activity = Activity.new(user_id: current_user.id, action_id: 3, activity_model_id: 1, ticket_id: id)
      if activity.save
        ticket_cd_activity = TicketCdActivity.new(activity_id: activity.id, ticket_id: id)
        puts 'Success'
      end
    end
    @@ids_array = []

    redirect_to tickets_path
  end

  def delete_array
    @@ids_array = []
    render plain: 'Success'
  end

  def sort
    @@sort = params[:sort]
    @@order = params[:order]
    redirect_to tickets_path
  end

  def tickets_filter
    @@filter = params[:option]
    @@filtered = true
    redirect_to tickets_path
  end

  def filter_returner
    @@filter
  end

  def filtered_returner
    @@filtered
  end

  def length_returner
    @@length
  end

  def searched_returner
    @@searched
  end

  def searched_array_returner
    @@searched_array
  end

  def reset
    @@searched = false
    @@searched_array = []
    @@length = false
    @@filtered = false
    @@filter = 'all'
    @@selected_all = false
  end

  def tickets_list_returner(searched_returner_value)
    @tickets_list = if searched_returner_value == false
                      if current_user.role == 'admin'
                        Ticket.all
                      else
                        current_user.tickets
                      end

                    else
                      searched_array_returner
                    end
  end

  def filtered_tickets(tickets, filter)
    case filter
    when 'all'
      @filtered_array = tickets
      @all = true
    when 'priority'
      @filtered_array = tickets.where(priority_id: 3)
      @priority = true
    when 'open'
      @filtered_array = tickets.where(status_id: 1)
      @open = true
    when 'resolved'
      @filtered_array = tickets.where(status_id: 4)
      @resolved = true
    else
      @filtered_array = tickets
      @all = true
    end
    @filtered_array
  end

  def option
    current_user
    @user_org = Organisation.all
    @user = User.find(current_user.id)
    @agent = params[:option] == 'pickup' ? current_user.first_name : params[:agent]
    puts @agent
    update_array_return.each do |id|
      @ticket = Ticket.find(id)
      ticket = @ticket
      before_update = { subject: ticket.subject, source: ticket.source,
                        impact: ticket.impact, urgency: ticket.urgency,
                        description: ticket.description, agent: ticket.agent,
                        user_id: ticket.user_id, priority_id: ticket.priority_id,
                        status_id: ticket.status_id }
      @ticket.update(agent: @agent)
      next unless @ticket.save

      after_update = { subject: @ticket.subject, source: @ticket.source,
                       impact: @ticket.impact, urgency: @ticket.urgency,
                       description: @ticket.description, agent: @ticket.agent,
                       user_id: @ticket.user_id, priority_id: @ticket.priority_id,
                       status_id: @ticket.status_id }
      activity = Activity.new(user_id: current_user.id, action_id: 2, activity_model_id: 1, ticket_id: ticket.id)
      next unless activity.save

      puts activity.id
      ticket_update_activity = TicketUpdateActivity.new(activity_id: activity.id, ticket_id: ticket.id,
                                                        before_update: before_update, after_update: after_update)
      @@ids_array = [] if ticket_update_activity.save
    end
    redirect_to tickets_path
  end

  def search
    current_user
    @count = 0
    @tickets_list = if current_user.role == 'admin'
                      Ticket.all
                    else
                      current_user.tickets
                    end
    @search_text = params[:search]
    @tickets_search = @tickets_list.where('subject LIKE ?',
                                          "%#{@search_text}%").or(Ticket.where('description LIKE ?',
                                                                               "%#{params[:search]}%"))
    @@searched_array = @tickets_search
    @@searched = true
    redirect_to tickets_path
  end

  def select_all
    current_user
    @tickets_list = if current_user.role == 'admin'
                      Ticket.all
                    else
                      current_user.tickets
                    end
    puts true
    case params[:selected][:result]
    when '1'
      @tickets_list.each do |ticket|
        @@ids_array << ticket.id
      end
    else
      @tickets_list.each do |ticket|
        @@ids_array.delete(ticket.id)
      end
    end
    @@selected_all = true
    redirect_to tickets_path
  end

  def selected_all_returner
    @@selected_all
  end

  def update_array
    case params[:selected][:result]
    when '1'
      @@ids_array << params[:id].to_i
      puts '------------'
    else
      @@ids_array.delete(params[:id].to_i)
      puts '-------------'
    end
    puts @@ids_array
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:subject, :source, :status_id,
                                   :urgency, :impact, :priority_id, :agent, :description,
                                   screenshots: [])
  end

  def sort_by
    @@sort
  end

  def order_by
    @@order
  end

  def update_array_return
    @@ids_array
  end

  def tickets_sort(tickets, order, sorting_order)
    case order
    when 'Date created'
      if sorting_order == 'Ascending'
        tickets.order('created_at ASC')
      else
        tickets.order('created_at DESC')
      end
    when 'Priority'
      if sorting_order == 'Ascending'
        tickets.order('priority_id ASC')
      else
        tickets.order('priority_id DESC')
      end
    when 'Status'
      if sorting_order == 'Ascending'
        tickets.order('status_id ASC')
      else
        tickets.order('status_id DESC')
      end
    else
      if sorting_order == 'Ascending'
        tickets.order('updated_at DESC')
      else
        tickets.order('updated_at ASC')
      end
    end
  end
end
