100.times do 
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  gender = ["male", "female"].sample
  match_preference = ["male", "female", "any"].sample
  photos_of_women = [
"http://s1.postimg.org/3mh6io64f/image.jpg",
"http://s1.postimg.org/gugkbm3nj/image.jpg",
"http://s1.postimg.org/3xymvfmkf/image.jpg",
"http://s1.postimg.org/9kuzswp33/image.jpg",
"http://s1.postimg.org/ldssx4lj3/image.jpg",
"http://s1.postimg.org/yvzp9exof/image.jpg",
"http://s1.postimg.org/jsdj5bbb3/image.jpg",
"http://s1.postimg.org/xxjc74kcf/image.jpg"
]

ip_addresses = ["64.114.24.114", "66.180.125.0"]
  
  user = User.create(name: name, email: email, password: password, password_confirmation: password, gender: gender, match_preference: match_preference)
  user.current_sign_in_ip = ip_addresses.sample
  user.pic = photos_of_women.sample
  user.save
end

# photos_of_women = [
# "http://s16.postimg.org/x4gu2l4ol/image.jpg",
# "http://s16.postimg.org/oq17ei3n9/image.jpg",
# "http://s16.postimg.org/nvensgvsl/image.jpg",
# "http://s16.postimg.org/5jo0bbn5h/image.jpg",
# "http://s16.postimg.org/yburusut1/image.jpg",
# "http://s16.postimg.org/yburusut1/image.jpg",
# "http://s16.postimg.org/oii5vqi2d/image.jpg",
# "http://s16.postimg.org/98iaojmk5/image.jpg",
# ]

vancouver_ip_address = "64.114.24.114"
photos_of_men = [
"http://s30.postimg.org/6z8juv11t/image.jpg",
"http://s30.postimg.org/nx7kgpafl/image.jpg",
"http://s30.postimg.org/aubxxfk7l/image.jpg",
"http://s30.postimg.org/bz602t6oh/image.jpg",
"http://s30.postimg.org/4kgoafksx/image.jpg"
]

User.all.each do |user|
  if user.gender == "male"
    user.pic = photos_of_men.sample unless user.id == 98 || user.id == 99
    user.save
  end
end