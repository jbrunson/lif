# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com" }

  factory :user do
    email  { generate(:email) }
    name   'john doe'
    password "acomplexpasswordthisisnot"
    password_confirmation "acomplexpasswordthisisnot"
  end
end