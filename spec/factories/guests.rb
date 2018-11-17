FactoryBot.define do
  factory :guest do
    user
    event

    trait :yes do
      accept_status { Guest.accept_statuses[:yes] }
    end

    trait :no do
      accept_status { Guest.accept_statuses[:no] }
    end

    trait :maybe do
      accept_status { Guest.accept_statuses[:maybe] }
    end
  end
end
