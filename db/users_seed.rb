100.times do 
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  gender = ["male", "female"].sample
  match_preference = ["male", "female", "any"].sample
  User.create(name: name, email: email, password: password, password_confirmation: password, gender: gender, match_preference: match_preference)
end

photos_of_women = [
"http://s16.postimg.org/x4gu2l4ol/image.jpg",
"http://s16.postimg.org/oq17ei3n9/image.jpg",
"http://s16.postimg.org/nvensgvsl/image.jpg",
"http://s16.postimg.org/5jo0bbn5h/image.jpg",
"http://s16.postimg.org/yburusut1/image.jpg",
"http://s16.postimg.org/yburusut1/image.jpg",
"http://s16.postimg.org/oii5vqi2d/image.jpg",
"http://s16.postimg.org/98iaojmk5/image.jpg",
]

vancouver_ip_address = "64.114.24.114"