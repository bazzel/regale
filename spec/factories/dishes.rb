FactoryBot.define do
  factory :dish do
    title { "MyString" }
    description { "MyString" }

    trait :random do
      title { Faker::Food.dish }
      description { Faker::Lorem.sentence }
    end
  end

  factory :soup, class: Soup, parent: :dish
  factory :appetizer, class: Appetizer, parent: :dish
  factory :main_course, class: MainCourse, parent: :dish

  factory :dessert, class: Dessert, parent: :dish do
    title { Faker::Dessert.variety }
  end
end
