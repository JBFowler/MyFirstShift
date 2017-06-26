FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "johndoe@example.com"
    password "Password1"
    password_confirmation "Password1"
    role "member"
    progress nil
    active true
    organization

    trait :completed do
      progress "complete"
    end

    trait :manager do
      role "manager"
    end

    trait :owner do
      role "owner"
    end
  end
end
