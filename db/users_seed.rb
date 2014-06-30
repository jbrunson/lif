100.times do 
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  gender = ["male", "female"].sample
  match_preference = ["male", "female", "any"].sample
  User.create(name: name, email: email, password: password, password_confirmation: password, gender: gender, match_preference: match_preference)
end