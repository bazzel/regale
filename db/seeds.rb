# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# bin/rails db:seed email=<your-email-address>
#
include FactoryBot::Syntax::Methods

Event.destroy_all
User.destroy_all

email = ENV['email']

current_user = create :user,
  email: email,
  name: nil

40.times do
  create :user, :random
end


20.times do
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

puts "Login: #{Rails.application.routes.url_helpers.token_sign_in_path(current_user.login_token)}"
