FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    login_token { 'lorem-ipsum' }
    login_token_valid_until { 15.minutes.from_now }
  end

  trait :admin do
    role { :admin }
  end

  trait :guest do
    role { :guest }
  end

  trait :expired_token do
    login_token_valid_until { 15.minutes.ago }
  end

  trait :random do
    email { Faker::Internet.unique.email }
    name { Faker::Name.unique.name }
  end
end
