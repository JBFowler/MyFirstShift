FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| Faker::Internet.email(first_name) + n.to_s }
    sequence(:username) { |n| Faker::Internet.user_name + n.to_s }
    password "Password1"
    password_confirmation "Password1"
    role "member"
    progress nil
    organization

    trait :completed do
      employee_type "hourly"
      sequence(:wage) { |n| n.odd? ? 8 : 10 }
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
