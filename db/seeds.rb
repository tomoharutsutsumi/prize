# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |n|
  User.create( email: "hogehoge@#{n}ff.com", password: 'hugahuga')
end


AwardCategory.create(level: "excellent")
AwardCategory.create(level: "good")
AwardCategory.create(level: "ordinary")
AwardCategory.create(level: "below_ordinary")
AwardCategory.create(level: "poor")


Award.create(contents: "aaa1", giver_id: 1, given_id: 2, award_category_id: 1)
Award.create(contents: "aaa2", giver_id: 2, given_id: 3, award_category_id: 2)
Award.create(contents: "aaa3", giver_id: 3, given_id: 2, award_category_id: 3)

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

