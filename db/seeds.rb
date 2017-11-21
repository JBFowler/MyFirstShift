# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

organization = FactoryGirl.create(:organization, name: "Steel City Pops", size: 100, sector: "Services", subdomain: "steelcitypops")
organization_2 = FactoryGirl.create(:organization, name: "My First Shift", subdomain: "myfirstshift")

FactoryGirl.create(:user, first_name: "John", last_name: "Lennon", email: "owner@steelcitypops.com", username: "admin", role: "owner", password: "Password1", password_confirmation: "Password1", organization_id: 1, subdomain: organization.subdomain)
FactoryGirl.create(:user, first_name: "John", last_name: "Lennon", email: "owner@myfirstshift.com", username: "admin", role: "owner", password: "Password1", password_confirmation: "Password1", organization_id: organization_2.id, subdomain: organization_2.subdomain)

FactoryGirl.create(:admin, email: "admin@myfirstshift.com", password: "Password1", password_confirmation: "Password1", admin: true)
FactoryGirl.create(:admin, email: "badadmin@myfirstshift.com", password: "Password1", password_confirmation: "Password1", admin: false)

unit = FactoryGirl.create(:unit, organization: organization_2, created_by: User.last)

12.times.each do |n|
  FactoryGirl.create_list(:user, n, :completed, organization: organization_2, created_at: n.months.ago)
end

12.times.each do |n|
  FactoryGirl.create_list(:user, n, :completed, organization: organization_2, unit: unit, created_at: n.months.ago)
end
