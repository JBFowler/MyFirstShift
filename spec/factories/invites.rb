FactoryGirl.define do
  factory :invite do
    email "johndoe@example.com"
    organization
    unit

    trait :with_code do
      code { SecureRandom.hex(50) }
    end
  end
end