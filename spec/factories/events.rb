FactoryBot.define do
  factory :event do
    title { "Italian dinner" }
    scheduled_at { "2018-11-04 18:00:00" }


    factory :event_with_guests do
      transient do
        guests_count { 5 }
      end

      before(:create) do |event, evaluator|
        event.guests = build_list(:guest, evaluator.guests_count)
      end
    end

    trait :future do
      scheduled_at { 1.week.from_now }
    end

    trait :random do
      transient do
        from { 2.months.ago }
        to { 6.months.from_now }
      end

      title { Faker::TwinPeaks.unique.location }
      scheduled_at { Time.at(from + rand * (to.to_f - from.to_f)) }
    end
  end
end
