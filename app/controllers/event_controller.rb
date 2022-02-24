class EventController < ApplicationController
  include UserHelper
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def create
    @event = Event.new(params_event)
    @event.admin_id = current_user.id
    @event.save
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash.now[:danger] = "N'arrive pas à sauvegarder."
      render action: 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(params_event)
      redirect_to event_path(@event.id)
    else
      flash.now[:danger] = "N'arrive pas à update."
      render action: 'edit'
    end
  end
  def params_event
    params.permit(:start_date, :duration, :title, :description, :price, :location)
  end
    
  def params_edit
    params.permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
