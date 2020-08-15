class BookingsController < ApplicationController
  
  def create
    begin
      Customer.transaction do
        customer = Customer.create(permit_customer_params)
        Booking.transaction do
          booking = Booking.create(check_in: params[:check_in], check_out: params[:check_out], customer_id: customer.id, room_id: params[:room_id])
          BookingDate.transaction do
            (params[:check_in].to_date..(params[:check_out].to_date-1.day)).each do |date|
              booking.booking_dates.create(date: date)
            end
          end 
        end
      end
      flash[:success] = "Booking done"
      redirect_to root_path
    rescue Exception => e
        flash[:error] = e.to_s
    end
  end

  def index
    @bookings = Booking.all.includes(:customer, :room)
  end

  def edit_customer
    @booking = Booking.find(params[:id])
    @customer = @booking.customer
  end

  def update_customer
    customer = Customer.find(params[:customer_id])
    redirect_to bookings_path if customer.update(permit_customer_params)
  end

  def search_customer
    cust_ids = Customer.where("customers.name like ?", "%#{params[:search]}%").map(&:id)
    @bookings = Booking.all.includes(:room).where("bookings.customer_id in (?)",cust_ids) if cust_ids.present?
  end

  private
  def permit_customer_params
    params.require(:customer).permit(:name, :email, :phone, :address)
  end
end
