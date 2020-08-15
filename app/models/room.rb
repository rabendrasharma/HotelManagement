class Room < ApplicationRecord
  belongs_to :room_type
  has_many :bookings

  # Scope for checking if any of the rooms are available or not
  scope :available?, -> (check_in, check_out=nil) { available_rooms(check_in, check_out).present? }

  # Scope for finding all the available rooms
  scope :available_rooms, -> (check_in, check_out=nil, room_type=nil) { 
    check_out = check_in if room_type.blank?
    # Fetching all the booked rooms in the particular date range 
    rooms = includes(:bookings=>:booking_dates).where("booking_dates.date": check_in..check_out)
    # Filtering all the booked rooms and finding out the available rooms for particular
    where.not(id: rooms.map(&:id))#.where(room_type_id: room_type) unless room_type.to_i == 0
  }
  scope :available_by_room_type, -> (room_type) {
    #Filtering on room type basis
    where(room_type_id: room_type) unless room_type.to_i == 0
  }
end
