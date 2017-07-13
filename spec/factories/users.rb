FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "johndoe@example.com"
    password "Password1"
    password_confirmation "Password1"
    role "member"
    progress nil
    organization

    trait :completed do
      employee_type "salary"
      phone "999-999-9999"
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
