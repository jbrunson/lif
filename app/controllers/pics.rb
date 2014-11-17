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
User.all.each do |user|
  user.pic = photos_of_women.sample unless user.id == 99 || user.id == 98
  user.save
end