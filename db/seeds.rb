# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
room_type_dictionary =  [ { name: "Single", price: 7000, rooms: [ {type: "A", numbers: 1..5}, {type: "B", numbers: 1..5}, {type: "C", numbers: 1..5}, {type: "D", numbers: 1..5} ] }, { name: "Double", price: 8500, rooms: [ {type: "A", numbers: 6..10}, {type: "B", numbers: 6..10}, {type: "C", numbers: 6..10}, {type: "D", numbers: 6..10} ] }, { name: "Queen", price: 12000, rooms: [ {type: "D", numbers: 11..20}, {type: "E", numbers: 1..2} ] }, { name: "King", price: 20000, rooms: [ {type: "E", numbers: 3..10} ] } ]

room_type_dictionary.each do |room_type_data|
  puts "Creating or Updating Room Type"
  puts "-----------------------------------"
  room_type = RoomType.find_or_initialize_by(name: room_type_data[:name])
  puts "Category: #{room_type.name}"
  room_type.update_attributes(
     :price => room_type_data[:price]
  )
  room_type_data[:rooms].each do |room_data|
  puts "    Creating or Updating Hotel room"
  puts "    -------------------------------"
    room_data[:numbers].each do |room_number|
      hotel_room = Room.find_or_initialize_by(name: "#{room_data[:type]}#{room_number}")  
      puts "    Room: #{hotel_room.name}"
      hotel_room.update_attributes(
       :room_type_id => room_type.id
      )
    end
  end
end