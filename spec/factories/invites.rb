FactoryGirl.define do
  factory :invite do
    email "invite@example.com"
    expires_at 30.days.from_now
    organization
    unit

    trait :with_code do
      code { SecureRandom.hex(50) }
    end

    trait :owner do
      role "owner"
    end

    trait :member do
      role "member"
    end

    trait :unit_leader do
      role "unit_leader"
    end

    trait :redeemed do
      redeemed_at DateTime.current
    end
  end
end
