class EventController < ApplicationController
    def index
        @events = Event.all
    end

    def new
    
    end

    def create
        @object = Object.new(params[:object])
        if @object.save
          flash[:success] = "Object successfully created"
          redirect_to @object
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    def show
        @event = Event.find(params[:id])
    end
    
end
