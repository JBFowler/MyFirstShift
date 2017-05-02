FactoryGirl.define do
  factory :admin do
    first_name "Admin"
    last_name "User"
    email "admin@example.com"
    username "adminuser"
    password "Password"
    password_confirmation "Password"
    admin true
  end
end
