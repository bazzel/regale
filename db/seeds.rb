# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# bin/rails db:seed email=<your-email-address>
# bin/rails db:seed email=<your-email-address> users_count=100 events_count=20
#
include FactoryBot::Syntax::Methods

Event.destroy_all
User.destroy_all

users_count = ENV.fetch('USERS_COUNT', 20)
events_count = ENV.fetch('EVENTS_COUNT', 10)

current_user = CreateAdminService.new.call

users_count.times do
  create :user, :random
end


events_count.times do
  event = create(:event, :random) do |e|
    rand(6).times do
      e.soups << build(:soup, :random)
    end
    rand(6).times do
      e.appetizers << build(:appetizer, :random)
    end
    rand(6).times do
      e.main_courses << build(:main_course, :random)
    end
    rand(6).times do
      e.desserts << build(:dessert, :random)
    end

    e.users = User.all.sample(rand(User.count))
  end

  event.guests.each do |guest|
    guest.update({
      accept_status: (Guest.accept_statuses.values << nil).sample,
      soup: event.soups.to_a.push(nil).sample,
      appetizer: event.appetizers.to_a.push(nil).sample,
      main_course: event.main_courses.to_a.push(nil).sample,
      dessert: event.desserts.to_a.push(nil).sample
    })
  end
end

puts "Login as #{current_user.email}"
