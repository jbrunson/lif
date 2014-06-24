# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  # sample fake shit
else
  # Cohort.create!
end

users_file = File.join(Rails.root, "db", "users_seed.rb")
if File.exists?(users_file)
  puts "Loading Users seed file"
  require(users_file)
end
