FactoryGirl.define do

  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| "person#{n}@test.com" }
    password "test1234"
    password_confirmation "test1234"
    role 1
  end

end
