# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    arrival_date "2014-06-23"
    departure_date "2014-06-26"
    location "Vancouver, BC"
    user 
  end
end
