# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

organization = FactoryGirl.create(:organization, name: "Steel City Pops", size: 100, sector: "Services", subdomain: "steelcitypops")
organization_2 = FactoryGirl.create(:organization, name: "My First Shift", subdomain: "myfirstshift")
user = FactoryGirl.create(:user, first_name: "John", last_name: "Lennon", email: "admin@myfirstshift.com", username: "admin", role: "super_admin", active: "true", password: "Password1", password_confirmation: "Password1", organization_id: 1, subdomain: organization.subdomain)
FactoryGirl.create(:user, first_name: "John", last_name: "Lennon", email: "admin@myfirstshift.com", username: "admin", role: "super_admin", active: "true", password: "Password1", password_confirmation: "Password1", organization_id: 1, subdomain: organization_2.subdomain)

