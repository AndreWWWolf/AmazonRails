# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Make sure to clear old data out of your db when you run rails db:seed
# In this case, Reviews will also be deleted since Product.destroy_all will
# run our 'dependent: :destroy' callback.
# Product.destroy_all()

# Now we'll use delete_all and just include all
# objects that need deleting.
Review.delete_all
Product.delete_all
User.delete_all

PASSWORD = "supersecret"
NUM_OF_USERS = 20
NUM_OF_PRODUCTS = 100

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  admin: true
)

NUM_OF_USERS.times do |num|
  full_name = Faker::TvShows::SiliconValley.character.split(' ')
  first_name = full_name[0]
  last_name = full_name[1]
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}-#{num}@piedpiper.com",
    password: 'supersecret'
  )
end

users = User.all

NUM_OF_PRODUCTS.times do
  created_at = Faker::Date.backward(365 * 5)
  p = Product.create({
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(100),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  })

  if p.valid?
    rand(0..10).times.each do
      Review.create(
        rating: Faker::Number.between(1, 5),
        body: Faker::TvShows::Seinfeld.quote,
        product: p,
        user: users.sample
      )
    end
  end
end

puts "Created #{User.count} users"
puts "Created #{Product.count} products"
puts "Created #{Review.count} reviews"
puts "Login as admin with #{super_user.email} and password of '#{PASSWORD}'!"
