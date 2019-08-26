#create users
rachel = User.create(username: "Rachel", email: "rachel@rachel.com", password: "password")
derek = User.create(username: "Derek", email: "derek@derek.com", password: "password")

#create beaches
waikiki = Beach.create(name: "Waikiki Beach", city: "Honolulu", shore: "South")
lanikai = Beach.create(name: "Lanikai Beach", city: "Kailua", shore: "East")

rachel.reviews.create(rating: 5, description: "Beautiful and popular Hawaii beach")
