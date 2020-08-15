class RoomsController < ApplicationController
  def index;end

  def filter_rooms
    @rooms = Room.includes(:room_type).available_rooms(params[:check_in], params[:check_out]).available_by_room_type(params[:room_type])
  end
end