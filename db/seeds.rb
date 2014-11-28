# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
u1 = User.create(first_name: "First1", last_name: "Last4", email: "u1@test.com", password: "test", password_confirmation: "test")
u2 = User.create(first_name: "First2", last_name: "Last1", email: "u2@test.com", password: "test", password_confirmation: "test")
u3 = User.create(first_name: "First3", last_name: "Last3", email: "u3@test.com", password: "test", password_confirmation: "test")
u4 = User.create(first_name: "First4", last_name: "Last4", email: "u4@test.com", password: "test", password_confirmation: "test")
