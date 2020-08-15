class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.date :check_in
      t.date :check_out
      t.integer :room_id
      t.string :customer_id
      t.string :integer

      t.timestamps
    end
  end
end
