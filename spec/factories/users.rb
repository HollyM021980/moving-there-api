FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    token "MyString" #For a base object, just need to have something here
    password_digest "MyString" #For a base object, just need to have something here
    role 1
  end

end
