# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# start this seed with an empty db
10.times do |n|
  User.create(username: "user#{n}",
              email: "user#{n}@example.com",
              password: "secret_password",
              password_confirmation: "secret_password")
end

User.first(10).each_with_index do |user, i|
  5.times do |j|
    recipe = user.recipes.build(title: "Recipe #{i}-#{j}")
    recipe.save!
    5.times do |k|
      recipe.ingredients.build(food: "food #{i}-#{j}-#{k}").save!
      recipe.instructions.build(body: "Be sure to blah blah blah", position: (k+1)).save!
    end
  end
end
