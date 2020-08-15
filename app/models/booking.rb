class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :customer
  has_many :booking_dates, dependent: :destroy
end
