class AttendancesController < ApplicationController
  def index
    @event_id = params[:event_id]
  end
end
