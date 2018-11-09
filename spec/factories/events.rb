FactoryBot.define do
  factory :event do
    title { "Italian dinner" }
    scheduled_at { "2018-11-04 18:00:00" }


    factory :event_with_guests do
      transient do
        guests_count { 5 }
      end

      before(:create) do |event, evaluator|
        event.users = build_list(:user, evaluator.guests_count)
      end
    end
  end
end
