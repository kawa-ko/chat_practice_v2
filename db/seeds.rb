# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..100).each do |number|
    test_user = User.create(name: 'test' + number.to_s, email: 'test-user' + number.to_s + '@abc.com', password: 'test-user' + number.to_s)
    Room.create(name: 'test-room' + number.to_s, host_id: test_user.id )
end