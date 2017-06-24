FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "johndoe@example.com"
    password "Password1"
    password_confirmation "Password1"
    role "member"
    organization

    trait :owner do
      role "owner"
    end

    trait :manager do
      role "manager"
    end
  end
end
